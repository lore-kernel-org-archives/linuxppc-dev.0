Return-Path: <fbarrat@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com
 [148.163.156.1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3zFgnN6GGMzDqHN
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  9 Jan 2018 03:33:28 +1100 (AEDT)
Received: from pps.filterd (m0098394.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.22/8.16.0.21) with SMTP id
 w08GT7TE080980
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 8 Jan 2018 11:33:27 -0500
Received: from e06smtp12.uk.ibm.com (e06smtp12.uk.ibm.com [195.75.94.108])
 by mx0a-001b2d01.pphosted.com with ESMTP id 2fc6w3r43w-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 08 Jan 2018 11:33:26 -0500
Received: from localhost
 by e06smtp12.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <fbarrat@linux.vnet.ibm.com>;
 Mon, 8 Jan 2018 16:33:24 -0000
Subject: Re: [PATCH v5 1/2] powerpc/powernv: Enable tunneled operations
To: Philippe Bergheaud <felix@linux.vnet.ibm.com>,
 linuxppc-dev@lists.ozlabs.org
Cc: clombard@linux.vnet.ibm.com, benh@au1.ibm.com
References: <20171222123624.1880-1-felix@linux.vnet.ibm.com>
From: Frederic Barrat <fbarrat@linux.vnet.ibm.com>
Date: Mon, 8 Jan 2018 17:33:20 +0100
MIME-Version: 1.0
In-Reply-To: <20171222123624.1880-1-felix@linux.vnet.ibm.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Message-Id: <f155b1a5-94d9-8b61-39dc-69a702f9623f@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>



Le 22/12/2017 à 13:36, Philippe Bergheaud a écrit :
> +#ifdef CONFIG_PPC64	/* for thread.tidr */
> +int pnv_pci_get_as_notify_info(struct task_struct *task, u32 *lpid, u32 *pid,
> +			       u32 *tid)
> +{
> +	struct mm_struct *mm = NULL;
> +
> +	if (task == NULL)
> +		return -EINVAL;
> +
> +	mm = get_task_mm(task);
> +	if (mm == NULL)
> +		return -EINVAL;
> +	/*
> +	 * Caller is keeping a reference on mm_users for as long
> +	 * as XSL uses the memory context
> +	 */


That comment needs to be tweaked for pci mode. There's no XSL in play.

  Fred

> +	*pid = mm->context.id;
> +	mmput(mm);
