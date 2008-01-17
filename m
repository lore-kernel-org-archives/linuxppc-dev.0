Return-Path: <mgreer@mvista.com>
Date: Wed, 16 Jan 2008 17:47:44 -0700
From: "Mark A. Greer" <mgreer@mvista.com>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: Re: [PATCH 1/4] powerpc: mv64x60 - Use early_* PCI accessors for
	hotswap reg
Message-ID: <20080117004744.GC1917@mag.az.mvista.com>
References: <20080114225150.GB21940@mag.az.mvista.com>
	<1200523739.6755.33.camel@pasglop>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1200523739.6755.33.camel@pasglop>
Cc: linuxppc-dev <Linuxppc-dev@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Thu, Jan 17, 2008 at 09:48:59AM +1100, Benjamin Herrenschmidt wrote:
> 
> On Mon, 2008-01-14 at 15:51 -0700, Mark A. Greer wrote:
> > From: Mark A. Greer <mgreer@mvista.com>
> > 
> > The mv64x60 Hotswap register is on the first hose of the mv64x60
> > hostbridge.  To access it, manually find the hose structure and
> > use the early_* PCI accessor routines because the hostbridge is
> > normally hidden.
> 
> Can't we unhide the NB instead ?

Hi Ben.

Possibly but it may cause issues since many hostbridge have BARs
that don't comply with the PCI spec which may get hosed when scanning
the PCI bus.  Maybe fixups/quirks/whatever will help but I'm not sure
that's any cleaner.  TBH, I'm not familiar enough with the PCI subsystem
to answer this intelligently.

Mark
