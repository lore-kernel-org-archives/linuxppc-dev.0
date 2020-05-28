Return-Path: <SRS0=Ue3/=7K=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 39CE1C433E0
	for <linuxppc-dev@archiver.kernel.org>; Thu, 28 May 2020 07:27:30 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8CE1E207BC
	for <linuxppc-dev@archiver.kernel.org>; Thu, 28 May 2020 07:27:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=ozlabs.org header.i=@ozlabs.org header.b="XI0dNVZx"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8CE1E207BC
Authentication-Results: mail.kernel.org; dmarc=pass (p=none dis=none) header.from=ozlabs.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from bilbo.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 49XfRL3CxHzDqYW
	for <linuxppc-dev@archiver.kernel.org>; Thu, 28 May 2020 17:27:26 +1000 (AEST)
Received: from ozlabs.org (bilbo.ozlabs.org [203.11.71.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 49XfPP6CVYzDqWp
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 28 May 2020 17:25:45 +1000 (AEST)
Authentication-Results: lists.ozlabs.org;
 dmarc=pass (p=none dis=none) header.from=ozlabs.org
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 secure) header.d=ozlabs.org header.i=@ozlabs.org header.a=rsa-sha256
 header.s=201707 header.b=XI0dNVZx; dkim-atps=neutral
Received: by ozlabs.org (Postfix, from userid 1003)
 id 49XfPP4BZGz9sSc; Thu, 28 May 2020 17:25:45 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ozlabs.org; s=201707;
 t=1590650745; bh=kSdQDz7vO+Nrjct0Vbe+Rg4cPq/AnwoAehhR5tfNwjo=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=XI0dNVZxg+BI1YM8yKcfmiJBvfH2tx+hp4ctTm2jXJuvXm5c6QwEJEnMF/duVt8uL
 E10B/UnM8wO2TnpkEfbPOD5tl2/RqcOZjCYjokVelpBUItKtZF6oo/Y6tyOfukmKa7
 IF6gjsv6n4ooRKBSQ4HHkVFlCxRg72YDBy0Git/O30rYrP/VXE0wGC7EF/FfXG1i0u
 3ECuMEUGQ+462XNqaTrbt5FZf2j3jeR//KT8JqtkRGXjx7je9yWzdHDaDWfxqpr861
 9ewtBMj/nWYo4VCakeRm0Vl7FcV8N+jVetc2XNEJwniyrAjNzpceaXYf+eOiVjGVm/
 ACQJUEWwe2xig==
Date: Thu, 28 May 2020 17:25:42 +1000
From: Paul Mackerras <paulus@ozlabs.org>
To: "Aneesh Kumar K.V" <aneesh.kumar@linux.ibm.com>
Subject: Re: [PATCH v4 09/22] powerpc/kvm/book3s: Add helper to walk
 partition scoped linux page table.
Message-ID: <20200528072542.GF307798@thinks.paulus.ozlabs.org>
References: <20200505071729.54912-1-aneesh.kumar@linux.ibm.com>
 <20200505071729.54912-10-aneesh.kumar@linux.ibm.com>
 <20200528014338.GC307798@thinks.paulus.ozlabs.org>
 <e732e386-4a8c-2a7d-220c-e22e85b7a6c3@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <e732e386-4a8c-2a7d-220c-e22e85b7a6c3@linux.ibm.com>
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
Cc: linuxppc-dev@lists.ozlabs.org, npiggin@gmail.com
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

On Thu, May 28, 2020 at 11:31:04AM +0530, Aneesh Kumar K.V wrote:
> On 5/28/20 7:13 AM, Paul Mackerras wrote:
> > On Tue, May 05, 2020 at 12:47:16PM +0530, Aneesh Kumar K.V wrote:
> > > The locking rules for walking partition scoped table is different from process
> > > scoped table. Hence add a helper for secondary linux page table walk and also
> > > add check whether we are holding the right locks.
> > 
> > This patch is causing new warnings to appear when testing migration,
> > like this:
> > 
> > [  142.090159] ------------[ cut here ]------------
> > [  142.090160] find_kvm_secondary_pte called with kvm mmu_lock not held
> > [  142.090176] WARNING: CPU: 23 PID: 5341 at arch/powerpc/include/asm/kvm_book3s_64.h:644 kvmppc_hv_get_dirty_log_radix+0x2e4/0x340 [kvm_hv]
> > [  142.090177] Modules linked in: xt_conntrack nf_conntrack nf_defrag_ipv6 nf_defrag_ipv4 libcrc32c bridge stp llc ebtable_filter ebtables ip6table_filter ip6_tables bpfilter overlay binfmt_misc input_leds raid_class scsi_transport_sas sch_fq_codel sunrpc kvm_hv kvm
> > [  142.090188] CPU: 23 PID: 5341 Comm: qemu-system-ppc Tainted: G        W         5.7.0-rc5-kvm-00211-g9ccf10d6d088 #432
> > [  142.090189] NIP:  c008000000fe848c LR: c008000000fe8488 CTR: 0000000000000000
> > [  142.090190] REGS: c000001e19f077e0 TRAP: 0700   Tainted: G        W          (5.7.0-rc5-kvm-00211-g9ccf10d6d088)
> > [  142.090191] MSR:  9000000000029033 <SF,HV,EE,ME,IR,DR,RI,LE>  CR: 42222422  XER: 20040000
> > [  142.090196] CFAR: c00000000012f5ac IRQMASK: 0
> >                 GPR00: c008000000fe8488 c000001e19f07a70 c008000000ffe200 0000000000000039
> >                 GPR04: 0000000000000001 c000001ffc8b4900 0000000000018840 0000000000000007
> >                 GPR08: 0000000000000003 0000000000000001 0000000000000007 0000000000000001
> >                 GPR12: 0000000000002000 c000001fff6d9400 000000011f884678 00007fff70b70000
> >                 GPR16: 00007fff7137cb90 00007fff7dcb4410 0000000000000001 0000000000000000
> >                 GPR20: 000000000ffe0000 0000000000000000 0000000000000001 0000000000000000
> >                 GPR24: 8000000000000000 0000000000000001 c000001e1f67e600 c000001e1fd82410
> >                 GPR28: 0000000000001000 c000001e2e410000 0000000000000fff 0000000000000ffe
> > [  142.090217] NIP [c008000000fe848c] kvmppc_hv_get_dirty_log_radix+0x2e4/0x340 [kvm_hv]
> > [  142.090223] LR [c008000000fe8488] kvmppc_hv_get_dirty_log_radix+0x2e0/0x340 [kvm_hv]
> > [  142.090224] Call Trace:
> > [  142.090230] [c000001e19f07a70] [c008000000fe8488] kvmppc_hv_get_dirty_log_radix+0x2e0/0x340 [kvm_hv] (unreliable)
> > [  142.090236] [c000001e19f07b50] [c008000000fd42e4] kvm_vm_ioctl_get_dirty_log_hv+0x33c/0x3c0 [kvm_hv]
> > [  142.090292] [c000001e19f07be0] [c008000000eea878] kvm_vm_ioctl_get_dirty_log+0x30/0x50 [kvm]
> > [  142.090300] [c000001e19f07c00] [c008000000edc818] kvm_vm_ioctl+0x2b0/0xc00 [kvm]
> > [  142.090302] [c000001e19f07d50] [c00000000046e148] ksys_ioctl+0xf8/0x150
> > [  142.090305] [c000001e19f07da0] [c00000000046e1c8] sys_ioctl+0x28/0x80
> > [  142.090307] [c000001e19f07dc0] [c00000000003652c] system_call_exception+0x16c/0x240
> > [  142.090309] [c000001e19f07e20] [c00000000000d070] system_call_common+0xf0/0x278
> > [  142.090310] Instruction dump:
> > [  142.090312] 7d3a512a 4200ffd0 7ffefb78 4bfffdc4 60000000 3c820000 e8848468 3c620000
> > [  142.090317] e86384a8 38840010 4800673d e8410018 <0fe00000> 4bfffdd4 60000000 60000000
> > [  142.090322] ---[ end trace 619d45057b6919e0 ]---
> > 
> > Indeed, kvm_radix_test_clear_dirty() tests the PTE dirty bit
> > locklessly, and only takes the kvm->mmu_lock once it finds a dirty
> > PTE.  I think that is important for performance, since on any given
> > scan of the guest real address space we may only find a small
> > proportion of the guest pages to be dirty.
> > 
> > Are you now relying on the kvm->mmu_lock to protect the existence of
> > the PTEs, or just their content?
> > 
> 
> The patch series should not change any rules w.r.t kvm partition scoped page
> table walk. We only added helpers to make it explicit that this is different
> from regular linux page table walk. And kvm->mmu_lock is what was used to
> protect the partition scoped table walk earlier.
> 
> In this specific case, what we need probably is an open coded kvm partition
> scoped walk with a comment around explaining why is it ok to walk that
> partition scoped table without taking kvm->mmu_lock.
> 
> What happens when a parallel invalidate happens to Qemu address space? Since
> we are not holding kvm->mmu_lock mmu notifier will complete and we will go
> ahead with unmapping partition scoped table.
> 
> Do we need a change like below?
> 
> @@ -1040,7 +1040,7 @@ static int kvm_radix_test_clear_dirty(struct kvm *kvm,
>  {
>  	unsigned long gfn = memslot->base_gfn + pagenum;
>  	unsigned long gpa = gfn << PAGE_SHIFT;
> -	pte_t *ptep;
> +	pte_t *ptep, pte;
>  	unsigned int shift;
>  	int ret = 0;
>  	unsigned long old, *rmapp;
> @@ -1049,11 +1049,23 @@ static int kvm_radix_test_clear_dirty(struct kvm
> *kvm,
>  		return ret;
> 
>  	ptep = find_kvm_secondary_pte(kvm, gpa, &shift);

We need something different from find_kvm_secondary_pte here, since
that is what is generating the warning.

> -	if (ptep && pte_present(*ptep) && pte_dirty(*ptep)) {
> +	if (!ptep)
> +		return 0;
> +
> +	pte = READ_ONCE(*ptep);
> +	if (pte_present(pte) && pte_dirty(pte)) {
>  		ret = 1;
>  		if (shift)
>  			ret = 1 << (shift - PAGE_SHIFT);
>  		spin_lock(&kvm->mmu_lock);
> +		/*
> +		 * Recheck the pte again
> +		 */
> +		if (pte_val(pte) != pte_val(*ptep)) {

I don't think this is quite right.  I think it should be something
like:

		pte = *ptep;
		if (!(pte_present(pte) && pte_dirty(pte))) {


> +			spin_unlock(&kvm->mmu_lock);
> +			return 0;
> +		}
> +
>  		old = kvmppc_radix_update_pte(kvm, ptep, _PAGE_DIRTY, 0,
>  					      gpa, shift);
>  		kvmppc_radix_tlbie_page(kvm, gpa, shift, kvm->arch.lpid);

Paul.
