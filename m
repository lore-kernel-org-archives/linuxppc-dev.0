Return-Path: <SRS0=EZew=QM=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4838AC282CB
	for <linuxppc-dev@archiver.kernel.org>; Tue,  5 Feb 2019 12:21:48 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C604820821
	for <linuxppc-dev@archiver.kernel.org>; Tue,  5 Feb 2019 12:21:47 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C604820821
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kaod.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 43v3bY6NHqzDqLf
	for <linuxppc-dev@archiver.kernel.org>; Tue,  5 Feb 2019 23:21:45 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=kaod.org
 (client-ip=178.33.251.173; helo=1.mo69.mail-out.ovh.net;
 envelope-from=clg@kaod.org; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=none (p=none dis=none) header.from=kaod.org
Received: from 1.mo69.mail-out.ovh.net (1.mo69.mail-out.ovh.net
 [178.33.251.173])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 43v35T5Z2CzDq7h
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  5 Feb 2019 22:59:08 +1100 (AEDT)
Received: from player778.ha.ovh.net (unknown [10.109.159.139])
 by mo69.mail-out.ovh.net (Postfix) with ESMTP id 0AC1E4171E
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  5 Feb 2019 12:59:04 +0100 (CET)
Received: from kaod.org (deibp9eh1--blueice1n0.emea.ibm.com [195.212.29.162])
 (Authenticated sender: clg@kaod.org)
 by player778.ha.ovh.net (Postfix) with ESMTPSA id A6FAD2521336;
 Tue,  5 Feb 2019 11:58:55 +0000 (UTC)
Subject: Re: [PATCH 17/19] KVM: PPC: Book3S HV: add get/set accessors for the
 VP XIVE state
To: David Gibson <david@gibson.dropbear.id.au>
References: <20190107184331.8429-1-clg@kaod.org>
 <20190107191006.10648-1-clg@kaod.org> <20190204052646.GJ1927@umbus.fritz.box>
 <5ebeb37b-623b-9b82-5628-fd6d78382064@kaod.org>
 <20190205053331.GH22661@umbus.fritz.box>
From: =?UTF-8?Q?C=c3=a9dric_Le_Goater?= <clg@kaod.org>
Message-ID: <5e18629d-8aaf-1e20-46a1-64095da18bfb@kaod.org>
Date: Tue, 5 Feb 2019 12:58:54 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.4.0
MIME-Version: 1.0
In-Reply-To: <20190205053331.GH22661@umbus.fritz.box>
Content-Type: text/plain; charset=windows-1252
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Ovh-Tracer-Id: 8829307071584832391
X-VR-SPAMSTATE: OK
X-VR-SPAMSCORE: -100
X-VR-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrgedtledrkeeigdefudcutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfqggfjpdevjffgvefmvefgnecuuegrihhlohhuthemucehtddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmd
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

On 2/5/19 6:33 AM, David Gibson wrote:
> On Mon, Feb 04, 2019 at 07:57:26PM +0100, Cédric Le Goater wrote:
>> On 2/4/19 6:26 AM, David Gibson wrote:
>>> On Mon, Jan 07, 2019 at 08:10:04PM +0100, Cédric Le Goater wrote:
>>>> At a VCPU level, the state of the thread context interrupt management
>>>> registers needs to be collected. These registers are cached under the
>>>> 'xive_saved_state.w01' field of the VCPU when the VPCU context is
>>>> pulled from the HW thread. An OPAL call retrieves the backup of the
>>>> IPB register in the NVT structure and merges it in the KVM state.
>>>>
>>>> The structures of the interface between QEMU and KVM provisions some
>>>> extra room (two u64) for further extensions if more state needs to be
>>>> transferred back to QEMU.
>>>>
>>>> Signed-off-by: Cédric Le Goater <clg@kaod.org>
>>>> ---
>>>>  arch/powerpc/include/asm/kvm_ppc.h    |  5 ++
>>>>  arch/powerpc/include/uapi/asm/kvm.h   |  2 +
>>>>  arch/powerpc/kvm/book3s.c             | 24 +++++++++
>>>>  arch/powerpc/kvm/book3s_xive_native.c | 78 +++++++++++++++++++++++++++
>>>>  4 files changed, 109 insertions(+)
>>>>
>>>> diff --git a/arch/powerpc/include/asm/kvm_ppc.h b/arch/powerpc/include/asm/kvm_ppc.h
>>>> index 4cc897039485..49c488af168c 100644
>>>> --- a/arch/powerpc/include/asm/kvm_ppc.h
>>>> +++ b/arch/powerpc/include/asm/kvm_ppc.h
>>>> @@ -270,6 +270,7 @@ union kvmppc_one_reg {
>>>>  		u64	addr;
>>>>  		u64	length;
>>>>  	}	vpaval;
>>>> +	u64	xive_timaval[4];
>>>>  };
>>>>  
>>>>  struct kvmppc_ops {
>>>> @@ -603,6 +604,8 @@ extern void kvmppc_xive_native_cleanup_vcpu(struct kvm_vcpu *vcpu);
>>>>  extern void kvmppc_xive_native_init_module(void);
>>>>  extern void kvmppc_xive_native_exit_module(void);
>>>>  extern int kvmppc_xive_native_hcall(struct kvm_vcpu *vcpu, u32 cmd);
>>>> +extern int kvmppc_xive_native_get_vp(struct kvm_vcpu *vcpu, union kvmppc_one_reg *val);
>>>> +extern int kvmppc_xive_native_set_vp(struct kvm_vcpu *vcpu, union kvmppc_one_reg *val);
>>>>  
>>>>  #else
>>>>  static inline int kvmppc_xive_set_xive(struct kvm *kvm, u32 irq, u32 server,
>>>> @@ -637,6 +640,8 @@ static inline void kvmppc_xive_native_init_module(void) { }
>>>>  static inline void kvmppc_xive_native_exit_module(void) { }
>>>>  static inline int kvmppc_xive_native_hcall(struct kvm_vcpu *vcpu, u32 cmd)
>>>>  	{ return 0; }
>>>> +static inline int kvmppc_xive_native_get_vp(struct kvm_vcpu *vcpu, union kvmppc_one_reg *val) { return 0; }
>>>> +static inline int kvmppc_xive_native_set_vp(struct kvm_vcpu *vcpu, union kvmppc_one_reg *val) { return -ENOENT; }
>>>
>>> IIRC "VP" is the old name for "TCTX".  Since we're using tctx in the
>>> rest of the XIVE code, can we use it here as well.
>>
>> OK. The state we are getting or setting is indeed related to the thread 
>> interrupt  context registers. 
>>
>> The name VP is related to an identifier to some interrupt context under 
>> OPAL (NVT in HW to be precise).
> 
> Oh, sorry, "NVT" was the name I was looking for, not "TCTX".  But in
> any case, please lets standardize on one.

There is some confusion in the naming for :

 - VP    Virtual Processor (XIVE 1)
 - VPD   Virtual Processor Descriptor (XIVE 1)
 - TCTX  Thread interrupt context registers
 - NVT   Notify Virtual Target. Former VP. 
 - NVTS  Notify Virtual Target Structure. Where the TCTX regs are cached.


I am fine with using NVT because this is indeed the name of the XIVE 
structure where the HW caches the thread interrupt context registers.

But the XIVE native layer and the XICS-over-XIVE KVM device use the
name VP (the old one). I don't think we want to change these now.

C. 
