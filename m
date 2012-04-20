Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client did not present a certificate)
 by ozlabs.org (Postfix) with ESMTPS id 6C400B6FBC
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 21 Apr 2012 07:11:46 +1000 (EST)
Message-ID: <1334956286.3197.16.camel@pasglop>
Subject: Re: pci node question
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Kumar Gala <galak@kernel.crashing.org>
Date: Sat, 21 Apr 2012 07:11:26 +1000
In-Reply-To: <D04C6167-5286-4675-A6D8-32BA63305424@kernel.crashing.org>
References: <9F6FE96B71CF29479FF1CDC8046E1503346013@039-SN1MPN1-002.039d.mgd.msft.net>
 <D04C6167-5286-4675-A6D8-32BA63305424@kernel.crashing.org>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Cc: "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Fri, 2012-04-20 at 13:53 -0500, Kumar Gala wrote:
> On Apr 20, 2012, at 1:37 PM, Yoder Stuart-B08248 wrote:
> 
> > There was refactoring change a while back that moved 
> > the interrupt map down into the virtual pci bridge.
> > 
> > example: 
> > 42 /* controller at 0x200000 */
> > 43 &pci0 {
> > 44         compatible = "fsl,p2041-pcie", "fsl,qoriq-pcie-v2.2";
> > 45         device_type = "pci";
> > 46         #size-cells = <2>;
> > 47         #address-cells = <3>;
> > 48         bus-range = <0x0 0xff>;
> > 49         clock-frequency = <33333333>;
> > 50         interrupts = <16 2 1 15>;
> > 51         pcie@0 {
> > 52                 reg = <0 0 0 0 0>;
> > 53                 #interrupt-cells = <1>;
> > 54                 #size-cells = <2>;
> > 55                 #address-cells = <3>;
> > 56                 device_type = "pci";
> > 57                 interrupts = <16 2 1 15>;
> > 58                 interrupt-map-mask = <0xf800 0 0 7>;
> > 59                 interrupt-map = <
> > 60                         /* IDSEL 0x0 */
> > 61                         0000 0 0 1 &mpic 40 1 0 0
> > 62                         0000 0 0 2 &mpic 1 1 0 0
> > 63                         0000 0 0 3 &mpic 2 1 0 0
> > 64                         0000 0 0 4 &mpic 3 1 0 0
> > 65                         >;
> > 66         };
> > 67 };
> > 
> > Why was the interrupt-map moved here?
> 
> Its been a while, but I think i moved it down because of which node is used for interrupt handling in linux.

Yeah, it would swizzle if going accross the virtual P2P bridge. On the
other hand, if it's PCIe, the children of the vP2P should always be at
device 0 and thus the swizzling should be a NOP no ? So we -could- leave
it in the PHB unless I'm mistaken...

On the other hand, we probably want to fix the mapping code to handle
things like SR-IOV PFs with different device numbers... do those get
swizzled ? In that case we might want to keep things down the virtual
bridge.

> > Do we really need the error interrupt specified twice?
> 
> I put it twice because it has multiple purposes, one has to do with interrupts defined by the PCI spec vs ones defined via FSL controller.
> 
> > Why is there a zeroed out reg property: reg = <0 0 0 0 0> ??
> 
> scratching my head, what happens if you remove it?

If you remove it, the kernel will fail to match the vP2P with the
corresponding struct pci_dev.... It's not "zeroed out". It contains a
valid bus/dev/fn ... of 0,0,0 :-)

Cheers,
Ben.

> - k
> 
> _______________________________________________
> Linuxppc-dev mailing list
> Linuxppc-dev@lists.ozlabs.org
> https://lists.ozlabs.org/listinfo/linuxppc-dev
