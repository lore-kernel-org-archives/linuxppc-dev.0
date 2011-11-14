Return-Path: <suzuki@in.ibm.com>
Received: from e23smtp09.au.ibm.com (e23smtp09.au.ibm.com [202.81.31.142])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client CN "e23smtp09.au.ibm.com", Issuer "Equifax" (verified OK))
 by ozlabs.org (Postfix) with ESMTPS id BCC32B6F65
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 14 Nov 2011 16:46:30 +1100 (EST)
Received: from /spool/local
 by e23smtp09.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <suzuki@in.ibm.com>;
 Mon, 14 Nov 2011 06:40:39 +1000
Received: from d23av04.au.ibm.com (d23av04.au.ibm.com [9.190.235.139])
 by d23relay05.au.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
 pAE5f2AH446490
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 14 Nov 2011 16:41:02 +1100
Received: from d23av04.au.ibm.com (loopback [127.0.0.1])
 by d23av04.au.ibm.com (8.14.4/8.13.1/NCO v10.0 AVout) with ESMTP id
 pAE5i87J020574
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 14 Nov 2011 16:44:09 +1100
From: "Suzuki K. Poulose" <suzuki@in.ibm.com>
Subject: [PATCH v3 7/8] [44x] Enable CRASH_DUMP for 440x
To: linuxppc-dev <linuxppc-dev@lists.ozlabs.org>
Date: Mon, 14 Nov 2011 11:14:06 +0530
Message-ID: <20111114054359.23410.66297.stgit@suzukikp.in.ibm.com>
In-Reply-To: <20111114053749.23410.63745.stgit@suzukikp.in.ibm.com>
References: <20111114053749.23410.63745.stgit@suzukikp.in.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Cc: Josh Poimboeuf <jpoimboe@linux.vnet.ibm.com>,
 David Laight <David.Laight@ACULAB.COM>, Alan Modra <amodra@au1.ibm.com>,
 Scott Wood <scottwood@freescale.com>
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
Cc:	Josh Boyer <jwboyer@gmail.com>
Cc:	Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc:	linuxppc-dev <linuxppc-dev@lists.ozlabs.org>
---

 arch/powerpc/Kconfig |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/powerpc/Kconfig b/arch/powerpc/Kconfig
index 7923520..d3fe852 100644
--- a/arch/powerpc/Kconfig
+++ b/arch/powerpc/Kconfig
@@ -362,8 +362,8 @@ config KEXEC
 
 config CRASH_DUMP
 	bool "Build a kdump crash kernel"
-	depends on PPC64 || 6xx || FSL_BOOKE
-	select RELOCATABLE if PPC64
+	depends on PPC64 || 6xx || FSL_BOOKE || (44x && !SMP && !PPC_47x)
+	select RELOCATABLE if PPC64 || 44x
 	select DYNAMIC_MEMSTART if FSL_BOOKE
 	help
 	  Build a kernel suitable for use as a kdump capture kernel.
