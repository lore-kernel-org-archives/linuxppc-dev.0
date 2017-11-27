Return-Path: <andrew.donnellan@au1.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com
 [148.163.156.1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3ylTBz1rkqzDrKp
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 27 Nov 2017 12:06:19 +1100 (AEDT)
Received: from pps.filterd (m0098394.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.21/8.16.0.21) with SMTP id
 vAR1461K126299
 for <linuxppc-dev@lists.ozlabs.org>; Sun, 26 Nov 2017 20:06:16 -0500
Received: from e06smtp13.uk.ibm.com (e06smtp13.uk.ibm.com [195.75.94.109])
 by mx0a-001b2d01.pphosted.com with ESMTP id 2efy6h7jwb-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Sun, 26 Nov 2017 20:06:16 -0500
Received: from localhost
 by e06smtp13.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <andrew.donnellan@au1.ibm.com>;
 Mon, 27 Nov 2017 01:06:14 -0000
Subject: Re: [PATCH v2 2/2] powerpc: Do not assign thread.tidr if already
 assigned
To: Vaibhav Jain <vaibhav@linux.vnet.ibm.com>, linuxppc-dev@lists.ozlabs.org,
 Sukadev Bhattiprolu <sukadev@linux.vnet.ibm.com>,
 Christophe Lombard <christophe_lombard@fr.ibm.com>,
 Philippe Bergheaud <philippe.bergheaud@fr.ibm.com>,
 Michael Ellerman <mpe@ellerman.id.au>
Cc: "Alastair D'Silva" <alastair@linux.ibm.com>,
 Frederic Barrat <fbarrat@linux.vnet.ibm.com>
References: <20171124083338.15283-1-vaibhav@linux.vnet.ibm.com>
 <20171124083338.15283-2-vaibhav@linux.vnet.ibm.com>
From: Andrew Donnellan <andrew.donnellan@au1.ibm.com>
Date: Mon, 27 Nov 2017 12:06:08 +1100
MIME-Version: 1.0
In-Reply-To: <20171124083338.15283-2-vaibhav@linux.vnet.ibm.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Message-Id: <4bafb7e0-8d79-2ad6-3ff0-1995adec0a54@au1.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>



On 24/11/17 19:33, Vaibhav Jain wrote:
> If set_thread_tidr() is called twice for same task_struct then it will
> allocate a new tidr value to it leaving the previous value still
> dangling in the vas_thread_ida table.
> 
> To fix this the patch changes set_thread_tidr() to check if a tidr
> value is already assigned to the task_struct and if yes then returns
> the existing value from function instead of allocating a new one.
> 
> Fixes: ec233ede4c86("powerpc: Add support for setting SPRN_TIDR")
> Signed-off-by: Vaibhav Jain <vaibhav@linux.vnet.ibm.com>

Reviewed-by: Andrew Donnellan <andrew.donnellan@au1.ibm.com>

> ---
> v2 ->	Fix minor spell errors in patch description
> ---
>   arch/powerpc/kernel/process.c | 3 +++
>   1 file changed, 3 insertions(+)
> 
> diff --git a/arch/powerpc/kernel/process.c b/arch/powerpc/kernel/process.c
> index 5d8176c7c2d8..9a72282b022d 100644
> --- a/arch/powerpc/kernel/process.c
> +++ b/arch/powerpc/kernel/process.c
> @@ -1577,6 +1577,9 @@ int set_thread_tidr(struct task_struct *t)
>   	if (t != current)
>   		return -EINVAL;
> 
> +	if (t->thread.tidr)
> +		return t->thread.tidr;
> +
>   	rc = assign_thread_tidr();
>   	if (rc > 0) {
>   		t->thread.tidr = rc;
> 

-- 
Andrew Donnellan              OzLabs, ADL Canberra
andrew.donnellan@au1.ibm.com  IBM Australia Limited
