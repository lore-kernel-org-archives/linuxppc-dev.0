Return-Path: <khandual@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com
 [148.163.158.5])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3wSMdP6Bn2zDqLp
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 17 May 2017 15:02:49 +1000 (AEST)
Received: from pps.filterd (m0098413.ppops.net [127.0.0.1])
 by mx0b-001b2d01.pphosted.com (8.16.0.20/8.16.0.20) with SMTP id
 v4H4rhgF001143
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 17 May 2017 01:02:42 -0400
Received: from e23smtp09.au.ibm.com (e23smtp09.au.ibm.com [202.81.31.142])
 by mx0b-001b2d01.pphosted.com with ESMTP id 2agck600ms-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 17 May 2017 01:02:42 -0400
Received: from localhost
 by e23smtp09.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <khandual@linux.vnet.ibm.com>;
 Wed, 17 May 2017 15:02:39 +1000
Received: from d23av04.au.ibm.com (d23av04.au.ibm.com [9.190.235.139])
 by d23relay07.au.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 v4H52TMq63242342
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 17 May 2017 15:02:37 +1000
Received: from d23av04.au.ibm.com (localhost [127.0.0.1])
 by d23av04.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 v4H523rg016864
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 17 May 2017 15:02:03 +1000
Subject: Re: [PATCH] powerpc/mm/hugetlb: Add support for reserving gigantic
 huge pages via kernel command line
To: "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>,
 benh@kernel.crashing.org, paulus@samba.org, mpe@ellerman.id.au
References: <1494926691-24664-1-git-send-email-aneesh.kumar@linux.vnet.ibm.com>
Cc: linuxppc-dev@lists.ozlabs.org
From: Anshuman Khandual <khandual@linux.vnet.ibm.com>
Date: Wed, 17 May 2017 10:31:42 +0530
MIME-Version: 1.0
In-Reply-To: <1494926691-24664-1-git-send-email-aneesh.kumar@linux.vnet.ibm.com>
Content-Type: text/plain; charset=windows-1252
Message-Id: <768f38fe-d2ad-df4a-19e3-910b4a584614@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 05/16/2017 02:54 PM, Aneesh Kumar K.V wrote:
> +void __init reserve_hugetlb_gpages(void)
> +{
> +	char buf[10];
> +	phys_addr_t base;
> +	unsigned long gpage_size = 1UL << 34;
> +	static __initdata char cmdline[COMMAND_LINE_SIZE];
> +
> +	if (radix_enabled())
> +		gpage_size = 1UL << 30;
> +
> +	strlcpy(cmdline, boot_command_line, COMMAND_LINE_SIZE);
> +	parse_args("hugetlb gpages", cmdline, NULL, 0, 0, 0,
> +		   NULL, &do_gpage_early_setup);
> +
> +	if (!gpage_npages)
> +		return;
> +
> +	string_get_size(gpage_size, 1, STRING_UNITS_2, buf, sizeof(buf));
> +	pr_info("Trying to reserve %ld %s pages\n", gpage_npages, buf);
> +
> +	/* Allocate one page at a time */
> +	while(gpage_npages) {
> +		base = memblock_alloc_base(gpage_size, gpage_size,
> +					   MEMBLOCK_ALLOC_ANYWHERE);
> +		add_gpage(base, gpage_size, 1);

For 16GB pages (1UL << 34) on POWER8, we already do these functions
inside htab_dt_scan_hugepage_blocks(). IIUC this happens just by
scanning DT without even specifying any gpages in kernel command
line.

memblock_reserve()
add_gpage()

Then attempting to allocate from memblock and adding it again into
gigantic pages list wont collide ? More over its trying to allocate
across the RAM not specifically on the gpages mentioned in device
tree by the platform. Are we trying to support 16GB pages just from
any memory without platform notification through DT ?
