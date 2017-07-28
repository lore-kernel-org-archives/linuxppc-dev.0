Return-Path: <bauerman@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com
 [148.163.158.5])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3xK3B367tFzDrVd
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 29 Jul 2017 08:17:31 +1000 (AEST)
Received: from pps.filterd (m0098416.ppops.net [127.0.0.1])
 by mx0b-001b2d01.pphosted.com (8.16.0.21/8.16.0.21) with SMTP id
 v6SMDX5h001216
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 28 Jul 2017 18:17:28 -0400
Received: from e24smtp01.br.ibm.com (e24smtp01.br.ibm.com [32.104.18.85])
 by mx0b-001b2d01.pphosted.com with ESMTP id 2c085jqg0r-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 28 Jul 2017 18:17:28 -0400
Received: from localhost
 by e24smtp01.br.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <bauerman@linux.vnet.ibm.com>;
 Fri, 28 Jul 2017 19:17:26 -0300
Received: from d24av04.br.ibm.com (d24av04.br.ibm.com [9.8.31.97])
 by d24relay02.br.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 v6SMHOJt21495912
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 28 Jul 2017 19:17:24 -0300
Received: from d24av04.br.ibm.com (localhost [127.0.0.1])
 by d24av04.br.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 v6SMHOqG007958
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 28 Jul 2017 19:17:25 -0300
References: <1500177424-13695-1-git-send-email-linuxram@us.ibm.com>
 <1500177424-13695-22-git-send-email-linuxram@us.ibm.com>
From: Thiago Jung Bauermann <bauerman@linux.vnet.ibm.com>
To: Ram Pai <linuxram@us.ibm.com>
Cc: linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org,
 linux-arch@vger.kernel.org, linux-mm@kvack.org, x86@kernel.org,
 linux-doc@vger.kernel.org, linux-kselftest@vger.kernel.org,
 arnd@arndb.de, corbet@lwn.net, mhocko@kernel.org,
 dave.hansen@intel.com, mingo@redhat.com, paulus@samba.org,
 aneesh.kumar@linux.vnet.ibm.com, akpm@linux-foundation.org,
 khandual@linux.vnet.ibm.com
Subject: Re: [RFC v6 21/62] powerpc: introduce execute-only pkey
In-reply-to: <1500177424-13695-22-git-send-email-linuxram@us.ibm.com>
Date: Fri, 28 Jul 2017 19:17:13 -0300
MIME-Version: 1.0
Content-Type: text/plain
Message-Id: <87shhgdx5i.fsf@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


Ram Pai <linuxram@us.ibm.com> writes:
> --- a/arch/powerpc/mm/pkeys.c
> +++ b/arch/powerpc/mm/pkeys.c
> @@ -97,3 +97,60 @@ int __arch_set_user_pkey_access(struct task_struct *tsk, int pkey,
>  	init_iamr(pkey, new_iamr_bits);
>  	return 0;
>  }
> +
> +static inline bool pkey_allows_readwrite(int pkey)
> +{
> +	int pkey_shift = pkeyshift(pkey);
> +
> +	if (!(read_uamor() & (0x3UL << pkey_shift)))
> +		return true;
> +
> +	return !(read_amr() & ((AMR_RD_BIT|AMR_WR_BIT) << pkey_shift));
> +}
> +
> +int __execute_only_pkey(struct mm_struct *mm)
> +{
> +	bool need_to_set_mm_pkey = false;
> +	int execute_only_pkey = mm->context.execute_only_pkey;
> +	int ret;
> +
> +	/* Do we need to assign a pkey for mm's execute-only maps? */
> +	if (execute_only_pkey == -1) {
> +		/* Go allocate one to use, which might fail */
> +		execute_only_pkey = mm_pkey_alloc(mm);
> +		if (execute_only_pkey < 0)
> +			return -1;
> +		need_to_set_mm_pkey = true;
> +	}
> +
> +	/*
> +	 * We do not want to go through the relatively costly
> +	 * dance to set AMR if we do not need to.  Check it
> +	 * first and assume that if the execute-only pkey is
> +	 * readwrite-disabled than we do not have to set it
> +	 * ourselves.
> +	 */
> +	if (!need_to_set_mm_pkey &&
> +	    !pkey_allows_readwrite(execute_only_pkey))
> +		return execute_only_pkey;
> +
> +	/*
> +	 * Set up AMR so that it denies access for everything
> +	 * other than execution.
> +	 */
> +	ret = __arch_set_user_pkey_access(current, execute_only_pkey,
> +			(PKEY_DISABLE_ACCESS | PKEY_DISABLE_WRITE));
> +	/*
> +	 * If the AMR-set operation failed somehow, just return
> +	 * 0 and effectively disable execute-only support.
> +	 */
> +	if (ret) {
> +		mm_set_pkey_free(mm, execute_only_pkey);
> +		return -1;
> +	}
> +
> +	/* We got one, store it and use it from here on out */
> +	if (need_to_set_mm_pkey)
> +		mm->context.execute_only_pkey = execute_only_pkey;
> +	return execute_only_pkey;
> +}

If you follow the code flow in __execute_only_pkey, the AMR and UAMOR
are read 3 times in total, and AMR is written twice. IAMR is read and
written twice. Since they are SPRs and access to them is slow (or isn't
it?), is it worth it to read them once in __execute_only_pkey and pass
down their values to the callees, and then write them once at the end of
the function?

This function is used both by the mmap syscall and the mprotect syscall
(but not by pkey_mprotect) if the requested protection is execute-only.

-- 
Thiago Jung Bauermann
IBM Linux Technology Center
