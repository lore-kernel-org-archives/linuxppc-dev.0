Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 10244B70DA
	for <linuxppc-dev@ozlabs.org>; Wed, 25 Aug 2010 11:30:56 +1000 (EST)
Subject: Re: [PATCH] powerpc: remove fpscr use from [kvm_]cvt_{fd,df}
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Michael Neuling <mikey@neuling.org>
In-Reply-To: <32250.1282626925@neuling.org>
References: <m2hbinzlon.fsf@igel.home> <27922.1282523025@neuling.org>
	<1282626718.22370.505.camel@pasglop>  <32250.1282626925@neuling.org>
Content-Type: text/plain; charset="UTF-8"
Date: Wed, 25 Aug 2010 11:30:36 +1000
Message-ID: <1282699836.22370.566.camel@pasglop>
Mime-Version: 1.0
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

On Tue, 2010-08-24 at 15:15 +1000, Michael Neuling wrote:
> > > Do some 32 bit processors need this? 
> > > 
> > > In 32 bit before the merge, we use to have code that did:
> > > 
> > >   #if defined(CONFIG_4xx) || defined(CONFIG_E500)
> > >    #define cvt_fd without save/restore fpscr
> > >   #else
> > >    #define cvt_fd with save/restore fpscr
> > >   #end if
> > > 
> > > Kumar; does this ring any bells?
> > 
> > I don't see anything in the various 440 docs I have at hand that would
> > hint at lfd/stfs adffecting FPSCR.
> 
> The way the ifdefs are, it's the other way around.  4xx procs don't need
> to save/restore fpscr and others do.

Right, my bad. In any case, Paulus reckons it's all his mistake and we
really never need to save/restore fpscr.

Cheers,
Ben.
