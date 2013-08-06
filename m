Return-Path: <anton@ozlabs.org>
From: Anton Blanchard <anton@samba.org>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Paul Mackerras <paulus@samba.org>
Subject: [PATCH 14/63] powerpc: Make RTAS calls endian safe
Date: Wed,  7 Aug 2013 02:01:31 +1000
Message-Id: <1375804940-22050-15-git-send-email-anton@samba.org>
In-Reply-To: <1375804940-22050-1-git-send-email-anton@samba.org>
References: <1375804940-22050-1-git-send-email-anton@samba.org>
Cc: linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

RTAS expects arguments in the call buffer to be big endian so we
need to byteswap on little endian builds

Signed-off-by: Anton Blanchard <anton@samba.org>
---
 arch/powerpc/include/asm/rtas.h |  8 ++++----
 arch/powerpc/kernel/rtas.c      | 38 +++++++++++++++++++-------------------
 2 files changed, 23 insertions(+), 23 deletions(-)

diff --git a/arch/powerpc/include/asm/rtas.h b/arch/powerpc/include/asm/rtas.h
index c7a8bfc..9bd52c6 100644
--- a/arch/powerpc/include/asm/rtas.h
+++ b/arch/powerpc/include/asm/rtas.h
@@ -44,12 +44,12 @@
  *
  */
 
-typedef u32 rtas_arg_t;
+typedef __be32 rtas_arg_t;
 
 struct rtas_args {
-	u32 token;
-	u32 nargs;
-	u32 nret; 
+	__be32 token;
+	__be32 nargs;
+	__be32 nret; 
 	rtas_arg_t args[16];
 	rtas_arg_t *rets;     /* Pointer to return values in args[]. */
 };  
diff --git a/arch/powerpc/kernel/rtas.c b/arch/powerpc/kernel/rtas.c
index 98b26af..4cf674d 100644
--- a/arch/powerpc/kernel/rtas.c
+++ b/arch/powerpc/kernel/rtas.c
@@ -91,7 +91,7 @@ static void unlock_rtas(unsigned long flags)
  * are designed only for very early low-level debugging, which
  * is why the token is hard-coded to 10.
  */
-static void call_rtas_display_status(char c)
+static void call_rtas_display_status(unsigned char c)
 {
 	struct rtas_args *args = &rtas.args;
 	unsigned long s;
@@ -100,11 +100,11 @@ static void call_rtas_display_status(char c)
 		return;
 	s = lock_rtas();
 
-	args->token = 10;
-	args->nargs = 1;
-	args->nret  = 1;
-	args->rets  = (rtas_arg_t *)&(args->args[1]);
-	args->args[0] = (unsigned char)c;
+	args->token = cpu_to_be32(10);
+	args->nargs = cpu_to_be32(1);
+	args->nret  = cpu_to_be32(1);
+	args->rets  = &(args->args[1]);
+	args->args[0] = cpu_to_be32(c);
 
 	enter_rtas(__pa(args));
 
@@ -380,11 +380,11 @@ static char *__fetch_rtas_last_error(char *altbuf)
 
 	bufsz = rtas_get_error_log_max();
 
-	err_args.token = rtas_last_error_token;
-	err_args.nargs = 2;
-	err_args.nret = 1;
-	err_args.args[0] = (rtas_arg_t)__pa(rtas_err_buf);
-	err_args.args[1] = bufsz;
+	err_args.token = cpu_to_be32(rtas_last_error_token);
+	err_args.nargs = cpu_to_be32(2);
+	err_args.nret = cpu_to_be32(1);
+	err_args.args[0] = cpu_to_be32(__pa(rtas_err_buf));
+	err_args.args[1] = cpu_to_be32(bufsz);
 	err_args.args[2] = 0;
 
 	save_args = rtas.args;
@@ -433,13 +433,13 @@ int rtas_call(int token, int nargs, int nret, int *outputs, ...)
 	s = lock_rtas();
 	rtas_args = &rtas.args;
 
-	rtas_args->token = token;
-	rtas_args->nargs = nargs;
-	rtas_args->nret  = nret;
-	rtas_args->rets  = (rtas_arg_t *)&(rtas_args->args[nargs]);
+	rtas_args->token = cpu_to_be32(token);
+	rtas_args->nargs = cpu_to_be32(nargs);
+	rtas_args->nret  = cpu_to_be32(nret);
+	rtas_args->rets  = &(rtas_args->args[nargs]);
 	va_start(list, outputs);
 	for (i = 0; i < nargs; ++i)
-		rtas_args->args[i] = va_arg(list, rtas_arg_t);
+		rtas_args->args[i] = cpu_to_be32(va_arg(list, __u32));
 	va_end(list);
 
 	for (i = 0; i < nret; ++i)
@@ -449,13 +449,13 @@ int rtas_call(int token, int nargs, int nret, int *outputs, ...)
 
 	/* A -1 return code indicates that the last command couldn't
 	   be completed due to a hardware error. */
-	if (rtas_args->rets[0] == -1)
+	if (be32_to_cpu(rtas_args->rets[0]) == -1)
 		buff_copy = __fetch_rtas_last_error(NULL);
 
 	if (nret > 1 && outputs != NULL)
 		for (i = 0; i < nret-1; ++i)
-			outputs[i] = rtas_args->rets[i+1];
-	ret = (nret > 0)? rtas_args->rets[0]: 0;
+			outputs[i] = be32_to_cpu(rtas_args->rets[i+1]);
+	ret = (nret > 0)? be32_to_cpu(rtas_args->rets[0]): 0;
 
 	unlock_rtas(s);
 
-- 
1.8.1.2
