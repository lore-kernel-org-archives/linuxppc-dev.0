Return-Path: <jared.bents@rockwellcollins.com>
Received: from ch3vs03.rockwellcollins.com (ch3vs03.rockwellcollins.com
 [205.175.226.47])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 406V112drpzF1vJ
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 23 Mar 2018 01:48:51 +1100 (AEDT)
Received: by mail-yb0-f200.google.com with SMTP id p77-v6so3583459ybg.10
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 22 Mar 2018 07:37:40 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <CAOSf1CGqc9=QnrChOY_+YL0v8TALQ+pH8u1e26Q--0PS4CGm2g@mail.gmail.com>
References: <CAM=7fbcynhZ3iPtCGpVCgDmw7OU6SQcucZDm1kUdv=soky9RJQ@mail.gmail.com>
 <CAOSf1CGqc9=QnrChOY_+YL0v8TALQ+pH8u1e26Q--0PS4CGm2g@mail.gmail.com>
From: Jared Bents <jared.bents@rockwellcollins.com>
Date: Thu, 22 Mar 2018 09:37:38 -0500
Message-ID: <CAM=7fbdN=sLncGK2hgq2fNWeULdff8opViD9UQ3qj29KTG5tNQ@mail.gmail.com>
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

Thank you for the response but unfortunately, it looks like I already
have that and it is being used.  To verify, I commented that out and
got the failure "dma_direct_alloc_coherent: No suitable zone for pfn
0xe0000".  Below is the code flow for function
ath10k_pci_hif_exchange_bmi_msg which is showing the first dma mapping
error.

ath10k_pci_hif_exchange_bmi_msg -> dma_map_single ->
dma_map_single_attrs -> swiotlb_map_page -> dma_capable (returns
false)


dma_capable is what reports the failure in that flow.

static inline bool dma_capable(struct device *dev, dma_addr_t addr, size_t size)
{
#ifdef CONFIG_SWIOTLB
    struct dev_archdata *sd = &dev->archdata;

   if (sd->max_direct_dma_addr && addr + size > sd->max_direct_dma_addr)
        return false;
#endif

    if (!dev->dma_mask)
        return false;

    return addr + size - 1 <= *dev->dma_mask;
}
Getting the below values:
addr = 1ee376218
size = 4
sd->max_direct_dma_addr = e0000000 which is I believe DMA window size (e0000000)

when executed sd->max_direct_dma_addr(e0000000) && addr(1ee376218) +
size(4) becomes e0000004 which is > sd->max_direct_dma_addr (e0000000)


So even though limit_zone_pfn(ZONE_DMA32, 1UL << (31 - PAGE_SHIFT)) is
being used in arch/powerpc/platforms/85xx/corenet_generic.c,
kmemdup(req, req_len, GFP_KERNEL) is returning an address that when
sent to dma_map_single(), results in a bad map.

- Jared

On Wed, Mar 21, 2018 at 11:54 PM, Oliver <oohall@gmail.com> wrote:
> On Thu, Mar 22, 2018 at 8:00 AM, Jared Bents
> <jared.bents@rockwellcollins.com> wrote:
>> Hi all,
>>
>> Apologies for the amount of information but we've been debugging this
>> for a while and I wanted to get what we are seeing captured as much as
>> possible.  We are a T1042 processor and have a total 8GB DDR and our
>> kernel version is fsl-sdk-v2.0-1703 (linux v4.1.35) as that is the
>> latest version supplied by NXP.
>>
>> A while ago we ported from 32 bit to 64 bit.  Everything continued to
>> work except the ath10k module we have.  So as a first step, we checked
>> to see if an ath9k module also failed to work and it was also no
>> longer working.  The ath10k is working fine on a 32 bit system but
>> it's not working on 64 bit system as we are getting dma mapping errors
>> when trying to initialize the wifi modules.
>>
>> pci_bus 0002:01: bus scan returning with max=01
>> pci_bus 0002:01: busn_res: [bus 01] end is updated to 01
>> pci_bus 0002:00: bus scan returning with max=01
>> ath10k_pci 0000:01:00.0: unable to get target info from device
>> ath10k_pci 0000:01:00.0: could not get target info (-5)
>> ath10k_pci 0000:01:00.0: could not probe fw (-5)
>> ath10k_pci 0001:01:00.0: Direct firmware load for
>> ath10k/cal-pci-0001:01:00.0.bin failed with error -2
>>
>>
>> First, we have tried the mainline kernel (v4.15)  to see if that would
>> fix the issue, it did not.  So I made a patch for the ath10k driver to
>> restrict to just GFP_DMA areas when allocating memory or creating
>> sk_buffs and have attached it.  The ath10k wifi modules now initialize
>> correctly but when I try to connect them and send traffic, they get a
>> DMA mapping error from the sk_buff that it receives from elsewhere in
>> the kernel.  So while the driver appears to be fixable with the patch,
>> the modules are still unusable due to data being sent to the driver
>> when ath10k_tx is called and it tries to dma map with the provided
>> skb.  Also, according to the ath10k mailing list, GFP_DMA is not
>> supposed to be used in general.  The error below is the same sort of
>> dma mapping error that is seen when initializing the modules without
>> the patch to OR with GFP_DMA.
>>
>> ath10k_pci 0001:01:00.0: failed to transmit packet, dropping: -5
>>
>>
>> We asked on the ath10k mailing list if anyone else is having this
>> problem and no one else seems to have the issue but they are using
>> different architectures (ARM or X86). As a result, it does not seem to
>> be a driver issue to us but something within the PowerPC arch.  So we
>> dug a little deeper to try to find what addresses being mapped are
>> working and what address being mapped are not working.
>>
>> We found that when the virtual address of data pointer (a member of
>> sk_buff) is above ~3.7 GB RAM address range then return address from
>> dma_map_single API is failed to validate in dma_mapping_error
>> function.
>>
>> We also noticed that in a 64bit machine sometimes ping is working and
>> because of the virtual address is under ~3.7GAM RAM address range.  So
>> if we set mem=2048M in the bootargs, the ath10k module works
>> perfectly, however this isn't a real solution since it cuts our
>> available RAM from 8GB to 2GB.
>
> I think there's a known issue with the freescale PCIe root complex
> where it can't DMA beyond the 4GB mark. There's a workaround in
> the form of limit_zone_pfn() which you can use to put the lower 4GB into
> ZONE_DMA32 and allocate from there rather than ZONE_NORMAL.
> For details of how to use it have a look at corenet_gen_setup_arch() in
> arch/powerpc/platforms/85xx/corenet_generic.c
>
> Hope that helps,
> Oliver
