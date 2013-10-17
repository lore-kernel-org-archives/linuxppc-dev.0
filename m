Return-Path: <alistair@popple.id.au>
Received: from ipmail07.adl2.internode.on.net (ipmail07.adl2.internode.on.net
 [IPv6:2001:44b8:8060:ff02:300:1:2:7])
 by ozlabs.org (Postfix) with ESMTP id B61212C00C5
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 17 Oct 2013 16:47:12 +1100 (EST)
From: Alistair Popple <alistair@popple.id.au>
To: linuxppc-dev@lists.ozlabs.org
Subject: Re: [PATCH] powerpc: Fix 64K page size support for PPC44x
Date: Thu, 17 Oct 2013 16:47:31 +1100
Message-ID: <2194030.73hIiVnCA9@mexican>
In-Reply-To: <87mwm8qxiy.fsf@linux.vnet.ibm.com>
References: <1381986910-16310-1-git-send-email-alistair@popple.id.au>
 <87mwm8qxiy.fsf@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Cc: "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Thu, 17 Oct 2013 10:55:25 Aneesh Kumar K.V wrote:
> Alistair Popple <alistair@popple.id.au> writes:

> > diff --git a/arch/powerpc/include/asm/page.h
> > b/arch/powerpc/include/asm/page.h index b9f4262..b142d58 100644
> > --- a/arch/powerpc/include/asm/page.h
> > +++ b/arch/powerpc/include/asm/page.h
> > @@ -403,7 +403,7 @@ void arch_free_page(struct page *page, int order);
> > 
> >  struct vm_area_struct;
> > 
> > -#ifdef CONFIG_PPC_64K_PAGES
> > +#if defined(CONFIG_PPC_64K_PAGES) && defined(PPC64)
> 
>                                                ^^^ CONFIG_PPC64 ?

Yes, of course it should be. Thanks for picking that up - I'll send an updated 
patch.

> >  typedef pte_t *pgtable_t;
> >  #else
> >  typedef struct page *pgtable_t;
> 
> _______________________________________________
> Linuxppc-dev mailing list
> Linuxppc-dev@lists.ozlabs.org
> https://lists.ozlabs.org/listinfo/linuxppc-dev
