Return-Path: <B07421@freescale.com>
Received: from am1outboundpool.messaging.microsoft.com
 (am1ehsobe003.messaging.microsoft.com [213.199.154.206])
 (using TLSv1 with cipher AES128-SHA (128/128 bits))
 (Client CN "mail.global.frontbridge.com",
 Issuer "Microsoft Secure Server Authority" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id F0FAFB6FAA
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 21 Apr 2012 06:53:55 +1000 (EST)
Message-ID: <4F91CCCA.1050204@freescale.com>
Date: Fri, 20 Apr 2012 15:53:30 -0500
From: Scott Wood <scottwood@freescale.com>
MIME-Version: 1.0
To: Kumar Gala <galak@kernel.crashing.org>
Subject: Re: pci node question
References: <9F6FE96B71CF29479FF1CDC8046E1503346013@039-SN1MPN1-002.039d.mgd.msft.net>
 <D04C6167-5286-4675-A6D8-32BA63305424@kernel.crashing.org>
 <4F91B335.4010501@freescale.com>
 <EDA55B32-FD14-4B5C-90AF-7FC5F77898E0@kernel.crashing.org>
In-Reply-To: <EDA55B32-FD14-4B5C-90AF-7FC5F77898E0@kernel.crashing.org>
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

On 04/20/2012 03:37 PM, Kumar Gala wrote:
> 
> On Apr 20, 2012, at 2:04 PM, Scott Wood wrote:
> 
>> On 04/20/2012 01:53 PM, Kumar Gala wrote:
>>>
>>> On Apr 20, 2012, at 1:37 PM, Yoder Stuart-B08248 wrote:
>>>
>>>> There was refactoring change a while back that moved 
>>>> the interrupt map down into the virtual pci bridge.
>>>>
>>>> example: 
>>>> 42 /* controller at 0x200000 */
>>>> 43 &pci0 {
>>>> 44         compatible = "fsl,p2041-pcie", "fsl,qoriq-pcie-v2.2";
>>>> 45         device_type = "pci";
>>>> 46         #size-cells = <2>;
>>>> 47         #address-cells = <3>;
>>>> 48         bus-range = <0x0 0xff>;
>>>> 49         clock-frequency = <33333333>;
>>>> 50         interrupts = <16 2 1 15>;
>>>> 51         pcie@0 {
>>>> 52                 reg = <0 0 0 0 0>;
>>>> 53                 #interrupt-cells = <1>;
>>>> 54                 #size-cells = <2>;
>>>> 55                 #address-cells = <3>;
>>>> 56                 device_type = "pci";
>>>> 57                 interrupts = <16 2 1 15>;
>>>> 58                 interrupt-map-mask = <0xf800 0 0 7>;
>>>> 59                 interrupt-map = <
>>>> 60                         /* IDSEL 0x0 */
>>>> 61                         0000 0 0 1 &mpic 40 1 0 0
>>>> 62                         0000 0 0 2 &mpic 1 1 0 0
>>>> 63                         0000 0 0 3 &mpic 2 1 0 0
>>>> 64                         0000 0 0 4 &mpic 3 1 0 0
>>>> 65                         >;
>>>> 66         };
>>>> 67 };
>>>>
>>>> Why was the interrupt-map moved here?
>>>
>>> Its been a while, but I think i moved it down because of which node is used for interrupt handling in linux.
>>
>> That's not supposed to be how device tree bindings are determined.
>>
>> It's causing us problems with virtualization device assignment, because
>> if we just assign the parent bus we don't get the interrupt map, but if
>> we assign the child we need to deal with what it means to assign an
>> individual PCI device (e.g. on our internal KVM stuff we get an error on
>> that reg property).
>>
>> What does this node represent in the first place?  Is there really a
>> PCI-to-PCI bridge?  Are all other PCI devices underneath it?
> 
> PCIe has this concept of a "virtual" bridge between the root-comples,

Between the root complex and whatever's plugged in?

> so that is what the node represents.  Its always been a bit confusing to me as its not 100% standardized by PCI sig.

Is it documented anywhere (e.g. in the chip manual)?  Is it common (even
if 100% standardized), or a Freescale-ism?

Is there an actual PCIe-to-PCIe bridge that shows up in the root
complex's config space (not talking about the host bridge PCI device
that has always been there on FSL PCI controllers, which we didn't
represent in the device tree on non-express PCI)?  Why does this bridge
need to be represented in the device tree (assuming no ISA devices need
to be represented), when other PCI devices (including bridges) don't?

> Maybe Ben's got some comments to add here from a generic PCIe point of view.
> 
>>>> Do we really need the error interrupt specified twice?
>>>
>>> I put it twice because it has multiple purposes, one has to do with interrupts defined by the PCI spec vs ones defined via FSL controller.
>>
>> There are PCI-defined error conditions that cause a host controller
>> interrupt.  What does this have to do with the bridge node?
> 
> Think of the "error" IRQ as shared between to classes of interrupts.  One set are controller errors defined by FSL, the other are errors defined by PCI sig / bus point of view.
> 
> I'd expect controller errors to be handled by something like EDAC would bind at "fsl,qoriq-pcie-v2.2" level node.  The PCI bus code would looks at the virtual bridge down.

This shouldn't be about where a specific piece of Linux code looks.

I don't see why the split of PCI-defined errors versus FSL-defined
errors maps to bridge node versus controller node.  What if we didn't
have the bridge?  We'd still have PCI-defined errors, right?

-Scott
