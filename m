Return-Path: <suzuki@in.ibm.com>
Received: from e23smtp04.au.ibm.com (e23smtp04.au.ibm.com [202.81.31.146])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client CN "e23smtp04.au.ibm.com", Issuer "GeoTrust SSL CA" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 71C2EB7431
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 15 Nov 2011 13:44:09 +1100 (EST)
Received: from /spool/local
 by e23smtp04.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <suzuki@in.ibm.com>;
 Tue, 15 Nov 2011 02:32:11 +1000
Received: from d23av01.au.ibm.com (d23av01.au.ibm.com [9.190.234.96])
 by d23relay04.au.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
 pAF2enqf2748524
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 15 Nov 2011 13:40:49 +1100
Received: from d23av01.au.ibm.com (loopback [127.0.0.1])
 by d23av01.au.ibm.com (8.14.4/8.13.1/NCO v10.0 AVout) with ESMTP id
 pAF2hrwe027776
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 15 Nov 2011 13:43:54 +1100
From: "Suzuki K. Poulose" <suzuki@in.ibm.com>
Subject: [UPDATED] [PATCH v3 1/8] [44x] Fix typo in KEXEC CONFIG dependency
To: linux-ppc dev <linuxppc-dev@lists.ozlabs.org>,
 Josh Boyer <jwboyer@gmail.com>
Date: Tue, 15 Nov 2011 08:13:50 +0530
Message-ID: <20111115024032.21658.64055.stgit@suzukikp.in.ibm.com>
In-Reply-To: <20111114054129.23410.57513.stgit@suzukikp.in.ibm.com>
References: <20111114054129.23410.57513.stgit@suzukikp.in.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Cc: Paul Bolle <pebolle@tiscali.nl>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Kexec is not supported on 47x. 47x is a variant of 44x with slightly
different MMU and SMP support. There was a typo in the config
dependency for KEXEC. This patch fixes the same.

Signed-off-by: Suzuki K. Poulose <suzuki@in.ibm.com>
Signed-off-by: Paul Bolle <pebolle@tiscali.nl>
Cc:	Kumar Gala <galak@kernel.crashing.org>
Cc:	Josh Boyer <jwboyer@gmail.com>
Cc:	linux ppc dev <linuxppc-dev@lists.ozlabs.org>
---

 arch/powerpc/Kconfig          |    2 +-
 arch/powerpc/kernel/misc_32.S |    2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/powerpc/Kconfig b/arch/powerpc/Kconfig
index 8523bd1..d7c2d1a 100644
--- a/arch/powerpc/Kconfig
+++ b/arch/powerpc/Kconfig
@@ -345,7 +345,7 @@ config ARCH_ENABLE_MEMORY_HOTREMOVE
 
 config KEXEC
 	bool "kexec system call (EXPERIMENTAL)"
-	depends on (PPC_BOOK3S || FSL_BOOKE || (44x && !SMP && !47x)) && EXPERIMENTAL
+	depends on (PPC_BOOK3S || FSL_BOOKE || (44x && !SMP && !PPC_47x)) && EXPERIMENTAL
 	help
 	  kexec is a system call that implements the ability to shutdown your
 	  current kernel, and to start another kernel.  It is like a reboot
diff --git a/arch/powerpc/kernel/misc_32.S b/arch/powerpc/kernel/misc_32.S
index f7d760a..7cd07b4 100644
--- a/arch/powerpc/kernel/misc_32.S
+++ b/arch/powerpc/kernel/misc_32.S
@@ -738,7 +738,7 @@ relocate_new_kernel:
 	mr      r5, r31
 
 	li	r0, 0
-#elif defined(CONFIG_44x)  && !defined(CONFIG_47x)
+#elif defined(CONFIG_44x)  && !defined(CONFIG_PPC_47x)
 
 /*
  * Code for setting up 1:1 mapping for PPC440x for KEXEC
