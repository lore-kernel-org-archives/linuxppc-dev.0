Return-Path: <benh@kernel.crashing.org>
Subject: Re: [PATCH v3 1/4] powerpc: Removing support for 'protected-sources'
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Meador Inge <meador_inge@mentor.com>
In-Reply-To: <4D5033C9.8030407@mentor.com>
References: <1296861941-3370-1-git-send-email-meador_inge@mentor.com>
	<1296861941-3370-2-git-send-email-meador_inge@mentor.com>
	<1297035336.14982.14.camel@pasglop>  <4D5033C9.8030407@mentor.com>
Content-Type: text/plain; charset="UTF-8"
Date: Tue, 08 Feb 2011 08:45:36 +1100
Message-ID: <1297115136.14982.82.camel@pasglop>
Mime-Version: 1.0
Cc: Hollis Blanchard <hollis_blanchard@mentor.com>,
	devicetree-discuss@lists.ozlabs.org, linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


> In my previous reply I said that "it is not so much as a need as it is a 
> potential simplification."  After further reflection, I don't think that 
> is completely true.  As we get into AMP systems with higher core counts, 
> then implementing this functionality using the existing 
> "protected-sources" implementation versus the new "pic-no-reset" work is 
> going to be harder to maintain.

I'm not arguing that your approach isn't more suitable for AMP systems,
I just want to leave the existing protected-sources mechanism alone. I'm
not opposing adding a new, better, mechanism for newer platforms.

However, I'd name it differently. "pic-no-reset" doesn't carry enough
meaning in that case. What we want to point out here is that the PIC
has been pre-initialized.

Another option, which may be cleaner, is to stick to "no-reset" (no need
for pic- prefix) and make it do just that (prevent the reset), and then
use a positive variant of "protected-sources", call it
"allowed-sources". Maybe even make it a series of ranges. Then have the
MPIC only access these.

I think this is more robust as it would also prevent "accidental" use of
the wrong sources (bad device-tree, drivers that let you muck around
with irq numbers, etc...).

Cheers,
Ben.

> The reason being that *every* OS instance has to know about *every* 
> other OSes interrupt sources, which is a little gross.  You can see this 
> happening already in "arch/powerpc/boot/dts/p2020rdb_camp_core0.dts" and 
> "arch/powerpc/boot/dts/p2020rdb_camp_core1.dts":
> 
> 	// p2020rdb_camp_core0.dts
> 	mpic: pic@40000 {
> 	...
> 		// Sources used by the OS on core 1
> 		protected-sources = <
> 		42 76 77 78 79 /* serial1 , dma2 */
> 		29 30 34 26 /* enet0, pci1 */
> 		0xe0 0xe1 0xe2 0xe3 /* msi */
> 		0xe4 0xe5 0xe6 0xe7
> 		>;
> 	};
> 
> 	// p2020rdb_camp_core1.dts
> 	mpic: pic@40000 {
> 	...
> 		// Sources used by the OS on core 0
> 		protected-sources = <
> 		17 18 43 42 59 47 /*ecm, mem, i2c, serial0, spi,gpio */
> 		16 20 21 22 23 28 	/* L2, dma1, USB */
> 		03 35 36 40 31 32 33 	/* mdio, enet1, enet2 */
> 		72 45 58 25 		/* sdhci, crypto , pci */
> 		>;
> 	};
> 
> It is going to be a real pain to keep all of the lists up to date. 
> Especially considering we already have sufficient information in the 
> device tree to do this work.  I do understand the concern of 
> finding/testing the older systems.  However, is the testing of those 
> systems enough to keep out the proposed change and potentially lower 
> maintenance in the future?  Is the legacy system argument the only 
> reason to keep this change out or are there other technical deficiencies?
> 
> Also, in the proposed MPIC modifications there is a check for protected 
> sources (it is treated as an alias for "pic-no-reset"; see PATCH 3 in 
> the set) that should provide functionality equivalent to what systems 
> using "protected-sources" already have.  That check only looks for the 
> presence of "protected-sources" and does not process the cells.  Another 
> option would be to leave in the protected sources implementation (but 
> undocumented in the binding) and have the full "pic-no-reset" behavior 
> there as well (and documented in the binding).
> 
> If this has no chance of acceptance (?), then I will just re-submit the 
> binding and implementation with "protected-sources" and the limited form 
> of "pic-no-reset".
> 
