Return-Path: <SRS0=xfkn=QI=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 14F7CC282D8
	for <linuxppc-dev@archiver.kernel.org>; Fri,  1 Feb 2019 17:23:32 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 437EF218AC
	for <linuxppc-dev@archiver.kernel.org>; Fri,  1 Feb 2019 17:23:31 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 437EF218AC
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kaod.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 43rkTY2hbPzDqjM
	for <linuxppc-dev@archiver.kernel.org>; Sat,  2 Feb 2019 04:23:29 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=kaod.org
 (client-ip=178.33.109.80; helo=2.mo177.mail-out.ovh.net;
 envelope-from=clg@kaod.org; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=none (p=none dis=none) header.from=kaod.org
Received: from 2.mo177.mail-out.ovh.net (2.mo177.mail-out.ovh.net
 [178.33.109.80])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 43rkRg07wKzDqdG
 for <linuxppc-dev@lists.ozlabs.org>; Sat,  2 Feb 2019 04:21:48 +1100 (AEDT)
Received: from player779.ha.ovh.net (unknown [10.109.160.5])
 by mo177.mail-out.ovh.net (Postfix) with ESMTP id 47C98E339D
 for <linuxppc-dev@lists.ozlabs.org>; Fri,  1 Feb 2019 18:03:37 +0100 (CET)
Received: from kaod.org (lfbn-1-10603-25.w90-89.abo.wanadoo.fr [90.89.194.25])
 (Authenticated sender: clg@kaod.org)
 by player779.ha.ovh.net (Postfix) with ESMTPSA id D965022F14DC;
 Fri,  1 Feb 2019 17:03:29 +0000 (UTC)
Subject: Re: [PATCH 05/19] KVM: PPC: Book3S HV: add a new KVM device for the
 XIVE native exploitation mode
To: Paul Mackerras <paulus@ozlabs.org>
References: <20190107184331.8429-1-clg@kaod.org>
 <20190107184331.8429-6-clg@kaod.org> <20190122050520.GC15124@blackberry>
 <d21664e5-1d9c-5a55-5b83-bf5e6247917a@kaod.org>
 <20190130042919.GA27109@blackberry>
 <74d4fe26-9e5a-a72e-815a-223a55f1bc0f@kaod.org>
 <20190131030120.GB4675@blackberry>
From: =?UTF-8?Q?C=c3=a9dric_Le_Goater?= <clg@kaod.org>
Message-ID: <e2e25ed7-e102-6391-98e4-ea79232e09ff@kaod.org>
Date: Fri, 1 Feb 2019 18:03:29 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.4.0
MIME-Version: 1.0
In-Reply-To: <20190131030120.GB4675@blackberry>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Ovh-Tracer-Id: 8928667739041860487
X-VR-SPAMSTATE: OK
X-VR-SPAMSCORE: -100
X-VR-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrgedtledrjeekgdeliecutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfqggfjpdevjffgvefmvefgnecuuegrihhlohhuthemucehtddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmd
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
Cc: kvm@vger.kernel.org, kvm-ppc@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
 David Gibson <david@gibson.dropbear.id.au>
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

On 1/31/19 4:01 AM, Paul Mackerras wrote:
> On Wed, Jan 30, 2019 at 08:01:22AM +0100, Cédric Le Goater wrote:
>> On 1/30/19 5:29 AM, Paul Mackerras wrote:
>>> On Mon, Jan 28, 2019 at 06:35:34PM +0100, Cédric Le Goater wrote:
>>>> On 1/22/19 6:05 AM, Paul Mackerras wrote:
>>>>> On Mon, Jan 07, 2019 at 07:43:17PM +0100, Cédric Le Goater wrote:
>>>>>> This is the basic framework for the new KVM device supporting the XIVE
>>>>>> native exploitation mode. The user interface exposes a new capability
>>>>>> and a new KVM device to be used by QEMU.
>>>>>
>>>>> [snip]
>>>>>> @@ -1039,7 +1039,10 @@ static int kvmppc_book3s_init(void)
>>>>>>  #ifdef CONFIG_KVM_XIVE
>>>>>>  	if (xive_enabled()) {
>>>>>>  		kvmppc_xive_init_module();
>>>>>> +		kvmppc_xive_native_init_module();
>>>>>>  		kvm_register_device_ops(&kvm_xive_ops, KVM_DEV_TYPE_XICS);
>>>>>> +		kvm_register_device_ops(&kvm_xive_native_ops,
>>>>>> +					KVM_DEV_TYPE_XIVE);
>>>>>
>>>>> I think we want tighter conditions on initializing the xive_native
>>>>> stuff and creating the xive device class.  We could have
>>>>> xive_enabled() returning true in a guest, and this code will get
>>>>> called both by PR KVM and HV KVM (and HV KVM no longer implies that we
>>>>> are running bare metal).
>>>>
>>>> So yes, I gave nested a try with kernel_irqchip=on and the nested hypervisor 
>>>> (L1) obviously crashes trying to call OPAL. I have tighten the test with : 
>>>>
>>>> 	if (xive_enabled() && !kvmhv_on_pseries()) {
>>>>
>>>> for now.
>>>>
>>>> As this is a problem today in 5.0.x, I will send a patch for it if you think
>>>
>>> How do you mean this is a problem today in 5.0?  I just tried 5.0-rc1
>>> with kernel_irqchip=on in a nested guest and it works just fine.  What
>>> exactly did you test?
>>
>> L0: Linux 5.0.0-rc3 (+ KVM HV)
>> L1:     QEMU pseries-4.0 (kernel_irqchip=on) - Linux 5.0.0-rc3 (+ KVM HV)
>> L2:          QEMU pseries-4.0 (kernel_irqchip=on) - Linux 5.0.0-rc3
>>
>> L1 crashes when L2 starts and tries to initialize the KVM IRQ device as 
>> it does an OPAL call and its running under SLOF. See below.
> 
> OK, you must have a QEMU that advertises XIVE to the guest (L1). 

XIVE is not advertised if QEMU is started with 'ic-mode=xics' 

> In
> that case I can see that L1 would try to do XICS-on-XIVE, which won't
> work.  We need to fix that.  Unfortunately the XICS-on-XICS emulation
> won't work as is in L1 either, but I think we can fix that by
> disabling the real-mode XICS hcall handling.

I have added some tests on kvm-hv, using kvmhv_on_pseries(), to disable 
the KVM XICS-on-XIVE device in a L1 guest running as hypervisor and 
to instead register the old KVM XICS device. 

If the L1 is started in KVM XICS mode, L2 can now run with KVM XICS.
All seem fine. I booted two guests with disk and network. 

But I am still "a bit" confused with what is being done at each 
hypervisor level. It's not obvious to follow at all even with traces.
 
>> I don't understand how L2 can work with kernel_irqchip=on. Could you
>> please explain ? 
> 
> If QEMU decides to advertise XIVE to the L2 guest and the L2 guest can
> do XIVE, then the only possibility is to use the XIVE software
> emulation in QEMU, and if kernel_irqchip=on has been specified
> explicitly, maybe QEMU decides to terminate the guest rather than
> implicitly turning off kernel_irqchip.

we can do that by disabling the KVM XIVE device when under kvmhv_on_pseries().

> If QEMU decides not to advertise XIVE to the L2 guest, or the L2 guest
> can't do XIVE, then we could use the XICS-on-XICS emulation in L1 as
> long as either (a) L1 is not using XIVE, or (b) we modify the
> XICS-on-XICS code to avoid using any XICS or XIVE access (i.e. just
> using calls to generic kernel facilities).

(a) is what I did above I think

May be we should consider having nested version of the KVM devices 
when under kvmhv_on_pseries(). With some sort of backend ops to
modify the relation with the parent hypervisor : PowerNV/Linux or 
pseries/Linux. 

> Ultimately, if the spapr xive backend code in the kernel could be
> extended to provide all the low-level functions that the XICS-on-XIVE
> code needs, then we could do XICS-on-XIVE in a guest.

What about a XIVE on XIVE ? 

Propagating the ESB pages to a nested guest seems feasible if not 
already done. The hcalls could be forwarded to the L1 QEMU ? The 
problematic part is handling the XIVE VP block.

C.

