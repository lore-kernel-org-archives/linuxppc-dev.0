Return-Path: <SRS0=Z4Cu=QL=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 328DFC282C4
	for <linuxppc-dev@archiver.kernel.org>; Mon,  4 Feb 2019 18:59:13 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4FD442082E
	for <linuxppc-dev@archiver.kernel.org>; Mon,  4 Feb 2019 18:59:12 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4FD442082E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kaod.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 43tcSZ0bvCzDqLC
	for <linuxppc-dev@archiver.kernel.org>; Tue,  5 Feb 2019 05:59:10 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=kaod.org
 (client-ip=46.105.58.226; helo=3.mo2.mail-out.ovh.net;
 envelope-from=clg@kaod.org; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=none (p=none dis=none) header.from=kaod.org
Received: from 3.mo2.mail-out.ovh.net (3.mo2.mail-out.ovh.net [46.105.58.226])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256
 bits)) (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 43tcQs3sPkzDqJ2
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  5 Feb 2019 05:57:40 +1100 (AEDT)
Received: from player789.ha.ovh.net (unknown [10.109.143.216])
 by mo2.mail-out.ovh.net (Postfix) with ESMTP id 9539017B997
 for <linuxppc-dev@lists.ozlabs.org>; Mon,  4 Feb 2019 19:57:35 +0100 (CET)
Received: from kaod.org (lfbn-1-10603-25.w90-89.abo.wanadoo.fr [90.89.194.25])
 (Authenticated sender: clg@kaod.org)
 by player789.ha.ovh.net (Postfix) with ESMTPSA id 6B9E1250C020;
 Mon,  4 Feb 2019 18:57:27 +0000 (UTC)
Subject: Re: [PATCH 17/19] KVM: PPC: Book3S HV: add get/set accessors for the
 VP XIVE state
To: David Gibson <david@gibson.dropbear.id.au>
References: <20190107184331.8429-1-clg@kaod.org>
 <20190107191006.10648-1-clg@kaod.org> <20190204052646.GJ1927@umbus.fritz.box>
From: =?UTF-8?Q?C=c3=a9dric_Le_Goater?= <clg@kaod.org>
Message-ID: <5ebeb37b-623b-9b82-5628-fd6d78382064@kaod.org>
Date: Mon, 4 Feb 2019 19:57:26 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.4.0
MIME-Version: 1.0
In-Reply-To: <20190204052646.GJ1927@umbus.fritz.box>
Content-Type: text/plain; charset=windows-1252
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Ovh-Tracer-Id: 10024731296739396487
X-VR-SPAMSTATE: OK
X-VR-SPAMSCORE: -100
X-VR-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrgedtledrkeeggdduudelucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuqfggjfdpvefjgfevmfevgfenuceurghilhhouhhtmecuhedttdenucesvcftvggtihhpihgvnhhtshculddquddttddm
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

On 2/4/19 6:26 AM, David Gibson wrote:
> On Mon, Jan 07, 2019 at 08:10:04PM +0100, Cédric Le Goater wrote:
>> At a VCPU level, the state of the thread context interrupt management
>> registers needs to be collected. These registers are cached under the
>> 'xive_saved_state.w01' field of the VCPU when the VPCU context is
>> pulled from the HW thread. An OPAL call retrieves the backup of the
>> IPB register in the NVT structure and merges it in the KVM state.
>>
>> The structures of the interface between QEMU and KVM provisions some
>> extra room (two u64) for further extensions if more state needs to be
>> transferred back to QEMU.
>>
>> Signed-off-by: Cédric Le Goater <clg@kaod.org>
>> ---
>>  arch/powerpc/include/asm/kvm_ppc.h    |  5 ++
>>  arch/powerpc/include/uapi/asm/kvm.h   |  2 +
>>  arch/powerpc/kvm/book3s.c             | 24 +++++++++
>>  arch/powerpc/kvm/book3s_xive_native.c | 78 +++++++++++++++++++++++++++
>>  4 files changed, 109 insertions(+)
>>
>> diff --git a/arch/powerpc/include/asm/kvm_ppc.h b/arch/powerpc/include/asm/kvm_ppc.h
>> index 4cc897039485..49c488af168c 100644
>> --- a/arch/powerpc/include/asm/kvm_ppc.h
>> +++ b/arch/powerpc/include/asm/kvm_ppc.h
>> @@ -270,6 +270,7 @@ union kvmppc_one_reg {
>>  		u64	addr;
>>  		u64	length;
>>  	}	vpaval;
>> +	u64	xive_timaval[4];
>>  };
>>  
>>  struct kvmppc_ops {
>> @@ -603,6 +604,8 @@ extern void kvmppc_xive_native_cleanup_vcpu(struct kvm_vcpu *vcpu);
>>  extern void kvmppc_xive_native_init_module(void);
>>  extern void kvmppc_xive_native_exit_module(void);
>>  extern int kvmppc_xive_native_hcall(struct kvm_vcpu *vcpu, u32 cmd);
>> +extern int kvmppc_xive_native_get_vp(struct kvm_vcpu *vcpu, union kvmppc_one_reg *val);
>> +extern int kvmppc_xive_native_set_vp(struct kvm_vcpu *vcpu, union kvmppc_one_reg *val);
>>  
>>  #else
>>  static inline int kvmppc_xive_set_xive(struct kvm *kvm, u32 irq, u32 server,
>> @@ -637,6 +640,8 @@ static inline void kvmppc_xive_native_init_module(void) { }
>>  static inline void kvmppc_xive_native_exit_module(void) { }
>>  static inline int kvmppc_xive_native_hcall(struct kvm_vcpu *vcpu, u32 cmd)
>>  	{ return 0; }
>> +static inline int kvmppc_xive_native_get_vp(struct kvm_vcpu *vcpu, union kvmppc_one_reg *val) { return 0; }
>> +static inline int kvmppc_xive_native_set_vp(struct kvm_vcpu *vcpu, union kvmppc_one_reg *val) { return -ENOENT; }
> 
> IIRC "VP" is the old name for "TCTX".  Since we're using tctx in the
> rest of the XIVE code, can we use it here as well.

OK. The state we are getting or setting is indeed related to the thread 
interrupt  context registers. 

The name VP is related to an identifier to some interrupt context under 
OPAL (NVT in HW to be precise).  

C.

> 
>>  #endif /* CONFIG_KVM_XIVE */
>>  
>> diff --git a/arch/powerpc/include/uapi/asm/kvm.h b/arch/powerpc/include/uapi/asm/kvm.h
>> index 95302558ce10..3c958c39a782 100644
>> --- a/arch/powerpc/include/uapi/asm/kvm.h
>> +++ b/arch/powerpc/include/uapi/asm/kvm.h
>> @@ -480,6 +480,8 @@ struct kvm_ppc_cpu_char {
>>  #define  KVM_REG_PPC_ICP_PPRI_SHIFT	16	/* pending irq priority */
>>  #define  KVM_REG_PPC_ICP_PPRI_MASK	0xff
>>  
>> +#define KVM_REG_PPC_VP_STATE	(KVM_REG_PPC | KVM_REG_SIZE_U256 | 0x8d)
>> +
>>  /* Device control API: PPC-specific devices */
>>  #define KVM_DEV_MPIC_GRP_MISC		1
>>  #define   KVM_DEV_MPIC_BASE_ADDR	0	/* 64-bit */
>> diff --git a/arch/powerpc/kvm/book3s.c b/arch/powerpc/kvm/book3s.c
>> index de7eed191107..5ad658077a35 100644
>> --- a/arch/powerpc/kvm/book3s.c
>> +++ b/arch/powerpc/kvm/book3s.c
>> @@ -641,6 +641,18 @@ int kvmppc_get_one_reg(struct kvm_vcpu *vcpu, u64 id,
>>  				*val = get_reg_val(id, kvmppc_xics_get_icp(vcpu));
>>  			break;
>>  #endif /* CONFIG_KVM_XICS */
>> +#ifdef CONFIG_KVM_XIVE
>> +		case KVM_REG_PPC_VP_STATE:
>> +			if (!vcpu->arch.xive_vcpu) {
>> +				r = -ENXIO;
>> +				break;
>> +			}
>> +			if (xive_enabled())
>> +				r = kvmppc_xive_native_get_vp(vcpu, val);
>> +			else
>> +				r = -ENXIO;
>> +			break;
>> +#endif /* CONFIG_KVM_XIVE */
>>  		case KVM_REG_PPC_FSCR:
>>  			*val = get_reg_val(id, vcpu->arch.fscr);
>>  			break;
>> @@ -714,6 +726,18 @@ int kvmppc_set_one_reg(struct kvm_vcpu *vcpu, u64 id,
>>  				r = kvmppc_xics_set_icp(vcpu, set_reg_val(id, *val));
>>  			break;
>>  #endif /* CONFIG_KVM_XICS */
>> +#ifdef CONFIG_KVM_XIVE
>> +		case KVM_REG_PPC_VP_STATE:
>> +			if (!vcpu->arch.xive_vcpu) {
>> +				r = -ENXIO;
>> +				break;
>> +			}
>> +			if (xive_enabled())
>> +				r = kvmppc_xive_native_set_vp(vcpu, val);
>> +			else
>> +				r = -ENXIO;
>> +			break;
>> +#endif /* CONFIG_KVM_XIVE */
>>  		case KVM_REG_PPC_FSCR:
>>  			vcpu->arch.fscr = set_reg_val(id, *val);
>>  			break;
>> diff --git a/arch/powerpc/kvm/book3s_xive_native.c b/arch/powerpc/kvm/book3s_xive_native.c
>> index f4eb71eafc57..1aefb366df0b 100644
>> --- a/arch/powerpc/kvm/book3s_xive_native.c
>> +++ b/arch/powerpc/kvm/book3s_xive_native.c
>> @@ -424,6 +424,84 @@ static int xive_native_validate_queue_size(u32 qsize)
>>  	}
>>  }
>>  
>> +#define TM_IPB_SHIFT 40
>> +#define TM_IPB_MASK  (((u64) 0xFF) << TM_IPB_SHIFT)
>> +
>> +int kvmppc_xive_native_get_vp(struct kvm_vcpu *vcpu, union kvmppc_one_reg *val)
>> +{
>> +	struct kvmppc_xive_vcpu *xc = vcpu->arch.xive_vcpu;
>> +	u64 opal_state;
>> +	int rc;
>> +
>> +	if (!kvmppc_xive_enabled(vcpu))
>> +		return -EPERM;
>> +
>> +	if (!xc)
>> +		return -ENOENT;
>> +
>> +	/* Thread context registers. We only care about IPB and CPPR */
>> +	val->xive_timaval[0] = vcpu->arch.xive_saved_state.w01;
>> +
>> +	/*
>> +	 * Return the OS CAM line to print out the VP identifier in
>> +	 * the QEMU monitor. This is not restored.
>> +	 */
>> +	val->xive_timaval[1] = vcpu->arch.xive_cam_word;
>> +
>> +	/* Get the VP state from OPAL */
>> +	rc = xive_native_get_vp_state(xc->vp_id, &opal_state);
>> +	if (rc)
>> +		return rc;
>> +
>> +	/*
>> +	 * Capture the backup of IPB register in the NVT structure and
>> +	 * merge it in our KVM VP state.
>> +	 *
>> +	 * TODO: P10 support.
>> +	 */
>> +	val->xive_timaval[0] |= cpu_to_be64(opal_state & TM_IPB_MASK);
>> +
>> +	pr_devel("%s NSR=%02x CPPR=%02x IBP=%02x PIPR=%02x w01=%016llx w2=%08x opal=%016llx\n",
>> +		 __func__,
>> +		 vcpu->arch.xive_saved_state.nsr,
>> +		 vcpu->arch.xive_saved_state.cppr,
>> +		 vcpu->arch.xive_saved_state.ipb,
>> +		 vcpu->arch.xive_saved_state.pipr,
>> +		 vcpu->arch.xive_saved_state.w01,
>> +		 (u32) vcpu->arch.xive_cam_word, opal_state);
>> +
>> +	return 0;
>> +}
>> +
>> +int kvmppc_xive_native_set_vp(struct kvm_vcpu *vcpu, union kvmppc_one_reg *val)
>> +{
>> +	struct kvmppc_xive_vcpu *xc = vcpu->arch.xive_vcpu;
>> +	struct kvmppc_xive *xive = vcpu->kvm->arch.xive;
>> +
>> +	pr_devel("%s w01=%016llx vp=%016llx\n", __func__,
>> +		 val->xive_timaval[0], val->xive_timaval[1]);
>> +
>> +	if (!kvmppc_xive_enabled(vcpu))
>> +		return -EPERM;
>> +
>> +	if (!xc || !xive)
>> +		return -ENOENT;
>> +
>> +	/* We can't update the state of a "pushed" VCPU	 */
>> +	if (WARN_ON(vcpu->arch.xive_pushed))
>> +		return -EIO;
>> +
>> +	/* Thread context registers. only restore IPB and CPPR ? */
>> +	vcpu->arch.xive_saved_state.w01 = val->xive_timaval[0];
>> +
>> +	/*
>> +	 * There is no need to restore the XIVE internal state (IPB
>> +	 * stored in the NVT) as the IPB register was merged in KVM VP
>> +	 * state.
>> +	 */
>> +	return 0;
>> +}
>> +
>>  static int kvmppc_xive_native_set_source(struct kvmppc_xive *xive, long irq,
>>  					 u64 addr)
>>  {
> 

