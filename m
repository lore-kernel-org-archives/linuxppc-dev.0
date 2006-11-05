Return-Path: <benh@kernel.crashing.org>
Subject: Re: [PATCH/RFC] powerpc: Add MPC5200 Interrupt Controller support.
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Nicolas DET <nd@bplan-gmbh.de>
In-Reply-To: <20061105123101.3cc1696f.nd@bplan-gmbh.de>
References: <454902F9.20206@bplan-gmbh.de>
	<1162419138.25682.453.camel@localhost.localdomain>
	<454A1C37.5050208@bplan-gmbh.de>	<454A5952.6090801@bplan-gmbh.de>
	<1162683341.28571.82.camel@localhost.localdomain>
	<20061105111753.3e41f6b7.nd@bplan-gmbh.de>
	<1162723031.28571.228.camel@localhost.localdomain>
	<20061105123101.3cc1696f.nd@bplan-gmbh.de>
Content-Type: text/plain
Date: Mon, 06 Nov 2006 00:02:13 +1100
Message-Id: <1162731733.28571.241.camel@localhost.localdomain>
Mime-Version: 1.0
Cc: linuxppc-dev@ozlabs.org, Sylvain Munaut <tnt@246tNt.com>, sl@bplan-gmbh.de,
	linuxppc-embedded@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Sun, 2006-11-05 at 12:30 +0100, Nicolas DET wrote:
> On Sun, 05 Nov 2006 21:37:11 +1100
> Benjamin Herrenschmidt <benh@kernel.crashing.org> wrote:
> 
> > 
> > > > You have changed the mapping of L1/L2 but not the device-tree
> > > > representation to match them. Which means that you need the ugly hack
> > > > above. That is not goot. Fix your device-tree instead and do the same
> > > > split in the tree for L1/L2 than you do in the code.
> > > 
> > > There is no option here.
> > 
> > I don't agree. Your firmware can always be upgraded. There is no way you
> > will impose a broken format on everybody else. Unfortunately, being the
> > first implementation, that's just what you are doing...
> > 
> 
> As said, no option here. I think there is different way to see how works the PIC. However, from a register point of view. There is just critical, main, peripherals, SDMA.
> 
> Loot at "ICTL Perstat, MainStat, MainStat, CritStat Encoded Register--MBAR + 0x0524"

You should have your device-tree match your internal numbering. As you
noticed, the CRIT interrupt and the EXT interrupts are just the same.
And you properly folded them under the same level 1... now just make
the device-tree expose the same informations.

I don't care if you have firmwares in production or whatever... As a
matter of fact, you guys have been working on this board for long enough
you could have dealt with that issue long ago :-)

So right now, what you should do is figure out a proper encoding for the
firmware, and then either fix your device-tree, or do a hack in
prom_init.c that fixes it up.

Ben.
