Return-Path: <suzuki@in.ibm.com>
Received: from e23smtp06.au.ibm.com (e23smtp06.au.ibm.com [202.81.31.148])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client CN "e23smtp06.au.ibm.com", Issuer "GeoTrust SSL CA" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id AAA9CB6FE0
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 14 Mar 2012 21:24:39 +1100 (EST)
Received: from /spool/local
 by e23smtp06.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <suzuki@in.ibm.com>;
 Wed, 14 Mar 2012 10:20:08 +1000
Received: from d23av03.au.ibm.com (d23av03.au.ibm.com [9.190.234.97])
 by d23relay03.au.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
 q2EANndJ1511446
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 14 Mar 2012 21:23:51 +1100
Received: from d23av03.au.ibm.com (loopback [127.0.0.1])
 by d23av03.au.ibm.com (8.14.4/8.13.1/NCO v10.0 AVout) with ESMTP id
 q2EANmQn023279
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 14 Mar 2012 21:23:48 +1100
From: "Suzuki K. Poulose" <suzuki@in.ibm.com>
Subject: [PATCH 2/2] [47x] Enable CRASH_DUMP
To: jwboyer@gmail.com
Date: Wed, 14 Mar 2012 15:53:42 +0530
Message-ID: <20120314102336.675.92570.stgit@suzukikp.in.ibm.com>
In-Reply-To: <20120314102121.675.92862.stgit@suzukikp.in.ibm.com>
References: <20120314102121.675.92862.stgit@suzukikp.in.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Cc: linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Now that we have KEXEC and relocatable kernel working on 47x (!SMP)
enable CRASH_DUMP.

Signed-off-by: Suzuki K. Poulose <suzuki@in.ibm.com>
---

 arch/powerpc/Kconfig |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/arch/powerpc/Kconfig b/arch/powerpc/Kconfig
index 975aae5..10070d2 100644
--- a/arch/powerpc/Kconfig
+++ b/arch/powerpc/Kconfig
@@ -363,7 +363,7 @@ config KEXEC
 
 config CRASH_DUMP
 	bool "Build a kdump crash kernel"
-	depends on PPC64 || 6xx || FSL_BOOKE || (44x && !SMP && !PPC_47x)
+	depends on PPC64 || 6xx || FSL_BOOKE || (44x && !SMP)
 	select RELOCATABLE if PPC64 || 44x
 	select DYNAMIC_MEMSTART if FSL_BOOKE
 	help
