Return-Path: <jared.bents@rockwellcollins.com>
Received: from da1vs01.rockwellcollins.com (smtpimr.rockwellcollins.com
 [205.175.227.27])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 408vdK6p4MzF22C
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 27 Mar 2018 00:10:10 +1100 (AEDT)
Received: by mail-yb0-f200.google.com with SMTP id i16-v6so8518779ybk.21
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 26 Mar 2018 06:10:08 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <CAOSf1CGb7HCuhLgyMo4EdiMkmMM0CPD-=QDQ+2S=wgZ43G8w5A@mail.gmail.com>
References: <CAM=7fbcynhZ3iPtCGpVCgDmw7OU6SQcucZDm1kUdv=soky9RJQ@mail.gmail.com>
 <CAOSf1CGqc9=QnrChOY_+YL0v8TALQ+pH8u1e26Q--0PS4CGm2g@mail.gmail.com>
 <CAM=7fbdN=sLncGK2hgq2fNWeULdff8opViD9UQ3qj29KTG5tNQ@mail.gmail.com>
 <CAOSf1CFHSnfBgnkyFi1o3SQp7pJvQBk64eAv+SPmOmMVzzQC3w@mail.gmail.com>
 <CAM=7fberG6pwy5kz1h=xnNWO4AeSbCR-N-Yw079qMB1tnhSzvQ@mail.gmail.com>
 <CAOSf1CGb7HCuhLgyMo4EdiMkmMM0CPD-=QDQ+2S=wgZ43G8w5A@mail.gmail.com>
From: Jared Bents <jared.bents@rockwellcollins.com>
Date: Mon, 26 Mar 2018 08:10:06 -0500
Message-ID: <CAM=7fbfw_AC6xxT0=1=928SUd8nYx7i+uRzVDFSmsrx5U+PDZA@mail.gmail.com>
Subject: Re: DMA Mapping Error in ppc64
To: Oliver <oohall@gmail.com>
Cc: linuxppc-dev <linuxppc-dev@lists.ozlabs.org>
Content-Type: text/plain; charset="UTF-8"
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Hi Ben

On Sat, Mar 24, 2018 at 3:19 AM, Benjamin Herrenschmidt
<benh@kernel.crashing.org> wrote:
> On Fri, 2018-03-23 at 07:41 -0500, Jared Bents wrote:
>> Thank you for the advice.  Looks like I get to try to rewrite the ath9k and ath10k drivers to use dma_alloc_coherent() instead of kmemdup() and dev_alloc_skb()
>
> Euh no... dev_alloc_skb() is the right thing to do for receive
> packets for a device driver.
>
> The arch should be able to map that for DMA, even if include
> bounce buffers via swiotlb.
>
> Cheers,
> Ben.

I have fixed the kmemdup usage to be dma_alloc_coherent() in the ath10k driver.

While dev_alloc_skb() is the right thing to do for receive packets,
the dma_map_single for all of those buffers fails.  So it looks like I
have to add the ifdef conditional from
arch/powerpc/platforms/85xx/corenet_generic.c to struct sk_buff
*__netdev_alloc_skb() in net/core/skbuff.c

#if defined(CONFIG_FSL_PCI) && defined(CONFIG_ZONE_DMA32)
        gfp_mask |= GFP_DMA32;
#endif

On Sun, Mar 25, 2018 at 6:27 PM, Oliver <oohall@gmail.com> wrote:
> On Fri, Mar 23, 2018 at 11:41 PM, Jared Bents
> <jared.bents@rockwellcollins.com> wrote:
>> Thank you for the advice.  Looks like I get to try to rewrite the ath9k and
>> ath10k drivers to use dma_alloc_coherent() instead of kmemdup() and
>> dev_alloc_skb()
>
> I don't think you need to go that far. It looks like you might be able
> to fix the uses of kmemdup() and kzalloc() in
> ath10k_pci_hif_exchange_bmi_msg() and call it a day. Auditing the
> other uses of dma_map_single() to see if they're using kmalloc()
> memory might be a good idea too.
>
> Anyway this is probably something you're better off taking to the ath10k list.
>
> Thanks,
> Oliver
>

I'll take my update of kmemdup to dma_alloc_coherent() to the ath10k
mailing list.  However, even after updating to use
dma_alloc_coherent() and adding the conditional to
__netdev_alloc_skb() for the rx skb's used in the driver, I am still
getting a transmit error.  I'm struggling to track down where in the
kernel the skb being taken from a queue is coming from in
drivers/net/wireless/ath/ath10k/mac.c
I will ask ath10k about this as well.  The skb being taken off the
queue below is later DMAed with dma_map_single and that fails but
since I haven't figured out where it comes from, I haven't been able
to try to fix it.

void ath10k_offchan_tx_work(struct work_struct *work)
{
>.......struct ath10k *ar = container_of(work, struct ath10k, offchan_tx_work);
[...]

>.......for (;;) {
>.......>.......skb = skb_dequeue(&ar->offchan_tx_queue);

Thank you for all the help,
Jared

>>
>> On Thu, Mar 22, 2018 at 8:19 PM, Oliver <oohall@gmail.com> wrote:
>>>
>>> On Fri, Mar 23, 2018 at 1:37 AM, Jared Bents
>>> <jared.bents@rockwellcollins.com> wrote:
>>> > Thank you for the response but unfortunately, it looks like I already
>>> > have that and it is being used.  To verify, I commented that out and
>>> > got the failure "dma_direct_alloc_coherent: No suitable zone for pfn
>>> > 0xe0000".  Below is the code flow for function
>>> > ath10k_pci_hif_exchange_bmi_msg which is showing the first dma mapping
>>> > error.
>>> >
>>> > ath10k_pci_hif_exchange_bmi_msg -> dma_map_single ->
>>> > dma_map_single_attrs -> swiotlb_map_page -> dma_capable (returns
>>> > false)
>>> >
>>> >
>>> > dma_capable is what reports the failure in that flow.
>>> >
>>> > static inline bool dma_capable(struct device *dev, dma_addr_t addr,
>>> > size_t size)
>>> > {
>>> > #ifdef CONFIG_SWIOTLB
>>> >     struct dev_archdata *sd = &dev->archdata;
>>> >
>>> >    if (sd->max_direct_dma_addr && addr + size > sd->max_direct_dma_addr)
>>> >         return false;
>>> > #endif
>>> >
>>> >     if (!dev->dma_mask)
>>> >         return false;
>>> >
>>> >     return addr + size - 1 <= *dev->dma_mask;
>>> > }
>>> > Getting the below values:
>>> > addr = 1ee376218
>>> > size = 4
>>> > sd->max_direct_dma_addr = e0000000 which is I believe DMA window size
>>> > (e0000000)
>>> >
>>> > when executed sd->max_direct_dma_addr(e0000000) && addr(1ee376218) +
>>> > size(4) becomes e0000004 which is > sd->max_direct_dma_addr (e0000000)
>>> >
>>> >
>>> > So even though limit_zone_pfn(ZONE_DMA32, 1UL << (31 - PAGE_SHIFT)) is
>>> > being used in arch/powerpc/platforms/85xx/corenet_generic.c,
>>>
>>> > kmemdup(req, req_len, GFP_KERNEL) is returning an address that when
>>> > sent to dma_map_single(), results in a bad map.
>>>
>>> You need to use (GFP_KERNEL | GFP_DMA32) to constrain the allocations
>>> to ZONE_DMA32. Without that the kmemdup() will allocate from any zone
>>> so you'll probably get an unmappable address.
>>>
>>> That said, the driver probably shouldn't be using kmemdup() here.
>>> DMA-API.txt pretty explicitly says that drivers should not assume that
>>> dma_map_single() will work with arbitrary memory. It should be using
>>> dma_alloc_coherent() or a dma pool here.
>>>
>>> > - Jared
>>> >
>>> > On Wed, Mar 21, 2018 at 11:54 PM, Oliver <oohall@gmail.com> wrote:
>>> >> On Thu, Mar 22, 2018 at 8:00 AM, Jared Bents
>>> >> <jared.bents@rockwellcollins.com> wrote:
>>> >>> Hi all,
>>> >>>
>>> >>> Apologies for the amount of information but we've been debugging this
>>> >>> for a while and I wanted to get what we are seeing captured as much as
>>> >>> possible.  We are a T1042 processor and have a total 8GB DDR and our
>>> >>> kernel version is fsl-sdk-v2.0-1703 (linux v4.1.35) as that is the
>>> >>> latest version supplied by NXP.
>>> >>>
>>> >>> A while ago we ported from 32 bit to 64 bit.  Everything continued to
>>> >>> work except the ath10k module we have.  So as a first step, we checked
>>> >>> to see if an ath9k module also failed to work and it was also no
>>> >>> longer working.  The ath10k is working fine on a 32 bit system but
>>> >>> it's not working on 64 bit system as we are getting dma mapping errors
>>> >>> when trying to initialize the wifi modules.
>>> >>>
>>> >>> pci_bus 0002:01: bus scan returning with max=01
>>> >>> pci_bus 0002:01: busn_res: [bus 01] end is updated to 01
>>> >>> pci_bus 0002:00: bus scan returning with max=01
>>> >>> ath10k_pci 0000:01:00.0: unable to get target info from device
>>> >>> ath10k_pci 0000:01:00.0: could not get target info (-5)
>>> >>> ath10k_pci 0000:01:00.0: could not probe fw (-5)
>>> >>> ath10k_pci 0001:01:00.0: Direct firmware load for
>>> >>> ath10k/cal-pci-0001:01:00.0.bin failed with error -2
>>> >>>
>>> >>>
>>> >>> First, we have tried the mainline kernel (v4.15)  to see if that would
>>> >>> fix the issue, it did not.  So I made a patch for the ath10k driver to
>>> >>> restrict to just GFP_DMA areas when allocating memory or creating
>>> >>> sk_buffs and have attached it.  The ath10k wifi modules now initialize
>>> >>> correctly but when I try to connect them and send traffic, they get a
>>> >>> DMA mapping error from the sk_buff that it receives from elsewhere in
>>> >>> the kernel.  So while the driver appears to be fixable with the patch,
>>> >>> the modules are still unusable due to data being sent to the driver
>>> >>> when ath10k_tx is called and it tries to dma map with the provided
>>> >>> skb.  Also, according to the ath10k mailing list, GFP_DMA is not
>>> >>> supposed to be used in general.  The error below is the same sort of
>>> >>> dma mapping error that is seen when initializing the modules without
>>> >>> the patch to OR with GFP_DMA.
>>> >>>
>>> >>> ath10k_pci 0001:01:00.0: failed to transmit packet, dropping: -5
>>> >>>
>>> >>>
>>> >>> We asked on the ath10k mailing list if anyone else is having this
>>> >>> problem and no one else seems to have the issue but they are using
>>> >>> different architectures (ARM or X86). As a result, it does not seem to
>>> >>> be a driver issue to us but something within the PowerPC arch.  So we
>>> >>> dug a little deeper to try to find what addresses being mapped are
>>> >>> working and what address being mapped are not working.
>>> >>>
>>> >>> We found that when the virtual address of data pointer (a member of
>>> >>> sk_buff) is above ~3.7 GB RAM address range then return address from
>>> >>> dma_map_single API is failed to validate in dma_mapping_error
>>> >>> function.
>>> >>>
>>> >>> We also noticed that in a 64bit machine sometimes ping is working and
>>> >>> because of the virtual address is under ~3.7GAM RAM address range.  So
>>> >>> if we set mem=2048M in the bootargs, the ath10k module works
>>> >>> perfectly, however this isn't a real solution since it cuts our
>>> >>> available RAM from 8GB to 2GB.
>>> >>
>>> >> I think there's a known issue with the freescale PCIe root complex
>>> >> where it can't DMA beyond the 4GB mark. There's a workaround in
>>> >> the form of limit_zone_pfn() which you can use to put the lower 4GB
>>> >> into
>>> >> ZONE_DMA32 and allocate from there rather than ZONE_NORMAL.
>>> >> For details of how to use it have a look at corenet_gen_setup_arch() in
>>> >> arch/powerpc/platforms/85xx/corenet_generic.c
>>> >>
>>> >> Hope that helps,
>>> >> Oliver
>>
>>
