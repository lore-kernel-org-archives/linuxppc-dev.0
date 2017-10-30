Return-Path: <aneeshkumar.opensource@gmail.com>
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com
 [148.163.158.5])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3yQfRf0zNrzDqmt
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 31 Oct 2017 03:03:57 +1100 (AEDT)
Received: from pps.filterd (m0098414.ppops.net [127.0.0.1])
 by mx0b-001b2d01.pphosted.com (8.16.0.21/8.16.0.21) with SMTP id
 v9UFrjne022380
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 30 Oct 2017 12:03:54 -0400
Received: from e38.co.us.ibm.com (e38.co.us.ibm.com [32.97.110.159])
 by mx0b-001b2d01.pphosted.com with ESMTP id 2dx5sdxgys-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 30 Oct 2017 12:03:54 -0400
Received: from localhost
 by e38.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <aneeshkumar.opensource@gmail.com>;
 Mon, 30 Oct 2017 10:03:53 -0600
Subject: Re: [rfc] powerpc/npu: Cleanup MMIO ATSD flushing
To: Balbir Singh <bsingharora@gmail.com>, alistair@popple.id.au,
 mpe@ellerman.id.au
Cc: linuxppc-dev@lists.ozlabs.org, arbab@linux.vnet.ibm.com
References: <20171030123820.29392-1-bsingharora@gmail.com>
From: "Aneesh Kumar K.V" <aneeshkumar.opensource@gmail.com>
Date: Mon, 30 Oct 2017 21:33:46 +0530
MIME-Version: 1.0
In-Reply-To: <20171030123820.29392-1-bsingharora@gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Message-Id: <d145cb52-5321-49fa-e33a-16a40bb00640@gmail.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>



On 10/30/2017 06:08 PM, Balbir Singh wrote:
> +
> +static void pnv_npu2_invalidate_helper(struct npu_context *npu_context,
> +		struct mm_struct *mm, unsigned long start,
> +		unsigned long end, bool flush)
> +{
> +	unsigned long address;
> +	bool is_thp;
> +	unsigned int hshift, shift;
> +
> +	address = start;
> +	do {
> +		local_irq_disable();
> +		find_linux_pte(mm->pgd, address, &is_thp, &hshift);
> +		if (!is_thp)
> +			shift = PAGE_SHIFT;
> +		else
> +			shift = hshift;

Is that correct? if is_thp is 0 can we derive shift from hshift? IIUC we 
set hshift only
if it is a hugepage.

> +		mmio_invalidate(npu_context, address > 0, address, flush,
> +				shift);
> +		local_irq_enable();
> +		address += (1ull << shift);
> +	} while (address < end);
>   }
>   
>

-aneesh
