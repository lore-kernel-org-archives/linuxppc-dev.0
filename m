Return-Path: <aneesh.kumar@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com
 [148.163.156.1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3yQbSd0HG5zDqmt
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 31 Oct 2017 00:49:36 +1100 (AEDT)
Received: from pps.filterd (m0098393.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.21/8.16.0.21) with SMTP id
 v9UDlvYn076690
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 30 Oct 2017 09:49:34 -0400
Received: from e06smtp14.uk.ibm.com (e06smtp14.uk.ibm.com [195.75.94.110])
 by mx0a-001b2d01.pphosted.com with ESMTP id 2dx2xm8x36-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 30 Oct 2017 09:49:34 -0400
Received: from localhost
 by e06smtp14.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <aneesh.kumar@linux.vnet.ibm.com>;
 Mon, 30 Oct 2017 13:49:31 -0000
From: "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>
To: Paul Mackerras <paulus@ozlabs.org>
Cc: benh@kernel.crashing.org, mpe@ellerman.id.au, linuxppc-dev@lists.ozlabs.org
Subject: Re: [PATCH 00/16] Remove hash page table slot tracking from linux PTE
In-Reply-To: <87r2tk22wo.fsf@linux.vnet.ibm.com>
References: <20171027040833.3644-1-aneesh.kumar@linux.vnet.ibm.com>
 <20171027043430.GA27483@fergus.ozlabs.ibm.com>
 <adf2d270-29df-701f-206e-0d8a35084e47@linux.vnet.ibm.com>
 <20171027054136.GC27483@fergus.ozlabs.ibm.com>
 <87tvyg26us.fsf@linux.vnet.ibm.com> <87r2tk22wo.fsf@linux.vnet.ibm.com>
Date: Mon, 30 Oct 2017 19:19:25 +0530
MIME-Version: 1.0
Content-Type: text/plain
Message-Id: <87o9oo21ay.fsf@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

"Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com> writes:

> "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com> writes:
>
>
>> I looked at the perf data and with the test, we are doing larger number
>> of hash faults and then around 10k flush_hash_range. Can the small
>> improvement in number be due to the fact that we are not storing slot
>> number when doing an insert now?. Also in the flush path we are now not
>> using real_pte_t.
>>
>
> With THP disabled I am finding below.
>
> Without patch
>
>     35.62%  a.out    [kernel.vmlinux]            [k] clear_user_page
>      8.54%  a.out    [kernel.vmlinux]            [k] __lock_acquire
>      3.86%  a.out    [kernel.vmlinux]            [k] native_flush_hash_range
>      3.38%  a.out    [kernel.vmlinux]            [k] save_context_stack
>      2.98%  a.out    a.out                       [.] main
>      2.59%  a.out    [kernel.vmlinux]            [k] lock_acquire
>      2.29%  a.out    [kernel.vmlinux]            [k] mark_lock
>      2.23%  a.out    [kernel.vmlinux]            [k] native_hpte_insert
>      1.87%  a.out    [kernel.vmlinux]            [k] get_mem_cgroup_from_mm
>      1.71%  a.out    [kernel.vmlinux]            [k] rcu_lockdep_current_cpu_online
>      1.68%  a.out    [kernel.vmlinux]            [k] lock_release
>      1.47%  a.out    [kernel.vmlinux]            [k] __handle_mm_fault
>      1.41%  a.out    [kernel.vmlinux]            [k] validate_sp
>
>
> With patch
>     35.40%  a.out    [kernel.vmlinux]            [k] clear_user_page
>      8.82%  a.out    [kernel.vmlinux]            [k] __lock_acquire
>      3.66%  a.out    a.out                       [.] main
>      3.49%  a.out    [kernel.vmlinux]            [k] save_context_stack
>      2.77%  a.out    [kernel.vmlinux]            [k] lock_acquire
>      2.45%  a.out    [kernel.vmlinux]            [k] mark_lock
>      1.80%  a.out    [kernel.vmlinux]            [k] get_mem_cgroup_from_mm
>      1.80%  a.out    [kernel.vmlinux]            [k] native_hpte_insert
>      1.79%  a.out    [kernel.vmlinux]            [k] rcu_lockdep_current_cpu_online
>      1.78%  a.out    [kernel.vmlinux]            [k] lock_release
>      1.73%  a.out    [kernel.vmlinux]            [k] native_flush_hash_range
>      1.53%  a.out    [kernel.vmlinux]            [k] __handle_mm_fault
>
> That is we are now spending less time in native_flush_hash_range.
>
> -aneesh

One possible explanation is, with slot tracking we do

	slot += hidx & _PTEIDX_GROUP_IX;
	hptep = htab_address + slot;
	want_v = hpte_encode_avpn(vpn, psize, ssize);
	native_lock_hpte(hptep);
	hpte_v = be64_to_cpu(hptep->v);
	if (cpu_has_feature(CPU_FTR_ARCH_300))
		hpte_v = hpte_new_to_old_v(hpte_v,
				be64_to_cpu(hptep->r));
	if (!HPTE_V_COMPARE(hpte_v, want_v) ||
	    !(hpte_v & HPTE_V_VALID))
		native_unlock_hpte(hptep);


and without slot tracking we do

	for (i = 0; i < HPTES_PER_GROUP; i++, hptep++) {
		/* check locklessly first */
		hpte_v = be64_to_cpu(hptep->v);
		if (cpu_has_feature(CPU_FTR_ARCH_300))
			hpte_v = hpte_new_to_old_v(hpte_v, be64_to_cpu(hptep->r));
		if (!HPTE_V_COMPARE(hpte_v, want_v) || !(hpte_v & HPTE_V_VALID))
			continue;

		native_lock_hpte(hptep);

That is without the patch series, we take the hpte lock always even if the
hpte didn't match. Hence in perf annotate we find the lock to be
highly contended without patch series.

I will change that to compare pte without taking lock and see if that
has any impact.

-aneesh
