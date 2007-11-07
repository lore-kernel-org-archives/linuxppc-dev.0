Return-Path: <johannes@sipsolutions.net>
Received: from sipsolutions.net (crystal.sipsolutions.net [195.210.38.204])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id DE91EDDEB9
	for <linuxppc-dev@ozlabs.org>; Thu,  8 Nov 2007 02:05:31 +1100 (EST)
Subject: [PATCH] powerpc swsusp: make altivec code depend on CONFIG_ALTIVEC
From: Johannes Berg <johannes@sipsolutions.net>
To: Paul Mackerras <paulus@samba.org>
In-Reply-To: <1194428323.4055.3.camel@johannes.berg>
References: <47304343.2010709@linux.vnet.ibm.com>
	<661de9470711060246s3040f68drf0a6310aeec4e1e8@mail.gmail.com>
	<1194346486.4066.13.camel@johannes.berg>
	<20071106.031001.189578769.davem@davemloft.net>
	<47304FE5.2010309@linux.vnet.ibm.com>
	<47306E9C.4090202@linux.vnet.ibm.com>
	<20071106154439.GK5080@shadowen.org>
	<1194428323.4055.3.camel@johannes.berg>
Content-Type: text/plain
Date: Wed, 07 Nov 2007 13:59:44 +0100
Message-Id: <1194440384.4470.10.camel@johannes.berg>
Mime-Version: 1.0
Cc: linux-kernel@vger.kernel.org,
	Kamalesh Babulal <kamalesh@linux.vnet.ibm.com>,
	linuxppc-dev@ozlabs.org, sam@ravnborg.org,
	David Miller <davem@davemloft.net>,
	Balbir Singh <balbir@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

This makes the altivec code in swsusp_32.S depend on CONFIG_ALTIVEC to
avoid build failures for systems that don't have altivec. I'm not sure
whether the code will actually work for other systems, but it was merged
for just ppc32 rather than powermac a very long time ago.

Signed-off-by: Johannes Berg <johannes@sipsolutions.net>
---

--- everything.orig/arch/powerpc/kernel/swsusp_32.S	2007-11-07 13:27:12.441517359 +0100
+++ everything/arch/powerpc/kernel/swsusp_32.S	2007-11-07 13:27:25.251519911 +0100
@@ -133,10 +133,12 @@ _GLOBAL(swsusp_arch_suspend)
 /* Resume code */
 _GLOBAL(swsusp_arch_resume)
 
+#ifdef CONFIG_ALTIVEC
 	/* Stop pending alitvec streams and memory accesses */
 BEGIN_FTR_SECTION
 	DSSALL
 END_FTR_SECTION_IFSET(CPU_FTR_ALTIVEC)
+#endif
  	sync
 
 	/* Disable MSR:DR to make sure we don't take a TLB or
