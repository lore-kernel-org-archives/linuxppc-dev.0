Return-Path: <mohan@in.ibm.com>
Received: from e33.co.us.ibm.com (e33.co.us.ibm.com [32.97.110.151])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e32.co.us.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id 50C85DE259
	for <linuxppc-dev@ozlabs.org>; Tue,  6 Jan 2009 21:23:09 +1100 (EST)
Received: from d03relay02.boulder.ibm.com (d03relay02.boulder.ibm.com
	[9.17.195.227])
	by e33.co.us.ibm.com (8.13.1/8.13.1) with ESMTP id n06AMDNL013697
	for <linuxppc-dev@ozlabs.org>; Tue, 6 Jan 2009 03:22:13 -0700
Received: from d03av02.boulder.ibm.com (d03av02.boulder.ibm.com [9.17.195.168])
	by d03relay02.boulder.ibm.com (8.13.8/8.13.8/NCO v9.1) with ESMTP id
	n06AN4dW211844
	for <linuxppc-dev@ozlabs.org>; Tue, 6 Jan 2009 03:23:04 -0700
Received: from d03av02.boulder.ibm.com (loopback [127.0.0.1])
	by d03av02.boulder.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id
	n06AN3CA013760
	for <linuxppc-dev@ozlabs.org>; Tue, 6 Jan 2009 03:23:04 -0700
Date: Tue, 6 Jan 2009 15:53:01 +0530
From: "M. Mohan Kumar" <mohan@in.ibm.com>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>,
	Paul Mackerras <paulus@samba.org>
Subject: [PATCH] ppc64: Enable RELOCATABLE option for CRASH_DUMP
Message-ID: <20090106102301.GA16676@in.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: linuxppc-dev@ozlabs.org, Milton Miller <miltonm@bga.com>
Reply-To: mohan@in.ibm.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Enable RELOCATABLE option if user selects CRASH_DUMP option. Without this
patch user has to first select RELOCATABLE option and then has to enable
CRASH_DUMP option.

Signed-off-by: M. Mohan Kumar <mohan@in.ibm.com>
---
 arch/powerpc/Kconfig |    3 ++-
 1 files changed, 2 insertions(+), 1 deletions(-)

diff --git a/arch/powerpc/Kconfig b/arch/powerpc/Kconfig
index 79f25ce..acda551 100644
--- a/arch/powerpc/Kconfig
+++ b/arch/powerpc/Kconfig
@@ -326,7 +326,8 @@ config KEXEC
 
 config CRASH_DUMP
 	bool "Build a kdump crash kernel"
-	depends on (PPC64 && RELOCATABLE) || 6xx
+	depends on PPC64 || 6xx
+	select RELOCATABLE if PPC64
 	help
 	  Build a kernel suitable for use as a kdump capture kernel.
 	  The same kernel binary can be used as production kernel and dump
-- 
1.5.5
