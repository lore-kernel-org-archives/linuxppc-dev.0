Return-Path: <mahesh@linux.vnet.ibm.com>
Received: from e23smtp04.au.ibm.com (e23smtp04.au.ibm.com [202.81.31.146])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client CN "e23smtp04.au.ibm.com", Issuer "GeoTrust SSL CA" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 5DF922C00CB
 for <linuxppc-dev@ozlabs.org>; Fri, 15 Nov 2013 15:20:55 +1100 (EST)
Received: from /spool/local
 by e23smtp04.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@ozlabs.org> from <mahesh@linux.vnet.ibm.com>;
 Fri, 15 Nov 2013 14:20:55 +1000
Received: from d23relay03.au.ibm.com (d23relay03.au.ibm.com [9.190.235.21])
 by d23dlp02.au.ibm.com (Postfix) with ESMTP id 666402BB0044
 for <linuxppc-dev@ozlabs.org>; Fri, 15 Nov 2013 15:20:52 +1100 (EST)
Received: from d23av04.au.ibm.com (d23av04.au.ibm.com [9.190.235.139])
 by d23relay03.au.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
 rAF4Ke9L9568738
 for <linuxppc-dev@ozlabs.org>; Fri, 15 Nov 2013 15:20:40 +1100
Received: from d23av04.au.ibm.com (localhost [127.0.0.1])
 by d23av04.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 rAF4KpWM007038
 for <linuxppc-dev@ozlabs.org>; Fri, 15 Nov 2013 15:20:51 +1100
Subject: [PATCH 1/2] powerpc/powernv: Add config option for hwpoisoning.
To: linuxppc-dev <linuxppc-dev@ozlabs.org>,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>
From: Mahesh J Salgaonkar <mahesh@linux.vnet.ibm.com>
Date: Fri, 15 Nov 2013 09:50:50 +0530
Message-ID: <20131115042050.5748.79036.stgit@mars.in.ibm.com>
In-Reply-To: <20131115041952.5748.19640.stgit@mars.in.ibm.com>
References: <20131115041952.5748.19640.stgit@mars.in.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

From: Mahesh Salgaonkar <mahesh@linux.vnet.ibm.com>

Add config option to enable generic memory hwpoisoning infrastructure for
ppc64.

Signed-off-by: Mahesh Salgaonkar <mahesh@linux.vnet.ibm.com>
---
 arch/powerpc/Kconfig |    6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/arch/powerpc/Kconfig b/arch/powerpc/Kconfig
index 38f3b7e..4690f5a 100644
--- a/arch/powerpc/Kconfig
+++ b/arch/powerpc/Kconfig
@@ -375,6 +375,12 @@ config ARCH_HAS_WALK_MEMORY
 config ARCH_ENABLE_MEMORY_HOTREMOVE
 	def_bool y
 
+config PPC64_SUPPORTS_MEMORY_FAILURE
+	bool "Add support for memory hwpoison"
+	depends on PPC_BOOK3S_64
+	default "y" if PPC_POWERNV
+	select ARCH_SUPPORTS_MEMORY_FAILURE
+
 config KEXEC
 	bool "kexec system call"
 	depends on (PPC_BOOK3S || FSL_BOOKE || (44x && !SMP))
