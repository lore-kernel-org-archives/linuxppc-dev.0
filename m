Return-Path: <becky.bruce@freescale.com>
Received: from az33egw01.freescale.net (az33egw01.freescale.net
	[192.88.158.102])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "az33egw01.freescale.net",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id B11BADDDFF
	for <linuxppc-dev@ozlabs.org>; Thu,  7 Feb 2008 13:44:26 +1100 (EST)
In-Reply-To: <1202347594.7079.107.camel@pasglop>
References: <Pine.LNX.4.64.0802061802310.1616@monty.am.freescale.net>
	<1202347594.7079.107.camel@pasglop>
Mime-Version: 1.0 (Apple Message framework v752.2)
Content-Type: text/plain; charset=US-ASCII; delsp=yes; format=flowed
Message-Id: <1D31DDE9-1E87-4A3D-B5E3-2377F86747AA@freescale.com>
From: Becky Bruce <becky.bruce@freescale.com>
Subject: Re: Reorg of 32-bit dma code
Date: Wed, 6 Feb 2008 20:45:18 -0600
To: benh@kernel.crashing.org
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Feb 6, 2008, at 7:26 PM, Benjamin Herrenschmidt wrote:

>
> On Wed, 2008-02-06 at 18:32 -0600, Becky Bruce wrote:
>>
>> I've been looking at converting 32-bit powerpc's DMA code over to the
>> 64-bit method, where there is a dma_ops structure inside archdata
>> that tells us which operations a device should use for DMA.  I'll be
>> needing this shortly because I need to implement swiotlb to deal with
>> PCI and large amounts of RAM on 32-bit systems that support 36-bit
>> physical addressing. (Yes, I know.  Fun for me.  Woohoo.)
>>
>> Anyway, I have an initial booting first pass, and wanted to get some
>> feedback.  What I've done at this point is to make dma_64 common  
>> to both
>> architectures (will rename it when I send a real patch...).  The
>> dma_direct_* functions have been changed to work on both 32/64,  
>> and the
>> old dma_* functionality in dma-mapping.h has been removed.   For  
>> now, to
>> avoid whacking on every 32-bit platform, the get_dma_ops()  
>> function has
>> been changed to return &dma_direct_ops if the device pointer  
>> exists but
>> the dma_ops field is NULL.   I'm not sure if this needs to be  
>> ifdef'd for
>> 64-bit?
>
> I'd prefer so yes.

Ok. I'll put that in, but I'd like to understand why it's necessary....

>
>> I've copied a bit of code over from pci_64.c into pci_common.c -  
>> some of
>> it isn't in use yet but will be once I start doing actual setup in  
>> the
>> platform code. pcibios_setup_new_device() becomes common as well.
>
> Cool !
>
>>   I've
>> also temporarily hacked the 32-bit code to set archdata.dma_data to
>> PCI_DRAM_OFFSET, so we can eliminate the use of virt_to_bus() and  
>> instead
>> use the 64-bit method, which gets rid of some ugly ifdefs in the  
>> dma code.
>
> Ok.
>
>> That's really about it - the preliminary patch is below - clearly  
>> it will
>> need some cleanup, but I wanted to post early and often.  Any  
>> feedback or
>> suggestions on cleaning this up are greatly appreciated.
>
> I'll have a look asap, thanks for doing this !
>

Heh, don't thank me until you've looked at it :)

Another thing that has to be done here is that I will need to audit  
all the driver code for places where the dev pointer passed to  
dma_alloc_coherent() and friends is NULL.  I've already fixed the  
gianfar driver locally, but I expect there are a pile of them.  If  
you have any other suggestions for dealing with this, speak up.

Cheers,
B
