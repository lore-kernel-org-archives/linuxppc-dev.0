Return-Path: <MAILER-DAEMON@rune.sasl.smtp.pobox.com>
Received: from gretel.pobox.com (gretel.pobox.com [208.58.1.197])
	by ozlabs.org (Postfix) with ESMTP id 65BED67C74
	for <linuxppc-dev@ozlabs.org>; Thu,  7 Dec 2006 13:23:13 +1100 (EST)
Received: from rune.pobox.com (rune.pobox.com [208.210.124.79])
	by gretel.pobox.com (Postfix) with ESMTP id DE7574F9F864
	for <linuxppc-dev@ozlabs.org>; Wed,  6 Dec 2006 19:51:49 -0500 (EST)
From: Nathan Lynch <ntl@pobox.com>
To: linuxppc-dev@ozlabs.org
Subject: [PATCH 3/4] add rtas_service_present() helper
Date: Wed,  6 Dec 2006 18:50:45 -0600
Message-Id: <11654526533213-git-send-email-ntl@pobox.com>
In-Reply-To: <11654526511379-git-send-email-ntl@pobox.com>
References: <11654526463043-git-send-email-ntl@pobox.com>
	<11654526511379-git-send-email-ntl@pobox.com>
Cc: paulus@samba.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

To test for the existence of an RTAS function, we typically do:

   foo_token = rtas_token("foo");
   if (foo_token == RTAS_UNKNOWN_SERVICE)
      return;

Add a rtas_service_present method, which provides a more conventional
boolean interface for testing the existence of an RTAS method.

Signed-off-by: Nathan Lynch <ntl@pobox.com>
---
 arch/powerpc/kernel/rtas.c |    6 ++++++
 include/asm-powerpc/rtas.h |    1 +
 2 files changed, 7 insertions(+), 0 deletions(-)

diff --git a/arch/powerpc/kernel/rtas.c b/arch/powerpc/kernel/rtas.c
index 387ed0d..7970bed 100644
--- a/arch/powerpc/kernel/rtas.c
+++ b/arch/powerpc/kernel/rtas.c
@@ -303,6 +303,12 @@ int rtas_token(const char *service)
 }
 EXPORT_SYMBOL(rtas_token);
 
+int rtas_service_present(const char *service)
+{
+	return rtas_token(service) != RTAS_UNKNOWN_SERVICE;
+}
+EXPORT_SYMBOL(rtas_service_present);
+
 #ifdef CONFIG_RTAS_ERROR_LOGGING
 /*
  * Return the firmware-specified size of the error log buffer
diff --git a/include/asm-powerpc/rtas.h b/include/asm-powerpc/rtas.h
index 5a0c136..f08f356 100644
--- a/include/asm-powerpc/rtas.h
+++ b/include/asm-powerpc/rtas.h
@@ -159,6 +159,7 @@ extern struct rtas_t rtas;
 
 extern void enter_rtas(unsigned long);
 extern int rtas_token(const char *service);
+extern int rtas_service_present(const char *service);
 extern int rtas_call(int token, int, int, int *, ...);
 extern void rtas_restart(char *cmd);
 extern void rtas_power_off(void);
-- 
1.4.4.1
