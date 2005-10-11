Return-Path: <benh@kernel.crashing.org>
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Olaf Hering <olh@suse.de>
In-Reply-To: <20051011093040.GA5362@suse.de>
References: <Pine.LNX.4.61.0510101449420.1572@nylon.am.freescale.net>
	<1129016771.17365.198.camel@gaston>  <20051011093040.GA5362@suse.de>
Content-Type: text/plain
Date: Tue, 11 Oct 2005 19:48:56 +1000
Message-Id: <1129024136.17365.202.camel@gaston>
Mime-Version: 1.0
Cc: linuxppc-dev@ozlabs.org, Kumar Gala <galak@freescale.com>,
	linuxppc64-dev <linuxppc64-dev@ozlabs.org>
Subject: Re: [PATCH] powerpc: zero out BSS for all platforms
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Tue, 2005-10-11 at 11:30 +0200, Olaf Hering wrote:
>  On Tue, Oct 11, Benjamin Herrenschmidt wrote:
> 
> > On Mon, 2005-10-10 at 14:51 -0500, Kumar Gala wrote:
> > > We need to ensure that the BSS is zeroed out for all platforms.
> > > Currently only prom_init.c was clearlying out the BSS which only works
> > > for PPC_OF platforms.
> > > 
> > > Signed-off-by: Kumar K. Gala <kumar.gala@freescale.com>
> > 
> > You need to make absolutely certain that we have not written anything to
> > the bss yet though... Is that the case ? I usually prefer doing the
> > zero'ing in assembly :)
> 
> early_init is called so early, its almost like asm code.

Yah, as long as that stuff is still separate between ppc32 and ppc64,
that's fine. We'll have to be careful with iSeries once we do the
merge :)

Ben.
