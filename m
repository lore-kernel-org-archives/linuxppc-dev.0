Return-Path: <bauerman@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com
 [148.163.156.1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3xT05C3PKCzDr2p
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 11 Aug 2017 06:25:51 +1000 (AEST)
Received: from pps.filterd (m0098410.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.21/8.16.0.21) with SMTP id
 v7AKOHGB071958
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 10 Aug 2017 16:25:49 -0400
Received: from e18.ny.us.ibm.com (e18.ny.us.ibm.com [129.33.205.208])
 by mx0a-001b2d01.pphosted.com with ESMTP id 2c8uv87uhc-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 10 Aug 2017 16:25:49 -0400
Received: from localhost
 by e18.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <bauerman@linux.vnet.ibm.com>;
 Thu, 10 Aug 2017 16:25:47 -0400
References: <1501459946-11619-1-git-send-email-linuxram@us.ibm.com>
 <1501459946-11619-3-git-send-email-linuxram@us.ibm.com>
From: Thiago Jung Bauermann <bauerman@linux.vnet.ibm.com>
To: Ram Pai <linuxram@us.ibm.com>
Cc: linuxppc-dev@lists.ozlabs.org, benh@kernel.crashing.org, paulus@samba.org,
 mpe@ellerman.id.au, khandual@linux.vnet.ibm.com,
 aneesh.kumar@linux.vnet.ibm.com, bsingharora@gmail.com,
 hbabu@us.ibm.com, bauerman@linux.vnet.ibm.com, mhocko@kernel.org
Subject: Re: [RFC v7 02/25] powerpc: track allocation status of all pkeys
In-reply-to: <1501459946-11619-3-git-send-email-linuxram@us.ibm.com>
Date: Thu, 10 Aug 2017 17:25:39 -0300
MIME-Version: 1.0
Content-Type: text/plain
Message-Id: <8760dvkw58.fsf@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


Ram Pai <linuxram@us.ibm.com> writes:
>  static inline void pkey_initialize(void)
>  {
> +	int os_reserved, i;
> +
>  	/* disable the pkey system till everything
>  	 * is in place. A patch further down the
>  	 * line will enable it.
>  	 */
>  	pkey_inited = false;
> +
> +	/* Lets assume 32 keys */
> +	pkeys_total = 32;
> +
> +#ifdef CONFIG_PPC_4K_PAGES
> +	/*
> +	 * the OS can manage only 8 pkeys
> +	 * due to its inability to represent
> +	 * them in the linux 4K-PTE.
> +	 */
> +	os_reserved = pkeys_total-8;
> +#else
> +	os_reserved = 0;
> +#endif
> +	/*
> +	 * Bits are in LE format.
> +	 * NOTE: 1, 0 are reserved.
> +	 * key 0 is the default key, which allows read/write/execute.
> +	 * key 1 is recommended not to be used.
> +	 * PowerISA(3.0) page 1015, programming note.
> +	 */
> +	initial_allocation_mask = ~0x0;
> +	for (i = 2; i < (pkeys_total - os_reserved); i++)
> +		initial_allocation_mask &= ~(0x1<<i);
>  }
>  #endif /*_ASM_PPC64_PKEYS_H */

In v6, key 31 was also reserved, but it's not in this version. Is this
intentional?

Isn't it better for this function to be in pkeys.c? Ideally, functions
should be in .c files not in headers unless they're very small or
performance sensitive IMHO.

-- 
Thiago Jung Bauermann
IBM Linux Technology Center
