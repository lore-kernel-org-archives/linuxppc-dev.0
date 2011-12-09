Return-Path: <suzuki@in.ibm.com>
Received: from e28smtp09.in.ibm.com (e28smtp09.in.ibm.com [122.248.162.9])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client CN "e28smtp09.in.ibm.com", Issuer "GeoTrust SSL CA" (verified OK))
 by ozlabs.org (Postfix) with ESMTPS id 6880F100863
 for <linuxppc-dev@lists.ozlabs.org>; Fri,  9 Dec 2011 22:48:25 +1100 (EST)
Received: from /spool/local
 by e28smtp09.in.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <suzuki@in.ibm.com>;
 Fri, 9 Dec 2011 17:18:23 +0530
Received: from d28av01.in.ibm.com (d28av01.in.ibm.com [9.184.220.63])
 by d28relay03.in.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
 pB9BmLVo4358392
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 9 Dec 2011 17:18:22 +0530
Received: from d28av01.in.ibm.com (loopback [127.0.0.1])
 by d28av01.in.ibm.com (8.14.4/8.13.1/NCO v10.0 AVout) with ESMTP id
 pB9BmK2o028099
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 9 Dec 2011 17:18:21 +0530
From: "Suzuki K. Poulose" <suzuki@in.ibm.com>
Subject: [PATCH v4 6/7] [44x] Enable CRASH_DUMP for 440x
To: Josh Boyer <jwboyer@gmail.com>,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>
Date: Fri, 09 Dec 2011 17:18:20 +0530
Message-ID: <20111209114808.16360.44506.stgit@suzukikp.in.ibm.com>
In-Reply-To: <20111209114148.15616.15996.stgit@suzukikp.in.ibm.com>
References: <20111209114148.15616.15996.stgit@suzukikp.in.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Cc: Scott Wood <scottwood@freescale.com>,
 Josh Poimboeuf <jpoimboe@linux.vnet.ibm.com>,
 linux ppc dev <linuxppc-dev@lists.ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Now that we have relocatable kernel, supporting CRASH_DUMP only requires
turning the switches on for UP machines.

We don't have kexec support on 47x yet. Enabling SMP support would be done
as part of enabling the PPC_47x support.


Signed-off-by: Suzuki K. Poulose <suzuki@in.ibm.com>
Cc: Josh Boyer <jwboyer@gmail.com>
Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: linuxppc-dev <linuxppc-dev@lists.ozlabs.org>
---

 arch/powerpc/Kconfig |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/powerpc/Kconfig b/arch/powerpc/Kconfig
index 90cd8d3..d612943 100644
--- a/arch/powerpc/Kconfig
+++ b/arch/powerpc/Kconfig
@@ -363,8 +363,8 @@ config KEXEC
 
 config CRASH_DUMP
 	bool "Build a kdump crash kernel"
-	depends on PPC64 || 6xx || FSL_BOOKE
-	select RELOCATABLE if PPC64
+	depends on PPC64 || 6xx || FSL_BOOKE || (44x && !SMP && !PPC_47x)
+	select RELOCATABLE if PPC64 || 44x
 	select DYNAMIC_MEMSTART if FSL_BOOKE
 	help
 	  Build a kernel suitable for use as a kdump capture kernel.
