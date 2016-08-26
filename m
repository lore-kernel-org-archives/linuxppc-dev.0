Return-Path: <scott.wood@nxp.com>
Received: from EUR02-AM5-obe.outbound.protection.outlook.com
 (mail-eopbgr00058.outbound.protection.outlook.com [40.107.0.58])
 (using TLSv1 with cipher ECDHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3sL9Ht1cYszDrK1
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 26 Aug 2016 15:55:22 +1000 (AEST)
From: Scott Wood <scott.wood@nxp.com>
To: Tillmann Heidsieck <theidsieck@leenox.de>
CC: Benjamin Herrenschmidt <benh@kernel.crashing.org>, Paul Mackerras
 <paulus@samba.org>, Michael Ellerman <mpe@ellerman.id.au>,
 "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [RFC PATCH] powerpc: fsl_pci: fix inbound ATMU entries for
 systems with >4G RAM
Date: Fri, 26 Aug 2016 05:55:14 +0000
Message-ID: <DB5PR0401MB19287448C33B14B1DB47E81F91EC0@DB5PR0401MB1928.eurprd04.prod.outlook.com>
References: <20160824194614.4014-1-theidsieck@leenox.de>
 <DB5PR0401MB19280DCC626ED0E83EDD0D3791EA0@DB5PR0401MB1928.eurprd04.prod.outlook.com>
 <faa14fe5cf19881838df0ab1a402517f@mail.leenox.de>
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 08/26/2016 12:26 AM, Tillmann Heidsieck wrote:=0A=
> Hello Scott,=0A=
> =0A=
> thanks for the fast reply!=0A=
> =0A=
> On 2016-08-24 23:39, Scott Wood wrote:=0A=
> [..]=0A=
>>=0A=
>> The second inbound window is at 256G, and it maps all of RAM.  Note =0A=
>> that=0A=
>> for accesses in this window, the PCI address is different from the host=
=0A=
>> address.=0A=
> =0A=
> I probably really misunderstand the manual here ...=0A=
> =0A=
> 1 << 40 =3D 0x100_00000000 right? So if I put=0A=
> =0A=
> (1 << 40) >> 44 =3D 0 in PEXIWBEAR and=0A=
> (1 << 40) >> 12 =3D 0x10000000 in PEXIWBAR=0A=
> =0A=
> the window base (extended) address would be (1 << 40) right? And at the=
=0A=
> risk of showing my complete lack of skill doing basic arithmetic ...=0A=
> isn't (1 << 40) =3D 128GB? So what am I missing here?=0A=
=0A=
Sorry, I meant 1 TiB, not 256 GiB.  1 << 40 =3D 1 TiB.=0A=
=0A=
> I also read that the maximum allowed window size for PCIe inbound =0A=
> windows=0A=
> is 64G this would result in the need for more ATMU entries in case of =0A=
>  >68G=0A=
> system memory (the question is whether this needs to be fixed because=0A=
> maybe nobody wants to build such a computer).=0A=
=0A=
Hmm, it does say that.  This code was written when the physical address=0A=
size was 36 bits rather than 40.  I wonder if there's a real 64 GiB=0A=
limitation or if the manual just wasn't updated when the physical=0A=
address size grew... though in any case we should follow what the manual=0A=
says unless it's confirmed otherwise.=0A=
=0A=
>> By trying to identity-map everything you also break the assumption that=
=0A=
>> we don't need swiotlb to avoid the PEXCSRBAR region on PCI devices=0A=
>> capable of generating 64-bit addresses.=0A=
> =0A=
> Can you point me to where I might read up on this? I know far to little=
=0A=
> about all of this, that's for sure.=0A=
=0A=
PEXCSRBAR (called PCICSRBAR in the Linux driver) is an inbound window=0A=
intended for MSIs, configured via a config space BAR rather than the=0A=
MMIO ATMU registers.  It only accepts 32-bit PCI addresses and can't be=0A=
disabled or pointed at anything but CCSR.  Any RAM that aliases the=0A=
PEXCSRBAR PCI address can't be DMAed to without either using swiotlb or=0A=
a non-identity mapping.=0A=
=0A=
>>> Tested on a T4240 with 12G of RAM and an AMD E6760 PCIe card working =
=0A=
>>> with=0A=
>>> the in-tree radeon driver.=0A=
>>=0A=
>> I have no problem using an e1000e card on a t4240 with 24 GiB RAM.=0A=
>>=0A=
>> Looking at the radeon driver I see that there's a possibility of a dma=
=0A=
>> mask that is exactly 40 bits.  I think there's an off-by-one error in=0A=
>> fsl_pci_dma_set_mask().  If you change "dma_mask >=3D=0A=
>> DMA_BIT_MASK(MAX_PHYS_ADDR_BITS)" to "dma_mask >=0A=
>> DMA_BIT_MASK(MAX_PHYS_ADDR_BITS)", does that make radeon work without=0A=
>> this patch?=0A=
> =0A=
> This works in the sense that the radeon driver uses only 32bit dma =0A=
> addresses=0A=
> after applying it.=0A=
> I don't think that is what was intended since the card clearly works =0A=
> which=0A=
> higher addresses.=0A=
=0A=
Right, step one is to fix the bug.  Step two is to make things faster. :-)=
=0A=
=0A=
For the second step I suggest setting the high window's address/size=0A=
based on the amount of RAM present (rounded up to a power of 2) rather=0A=
than trying to map the entire 40-bit address space.  Thus if you have 12=0A=
GiB RAM, you'd get a 16 GiB window at PCI address 16 GiB, and any PCI=0A=
device with a DMA mask of at least 35 bits could use direct DMA to the=0A=
high window.  I'll put a patch together.=0A=
=0A=
>>=0A=
>> This change is unrelated.=0A=
> =0A=
> yeah sorry for sneaking that one in here, are you interested in this =0A=
> change?=0A=
> It cleans up the code a little bit by using existing functions. I think =
=0A=
> it=0A=
> makes the intend more clear but that's up for interpretation ;-)=0A=
=0A=
Sure.  If you resend it, please CC me at oss@buserror.net rather than=0A=
the NXP address.=0A=
=0A=
BTW, we can probably just drop that "Setting PCI inbound window greater=0A=
than memory size" message.  We routinely silently map beyond the end of=0A=
RAM with the high mapping...=0A=
=0A=
>> BTW, for some reason your patch is not showing up in Patchwork.=0A=
> =0A=
> Are there some known pitfalls when sending patches to Patchwork?=0A=
=0A=
It's not the first time I've seen certain people's patches not show up=0A=
there, but I don't know what the root cause is.=0A=
=0A=
-Scott=0A=
=0A=
