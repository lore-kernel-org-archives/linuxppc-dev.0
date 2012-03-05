Return-Path: <Tiejun.Chen@windriver.com>
Received: from mail1.windriver.com (unknown [147.11.146.13])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client CN "mail1.windriver.com",
 Issuer "Intel External Basic Issuing CA 3A" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 0568BB6EE7
 for <linuxppc-dev@lists.ozlabs.org>; Mon,  5 Mar 2012 23:08:36 +1100 (EST)
Message-ID: <4F548E19.6050507@windriver.com>
Date: Mon, 5 Mar 2012 17:57:45 +0800
From: "tiejun.chen" <tiejun.chen@windriver.com>
MIME-Version: 1.0
To: Bhushan Bharat-R65777 <R65777@freescale.com>
Subject: Re: [PATCH 13/38] KVM: PPC: booke: category E.HV (GS-mode) support
References: <1330474206-14794-1-git-send-email-agraf@suse.de>
 <1330474206-14794-14-git-send-email-agraf@suse.de>
 <6A3DF150A5B70D4F9B66A25E3F7C888D154397@039-SN2MPN1-023.039d.mgd.msft.net>
In-Reply-To: <6A3DF150A5B70D4F9B66A25E3F7C888D154397@039-SN2MPN1-023.039d.mgd.msft.net>
Content-Type: text/plain; charset="UTF-8"
Cc: Wood Scott-B07421 <B07421@freescale.com>,
 "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>,
 Alexander Graf <agraf@suse.de>,
 "kvm-ppc@vger.kernel.org" <kvm-ppc@vger.kernel.org>,
 "kvm@vger.kernel.org" <kvm@vger.kernel.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

>> +	/*
>> +	 * Host interrupt handlers may have clobbered these guest-readable
>> +	 * SPRGs, so we need to reload them here with the guest's values.
>> +	 */
>> +	lwz	r3, VCPU_VRSAVE(r4)
>> +	lwz	r5, VCPU_SHARED_SPRG4(r11)
>> +	mtspr	SPRN_VRSAVE, r3
>> +	lwz	r6, VCPU_SHARED_SPRG5(r11)
>> +	mtspr	SPRN_SPRG4W, r5
>> +	lwz	r7, VCPU_SHARED_SPRG6(r11)
>> +	mtspr	SPRN_SPRG5W, r6
>> +	lwz	r8, VCPU_SHARED_SPRG7(r11)
>> +	mtspr	SPRN_SPRG6W, r7
>> +	mtspr	SPRN_SPRG7W, r8
>> +

That should be here.

>> +	/* Load some guest volatiles. */
>> +	PPC_LL	r3, VCPU_LR(r4)
>> +	PPC_LL	r5, VCPU_XER(r4)
>> +	PPC_LL	r6, VCPU_CTR(r4)
>> +	PPC_LL	r7, VCPU_CR(r4)
>> +	PPC_LL	r8, VCPU_PC(r4)
>> +#ifndef CONFIG_64BIT
>> +	lwz	r9, (VCPU_SHARED_MSR + 4)(r11)
>> +#else
>> +	ld	r9, (VCPU_SHARED_MSR)(r11)
>> +#endif
>> +	PPC_LL	r0, VCPU_GPR(r0)(r4)
>> +	PPC_LL	r1, VCPU_GPR(r1)(r4)
>> +	PPC_LL	r2, VCPU_GPR(r2)(r4)
>> +	PPC_LL	r10, VCPU_GPR(r10)(r4)
>> +	PPC_LL	r11, VCPU_GPR(r11)(r4)
>> +	PPC_LL	r12, VCPU_GPR(r12)(r4)
>> +	PPC_LL	r13, VCPU_GPR(r13)(r4)
>> +	mtlr	r3
>> +	mtxer	r5
>> +	mtctr	r6
>> +	mtcr	r7
>> +	mtsrr0	r8
>> +	mtsrr1	r9
>> +
>> +#ifdef CONFIG_KVM_EXIT_TIMING
>> +	/* save enter time */
>> +1:
>> +	mfspr	r6, SPRN_TBRU
>> +	mfspr	r7, SPRN_TBRL
>> +	mfspr	r8, SPRN_TBRU
>> +	cmpw	r8, r6
> 
> Is not we should save guest CR after this otherwise this can corrupt it?

I think this should be a typo since in our previous kvm implementation, we
always did collect kvm exit timing at the above location :)

Tiejun

> 
> Thanks
> -Bharat
> 
>> +	PPC_STL	r7, VCPU_TIMING_LAST_ENTER_TBL(r4)
>> +	bne	1b	
>> +	PPC_STL	r8, VCPU_TIMING_LAST_ENTER_TBU(r4)
>> +#endif
>> +
>> +	/* Finish loading guest volatiles and jump to guest. */
>> +	PPC_LL	r5, VCPU_GPR(r5)(r4)
>> +	PPC_LL	r6, VCPU_GPR(r6)(r4)
>> +	PPC_LL	r7, VCPU_GPR(r7)(r4)
>> +	PPC_LL	r8, VCPU_GPR(r8)(r4)	
>> +	PPC_LL	r9, VCPU_GPR(r9)(r4)
>> +
>> +	PPC_LL	r3, VCPU_GPR(r3)(r4)
>> +	PPC_LL	r4, VCPU_GPR(r4)(r4)
>> +	rfi
