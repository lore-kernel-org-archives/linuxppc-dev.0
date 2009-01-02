Return-Path: <mohan@in.ibm.com>
Received: from e2.ny.us.ibm.com (e2.ny.us.ibm.com [32.97.182.142])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e2.ny.us.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id B5AF0DDEFE
	for <linuxppc-dev@ozlabs.org>; Sat,  3 Jan 2009 04:55:19 +1100 (EST)
Received: from d01relay04.pok.ibm.com (d01relay04.pok.ibm.com [9.56.227.236])
	by e2.ny.us.ibm.com (8.13.1/8.13.1) with ESMTP id n02Hs4qW019928
	for <linuxppc-dev@ozlabs.org>; Fri, 2 Jan 2009 12:54:04 -0500
Received: from d01av02.pok.ibm.com (d01av02.pok.ibm.com [9.56.224.216])
	by d01relay04.pok.ibm.com (8.13.8/8.13.8/NCO v9.1) with ESMTP id
	n02HtDhv174276
	for <linuxppc-dev@ozlabs.org>; Fri, 2 Jan 2009 12:55:13 -0500
Received: from d01av02.pok.ibm.com (loopback [127.0.0.1])
	by d01av02.pok.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id
	n02HsUVk014998
	for <linuxppc-dev@ozlabs.org>; Fri, 2 Jan 2009 12:54:30 -0500
Date: Fri, 2 Jan 2009 23:25:13 +0530
From: "M. Mohan Kumar" <mohan@in.ibm.com>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>,
	Paul Mackerras <paulus@samba.org>
Subject: [PATCH] ppc64: Enable RELOCATABLE option for CRASH_DUMP
Message-ID: <20090102175513.GA8028@in.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: linuxppc-dev@ozlabs.org
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
index 79f25ce..0cdce19 100644
--- a/arch/powerpc/Kconfig
+++ b/arch/powerpc/Kconfig
@@ -326,7 +326,8 @@ config KEXEC
 
 config CRASH_DUMP
 	bool "Build a kdump crash kernel"
-	depends on (PPC64 && RELOCATABLE) || 6xx
+	depends on PPC64 || 6xx
+	select RELOCATABLE
 	help
 	  Build a kernel suitable for use as a kdump capture kernel.
 	  The same kernel binary can be used as production kernel and dump
-- 
1.6.0.2
