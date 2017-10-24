Return-Path: <aneesh.kumar@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com
 [148.163.158.5])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3yLjyg5SX2zDqhg
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 24 Oct 2017 17:28:43 +1100 (AEDT)
Received: from pps.filterd (m0098421.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.21/8.16.0.21) with SMTP id
 v9O6O3Jk046556
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 24 Oct 2017 02:28:41 -0400
Received: from e06smtp11.uk.ibm.com (e06smtp11.uk.ibm.com [195.75.94.107])
 by mx0a-001b2d01.pphosted.com with ESMTP id 2dsu1ckt6r-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 24 Oct 2017 02:28:40 -0400
Received: from localhost
 by e06smtp11.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <aneesh.kumar@linux.vnet.ibm.com>;
 Tue, 24 Oct 2017 07:28:39 +0100
From: "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>
To: Ram Pai <linuxram@us.ibm.com>, mpe@ellerman.id.au,
 linuxppc-dev@lists.ozlabs.org
Cc: benh@kernel.crashing.org, paulus@samba.org, khandual@linux.vnet.ibm.com,
 bsingharora@gmail.com, hbabu@us.ibm.com, mhocko@kernel.org,
 bauerman@linux.vnet.ibm.com, ebiederm@xmission.com, linuxram@us.ibm.com
Subject: Re: [PATCH 03/25] powerpc: track allocation status of all pkeys
In-Reply-To: <1504910713-7094-12-git-send-email-linuxram@us.ibm.com>
References: <1504910713-7094-1-git-send-email-linuxram@us.ibm.com>
 <1504910713-7094-12-git-send-email-linuxram@us.ibm.com>
Date: Tue, 24 Oct 2017 11:58:29 +0530
MIME-Version: 1.0
Content-Type: text/plain
Message-Id: <87zi8hvz3m.fsf@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Ram Pai <linuxram@us.ibm.com> writes:
 +
> +#define mm_set_pkey_is_allocated(mm, pkey)	\
> +	(mm_pkey_allocation_map(mm) & pkey_alloc_mask(pkey))
> +

>  static inline bool mm_pkey_is_allocated(struct mm_struct *mm, int pkey)
>  {
> -	return (pkey == 0);
> +	/* a reserved key is never considered as 'explicitly allocated' */
> +	return ((pkey < arch_max_pkey()) &&
> +		!mm_set_pkey_is_reserved(mm, pkey) &&
> +		mm_set_pkey_is_allocated(mm, pkey));
>  }
>

that is confusing naming. what is mm_set_pkey_is_allocated()? . 'set' in
that name is confusing.

-aneesh
