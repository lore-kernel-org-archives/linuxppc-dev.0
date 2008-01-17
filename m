Return-Path: <benh@kernel.crashing.org>
Subject: Re: [PATCH 1/4] powerpc: mv64x60 - Use early_* PCI accessors for
	hotswap reg
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: "Mark A. Greer" <mgreer@mvista.com>
In-Reply-To: <20080117004744.GC1917@mag.az.mvista.com>
References: <20080114225150.GB21940@mag.az.mvista.com>
	<1200523739.6755.33.camel@pasglop>
	<20080117004744.GC1917@mag.az.mvista.com>
Content-Type: text/plain
Date: Thu, 17 Jan 2008 13:39:02 +1100
Message-Id: <1200537542.20581.3.camel@pasglop>
Mime-Version: 1.0
Cc: linuxppc-dev <Linuxppc-dev@ozlabs.org>
Reply-To: benh@kernel.crashing.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


On Wed, 2008-01-16 at 17:47 -0700, Mark A. Greer wrote:
> On Thu, Jan 17, 2008 at 09:48:59AM +1100, Benjamin Herrenschmidt wrote:
> > 
> > On Mon, 2008-01-14 at 15:51 -0700, Mark A. Greer wrote:
> > > From: Mark A. Greer <mgreer@mvista.com>
> > > 
> > > The mv64x60 Hotswap register is on the first hose of the mv64x60
> > > hostbridge.  To access it, manually find the hose structure and
> > > use the early_* PCI accessor routines because the hostbridge is
> > > normally hidden.
> > 
> > Can't we unhide the NB instead ?
> 
> Hi Ben.
> 
> Possibly but it may cause issues since many hostbridge have BARs
> that don't comply with the PCI spec which may get hosed when scanning
> the PCI bus. 

True. But it's nice to be able to see their config space.

I tend to use a header quirk to blank the BARs of the host bridge in
those cases. But that does mean that the sizing operation is done on
them (writing ff's etc...) which might be an issue in your case (or
not).

Ben.
