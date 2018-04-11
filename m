Return-Path: <benh@au1.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com
 [148.163.156.1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 40LRNp48rJzF1Ps
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 11 Apr 2018 11:32:25 +1000 (AEST)
Received: from pps.filterd (m0098394.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id
 w3B1TQrM095826
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 10 Apr 2018 21:32:22 -0400
Received: from e06smtp12.uk.ibm.com (e06smtp12.uk.ibm.com [195.75.94.108])
 by mx0a-001b2d01.pphosted.com with ESMTP id 2h95v0645g-1
 (version=TLSv1.2 cipher=AES256-SHA256 bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 10 Apr 2018 21:32:21 -0400
Received: from localhost
 by e06smtp12.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <benh@au1.ibm.com>;
 Wed, 11 Apr 2018 02:32:19 +0100
Subject: Re: [RFC PATCH 4/5] KVM: PPC: Book3S HV: handle need_tlb_flush in C
 before low-level guest entry
From: Benjamin Herrenschmidt <benh@au1.ibm.com>
Reply-To: benh@au1.ibm.com
To: Nicholas Piggin <npiggin@gmail.com>, kvm-ppc@vger.kernel.org
Cc: linuxppc-dev@lists.ozlabs.org
Date: Wed, 11 Apr 2018 11:32:12 +1000
In-Reply-To: <20180410124842.30184-5-npiggin@gmail.com>
References: <20180410124842.30184-1-npiggin@gmail.com>
 <20180410124842.30184-5-npiggin@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Message-Id: <1523410332.11062.116.camel@au1.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Tue, 2018-04-10 at 22:48 +1000, Nicholas Piggin wrote:
>  
> +       /*
> +        * Do we need to flush the TLB for the LPAR? (see TLB comment above)
> +         * On POWER9, individual threads can come in here, but the
> +         * TLB is shared between the 4 threads in a core, hence
> +         * invalidating on one thread invalidates for all.
> +         * Thus we make all 4 threads use the same bit here.
> +         */

This might be true of P9 implementation but isn't architecturally
correct. From an ISA perspective, the threads could have dedicatd
tagged TLB entries. Do we need to be careful here vs. backward
compatiblity ?

Also this won't flush ERAT entries for another thread afaik.

> +       tmp = pcpu;
> +       if (cpu_has_feature(CPU_FTR_ARCH_300))
> +               tmp &= ~0x3UL;
> +       if (cpumask_test_cpu(tmp, &vc->kvm->arch.need_tlb_flush)) {
> +               if (kvm_is_radix(vc->kvm))
> +                       radix__local_flush_tlb_lpid(vc->kvm->arch.lpid);
> +               else
> +                       hash__local_flush_tlb_lpid(vc->kvm->arch.lpid);
> +               /* Clear the bit after the TLB flush */
> +               cpumask_clear_cpu(tmp, &vc->kvm->arch.need_tlb_flush);
> +       }
> +
