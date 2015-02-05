Return-Path: <hbathini@linux.vnet.ibm.com>
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 45F461A1390
 for <linuxppc-dev@lists.ozlabs.org>; Fri,  6 Feb 2015 06:38:12 +1100 (AEDT)
Received: from e23smtp04.au.ibm.com (e23smtp04.au.ibm.com [202.81.31.146])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id EE36B140273
 for <linuxppc-dev@ozlabs.org>; Fri,  6 Feb 2015 06:38:11 +1100 (AEDT)
Received: from /spool/local
 by e23smtp04.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@ozlabs.org> from <hbathini@linux.vnet.ibm.com>;
 Fri, 6 Feb 2015 05:38:11 +1000
Received: from d23relay10.au.ibm.com (d23relay10.au.ibm.com [9.190.26.77])
 by d23dlp03.au.ibm.com (Postfix) with ESMTP id 25F393578048
 for <linuxppc-dev@ozlabs.org>; Fri,  6 Feb 2015 06:38:09 +1100 (EST)
Received: from d23av02.au.ibm.com (d23av02.au.ibm.com [9.190.235.138])
 by d23relay10.au.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 t15Jc0SW43778294
 for <linuxppc-dev@ozlabs.org>; Fri, 6 Feb 2015 06:38:09 +1100
Received: from d23av02.au.ibm.com (localhost [127.0.0.1])
 by d23av02.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 t15JbYdS021368
 for <linuxppc-dev@ozlabs.org>; Fri, 6 Feb 2015 06:37:35 +1100
Subject: [PATCH v5 4/4] powerpc: make timestamp related code y2038-safe
From: Hari Bathini <hbathini@linux.vnet.ibm.com>
To: Tony Luck <tony.luck@intel.com>, Kees Cook <keescook@chromium.org>,
 Anton Vorontsov <anton@enomsg.org>, lkml <linux-kernel@vger.kernel.org>,
 linuxppc-dev <linuxppc-dev@ozlabs.org>, Colin Cross <ccross@android.com>
Date: Fri, 06 Feb 2015 01:07:17 +0530
Message-ID: <20150205193716.24669.94228.stgit@localhost.localdomain>
In-Reply-To: <20150205193412.24669.8648.stgit@localhost.localdomain>
References: <20150205193412.24669.8648.stgit@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Cc: Mahesh J Salgaonkar <mahesh@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

While we are here, let us make timestamp related code
y2038-safe.

Suggested-by: Arnd Bergmann <arnd@arndb.de>
Signed-off-by: Hari Bathini <hbathini@linux.vnet.ibm.com>
---
 arch/powerpc/include/asm/rtas.h        |    3 ++-
 arch/powerpc/kernel/nvram_64.c         |    6 +++---
 arch/powerpc/platforms/pseries/nvram.c |   10 +++++-----
 3 files changed, 10 insertions(+), 9 deletions(-)

diff --git a/arch/powerpc/include/asm/rtas.h b/arch/powerpc/include/asm/rtas.h
index 123d7ff..efa9152 100644
--- a/arch/powerpc/include/asm/rtas.h
+++ b/arch/powerpc/include/asm/rtas.h
@@ -4,6 +4,7 @@
 
 #include <linux/spinlock.h>
 #include <asm/page.h>
+#include <linux/time.h>
 
 /*
  * Definitions for talking to the RTAS on CHRP machines.
@@ -343,7 +344,7 @@ extern int early_init_dt_scan_rtas(unsigned long node,
 extern void pSeries_log_error(char *buf, unsigned int err_type, int fatal);
 
 #ifdef CONFIG_PPC_PSERIES
-extern unsigned long last_rtas_event;
+extern time64_t last_rtas_event;
 extern int clobbering_unread_rtas_event(void);
 extern int pseries_devicetree_update(s32 scope);
 extern void post_mobility_fixup(void);
diff --git a/arch/powerpc/kernel/nvram_64.c b/arch/powerpc/kernel/nvram_64.c
index 293da88..1e703f8 100644
--- a/arch/powerpc/kernel/nvram_64.c
+++ b/arch/powerpc/kernel/nvram_64.c
@@ -376,7 +376,7 @@ static int zip_oops(size_t text_len)
 	}
 	oops_hdr->version = cpu_to_be16(OOPS_HDR_VERSION);
 	oops_hdr->report_length = cpu_to_be16(zipped_len);
-	oops_hdr->timestamp = cpu_to_be64(get_seconds());
+	oops_hdr->timestamp = cpu_to_be64(ktime_get_real_seconds());
 	return 0;
 }
 
@@ -423,7 +423,7 @@ static int nvram_pstore_write(enum pstore_type_id type,
 
 	oops_hdr->version = cpu_to_be16(OOPS_HDR_VERSION);
 	oops_hdr->report_length = cpu_to_be16(size);
-	oops_hdr->timestamp = cpu_to_be64(get_seconds());
+	oops_hdr->timestamp = cpu_to_be64(ktime_get_real_seconds());
 
 	if (compressed)
 		err_type = ERR_TYPE_KERNEL_PANIC_GZ;
@@ -721,7 +721,7 @@ static void oops_to_nvram(struct kmsg_dumper *dumper,
 		err_type = ERR_TYPE_KERNEL_PANIC;
 		oops_hdr->version = cpu_to_be16(OOPS_HDR_VERSION);
 		oops_hdr->report_length = cpu_to_be16(text_len);
-		oops_hdr->timestamp = cpu_to_be64(get_seconds());
+		oops_hdr->timestamp = cpu_to_be64(ktime_get_real_seconds());
 	}
 
 	(void) nvram_write_os_partition(&oops_log_partition, oops_buf,
diff --git a/arch/powerpc/platforms/pseries/nvram.c b/arch/powerpc/platforms/pseries/nvram.c
index 97b8fc6..d77713b 100644
--- a/arch/powerpc/platforms/pseries/nvram.c
+++ b/arch/powerpc/platforms/pseries/nvram.c
@@ -37,10 +37,10 @@ static DEFINE_SPINLOCK(nvram_lock);
 
 /* See clobbering_unread_rtas_event() */
 #define NVRAM_RTAS_READ_TIMEOUT 5		/* seconds */
-static unsigned long last_unread_rtas_event;	/* timestamp */
+static time64_t last_unread_rtas_event;		/* timestamp */
 
 #ifdef CONFIG_PSTORE
-unsigned long last_rtas_event;
+time64_t last_rtas_event;
 #endif
 
 static ssize_t pSeries_nvram_read(char *buf, size_t count, loff_t *index)
@@ -145,9 +145,9 @@ int nvram_write_error_log(char * buff, int length,
 	int rc = nvram_write_os_partition(&rtas_log_partition, buff, length,
 						err_type, error_log_cnt);
 	if (!rc) {
-		last_unread_rtas_event = get_seconds();
+		last_unread_rtas_event = ktime_get_real_seconds();
 #ifdef CONFIG_PSTORE
-		last_rtas_event = get_seconds();
+		last_rtas_event = ktime_get_real_seconds();
 #endif
 	}
 
@@ -201,7 +201,7 @@ int clobbering_unread_rtas_event(void)
 {
 	return (oops_log_partition.index == rtas_log_partition.index
 		&& last_unread_rtas_event
-		&& get_seconds() - last_unread_rtas_event <=
+		&& ktime_get_real_seconds() - last_unread_rtas_event <=
 						NVRAM_RTAS_READ_TIMEOUT);
 }
 
