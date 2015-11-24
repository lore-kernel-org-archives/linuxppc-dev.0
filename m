Return-Path: <michael@ozlabs.org>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 460A01A004C
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 24 Nov 2015 22:26:16 +1100 (AEDT)
From: Michael Ellerman <mpe@ellerman.id.au>
To: <linuxppc-dev@ozlabs.org>
Subject: [PATCH 1/5] powerpc/rtas: Add rtas_call_unlocked()
Date: Tue, 24 Nov 2015 22:26:08 +1100
Message-Id: <1448364372-28065-1-git-send-email-mpe@ellerman.id.au>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Most users of RTAS (Run-Time Abstraction Services) use rtas_call(),
which deals with locking as well as endian handling.

However we have two users outside of rtas.c that can't use rtas_call()
because they have different locking requirements.

The hotplug CPU code can't take the RTAS lock because the CPU would go
offline with the lock held and no other CPUs would be able to call RTAS
until the CPU came back online.

The xmon code doesn't want to take the lock because it would risk dead
locking when we are trying to recover from a crash.

Both sites required multiple patches when we added little endian
support, proving that programmers can't do endian right.

Although that ship has sailed, we can still clean the code up by
providing an unlocked version of rtas_call() which avoids the need to
open code the logic elsewhere.

Signed-off-by: Michael Ellerman <mpe@ellerman.id.au>

commit 98bd678fc89575d0f4026a3ced3de19d90d1fe72
Author: Michael Ellerman <mpe@ellerman.id.au>
Date:   Fri May 15 16:40:48 2015 +1000

    powerpc/rtas: Add rtas_call_unlocked(), make enter_rtas() private

    Most users of RTAS (Run-Time Abstraction Services) use rtas_call(),
    which deals with locking as well as endian handling.

    However we have two users outside of rtas.c that can't use rtas_call()
    because they have different locking requirements.

    The hotplug CPU code can't take the RTAS lock because the CPU would go
    offline with the lock held and no other CPUs would be able to call RTAS
    until the CPU came back online.

    The xmon code doesn't want to take the lock because it would risk dead
    locking when we are trying to recover from a crash.

    Both sites required multiple patches when we added little endian
    support, proving that programmers can't do endian right.

    Although that ship has sailed, we can still clean the code up by
    providing an unlocked version of rtas_call() which avoids the need to
    open code the logic elsewhere.

    Signed-off-by: Michael Ellerman <mpe@ellerman.id.au>

diff --git a/arch/powerpc/include/asm/rtas.h b/arch/powerpc/include/asm/rtas.h
index b77ef369c0f0..51400baa8d48 100644
--- a/arch/powerpc/include/asm/rtas.h
+++ b/arch/powerpc/include/asm/rtas.h
@@ -334,10 +334,11 @@ extern void (*rtas_flash_term_hook)(int);

 extern struct rtas_t rtas;

-extern void enter_rtas(unsigned long);
 extern int rtas_token(const char *service);
 extern int rtas_service_present(const char *service);
 extern int rtas_call(int token, int, int, int *, ...);
+void rtas_call_unlocked(struct rtas_args *args, int token, int nargs,
+			int nret, ...);
 extern void rtas_restart(char *cmd);
 extern void rtas_power_off(void);
 extern void rtas_halt(void);
diff --git a/arch/powerpc/kernel/rtas.c b/arch/powerpc/kernel/rtas.c
index 5a753fae8265..dda465b62e9b 100644
--- a/arch/powerpc/kernel/rtas.c
+++ b/arch/powerpc/kernel/rtas.c
@@ -44,6 +44,9 @@
 #include <asm/mmu.h>
 #include <asm/topology.h>

+/* This is here deliberately so it's only used in this file */
+void enter_rtas(unsigned long);
+
 struct rtas_t rtas = {
 	.lock = __ARCH_SPIN_LOCK_UNLOCKED
 };
@@ -418,6 +421,36 @@ static char *__fetch_rtas_last_error(char *altbuf)
 #define get_errorlog_buffer()		NULL
 #endif

+
+static void
+va_rtas_call_unlocked(struct rtas_args *args, int token, int nargs, int nret,
+		      va_list list)
+{
+	int i;
+
+	args->token = cpu_to_be32(token);
+	args->nargs = cpu_to_be32(nargs);
+	args->nret  = cpu_to_be32(nret);
+	args->rets  = &(args->args[nargs]);
+
+	for (i = 0; i < nargs; ++i)
+		args->args[i] = cpu_to_be32(va_arg(list, __u32));
+
+	for (i = 0; i < nret; ++i)
+		args->rets[i] = 0;
+
+	enter_rtas(__pa(args));
+}
+
+void rtas_call_unlocked(struct rtas_args *args, int token, int nargs, int nret, ...)
+{
+	va_list list;
+
+	va_start(list, nret);
+	va_rtas_call_unlocked(args, token, nargs, nret, list);
+	va_end(list);
+}
+
 int rtas_call(int token, int nargs, int nret, int *outputs, ...)
 {
 	va_list list;
@@ -431,22 +464,14 @@ int rtas_call(int token, int nargs, int nret, int *outputs, ...)
 		return -1;

 	s = lock_rtas();
+
+	/* We use the global rtas args buffer */
 	rtas_args = &rtas.args;

-	rtas_args->token = cpu_to_be32(token);
-	rtas_args->nargs = cpu_to_be32(nargs);
-	rtas_args->nret  = cpu_to_be32(nret);
-	rtas_args->rets  = &(rtas_args->args[nargs]);
 	va_start(list, outputs);
-	for (i = 0; i < nargs; ++i)
-		rtas_args->args[i] = cpu_to_be32(va_arg(list, __u32));
+	va_rtas_call_unlocked(rtas_args, token, nargs, nret, list);
 	va_end(list);

-	for (i = 0; i < nret; ++i)
-		rtas_args->rets[i] = 0;
-
-	enter_rtas(__pa(rtas_args));
-
 	/* A -1 return code indicates that the last command couldn't
 	   be completed due to a hardware error. */
 	if (be32_to_cpu(rtas_args->rets[0]) == -1)
---
 arch/powerpc/include/asm/rtas.h |  2 ++
 arch/powerpc/kernel/rtas.c      | 44 ++++++++++++++++++++++++++++++-----------
 2 files changed, 35 insertions(+), 11 deletions(-)

diff --git a/arch/powerpc/include/asm/rtas.h b/arch/powerpc/include/asm/rtas.h
index b77ef369c0f0..6db1d6977a0d 100644
--- a/arch/powerpc/include/asm/rtas.h
+++ b/arch/powerpc/include/asm/rtas.h
@@ -338,6 +338,8 @@ extern void enter_rtas(unsigned long);
 extern int rtas_token(const char *service);
 extern int rtas_service_present(const char *service);
 extern int rtas_call(int token, int, int, int *, ...);
+void rtas_call_unlocked(struct rtas_args *args, int token, int nargs,
+			int nret, ...);
 extern void rtas_restart(char *cmd);
 extern void rtas_power_off(void);
 extern void rtas_halt(void);
diff --git a/arch/powerpc/kernel/rtas.c b/arch/powerpc/kernel/rtas.c
index 5a753fae8265..fcf2d653a6fe 100644
--- a/arch/powerpc/kernel/rtas.c
+++ b/arch/powerpc/kernel/rtas.c
@@ -418,6 +418,36 @@ static char *__fetch_rtas_last_error(char *altbuf)
 #define get_errorlog_buffer()		NULL
 #endif
 
+
+static void
+va_rtas_call_unlocked(struct rtas_args *args, int token, int nargs, int nret,
+		      va_list list)
+{
+	int i;
+
+	args->token = cpu_to_be32(token);
+	args->nargs = cpu_to_be32(nargs);
+	args->nret  = cpu_to_be32(nret);
+	args->rets  = &(args->args[nargs]);
+
+	for (i = 0; i < nargs; ++i)
+		args->args[i] = cpu_to_be32(va_arg(list, __u32));
+
+	for (i = 0; i < nret; ++i)
+		args->rets[i] = 0;
+
+	enter_rtas(__pa(args));
+}
+
+void rtas_call_unlocked(struct rtas_args *args, int token, int nargs, int nret, ...)
+{
+	va_list list;
+
+	va_start(list, nret);
+	va_rtas_call_unlocked(args, token, nargs, nret, list);
+	va_end(list);
+}
+
 int rtas_call(int token, int nargs, int nret, int *outputs, ...)
 {
 	va_list list;
@@ -431,22 +461,14 @@ int rtas_call(int token, int nargs, int nret, int *outputs, ...)
 		return -1;
 
 	s = lock_rtas();
+
+	/* We use the global rtas args buffer */
 	rtas_args = &rtas.args;
 
-	rtas_args->token = cpu_to_be32(token);
-	rtas_args->nargs = cpu_to_be32(nargs);
-	rtas_args->nret  = cpu_to_be32(nret);
-	rtas_args->rets  = &(rtas_args->args[nargs]);
 	va_start(list, outputs);
-	for (i = 0; i < nargs; ++i)
-		rtas_args->args[i] = cpu_to_be32(va_arg(list, __u32));
+	va_rtas_call_unlocked(rtas_args, token, nargs, nret, list);
 	va_end(list);
 
-	for (i = 0; i < nret; ++i)
-		rtas_args->rets[i] = 0;
-
-	enter_rtas(__pa(rtas_args));
-
 	/* A -1 return code indicates that the last command couldn't
 	   be completed due to a hardware error. */
 	if (be32_to_cpu(rtas_args->rets[0]) == -1)
-- 
2.5.0
