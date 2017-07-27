Return-Path: <bauerman@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com
 [148.163.156.1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3xJP5s4DmzzDrLR
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 28 Jul 2017 06:41:37 +1000 (AEST)
Received: from pps.filterd (m0098409.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.21/8.16.0.21) with SMTP id
 v6RKfUbs089427
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 27 Jul 2017 16:41:34 -0400
Received: from e24smtp03.br.ibm.com (e24smtp03.br.ibm.com [32.104.18.24])
 by mx0a-001b2d01.pphosted.com with ESMTP id 2byny43rxh-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 27 Jul 2017 16:41:33 -0400
Received: from localhost
 by e24smtp03.br.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <bauerman@linux.vnet.ibm.com>;
 Thu, 27 Jul 2017 17:40:58 -0300
Received: from d24av02.br.ibm.com (d24av02.br.ibm.com [9.8.31.93])
 by d24relay02.br.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 v6RKeuO721496030
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 27 Jul 2017 17:40:56 -0300
Received: from d24av02.br.ibm.com (localhost [127.0.0.1])
 by d24av02.br.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 v6RKewmM022674
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 27 Jul 2017 17:40:59 -0300
References: <1500177424-13695-1-git-send-email-linuxram@us.ibm.com>
 <1500177424-13695-16-git-send-email-linuxram@us.ibm.com>
From: Thiago Jung Bauermann <bauerman@linux.vnet.ibm.com>
To: Ram Pai <linuxram@us.ibm.com>
Cc: linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org,
 linux-arch@vger.kernel.org, linux-mm@kvack.org, x86@kernel.org,
 linux-doc@vger.kernel.org, linux-kselftest@vger.kernel.org,
 arnd@arndb.de, corbet@lwn.net, mhocko@kernel.org,
 dave.hansen@intel.com, mingo@redhat.com, paulus@samba.org,
 aneesh.kumar@linux.vnet.ibm.com, akpm@linux-foundation.org,
 khandual@linux.vnet.ibm.com
Subject: Re: [RFC v6 15/62] powerpc: helper functions to initialize AMR,
 IAMR and UMOR registers
In-reply-to: <1500177424-13695-16-git-send-email-linuxram@us.ibm.com>
Date: Thu, 27 Jul 2017 17:40:44 -0300
MIME-Version: 1.0
Content-Type: text/plain
Message-Id: <877eyt4nqr.fsf@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


Ram Pai <linuxram@us.ibm.com> writes:

> Introduce helper functions that can initialize the bits in the AMR,
> IAMR and UMOR register; the bits that correspond to the given pkey.
>
> Signed-off-by: Ram Pai <linuxram@us.ibm.com>

s/UMOR/UAMOR/ here and in the subject as well.

> --- a/arch/powerpc/mm/pkeys.c
> +++ b/arch/powerpc/mm/pkeys.c
> @@ -16,3 +16,47 @@
>  #include <linux/pkeys.h>                /* PKEY_*                       */
>
>  bool pkey_inited;
> +#define pkeyshift(pkey) ((arch_max_pkey()-pkey-1) * AMR_BITS_PER_PKEY)
> +
> +static inline void init_amr(int pkey, u8 init_bits)
> +{
> +	u64 new_amr_bits = (((u64)init_bits & 0x3UL) << pkeyshift(pkey));
> +	u64 old_amr = read_amr() & ~((u64)(0x3ul) << pkeyshift(pkey));
> +
> +	write_amr(old_amr | new_amr_bits);
> +}
> +
> +static inline void init_iamr(int pkey, u8 init_bits)
> +{
> +	u64 new_iamr_bits = (((u64)init_bits & 0x3UL) << pkeyshift(pkey));
> +	u64 old_iamr = read_iamr() & ~((u64)(0x3ul) << pkeyshift(pkey));
> +
> +	write_amr(old_iamr | new_iamr_bits);
> +}

init_iamr should call write_iamr, not write_amr.

-- 
Thiago Jung Bauermann
IBM Linux Technology Center
