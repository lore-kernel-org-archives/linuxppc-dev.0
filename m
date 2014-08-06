Return-Path: <scottwood@freescale.com>
Received: from na01-bl2-obe.outbound.protection.outlook.com
 (mail-bl2lp0211.outbound.protection.outlook.com [207.46.163.211])
 (using TLSv1 with cipher ECDHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 097D71A017B
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  6 Aug 2014 10:49:26 +1000 (EST)
Message-ID: <1407286090.7427.19.camel@snotra.buserror.net>
Subject: Re: [PATCH 2/2] powerpc/nohash: Split __early_init_mmu() into boot
 and secondary
From: Scott Wood <scottwood@freescale.com>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Date: Tue, 5 Aug 2014 19:48:10 -0500
In-Reply-To: <1407213410.19150.65.camel@pasglop>
References: <1406948861-11322-1-git-send-email-scottwood@freescale.com>
 <1406948861-11322-2-git-send-email-scottwood@freescale.com>
 <1407213410.19150.65.camel@pasglop>
Content-Type: text/plain; charset="UTF-8"
MIME-Version: 1.0
Cc: linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Tue, 2014-08-05 at 14:36 +1000, Benjamin Herrenschmidt wrote:
> On Fri, 2014-08-01 at 22:07 -0500, Scott Wood wrote:
> 
> >  
> > -void __init early_init_mmu(void)
> > -{
> > -	__early_init_mmu(1);
> > -}
> > -
> >  void early_init_mmu_secondary(void)
> >  {
> > -	__early_init_mmu(0);
> > +	early_init_mmu_allcpus();
> >  }
> 
> Small nit, it took me 30s too long to figure out what you were doing due
> to the naming above :)
> 
> Call the latter early_init_this_mmu() and keep the global one separate
> such that early_init_mmu() does:
> 
> 	early_init_mmu_common();
> 	early_init_this_mmu();

I'll do s/mmu_allcpus/this_mmu/ but early_init_mmu() needs to do things
both before and after early_init_mmu_common().  Do you want two new
functions (before and after) or is it OK to just rename
early_init_mmu_allcpus() and put a comment before early_init_mmu()
saying it's just for the boot cpu?

-Scott
