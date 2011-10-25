Return-Path: <suzuki@in.ibm.com>
Received: from e28smtp09.in.ibm.com (e28smtp09.in.ibm.com [122.248.162.9])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client CN "e28smtp09.in.ibm.com", Issuer "Equifax" (verified OK))
 by ozlabs.org (Postfix) with ESMTPS id 4478E1007E0
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 25 Oct 2011 22:55:59 +1100 (EST)
Received: from /spool/local by e28smtp09.in.ibm.com with XMail ESMTP
 for <linuxppc-dev@lists.ozlabs.org> from <suzuki@in.ibm.com>;
 Tue, 25 Oct 2011 17:25:54 +0530
Received: from d28av05.in.ibm.com (d28av05.in.ibm.com [9.184.220.67])
 by d28relay05.in.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
 p9PBsXbv3563704
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 25 Oct 2011 17:24:33 +0530
Received: from d28av05.in.ibm.com (loopback [127.0.0.1])
 by d28av05.in.ibm.com (8.14.4/8.13.1/NCO v10.0 AVout) with ESMTP id
 p9PBsWGW003211
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 25 Oct 2011 22:54:33 +1100
From: "Suzuki K. Poulose" <suzuki@in.ibm.com>
Subject: [PATCH v2 4/5] [44x] Enable CRASH_DUMP for 440x
To: linuxppc-dev <linuxppc-dev@lists.ozlabs.org>
Date: Tue, 25 Oct 2011 17:24:31 +0530
Message-ID: <20111025115427.8183.9557.stgit@suzukikp.in.ibm.com>
In-Reply-To: <20111025114829.8183.1725.stgit@suzukikp.in.ibm.com>
References: <20111025114829.8183.1725.stgit@suzukikp.in.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Cc: Suzuki Poulose <suzuki@in.ibm.com>, Alan Modra <amodra@au1.ibm.com>,
 Scott Wood <scottwood@freescale.com>, Paul Mackerras <paulus@samba.org>,
 Dave Hansen <dave@linux.vnet.ibm.com>
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
index 1cedcda..4de7733 100644
--- a/arch/powerpc/Kconfig
+++ b/arch/powerpc/Kconfig
@@ -362,8 +362,8 @@ config KEXEC
 
 config CRASH_DUMP
 	bool "Build a kdump crash kernel"
-	depends on PPC64 || 6xx || FSL_BOOKE
-	select RELOCATABLE if PPC64 || FSL_BOOKE
+	depends on PPC64 || 6xx || FSL_BOOKE || (44x && !SMP)
+	select RELOCATABLE if PPC64 || FSL_BOOKE || 44x
 	help
 	  Build a kernel suitable for use as a kdump capture kernel.
 	  The same kernel binary can be used as production kernel and dump
