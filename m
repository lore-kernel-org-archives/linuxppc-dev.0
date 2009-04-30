Return-Path: <tabbott@MIT.EDU>
Received: from biscayne-one-station.mit.edu (BISCAYNE-ONE-STATION.MIT.EDU
	[18.7.7.80])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id E246ADF8A8
	for <linuxppc-dev@ozlabs.org>; Fri,  1 May 2009 10:06:33 +1000 (EST)
From: Tim Abbott <tabbott@MIT.EDU>
To: Sam Ravnborg <sam@ravnborg.org>
Subject: [PATCH 8/8] powerpc: convert to new generic read_mostly support.
Date: Thu, 30 Apr 2009 19:56:17 -0400
Message-Id: <1241135777-9462-9-git-send-email-tabbott@mit.edu>
In-Reply-To: <1241135777-9462-8-git-send-email-tabbott@mit.edu>
References: <1241135777-9462-1-git-send-email-tabbott@mit.edu>
	<1241135777-9462-2-git-send-email-tabbott@mit.edu>
	<1241135777-9462-3-git-send-email-tabbott@mit.edu>
	<1241135777-9462-4-git-send-email-tabbott@mit.edu>
	<1241135777-9462-5-git-send-email-tabbott@mit.edu>
	<1241135777-9462-6-git-send-email-tabbott@mit.edu>
	<1241135777-9462-7-git-send-email-tabbott@mit.edu>
	<1241135777-9462-8-git-send-email-tabbott@mit.edu>
Cc: Denys Vlasenko <vda.linux@googlemail.com>, Jeff Arnold <jbarnold@mit.edu>,
	Linux kernel mailing list <linux-kernel@vger.kernel.org>,
	Anders Kaseorg <andersk@mit.edu>, linuxppc-dev@ozlabs.org,
	Paul Mackerras <paulus@samba.org>, Tim Abbott <tabbott@mit.edu>,
	Waseem Daher <wdaher@mit.edu>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Signed-off-by: Tim Abbott <tabbott@mit.edu>
Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: Paul Mackerras <paulus@samba.org>
Cc: linuxppc-dev@ozlabs.org
---
 arch/powerpc/Kconfig             |    3 +++
 arch/powerpc/include/asm/cache.h |    4 ----
 2 files changed, 3 insertions(+), 4 deletions(-)

diff --git a/arch/powerpc/Kconfig b/arch/powerpc/Kconfig
index 4c78045..d29ea59 100644
--- a/arch/powerpc/Kconfig
+++ b/arch/powerpc/Kconfig
@@ -32,6 +32,9 @@ config GENERIC_CMOS_UPDATE
 config GENERIC_TIME
 	def_bool y
 
+config HAVE_READ_MOSTLY_DATA
+	def_bool y
+
 config GENERIC_TIME_VSYSCALL
 	def_bool y
 
diff --git a/arch/powerpc/include/asm/cache.h b/arch/powerpc/include/asm/cache.h
index 81de6eb..1843a11 100644
--- a/arch/powerpc/include/asm/cache.h
+++ b/arch/powerpc/include/asm/cache.h
@@ -37,9 +37,5 @@ struct ppc64_caches {
 extern struct ppc64_caches ppc64_caches;
 #endif /* __powerpc64__ && ! __ASSEMBLY__ */
 
-#if !defined(__ASSEMBLY__)
-#define __read_mostly __attribute__((__section__(".data.read_mostly")))
-#endif
-
 #endif /* __KERNEL__ */
 #endif /* _ASM_POWERPC_CACHE_H */
-- 
1.6.2.1
