Return-Path: <theidsieck@leenox.de>
Received: from mail.leenox.de (giles.leenox.de [5.9.156.120])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3sL8fk6jZ2zDrK1
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 26 Aug 2016 15:26:38 +1000 (AEST)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Date: Fri, 26 Aug 2016 07:26:31 +0200
From: Tillmann Heidsieck <theidsieck@leenox.de>
To: Scott Wood <scott.wood@nxp.com>
Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>, Paul Mackerras
 <paulus@samba.org>, Michael Ellerman <mpe@ellerman.id.au>,
 linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
Subject: Re: [RFC PATCH] powerpc: fsl_pci: fix inbound ATMU entries for
 systems with >4G RAM
In-Reply-To: <DB5PR0401MB19280DCC626ED0E83EDD0D3791EA0@DB5PR0401MB1928.eurprd04.prod.outlook.com>
References: <20160824194614.4014-1-theidsieck@leenox.de>
 <DB5PR0401MB19280DCC626ED0E83EDD0D3791EA0@DB5PR0401MB1928.eurprd04.prod.outlook.com>
Message-ID: <faa14fe5cf19881838df0ab1a402517f@mail.leenox.de>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Hello Scott,

thanks for the fast reply!

On 2016-08-24 23:39, Scott Wood wrote:
[..]
> 
> The second inbound window is at 256G, and it maps all of RAM.  Note 
> that
> for accesses in this window, the PCI address is different from the host
> address.

I probably really misunderstand the manual here ...

1 << 40 = 0x100_00000000 right? So if I put

(1 << 40) >> 44 = 0 in PEXIWBEAR and
(1 << 40) >> 12 = 0x10000000 in PEXIWBAR

the window base (extended) address would be (1 << 40) right? And at the
risk of showing my complete lack of skill doing basic arithmetic ...
isn't (1 << 40) = 128GB? So what am I missing here?

I also read that the maximum allowed window size for PCIe inbound 
windows
is 64G this would result in the need for more ATMU entries in case of 
 >68G
system memory (the question is whether this needs to be fixed because
maybe nobody wants to build such a computer).

> 
>> The according errors can be observed by using the EDAC driver for 
>> MPC85XX.
>> 
>> This patch changes this behaviour by adding the second window starting
>> at 4G. The current implementation still leaves memory beyond 68G
>> unmapped as this would require yet another ATMU entry.
> 
> Windows must be size-aligned, as per the description of PEXIWBARn[WBA].
>  This window is illegal.

OK, I did mess up that one. I fiddled around with the starting address 
and it
seems that the chip might align the window silently, making the window 
start
at 0x0.  This solves the puzzle why this window works for me. However, 
this
means that my solution is still wrong because of the illegal window size 
as
well as that it (potentially) does not map the whole memory.

> 
> By trying to identity-map everything you also break the assumption that
> we don't need swiotlb to avoid the PEXCSRBAR region on PCI devices
> capable of generating 64-bit addresses.

Can you point me to where I might read up on this? I know far to little
about all of this, that's for sure.

> 
>> Tested on a T4240 with 12G of RAM and an AMD E6760 PCIe card working 
>> with
>> the in-tree radeon driver.
> 
> I have no problem using an e1000e card on a t4240 with 24 GiB RAM.
> 
> Looking at the radeon driver I see that there's a possibility of a dma
> mask that is exactly 40 bits.  I think there's an off-by-one error in
> fsl_pci_dma_set_mask().  If you change "dma_mask >=
> DMA_BIT_MASK(MAX_PHYS_ADDR_BITS)" to "dma_mask >
> DMA_BIT_MASK(MAX_PHYS_ADDR_BITS)", does that make radeon work without
> this patch?

This works in the sense that the radeon driver uses only 32bit dma 
addresses
after applying it.
I don't think that is what was intended since the card clearly works 
which
higher addresses.

To elaborate on the problem I am trying to fix. After applying my 
accepted EDAC
patch. I get errors like this (in this case for the snd device which is 
part of
the radeon card)

[    8.429635] PCIe ERR_DR register: 0x00100000
[    8.433893] PCIe ERR_CAP_STAT register: 0x00000005
[    8.438671] PCIe ERR_CAP_R0 register: 0x04000020
[    8.443276] PCIe ERR_CAP_R1 register: 0xff000103
[    8.447882] PCIe ERR_CAP_R2 register: 0x02000000
[    8.452486] PCIe ERR_CAP_R3 register: 0x0080a4ec

which I read as
"There is some incoming PCIe transaction to address 0x2_ec4a8000 and 
there is
no mapping for it".

According to the radeon driver it did put one of the rings to this 
address
(viewed from the CPU).

> 
> 
>> Signed-off-by: Tillmann Heidsieck <theidsieck@leenox.de>
>> ---
>>  arch/powerpc/sysdev/fsl_pci.c | 40 
>> ++++++++++++++++++++--------------------
>>  1 file changed, 20 insertions(+), 20 deletions(-)
>> 
>> diff --git a/arch/powerpc/sysdev/fsl_pci.c 
>> b/arch/powerpc/sysdev/fsl_pci.c
>> index 0ef9df49f0f2..260983037904 100644
>> --- a/arch/powerpc/sysdev/fsl_pci.c
>> +++ b/arch/powerpc/sysdev/fsl_pci.c
>> @@ -349,17 +349,13 @@ static void setup_pci_atmu(struct pci_controller 
>> *hose)
>>  	}
>> 
>>  	sz = min(mem, paddr_lo);
>> -	mem_log = ilog2(sz);
>> +	mem_log = order_base_2(sz);
>> 
>>  	/* PCIe can overmap inbound & outbound since RX & TX are separated 
>> */
>>  	if (early_find_capability(hose, 0, 0, PCI_CAP_ID_EXP)) {
>> -		/* Size window to exact size if power-of-two or one size up */
>> -		if ((1ull << mem_log) != mem) {
>> -			mem_log++;
>> -			if ((1ull << mem_log) > mem)
>> -				pr_info("%s: Setting PCI inbound window "
>> -					"greater than memory size\n", name);
>> -		}
>> +		if ((1ull << mem_log) > mem)
>> +			pr_info("%s: Setting PCI inbound window greater than memory 
>> size\n",
>> +				name);
>> 
>>  		piwar |= ((mem_log - 1) & PIWAR_SZ_MASK);
>> 
> 
> This change is unrelated.

yeah sorry for sneaking that one in here, are you interested in this 
change?
It cleans up the code a little bit by using existing functions. I think 
it
makes the intend more clear but that's up for interpretation ;-)

> 
> BTW, for some reason your patch is not showing up in Patchwork.

Are there some known pitfalls when sending patches to Patchwork?

> 
> -Scott

Thanks for your help
- Tillmann
