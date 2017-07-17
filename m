Return-Path: <aneesh.kumar@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com
 [148.163.156.1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3x9rvz4ndNzDrCn
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 17 Jul 2017 15:10:23 +1000 (AEST)
Received: from pps.filterd (m0098410.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.21/8.16.0.21) with SMTP id
 v6H58mHU044520
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 17 Jul 2017 01:10:21 -0400
Received: from e23smtp03.au.ibm.com (e23smtp03.au.ibm.com [202.81.31.145])
 by mx0a-001b2d01.pphosted.com with ESMTP id 2bqfkg9j2n-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 17 Jul 2017 01:10:20 -0400
Received: from localhost
 by e23smtp03.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <aneesh.kumar@linux.vnet.ibm.com>;
 Mon, 17 Jul 2017 15:10:18 +1000
Received: from d23av03.au.ibm.com (d23av03.au.ibm.com [9.190.234.97])
 by d23relay10.au.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 v6H5AFN823855156
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 17 Jul 2017 15:10:15 +1000
Received: from d23av03.au.ibm.com (localhost [127.0.0.1])
 by d23av03.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 v6H5A67L031763
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 17 Jul 2017 15:10:06 +1000
From: "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 linuxppc-dev@lists.ozlabs.org
Cc: npiggin@gmail.com, paulus@samba.org
Subject: Re: [PATCH v2] powerpc/mm/radix: Workaround prefetch issue with KVM
In-Reply-To: <1500014988.2865.78.camel@kernel.crashing.org>
References: <20170714015258.7933-1-benh@kernel.crashing.org>
 <20170714015258.7933-4-benh@kernel.crashing.org>
 <87vamvpnve.fsf@skywalker.in.ibm.com>
 <1500014988.2865.78.camel@kernel.crashing.org>
Date: Mon, 17 Jul 2017 10:40:10 +0530
MIME-Version: 1.0
Content-Type: text/plain
Message-Id: <87poczps25.fsf@skywalker.in.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Benjamin Herrenschmidt <benh@kernel.crashing.org> writes:

> There's a somewhat architectural issue with Radix MMU and KVM.
>
> When coming out of a guest with AIL (ie, MMU enabled), we start
> executing hypervisor code with the PID register still containing
> whatever the guest has been using.
>
> The problem is that the CPU can (and will) then start prefetching
> or speculatively load from whatever host context has that same
> PID (if any), thus bringing translations for that context into
> the TLB, which Linux doesn't know about.
>
> This can cause stale translations and subsequent crashes.
>
> Fixing this in a way that is neither racy nor a huge performance
> impact is difficult. We could just make the host invalidations
> always use broadcast forms but that would hurt single threaded
> programs for example.
>
> We chose to fix it instead by partitioning the PID space between
> guest and host. This is possible because today Linux only use 19
> out of the 20 bits of PID space, so existing guests will work
> if we make the host use the top half of the 20 bits space.
>
> We additionally add a property to indicate to Linux the size of
> the PID register which will be useful if we eventually have
> processors with a larger PID space available.
>
> There is still an issue with malicious guests purposefully setting
> the PID register to a value in the host range. Hopefully future HW
> can prevent that, but in the meantime, we handle it with a pair of
> kludges:
>
>  - On the way out of a guest, before we clear the current VCPU
> in the PACA, we check the PID and if it's outside of the permitted
> range we flush the TLB for that PID.
>
>  - When context switching, if the mm is "new" on that CPU (the
> corresponding bit was set for the first time in the mm cpumask), we
> check if any sibling thread is in KVM (has a non-NULL VCPU pointer
> in the PACA). If that is the case, we also flush the PID for that
> CPU (core).
>
> This second part is needed to handle the case where a process is
> migrated (or starts a new pthread) on a sibling thread of the CPU
> coming out of KVM, as there's a window where stale translations
> can exist before we detect it and flush them out.
>
> A future optimization could be added by keeping track of whether
> the PID has ever been used and avoid doing that for completely
> fresh PIDs. We could similarily mark PIDs that have been the subject of
> a global invalidation as "fresh". But for now this will do.
>
> Signed-off-by: Benjamin Herrenschmidt <benh@kernel.crashing.org>
> ---
>
> v2. Do the check on KVM exit *after* we've restored the host PID
>
....

 diff --git a/arch/powerpc/kvm/book3s_hv_rmhandlers.S b/arch/powerpc/kvm/book3s_hv_rmhandlers.S
> index 6ea4b53..e744d11 100644
> --- a/arch/powerpc/kvm/book3s_hv_rmhandlers.S
> +++ b/arch/powerpc/kvm/book3s_hv_rmhandlers.S
> @@ -1522,6 +1522,7 @@ END_FTR_SECTION_IFCLR(CPU_FTR_ARCH_207S)
>  	std	r6, VCPU_BESCR(r9)
>  	stw	r7, VCPU_GUEST_PID(r9)
>  	std	r8, VCPU_WORT(r9)
> +
>  BEGIN_FTR_SECTION
>  	mfspr	r5, SPRN_TCSCR
>  	mfspr	r6, SPRN_ACOP
> @@ -1728,6 +1729,19 @@ BEGIN_FTR_SECTION
>  	mtspr	SPRN_PSSCR, r6
>  	mtspr	SPRN_PID, r7
>  	mtspr	SPRN_IAMR, r8
> +
> +	/* Handle the case where the guest used an illegal PID */
> +	LOAD_REG_ADDR(r4, mmu_base_pid)
> +	lwz	r3, VCPU_GUEST_PID(r9)
> +	lwz	r5, 0(r4)
> +	cmpw	cr0,r3,r5
> +	blt	1f
> +
> +	/* Illegal PID, flush the TLB */
> +	isync
> +	bl	radix_flush_pid
> +1:

this need to be done only for radix right ? Do we need radix feature
check here ?


> +
>  END_FTR_SECTION_IFSET(CPU_FTR_ARCH_300)
>  BEGIN_FTR_SECTION
>  	PPC_INVALIDATE_ERAT


-aneesh
