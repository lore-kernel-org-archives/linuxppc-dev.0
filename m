Return-Path: <mikey@neuling.org>
From: Michael Neuling <mikey@neuling.org>
To: Kumar Gala <galak@kernel.crashing.org>
Subject: Re: [PATCH] powerpc: remove fpscr use from [kvm_]cvt_{fd,df}
In-reply-to: <DCE42647-5931-41EF-BBE8-F09FDC700143@kernel.crashing.org>
References: <m2hbinzlon.fsf@igel.home> <27922.1282523025@neuling.org>
	<DCE42647-5931-41EF-BBE8-F09FDC700143@kernel.crashing.org>
Date: Tue, 24 Aug 2010 15:51:26 +1000
Message-ID: <5539.1282629086@neuling.org>
Cc: linuxppc-dev@ozlabs.org, Paul Mackerras <paulus@samba.org>,
	Andreas Schwab <schwab@linux-m68k.org>, kvm-ppc@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

> >> Neither lfs nor stfs touch the fpscr, so remove the restore/save of =
> it
> >> around them.
> >=20
> > Do some 32 bit processors need this?=20
> >=20
> > In 32 bit before the merge, we use to have code that did:
> >=20
> >  #if defined(CONFIG_4xx) || defined(CONFIG_E500)
> >   #define cvt_fd without save/restore fpscr
> >  #else
> >   #define cvt_fd with save/restore fpscr
> >  #end if
> >=20
> > Kumar; does this ring any bells?
> >=20
> > (The addition of this predates even bitkeeper)
> >=20
> > Mikey
> 
> Not really.  However if the ifdef is as you say that seems wrong to
> me.  We should be using CONFIG_PPC_FPU or !CONFIG_PPC_FPU.  As both
> 4xx and E500 have variants w/FPUs.

It actually got changed to CONFIG_PPC_FPU, then dwg merged it with some
other versions that were around.  

Mikey
