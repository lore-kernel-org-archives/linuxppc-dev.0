Return-Path: <SRS0=wHv8=RQ=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_SBL,
	URIBL_SBL_A autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B2FF5C43381
	for <linuxppc-dev@archiver.kernel.org>; Wed, 13 Mar 2019 13:21:36 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 170462087C
	for <linuxppc-dev@archiver.kernel.org>; Wed, 13 Mar 2019 13:21:36 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 170462087C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kaod.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 44KCCx6HD5zDqLj
	for <linuxppc-dev@archiver.kernel.org>; Thu, 14 Mar 2019 00:21:33 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=kaod.org
 (client-ip=46.105.39.61; helo=2.mo178.mail-out.ovh.net;
 envelope-from=clg@kaod.org; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=none (p=none dis=none) header.from=kaod.org
Received: from 2.mo178.mail-out.ovh.net (2.mo178.mail-out.ovh.net
 [46.105.39.61])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 44KCB54vSRzDqKh
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 14 Mar 2019 00:19:53 +1100 (AEDT)
Received: from player787.ha.ovh.net (unknown [10.109.160.244])
 by mo178.mail-out.ovh.net (Postfix) with ESMTP id 2C47E52C41
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 13 Mar 2019 14:19:48 +0100 (CET)
Received: from kaod.org (lfbn-1-2226-17.w90-76.abo.wanadoo.fr [90.76.48.17])
 (Authenticated sender: clg@kaod.org)
 by player787.ha.ovh.net (Postfix) with ESMTPSA id 776E53B95A5F;
 Wed, 13 Mar 2019 13:19:15 +0000 (UTC)
Subject: Re: [PATCH v2 10/16] KVM: PPC: Book3S HV: XIVE: add get/set accessors
 for the VP XIVE state
To: David Gibson <david@gibson.dropbear.id.au>
References: <20190222112840.25000-1-clg@kaod.org>
 <20190222112840.25000-11-clg@kaod.org>
 <20190225033144.GN7668@umbus.fritz.box>
From: =?UTF-8?Q?C=c3=a9dric_Le_Goater?= <clg@kaod.org>
Message-ID: <d33a2cb1-5370-7e72-07d9-ed0028c85b8c@kaod.org>
Date: Wed, 13 Mar 2019 14:19:13 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.4.0
MIME-Version: 1.0
In-Reply-To: <20190225033144.GN7668@umbus.fritz.box>
Content-Type: text/plain; charset=windows-1252
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Ovh-Tracer-Id: 248823883603610503
X-VR-SPAMSTATE: OK
X-VR-SPAMSCORE: -100
X-VR-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrgedutddrhedtgdehtdcutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfqggfjpdevjffgvefmvefgnecuuegrihhlohhuthemucehtddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmd
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

On 2/25/19 4:31 AM, David Gibson wrote:
> On Fri, Feb 22, 2019 at 12:28:34PM +0100, Cédric Le Goater wrote:
>> At a VCPU level, the state of the thread interrupt management
>> registers needs to be collected. These registers are cached under the
>> 'xive_saved_state.w01' field of the VCPU when the VPCU context is
>> pulled from the HW thread. An OPAL call retrieves the backup of the
>> IPB register in the underlying XIVE NVT structure and merges it in the
>> KVM state.
>>
>> The structures of the interface between QEMU and KVM provisions some
>> extra room (two u64) for further extensions if more state needs to be
>> transferred back to QEMU.
>>
>> Signed-off-by: Cédric Le Goater <clg@kaod.org>
>> ---
>>  arch/powerpc/include/asm/kvm_ppc.h         | 11 +++
>>  arch/powerpc/include/uapi/asm/kvm.h        |  2 +
>>  arch/powerpc/kvm/book3s.c                  | 24 +++++++
>>  arch/powerpc/kvm/book3s_xive_native.c      | 82 ++++++++++++++++++++++
>>  Documentation/virtual/kvm/devices/xive.txt | 19 +++++
>>  5 files changed, 138 insertions(+)
>>
>> diff --git a/arch/powerpc/include/asm/kvm_ppc.h b/arch/powerpc/include/asm/kvm_ppc.h
>> index 1e61877fe147..664c65051612 100644
>> --- a/arch/powerpc/include/asm/kvm_ppc.h
>> +++ b/arch/powerpc/include/asm/kvm_ppc.h
>> @@ -272,6 +272,7 @@ union kvmppc_one_reg {
>>  		u64	addr;
>>  		u64	length;
>>  	}	vpaval;
>> +	u64	xive_timaval[4];
> 
> This is doubling the size of the userspace visible one_reg union.  Is
> that safe?

'safe' as in compatibility on an older KVM which would still use the old 
kvmppc_one_reg definition ? 

It should be fine as KVM_REG_PPC_VP_STATE would not be handled. Am I wrong ?

>>  };
>>  
>>  struct kvmppc_ops {
>> @@ -604,6 +605,10 @@ extern int kvmppc_xive_native_connect_vcpu(struct kvm_device *dev,
>>  extern void kvmppc_xive_native_cleanup_vcpu(struct kvm_vcpu *vcpu);
>>  extern void kvmppc_xive_native_init_module(void);
>>  extern void kvmppc_xive_native_exit_module(void);
>> +extern int kvmppc_xive_native_get_vp(struct kvm_vcpu *vcpu,
>> +				     union kvmppc_one_reg *val);
>> +extern int kvmppc_xive_native_set_vp(struct kvm_vcpu *vcpu,
>> +				     union kvmppc_one_reg *val);
>>  
>>  #else
>>  static inline int kvmppc_xive_set_xive(struct kvm *kvm, u32 irq, u32 server,
>> @@ -636,6 +641,12 @@ static inline int kvmppc_xive_native_connect_vcpu(struct kvm_device *dev,
>>  static inline void kvmppc_xive_native_cleanup_vcpu(struct kvm_vcpu *vcpu) { }
>>  static inline void kvmppc_xive_native_init_module(void) { }
>>  static inline void kvmppc_xive_native_exit_module(void) { }
>> +static inline int kvmppc_xive_native_get_vp(struct kvm_vcpu *vcpu,
>> +					    union kvmppc_one_reg *val)
>> +{ return 0; }
>> +static inline int kvmppc_xive_native_set_vp(struct kvm_vcpu *vcpu,
>> +					    union kvmppc_one_reg *val)
>> +{ return -ENOENT; }
>>  
>>  #endif /* CONFIG_KVM_XIVE */
>>  
>> diff --git a/arch/powerpc/include/uapi/asm/kvm.h b/arch/powerpc/include/uapi/asm/kvm.h
>> index cd78ad1020fe..42d4ef93ec2d 100644
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
>> index 96d43f091255..f85a9211f30c 100644
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
>> index 3debc876d5a0..132bff52d70a 100644
>> --- a/arch/powerpc/kvm/book3s_xive_native.c
>> +++ b/arch/powerpc/kvm/book3s_xive_native.c
>> @@ -845,6 +845,88 @@ static int kvmppc_xive_native_create(struct kvm_device *dev, u32 type)
>>  	return ret;
>>  }
>>  
>> +/*
>> + * Interrupt Pending Buffer (IPB) offset
>> + */
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
> 
> I'm pretty dubious about this mixing of vital state information with
> what's basically debug information. 

I think QEMU deserves to know about the OS CAM line value. I was even 
thinking about adding the POOL CAM line value for future use (nested) 

> Doubly so since it requires changing the ABI to increase 
> the one_reg union's size.

OK. That's one argument.
 
> Might be better to have this control only return the 0th and 2nd u64s
> from the TIMA, with the CAM debug information returned via some other
> mechanism.

Like an extra reg : KVM_REG_PPC_VP_CAM ? 

>> +
>> +	/* Get the VP state from OPAL */
>> +	rc = xive_native_get_vp_state(xc->vp_id, &opal_state);
>> +	if (rc)
>> +		return rc;
>> +
>> +	/*
>> +	 * Capture the backup of IPB register in the NVT structure and
>> +	 * merge it in our KVM VP state.
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
> 
> Hrm.. except you don't seem to be using the last half of the timaval
> field anyway.

Yes. The two u64 are extras. We can do without. 

Would that be ok if I stored the w01 regs in the first u64, the CAM line(s) 
in the second and remove the extra two u64 ?  
 
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
> 
> What prevents userspace from tripping this WARN_ON()?

if the vCPU is executing a vCPU ioctl, it means that it exited the guest 
and that its interrupt context has been pulled out of XIVE.
 
>> +		return -EIO;
> 
> EBUSY might be more appropriate here.

OK.

Thanks,

C. 

> 
>> +
>> +	/*
>> +	 * Restore the thread context registers. IPB and CPPR should
>> +	 * be the only ones that matter.
>> +	 */
>> +	vcpu->arch.xive_saved_state.w01 = val->xive_timaval[0];
>> +
>> +	/*
>> +	 * There is no need to restore the XIVE internal state (IPB
>> +	 * stored in the NVT) as the IPB register was merged in KVM VP
>> +	 * state when captured.
>> +	 */
>> +	return 0;
>> +}
>> +
>>  static int xive_native_debug_show(struct seq_file *m, void *private)
>>  {
>>  	struct kvmppc_xive *xive = m->private;
>> diff --git a/Documentation/virtual/kvm/devices/xive.txt b/Documentation/virtual/kvm/devices/xive.txt
>> index a26be635cff9..1b8957c50c53 100644
>> --- a/Documentation/virtual/kvm/devices/xive.txt
>> +++ b/Documentation/virtual/kvm/devices/xive.txt
>> @@ -102,6 +102,25 @@ the legacy interrupt mode, referred as XICS (POWER7/8).
>>      -EINVAL: Not initialized source number, invalid priority or
>>               invalid CPU number.
>>  
>> +* VCPU state
>> +
>> +  The XIVE IC maintains VP interrupt state in an internal structure
>> +  called the NVT. When a VP is not dispatched on a HW processor
>> +  thread, this structure can be updated by HW if the VP is the target
>> +  of an event notification.
>> +
>> +  It is important for migration to capture the cached IPB from the NVT
>> +  as it synthesizes the priorities of the pending interrupts. We
>> +  capture a bit more to report debug information.
>> +
>> +  KVM_REG_PPC_VP_STATE (4 * 64bits)
>> +  bits:     |  63  ....  32  |  31  ....  0  |
>> +  values:   |   TIMA word0   |   TIMA word1  |
>> +  bits:     | 127       ..........       64  |
>> +  values:   |         VP CAM Line            |
>> +  bits:     | 255       ..........      128  |
>> +  values:   |            unused              |
>> +
>>  * Migration:
>>  
>>    Saving the state of a VM using the XIVE native exploitation mode
> 

