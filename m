Return-Path: <SRS0=N2MO=QO=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0392CC282C2
	for <linuxppc-dev@archiver.kernel.org>; Thu,  7 Feb 2019 09:05:07 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7444B218B0
	for <linuxppc-dev@archiver.kernel.org>; Thu,  7 Feb 2019 09:05:06 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7444B218B0
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kaod.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 43wC7h496tzDqRn
	for <linuxppc-dev@archiver.kernel.org>; Thu,  7 Feb 2019 20:05:04 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=kaod.org
 (client-ip=46.105.51.249; helo=6.mo177.mail-out.ovh.net;
 envelope-from=clg@kaod.org; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=none (p=none dis=none) header.from=kaod.org
Received: from 6.mo177.mail-out.ovh.net (6.mo177.mail-out.ovh.net
 [46.105.51.249])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 43wC5x4R7hzDqQy
 for <linuxppc-dev@lists.ozlabs.org>; Thu,  7 Feb 2019 20:03:33 +1100 (AEDT)
Received: from player714.ha.ovh.net (unknown [10.109.160.230])
 by mo177.mail-out.ovh.net (Postfix) with ESMTP id BA619E3A83
 for <linuxppc-dev@lists.ozlabs.org>; Thu,  7 Feb 2019 10:03:28 +0100 (CET)
Received: from kaod.org (lfbn-1-10603-25.w90-89.abo.wanadoo.fr [90.89.194.25])
 (Authenticated sender: clg@kaod.org)
 by player714.ha.ovh.net (Postfix) with ESMTPSA id 3785F264ED7E;
 Thu,  7 Feb 2019 09:03:16 +0000 (UTC)
Subject: Re: [PATCH 06/19] KVM: PPC: Book3S HV: add a GET_ESB_FD control to
 the XIVE native device
To: David Gibson <david@gibson.dropbear.id.au>
References: <20190107184331.8429-1-clg@kaod.org>
 <20190107184331.8429-7-clg@kaod.org> <20190204044531.GB1927@umbus.fritz.box>
 <69791b73-f93e-6957-92e8-5b8620b87731@kaod.org>
 <20190205052822.GE22661@umbus.fritz.box>
 <4d565738-a99b-0333-8533-037677358faa@kaod.org>
 <20190206012308.GP22661@umbus.fritz.box>
 <1745dd9f-2927-cae6-e8da-c350b0bd0a66@kaod.org>
 <20190207024950.GA22661@umbus.fritz.box>
From: =?UTF-8?Q?C=c3=a9dric_Le_Goater?= <clg@kaod.org>
Message-ID: <d20bbaca-5b49-66e4-9d99-21d991c2c345@kaod.org>
Date: Thu, 7 Feb 2019 10:03:15 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.4.0
MIME-Version: 1.0
In-Reply-To: <20190207024950.GA22661@umbus.fritz.box>
Content-Type: text/plain; charset=windows-1252
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Ovh-Tracer-Id: 17609074545855138695
X-VR-SPAMSTATE: OK
X-VR-SPAMSCORE: -100
X-VR-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrgedtledrledtucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuqfggjfdpvefjgfevmfevgfenuceurghilhhouhhtmecuhedttdenucesvcftvggtihhpihgvnhhtshculddquddttddm
X-BeenThere: linuxppc-dev@lists.ozlabs.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>
Cc: kvm@vger.kernel.org, kvm-ppc@vger.kernel.org,
 Paul Mackerras <paulus@samba.org>, linuxppc-dev@lists.ozlabs.org
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

On 2/7/19 3:49 AM, David Gibson wrote:
> On Wed, Feb 06, 2019 at 08:21:10AM +0100, Cédric Le Goater wrote:
>> On 2/6/19 2:23 AM, David Gibson wrote:
>>> On Tue, Feb 05, 2019 at 01:55:40PM +0100, Cédric Le Goater wrote:
>>>> On 2/5/19 6:28 AM, David Gibson wrote:
>>>>> On Mon, Feb 04, 2019 at 12:30:39PM +0100, Cédric Le Goater wrote:
>>>>>> On 2/4/19 5:45 AM, David Gibson wrote:
>>>>>>> On Mon, Jan 07, 2019 at 07:43:18PM +0100, Cédric Le Goater wrote:
>>>>>>>> This will let the guest create a memory mapping to expose the ESB MMIO
>>>>>>>> regions used to control the interrupt sources, to trigger events, to
>>>>>>>> EOI or to turn off the sources.
>>>>>>>>
>>>>>>>> Signed-off-by: Cédric Le Goater <clg@kaod.org>
>>>>>>>> ---
>>>>>>>>  arch/powerpc/include/uapi/asm/kvm.h   |  4 ++
>>>>>>>>  arch/powerpc/kvm/book3s_xive_native.c | 97 +++++++++++++++++++++++++++
>>>>>>>>  2 files changed, 101 insertions(+)
>>>>>>>>
>>>>>>>> diff --git a/arch/powerpc/include/uapi/asm/kvm.h b/arch/powerpc/include/uapi/asm/kvm.h
>>>>>>>> index 8c876c166ef2..6bb61ba141c2 100644
>>>>>>>> --- a/arch/powerpc/include/uapi/asm/kvm.h
>>>>>>>> +++ b/arch/powerpc/include/uapi/asm/kvm.h
>>>>>>>> @@ -675,4 +675,8 @@ struct kvm_ppc_cpu_char {
>>>>>>>>  #define  KVM_XICS_PRESENTED		(1ULL << 43)
>>>>>>>>  #define  KVM_XICS_QUEUED		(1ULL << 44)
>>>>>>>>  
>>>>>>>> +/* POWER9 XIVE Native Interrupt Controller */
>>>>>>>> +#define KVM_DEV_XIVE_GRP_CTRL		1
>>>>>>>> +#define   KVM_DEV_XIVE_GET_ESB_FD	1
>>>>>>>
>>>>>>> Introducing a new FD for ESB and TIMA seems overkill.  Can't you get
>>>>>>> to both with an mmap() directly on the xive device fd?  Using the
>>>>>>> offset to distinguish which one to map, obviously.
>>>>>>
>>>>>> The page offset would define some sort of user API. It seems feasible.
>>>>>> But I am not sure this would be practical in the future if we need to 
>>>>>> tune the length.
>>>>>
>>>>> Um.. why not?  I mean, yes the XIVE supports rather a lot of
>>>>> interrupts, but we have 64-bits of offset we can play with - we can
>>>>> leave room for billions of ESB slots and still have room for billions
>>>>> of VPs.
>>>>
>>>> So the first 4 pages could be the TIMA pages and then would come  
>>>> the pages for the interrupt ESBs. I think that we can have different 
>>>> vm_fault handler for each mapping.
>>>
>>> Um.. no, I'm saying you don't need to tightly pack them.  So you could
>>> have the ESB pages at 0, the TIMA at, say offset 2^60.
>>
>> Well, we know that the TIMA is 4 pages wide and is "directly" related
>> with the KVM interrupt device. So being at offset 0 seems a good idea.
>> While the ESB segment is of a variable size depending on the number
>> of IRQs and it can come after I think.
>>
>>>> I wonder how this will work out with pass-through. As Paul said in 
>>>> a previous email, it would be better to let QEMU request a new 
>>>> mapping to handle the ESB pages of the device being passed through.
>>>> I guess this is not a special case, just another offset and length.
>>>
>>> Right, if we need multiple "chunks" of ESB pages we can given them
>>> each their own terabyte or several.  No need to be stingy with address
>>> space.
>>
>> You can not put them anywhere. They should map the same interrupt range
>> of ESB pages, overlapping with the underlying segment of IPI ESB pages. 
> 
> I don't really follow what you're saying here.


What we want the guest to access in terms of ESB pages is something like 
below, VMA0 being the initial mapping done by QEMU at offset 0x0, the IPI 
ESB pages being populated on the demand with the loads and the stores from 
the guest :


                 0x0                   0x1100  0x1200    0x1300     
      
         ranges   |       CPU IPIs   .. |  VIO  | PCI LSI |  MSIs
       	  
                  +-+-+-+-+-+-+-...-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+- ....
 VMA0    IPI ESB  | | | | | | |     | | | | | | | | | | | | | | | | | |
          pages   +-+-+-+-+-+-+-...-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+- ....



A device is passed through and the driver requests MSIs. 

We now want the guest to access the HW ESB pages for the requested IRQs 
but still the initial IPI ESB pages for the others. Something like below : 


                 0x0                   0x1100  0x1200    0x1300     
      
         ranges   |       CPU IPIs   .. |  VIO  | PCI LSI |  MSIs

                  +-+-+-+-+-+-+-...-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+- ....
 VMA0    IPI ESB  | | | | | | |     | | | | | | | | | | | | | | | | | |
          pages   +-+-+-+-+-+-+-...-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+- ....
                                                                  
 VMA1    PHB ESB                                          +-------+
          pages                                           | | | | | 
                                                          +-------+

The VMA1 is the result of a new mmap() being done at an offset depending on 
the first IRQ number requested by the driver. 

This is because the vm_fault handler uses the page offset to find the 
associated KVM IRQ struct containing the addresses of the EOI and trigger 
pages in the underlying hardware, which will be the PHB in case of a 
passthrough device.  

From there, the VMA1 mmap() pointer will be used to create a 'ram device'
memory region which will be mapped on top of the initial ESB memory region 
in QEMU. This will override the initial IPI ESB pages with the PHB ESB pages 
in the guest ESB address space. 

That's the plan I have in mind as suggested by Paul if I understood it well.
The mechanics are more complex than the patch zapping the PTEs from the VMA
but it's also safer. 


C.
