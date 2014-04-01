Return-Path: <joel@jms.id.au>
Received: from mail-pa0-x22d.google.com (mail-pa0-x22d.google.com
 [IPv6:2607:f8b0:400e:c03::22d])
 (using TLSv1 with cipher ECDHE-RSA-RC4-SHA (128/128 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id 6BD9F140166
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  1 Apr 2014 15:00:06 +1100 (EST)
Received: by mail-pa0-f45.google.com with SMTP id kl14so9191750pab.18
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 31 Mar 2014 21:00:03 -0700 (PDT)
From: Joel Stanley <joel@jms.id.au>
To: benh@kernel.crashing.org, paulus@samba.org, anton@samba.org,
 shangw@linux.vnet.ibm.com, hegdevasant@linux.vnet.ibm.com,
 michael@ellerman.id.au, mikey@neuling.org, stewart@linux.vnet.ibm.com
Subject: [PATCH v2 2/2] powerpc/powernv: Add invalid OPAL call
Date: Tue,  1 Apr 2014 14:28:20 +1030
Message-Id: <1396324700-22457-3-git-send-email-joel@jms.id.au>
In-Reply-To: <1396324700-22457-1-git-send-email-joel@jms.id.au>
References: <1396324700-22457-1-git-send-email-joel@jms.id.au>
Cc: linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

This call will not be understood by OPAL, and cause it to add an error
to it's log. Among other things, this is useful for testing the
behaviour of the log as it fills up.

Signed-off-by: Joel Stanley <joel@jms.id.au>
---
 arch/powerpc/include/asm/opal.h                | 2 ++
 arch/powerpc/platforms/powernv/opal-wrappers.S | 1 +
 arch/powerpc/platforms/powernv/opal.c          | 3 +++
 3 files changed, 6 insertions(+)

diff --git a/arch/powerpc/include/asm/opal.h b/arch/powerpc/include/asm/opal.h
index 693bdc4..6a2c485 100644
--- a/arch/powerpc/include/asm/opal.h
+++ b/arch/powerpc/include/asm/opal.h
@@ -87,6 +87,7 @@ extern int opal_enter_rtas(struct rtas_args *args,
 #define OPAL_ASYNC_COMPLETION	-15
 
 /* API Tokens (in r0) */
+#define OPAL_INVALID_CALL			-1
 #define OPAL_CONSOLE_WRITE			1
 #define OPAL_CONSOLE_READ			2
 #define OPAL_RTC_READ				3
@@ -878,6 +879,7 @@ int64_t opal_set_param(uint64_t token, uint32_t param_id, uint64_t buffer,
 		size_t length);
 int64_t opal_sensor_read(uint32_t sensor_hndl, int token,
 		uint32_t *sensor_data);
+int64_t opal_invalid_call(void);
 
 /* Internal functions */
 extern int early_init_dt_scan_opal(unsigned long node, const char *uname, int depth, void *data);
diff --git a/arch/powerpc/platforms/powernv/opal-wrappers.S b/arch/powerpc/platforms/powernv/opal-wrappers.S
index 75c89df..2d8adb3 100644
--- a/arch/powerpc/platforms/powernv/opal-wrappers.S
+++ b/arch/powerpc/platforms/powernv/opal-wrappers.S
@@ -61,6 +61,7 @@ _STATIC(opal_return)
 	mtcr	r4;
 	rfid
 
+OPAL_CALL(opal_invalid_call,			OPAL_INVALID_CALL);
 OPAL_CALL(opal_console_write,			OPAL_CONSOLE_WRITE);
 OPAL_CALL(opal_console_read,			OPAL_CONSOLE_READ);
 OPAL_CALL(opal_console_write_buffer_space,	OPAL_CONSOLE_WRITE_BUFFER_SPACE);
diff --git a/arch/powerpc/platforms/powernv/opal.c b/arch/powerpc/platforms/powernv/opal.c
index e6f14d7..4b7aced 100644
--- a/arch/powerpc/platforms/powernv/opal.c
+++ b/arch/powerpc/platforms/powernv/opal.c
@@ -607,3 +607,6 @@ void opal_shutdown(void)
 			mdelay(10);
 	}
 }
+
+/* Export this so that test modules can use it */
+EXPORT_SYMBOL_GPL(opal_invalid_call);
-- 
1.9.1
