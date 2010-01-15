Return-Path: <monstr@monstr.eu>
Received: from mail-fx0-f213.google.com (mail-fx0-f213.google.com
	[209.85.220.213]) by ozlabs.org (Postfix) with ESMTP id 17D17B7CBA
	for <linuxppc-dev@ozlabs.org>; Fri, 15 Jan 2010 20:25:24 +1100 (EST)
Received: by fxm5 with SMTP id 5so376845fxm.9
	for <linuxppc-dev@ozlabs.org>; Fri, 15 Jan 2010 01:25:22 -0800 (PST)
Message-ID: <4B503422.60209@monstr.eu>
Date: Fri, 15 Jan 2010 10:23:46 +0100
From: Michal Simek <monstr@monstr.eu>
MIME-Version: 1.0
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: Re: xilinx-pci driver and pci in general
References: <4B4DE58D.10008@petalogix.com> <1263434836.724.317.camel@pasglop>
In-Reply-To: <1263434836.724.317.camel@pasglop>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Cc: Arnd Bergmann <arnd@arndb.de>, linuxppc-dev@ozlabs.org,
	thunderbird2k@gmx.net, LKML <linux-kernel@vger.kernel.org>,
	michal.simek@petalogix.com, John Williams <john.williams@petalogix.com>
Reply-To: monstr@monstr.eu
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Benjamin Herrenschmidt wrote:
> On Wed, 2010-01-13 at 16:23 +0100, Michal Simek wrote:
> 
>> The main problems are:
>> ppc use ppc_md struct which we don't have it on Microblaze.
>> xilinx-pci driver uses exclude_device function. This function is used in 
>> indirect_pci.c too. There could be a way to move that function directly 
>> to pci_controller structure which could be useful for other controllers 
>> too. What do you think?
>>
>> Then there are some other ppc_md. calling like pcibios_after_init which
>> if I see correctly not used for ppc too.
> 
> We may not be using after_init() anymore in which case you are welcome
> to send a patch to remove it :-)

hmm. I used older kernel and I see that in the latest version powermac
use it. :-( I will just remove it.

> 
> As for the others, well ... maybe you can do wrappers for these that
> call into ppc_md. on powerpc and into some kind of arch_pci_ops. that
> the platform provides on microblaze ?
> 
> I'm not sure moving them into the pci_controller is the best way to go
> there.

ok. I will remove that part of code for now.

> 
>> The next thing is that some files contains asm/machdep.h which could be 
>> added to asm/pci-bridge.h and the same is for asm/ppc-pci.h
> 
> Yeah, moving includes like that is ok.
> 
>> Files contains CONFIG_PPC_OF and we would like to use only CONFIG_OF.
>> I remember any discuss around but not sure what was the conclusion on 
>> powerpc.
> 
> I think that should be allright, Grant, any objection there ?
> 
>> Part of headers are the same that's why there will be a space to move 
>> them to asm-generic.
> 
> If you can convince other archs that it makes sense to do so ? :-)

will try.

> 
>> Anyway: I look at your dma-mapping.h and you can use 
>> asm-generic/dma-mapping-common.h as I am using.
> 
> Not just quite yet, there's still some stuff we need to cleanup with
> the !coherent cases.
> 
>> Then I have some question about EARLY_PCI_OP in ppc_32.c. Is there any 
>> reason to use early_##rw##_config_##size fucntions instead of proper 
>> pci_bus_##rw##_config_##size functions?
>> There is one comment that these functions are used before PCI scanning 
>> is done but there are used the same function as are in driver/pci/access.c.
>> Is there any "secret" reason to do it in this way?
> 
> Well, first of all, those aren't ppc32 only anymore, they are in
> pci-common.c now. Then, if you look at them you'll notice that
> they are just a wrapper on top of pci_bus_* which uses a fake
> pci_bus structure. IE. They are meant to be used in very early
> arch fixup code at a time when we may not even have the struct
> pci_bus at hand. Their use is pretty rare though, maybe we -could-
> get rid of them at some stage by moving some of that fixup code.

Thanks for that.

> 
>> Thanks for this early discuss. I would like to hear your opinion and 
>> then I will choose solution how to add our pci support to mainline.

I will keep you informed but I see that I will add that part of code to 
mainline and then we look at consolidation work.

Thanks,
Michal

> 
> Cheers,
> Ben.
> 
> 
> 
> _______________________________________________
> Linuxppc-dev mailing list
> Linuxppc-dev@lists.ozlabs.org
> https://lists.ozlabs.org/listinfo/linuxppc-dev


-- 
Michal Simek, Ing. (M.Eng)
w: www.monstr.eu p: +42-0-721842854
Maintainer of Linux kernel 2.6 Microblaze Linux - http://www.monstr.eu/fdt/
Microblaze U-BOOT custodian
