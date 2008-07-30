Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 6207CDDEF0
	for <linuxppc-dev@ozlabs.org>; Thu, 31 Jul 2008 08:26:18 +1000 (EST)
Subject: Re: [PATCH] powerpc/mm: Lockless get_user_pages_fast()
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Kumar Gala <galak@kernel.crashing.org>
In-Reply-To: <C8EC8414-A033-46FE-AFEC-8C2A6AB5B4F7@kernel.crashing.org>
References: <1217389038.11188.285.camel@pasglop>
	<C8EC8414-A033-46FE-AFEC-8C2A6AB5B4F7@kernel.crashing.org>
Content-Type: text/plain
Date: Thu, 31 Jul 2008 08:26:12 +1000
Message-Id: <1217456772.11188.342.camel@pasglop>
Mime-Version: 1.0
Cc: Nick Piggin <npiggin@suse.de>, linuxppc-dev list <linuxppc-dev@ozlabs.org>
Reply-To: benh@kernel.crashing.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


> > Index: linux-work/arch/powerpc/Kconfig
> > ===================================================================
> > --- linux-work.orig/arch/powerpc/Kconfig	2008-07-30  
> > 13:17:06.000000000 +1000
> > +++ linux-work/arch/powerpc/Kconfig	2008-07-30 13:27:40.000000000  
> > +1000
> > @@ -42,6 +42,9 @@ config GENERIC_HARDIRQS
> > 	bool
> > 	default y
> >
> > +config HAVE_GET_USER_PAGES_FAST
> > +	def_bool PPC64
> > +
> > config HAVE_SETUP_PER_CPU_AREA
> > 	def_bool PPC64
> 
> what's ppc64 specific here?

Mostly _PAGE_SPECIAL (which I do plan to add to embedded which is why
I've been trying hard to free a PTE bit :-) and the way we synchronize
with the freeing of page tables (ppc64 uses RCU, ppc32 doesn't, we'd
have to find something to keep fast gup in sync).

Ben.
