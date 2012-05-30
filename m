Return-Path: <zhong@linux.vnet.ibm.com>
Received: from e28smtp06.in.ibm.com (e28smtp06.in.ibm.com [122.248.162.6])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client CN "e28smtp06.in.ibm.com", Issuer "GeoTrust SSL CA" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id AB834B7042
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 30 May 2012 19:32:07 +1000 (EST)
Received: from /spool/local
 by e28smtp06.in.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <zhong@linux.vnet.ibm.com>;
 Wed, 30 May 2012 15:02:03 +0530
Received: from d28av02.in.ibm.com (d28av02.in.ibm.com [9.184.220.64])
 by d28relay01.in.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
 q4U9W0cN63176762
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 30 May 2012 15:02:01 +0530
Received: from d28av02.in.ibm.com (loopback [127.0.0.1])
 by d28av02.in.ibm.com (8.14.4/8.13.1/NCO v10.0 AVout) with ESMTP id
 q4UF2cRJ017198
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 31 May 2012 01:02:38 +1000
Message-ID: <1338370318.3637.12.camel@ThinkPad-T420>
Subject: [RFC PATCH powerpc] make CONFIG_NUMA depends on CONFIG_SMP
From: Li Zhong <zhong@linux.vnet.ibm.com>
Date: Wed, 30 May 2012 17:31:58 +0800
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Cc: Paul Mackerras <paulus@samba.org>,
 PowerPC email list <linuxppc-dev@lists.ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

I'm not sure whether it makes sense to add this dependency to avoid
CONFI_NUMA && !CONFIG_SMP. 

I want to do this because I saw some build errors on next-tree when
compiling with CONFIG_SMP disabled, and it seems they are caused by some
codes under the CONFIG_NUMA #ifdefs.  

Signed-off-by: Li Zhong <zhong@linux.vnet.ibm.com>
---
 arch/powerpc/Kconfig |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/arch/powerpc/Kconfig b/arch/powerpc/Kconfig
index 050cb37..b2aa74b 100644
--- a/arch/powerpc/Kconfig
+++ b/arch/powerpc/Kconfig
@@ -394,7 +394,7 @@ config IRQ_ALL_CPUS
 
 config NUMA
 	bool "NUMA support"
-	depends on PPC64
+	depends on PPC64 && SMP
 	default y if SMP && PPC_PSERIES
 
 config NODES_SHIFT
-- 
1.7.1
