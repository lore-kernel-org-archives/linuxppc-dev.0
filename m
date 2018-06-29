Return-Path: <bauerman@linux.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com
 [148.163.156.1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 41H1fv31dVzF1Ld
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 29 Jun 2018 13:03:03 +1000 (AEST)
Received: from pps.filterd (m0098396.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id
 w5T2sIdK117383
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 28 Jun 2018 23:03:01 -0400
Received: from e31.co.us.ibm.com (e31.co.us.ibm.com [32.97.110.149])
 by mx0a-001b2d01.pphosted.com with ESMTP id 2jw7jntprh-1
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 28 Jun 2018 23:03:00 -0400
Received: from localhost
 by e31.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <bauerman@linux.ibm.com>;
 Thu, 28 Jun 2018 21:03:00 -0600
References: <1528936144-6696-1-git-send-email-linuxram@us.ibm.com>
 <1528936144-6696-5-git-send-email-linuxram@us.ibm.com>
From: Thiago Jung Bauermann <bauerman@linux.ibm.com>
To: Ram Pai <linuxram@us.ibm.com>
Cc: mpe@ellerman.id.au, linuxppc-dev@lists.ozlabs.org, dave.hansen@intel.com,
 aneesh.kumar@linux.vnet.ibm.com, bsingharora@gmail.com,
 hbabu@us.ibm.com, mhocko@kernel.org, bauerman@linux.vnet.ibm.com,
 Ulrich.Weigand@de.ibm.com, fweimer@redhat.com, luto@kernel.org,
 msuchanek@suse.de
Subject: Re: [PATCH v2 4/6] powerpc/pkeys: Preallocate execute-only key
In-reply-to: <1528936144-6696-5-git-send-email-linuxram@us.ibm.com>
Date: Fri, 29 Jun 2018 00:02:46 -0300
MIME-Version: 1.0
Content-Type: text/plain
Message-Id: <87efgqxpk9.fsf@morokweng.localdomain>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


Hello,

My understanding is that this patch isn't upstream yet and it's not too
late for bikeshedding. Please ignore if this is not the case.

Ram Pai <linuxram@us.ibm.com> writes:

> @@ -326,48 +330,7 @@ static inline bool pkey_allows_readwrite(int pkey)
>
>  int __execute_only_pkey(struct mm_struct *mm)
>  {
> -	bool need_to_set_mm_pkey = false;
> -	int execute_only_pkey = mm->context.execute_only_pkey;
> -	int ret;
> -
> -	/* Do we need to assign a pkey for mm's execute-only maps? */
> -	if (execute_only_pkey == -1) {
> -		/* Go allocate one to use, which might fail */
> -		execute_only_pkey = mm_pkey_alloc(mm);
> -		if (execute_only_pkey < 0)
> -			return -1;
> -		need_to_set_mm_pkey = true;
> -	}
> -
> -	/*
> -	 * We do not want to go through the relatively costly dance to set AMR
> -	 * if we do not need to. Check it first and assume that if the
> -	 * execute-only pkey is readwrite-disabled than we do not have to set it
> -	 * ourselves.
> -	 */
> -	if (!need_to_set_mm_pkey && !pkey_allows_readwrite(execute_only_pkey))
> -		return execute_only_pkey;
> -
> -	/*
> -	 * Set up AMR so that it denies access for everything other than
> -	 * execution.
> -	 */
> -	ret = __arch_set_user_pkey_access(current, execute_only_pkey,
> -					  PKEY_DISABLE_ACCESS |
> -					  PKEY_DISABLE_WRITE);
> -	/*
> -	 * If the AMR-set operation failed somehow, just return 0 and
> -	 * effectively disable execute-only support.
> -	 */
> -	if (ret) {
> -		mm_pkey_free(mm, execute_only_pkey);
> -		return -1;
> -	}
> -
> -	/* We got one, store it and use it from here on out */
> -	if (need_to_set_mm_pkey)
> -		mm->context.execute_only_pkey = execute_only_pkey;
> -	return execute_only_pkey;
> +	return mm->context.execute_only_pkey;
>  }

There's no reason to have a separate  __execute_only_pkey() function
anymore. Its single line can go directly in execute_only_pkey(), defined
in <asm/pkeys.h>.
-- 
Thiago Jung Bauermann
IBM Linux Technology Center
