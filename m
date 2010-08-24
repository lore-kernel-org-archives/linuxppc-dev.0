Return-Path: <mikey@neuling.org>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: Re: [PATCH] powerpc: remove fpscr use from [kvm_]cvt_{fd,df}
In-reply-to: <1282626718.22370.505.camel@pasglop>
References: <m2hbinzlon.fsf@igel.home> <27922.1282523025@neuling.org>
	<1282626718.22370.505.camel@pasglop>
Date: Tue, 24 Aug 2010 15:15:25 +1000
Message-ID: <32250.1282626925@neuling.org>
From: Michael Neuling <mikey@neuling.org>
Cc: linuxppc-dev@ozlabs.org, Andreas Schwab <schwab@linux-m68k.org>,
	kvm-ppc@vger.kernel.org, Paul Mackerras <paulus@samba.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

> > Do some 32 bit processors need this? 
> > 
> > In 32 bit before the merge, we use to have code that did:
> > 
> >   #if defined(CONFIG_4xx) || defined(CONFIG_E500)
> >    #define cvt_fd without save/restore fpscr
> >   #else
> >    #define cvt_fd with save/restore fpscr
> >   #end if
> > 
> > Kumar; does this ring any bells?
> 
> I don't see anything in the various 440 docs I have at hand that would
> hint at lfd/stfs adffecting FPSCR.

The way the ifdefs are, it's the other way around.  4xx procs don't need
to save/restore fpscr and others do.

Mikey
