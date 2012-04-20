Return-Path: <B07421@freescale.com>
Received: from tx2outboundpool.messaging.microsoft.com
 (tx2ehsobe004.messaging.microsoft.com [65.55.88.14])
 (using TLSv1 with cipher AES128-SHA (128/128 bits))
 (Client CN "mail.global.frontbridge.com",
 Issuer "Microsoft Secure Server Authority" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 3B4FAB6FA3
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 21 Apr 2012 05:04:50 +1000 (EST)
Message-ID: <4F91B335.4010501@freescale.com>
Date: Fri, 20 Apr 2012 14:04:21 -0500
From: Scott Wood <scottwood@freescale.com>
MIME-Version: 1.0
To: Kumar Gala <galak@kernel.crashing.org>
Subject: Re: pci node question
References: <9F6FE96B71CF29479FF1CDC8046E1503346013@039-SN1MPN1-002.039d.mgd.msft.net>
 <D04C6167-5286-4675-A6D8-32BA63305424@kernel.crashing.org>
In-Reply-To: <D04C6167-5286-4675-A6D8-32BA63305424@kernel.crashing.org>
Content-Type: text/plain; charset="ISO-8859-1"
Cc: "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 04/20/2012 01:53 PM, Kumar Gala wrote:
> 
> On Apr 20, 2012, at 1:37 PM, Yoder Stuart-B08248 wrote:
> 
>> There was refactoring change a while back that moved 
>> the interrupt map down into the virtual pci bridge.
>>
>> example: 
>> 42 /* controller at 0x200000 */
>> 43 &pci0 {
>> 44         compatible = "fsl,p2041-pcie", "fsl,qoriq-pcie-v2.2";
>> 45         device_type = "pci";
>> 46         #size-cells = <2>;
>> 47         #address-cells = <3>;
>> 48         bus-range = <0x0 0xff>;
>> 49         clock-frequency = <33333333>;
>> 50         interrupts = <16 2 1 15>;
>> 51         pcie@0 {
>> 52                 reg = <0 0 0 0 0>;
>> 53                 #interrupt-cells = <1>;
>> 54                 #size-cells = <2>;
>> 55                 #address-cells = <3>;
>> 56                 device_type = "pci";
>> 57                 interrupts = <16 2 1 15>;
>> 58                 interrupt-map-mask = <0xf800 0 0 7>;
>> 59                 interrupt-map = <
>> 60                         /* IDSEL 0x0 */
>> 61                         0000 0 0 1 &mpic 40 1 0 0
>> 62                         0000 0 0 2 &mpic 1 1 0 0
>> 63                         0000 0 0 3 &mpic 2 1 0 0
>> 64                         0000 0 0 4 &mpic 3 1 0 0
>> 65                         >;
>> 66         };
>> 67 };
>>
>> Why was the interrupt-map moved here?
> 
> Its been a while, but I think i moved it down because of which node is used for interrupt handling in linux.

That's not supposed to be how device tree bindings are determined.

It's causing us problems with virtualization device assignment, because
if we just assign the parent bus we don't get the interrupt map, but if
we assign the child we need to deal with what it means to assign an
individual PCI device (e.g. on our internal KVM stuff we get an error on
that reg property).

What does this node represent in the first place?  Is there really a
PCI-to-PCI bridge?  Are all other PCI devices underneath it?

>> Do we really need the error interrupt specified twice?
> 
> I put it twice because it has multiple purposes, one has to do with interrupts defined by the PCI spec vs ones defined via FSL controller.

There are PCI-defined error conditions that cause a host controller
interrupt.  What does this have to do with the bridge node?

>> Why is there a zeroed out reg property: reg = <0 0 0 0 0> ??
> 
> scratching my head, what happens if you remove it?

Sigh.

-Scott
