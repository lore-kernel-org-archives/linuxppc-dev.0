Return-Path: <ruscur@russell.cc>
Received: from russell.cc (russell.cc [IPv6:2404:9400:2:0:216:3eff:fee0:3370])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256
 bits)) (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 860681A0513
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 13 Jan 2016 12:07:37 +1100 (AEDT)
From: Russell Currey <ruscur@russell.cc>
To: linuxppc-dev@lists.ozlabs.org
Cc: stewart@linux.vnet.ibm.com,
	Russell Currey <ruscur@russell.cc>
Subject: [PATCH] powerpc/powernv: Fix OPAL_CONSOLE_FLUSH prototype and usages
Date: Wed, 13 Jan 2016 12:04:32 +1100
Message-Id: <1452647072-23321-1-git-send-email-ruscur@russell.cc>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

The recently added OPAL API call, OPAL_CONSOLE_FLUSH, originally took no
parameters and returned nothing.  The call was updated to accept the
terminal number to flush, and returned various values depending on the
state of the output buffer.

The prototype has been updated and its usage in the OPAL kmsg dumper has
been modified to support its new behaviour as an incremental flush.

Signed-off-by: Russell Currey <ruscur@russell.cc>
---
This patch should be applied on top of "powerpc/powernv: Add a kmsg_dumper
that flushes console output on panic", which was recently merged into
powerpc-next.
---
 arch/powerpc/include/asm/opal.h            | 2 +-
 arch/powerpc/platforms/powernv/opal-kmsg.c | 9 ++++++++-
 2 files changed, 9 insertions(+), 2 deletions(-)

diff --git a/arch/powerpc/include/asm/opal.h b/arch/powerpc/include/asm/opal.h
index a5fd407..07a99e6 100644
--- a/arch/powerpc/include/asm/opal.h
+++ b/arch/powerpc/include/asm/opal.h
@@ -35,7 +35,7 @@ int64_t opal_console_read(int64_t term_number, __be64 *length,
 			  uint8_t *buffer);
 int64_t opal_console_write_buffer_space(int64_t term_number,
 					__be64 *length);
-void opal_console_flush(void);
+int64_t opal_console_flush(int64_t term_number);
 int64_t opal_rtc_read(__be32 *year_month_day,
 		      __be64 *hour_minute_second_millisecond);
 int64_t opal_rtc_write(uint32_t year_month_day,
diff --git a/arch/powerpc/platforms/powernv/opal-kmsg.c b/arch/powerpc/platforms/powernv/opal-kmsg.c
index bd3b2ee..6f1214d 100644
--- a/arch/powerpc/platforms/powernv/opal-kmsg.c
+++ b/arch/powerpc/platforms/powernv/opal-kmsg.c
@@ -27,6 +27,7 @@ static void force_opal_console_flush(struct kmsg_dumper *dumper,
 				     enum kmsg_dump_reason reason)
 {
 	int i;
+	int64_t ret;
 
 	/*
 	 * Outside of a panic context the pollers will continue to run,
@@ -36,7 +37,13 @@ static void force_opal_console_flush(struct kmsg_dumper *dumper,
 		return;
 
 	if (opal_check_token(OPAL_CONSOLE_FLUSH)) {
-		opal_console_flush();
+		ret = opal_console_flush(0);
+
+		if (ret == OPAL_UNSUPPORTED || ret == OPAL_PARAMETER)
+			return;
+
+		/* Incrementally flush until there's nothing left */
+		while (opal_console_flush(0) != OPAL_SUCCESS);
 	} else {
 		/*
 		 * If OPAL_CONSOLE_FLUSH is not implemented in the firmware,
-- 
2.7.0
