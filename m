Return-Path: <sukadev@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com
 [148.163.158.5])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3vhnmw6QYyzDqY4
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 14 Mar 2017 06:22:08 +1100 (AEDT)
Received: from pps.filterd (m0098421.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.20/8.16.0.20) with SMTP id
 v2DJIWfA142749
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 13 Mar 2017 15:21:57 -0400
Received: from e18.ny.us.ibm.com (e18.ny.us.ibm.com [129.33.205.208])
 by mx0a-001b2d01.pphosted.com with ESMTP id 295xm2rqg4-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 13 Mar 2017 15:21:57 -0400
Received: from localhost
 by e18.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <sukadev@linux.vnet.ibm.com>;
 Mon, 13 Mar 2017 15:21:57 -0400
Date: Mon, 13 Mar 2017 12:21:51 -0700
From: Sukadev Bhattiprolu <sukadev@linux.vnet.ibm.com>
To: Madhavan Srinivasan <maddy@linux.vnet.ibm.com>
Cc: peterz@infradead.org, mpe@ellerman.id.au, linux-kernel@vger.kernel.org,
 linuxppc-dev@lists.ozlabs.org,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Paul Mackerras <paulus@samba.org>, Thomas Gleixner <tglx@linutronix.de>,
 Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
 Anna-Maria Gleixner <anna-maria@linutronix.de>,
 Daniel Axtens <dja@axtens.net>
Subject: Re: [PATCH v2 2/6] powerpc/perf: Export memory hierarchy info to
 user space
References: <1488796993-25495-1-git-send-email-maddy@linux.vnet.ibm.com>
 <1488796993-25495-3-git-send-email-maddy@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1488796993-25495-3-git-send-email-maddy@linux.vnet.ibm.com>
Message-Id: <20170313192151.GA3420@us.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Madhavan Srinivasan [maddy@linux.vnet.ibm.com] wrote:
> The LDST field and DATA_SRC in SIER identifies the memory hierarchy level
> (eg: L1, L2 etc), from which a data-cache miss for a marked instruction
> was satisfied. Use the 'perf_mem_data_src' object to export this
> hierarchy level to user space.
> 
<snip>

> diff --git a/arch/powerpc/include/asm/perf_event_server.h b/arch/powerpc/include/asm/perf_event_server.h
>  int isa207_get_constraint(u64 event, unsigned long *maskp, unsigned long *valp)
>  {
>  	unsigned int unit, pmc, cache, ebb;
> diff --git a/arch/powerpc/perf/isa207-common.h b/arch/powerpc/perf/isa207-common.h
> index cf9bd8990159..982542cce991 100644
> --- a/arch/powerpc/perf/isa207-common.h
> +++ b/arch/powerpc/perf/isa207-common.h
> @@ -259,6 +259,19 @@
>  #define MAX_ALT				2
>  #define MAX_PMU_COUNTERS		6
> 
> +#define ISA207_SIER_TYPE_SHIFT		15
> +#define ISA207_SIER_TYPE_MASK		(0x7ull << ISA207_SIER_TYPE_SHIFT)
> +
> +#define ISA207_SIER_LDST_SHIFT		1
> +#define ISA207_SIER_LDST_MASK		(0x7ull << ISA207_SIER_LDST_SHIFT)
> +
> +#define ISA207_SIER_DATA_SRC_SHIFT	53
> +#define ISA207_SIER_DATA_SRC_MASK	(0x7ull << ISA207_SIER_DATA_SRC_SHIFT)
> +
> +#define P(a, b)				PERF_MEM_S(a, b)

Madhavan, Peter,

Can we see if we can get the kernel to set 'perf_mem_data_src.val' in
endian-nuetral format?

With something like  (untested) in include/uapi/linux/perf_event.h

#define PERF_MEM_OP_NBITS	PERF_MEM_LVL_SHIFT
#define PERF_MEM_LVL_NBITS	PERF_MEM_SNOOP_SHIFT
#define PERF_MEM_SNOOP_NBITS	PERF_MEM_LOCK_SHIFT
#define PERF_MEM_TLB_NBITS	PERF_MEM_TLB_SHIFT

and here in arch/powerpc/perf/isa207-common.h

#define PERF_MEM_S_BE_SHIFT(a)	\
	(63 - PERF_MEM_##a##_NBITS - PERF_MEM_##a##_SHIFT)

#define PERF_MEM_S_BE(a, s)	\
		(((__u64)PERF_MEM_##a##_##s) << PERF_MEM_S_BE_SHIFT(a))

#define P(a, b)		PERF_MEM_S_BE(a, b)

Basically, have PERF_MEM_OP_NA be the right most bit and PERF_MEM_TLB_OS
the left most bit in perf_mem_data_src.val regardless of the endianness?

Sukadev
