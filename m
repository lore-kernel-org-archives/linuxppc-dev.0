Return-Path: <srikar@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com
 [148.163.158.5])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 41mTZB2096zDqBy
 for <linuxppc-dev@lists.ozlabs.org>; Thu,  9 Aug 2018 23:27:14 +1000 (AEST)
Received: from pps.filterd (m0098421.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id
 w79DOAqn063224
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 9 Aug 2018 09:27:11 -0400
Received: from e06smtp05.uk.ibm.com (e06smtp05.uk.ibm.com [195.75.94.101])
 by mx0a-001b2d01.pphosted.com with ESMTP id 2krmxsvd3a-1
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 09 Aug 2018 09:27:11 -0400
Received: from localhost
 by e06smtp05.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <srikar@linux.vnet.ibm.com>;
 Thu, 9 Aug 2018 14:27:03 +0100
Date: Thu, 9 Aug 2018 06:26:57 -0700
From: Srikar Dronamraju <srikar@linux.vnet.ibm.com>
To: "Gautham R. Shenoy" <ego@linux.vnet.ibm.com>
Cc: Michael Ellerman <mpe@ellerman.id.au>,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Michael Neuling <mikey@neuling.org>,
 Vaidyanathan Srinivasan <svaidy@linux.vnet.ibm.com>,
 Akshay Adiga <akshay.adiga@linux.vnet.ibm.com>,
 Shilpasri G Bhat <shilpa.bhat@linux.vnet.ibm.com>,
 "Oliver O'Halloran" <oohall@gmail.com>,
 Nicholas Piggin <npiggin@gmail.com>,
 Murilo Opsfelder Araujo <muriloo@linux.ibm.com>,
 Anton Blanchard <anton@samba.org>, linuxppc-dev@lists.ozlabs.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH v6 2/2] powerpc: Use cpu_smallcore_sibling_mask at SMT
 level on bigcores
Reply-To: Srikar Dronamraju <srikar@linux.vnet.ibm.com>
References: <1533792728-6304-1-git-send-email-ego@linux.vnet.ibm.com>
 <1533792728-6304-3-git-send-email-ego@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
In-Reply-To: <1533792728-6304-3-git-send-email-ego@linux.vnet.ibm.com>
Message-Id: <20180809132657.GA42474@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

* Gautham R. Shenoy <ego@linux.vnet.ibm.com> [2018-08-09 11:02:08]:

> 
> 3) ppc64_cpu --smt=2
>    SMT domain ceases to exist as each domain consists of just one
>    group.
> 

When seen in isolation, the above looks as if ppc64_cpu --smt=2 o/p says
" SMT domain ceases to exist...."

> @@ -999,7 +1012,17 @@ static void add_cpu_to_masks(int cpu)
>  {
>  	int first_thread = cpu_first_thread_sibling(cpu);
>  	int chipid = cpu_to_chip_id(cpu);
> -	int i;
> +
> +	struct thread_groups tg;
> +	int i, cpu_group_start = -1;
> +
> +	if (has_big_cores) {
> +		struct device_node *dn = of_get_cpu_node(cpu, NULL);
> +

Not checking for validity of dn and no of_node_puts?

> +		parse_thread_groups(dn, &tg);
> +		cpu_group_start = get_cpu_thread_group_start(cpu, &tg);
> +		cpumask_set_cpu(cpu, cpu_smallcore_sibling_mask(cpu));
> +	}
> 
>  	/*
>  	 * This CPU will not be in the online mask yet so we need to manually

The rest looks good
