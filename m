Return-Path: <michael@ellerman.id.au>
Received: from bilbo.ozlabs.org (bilbo.ozlabs.org [203.10.76.25])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "bilbo.ozlabs.org",
	Issuer "CAcert Class 3 Root" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id 56D7FDDDA0
	for <linuxppc-dev@ozlabs.org>; Thu, 16 Apr 2009 18:25:07 +1000 (EST)
Subject: Re: [ppc64] 2.6.29-git7 : offlining a cpu causes an exception
From: Michael Ellerman <michael@ellerman.id.au>
To: Sachin Sant <sachinp@in.ibm.com>
In-Reply-To: <49E6C3F4.4080801@in.ibm.com>
References: <49D1E21E.3090505@in.ibm.com>
	<1238539469.17330.70.camel@pasglop> <49D30C48.4090902@in.ibm.com>
	<49D3547E.8030200@in.ibm.com>  <49E6C3F4.4080801@in.ibm.com>
Content-Type: text/plain
Date: Thu, 16 Apr 2009 18:25:06 +1000
Message-Id: <1239870306.14642.181.camel@localhost>
Mime-Version: 1.0
Cc: linuxppc-dev@ozlabs.org
Reply-To: michael@ellerman.id.au
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Thu, 2009-04-16 at 11:06 +0530, Sachin Sant wrote:
> Sachin Sant wrote:
> > Sachin Sant wrote:
> >> Benjamin Herrenschmidt wrote:
> >>> On Tue, 2009-03-31 at 14:57 +0530, Sachin Sant wrote:
> >>>  
> >>>> While executing CPU HotPlug[1] tests i observed that during
> >>>> every cpu offline process an exception is thrown.
> >>>>     
> >>>
> >>> Looks like a BUG_ON() to me... can you look at what other
> >>> messages just before that ?  
> >>
> > Ben, seems like the following patch is causing the cpu hotplug
> > test failure.
> > [PATCH 6/6] powerpc/mm: Introduce early_init_mmu() on 64-bit
> >
> > http://ozlabs.org/pipermail/linuxppc-dev/2009-March/069613.html
> >
> > If i back out this patch, i am able to offline/online cpu's
> > without any issue.
> I can recreate this problem with 2.6.30-rc2-git1 as well. Same BUG_ON while
> running cpu hotplug tests.
> 
> Let me know if there is any thing i can help to find a fix for this.

Hi Sachin,

Does this patch, on top of Ben's patch, fix it?

cheers

diff --git a/arch/powerpc/mm/hash_utils_64.c b/arch/powerpc/mm/hash_utils_64.c
index db556d2..1ade7eb 100644
--- a/arch/powerpc/mm/hash_utils_64.c
+++ b/arch/powerpc/mm/hash_utils_64.c
@@ -753,7 +753,7 @@ void __init early_init_mmu(void)
 }
 
 #ifdef CONFIG_SMP
-void __init early_init_mmu_secondary(void)
+void __cpuinit early_init_mmu_secondary(void)
 {
        /* Initialize hash table for that CPU */
        if (!firmware_has_feature(FW_FEATURE_LPAR))
