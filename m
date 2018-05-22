Return-Path: <bauerman@linux.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com
 [148.163.156.1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 40qdgl73H9zDqH4
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 22 May 2018 11:42:40 +1000 (AEST)
Received: from pps.filterd (m0098399.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id
 w4M1YNQb129165
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 21 May 2018 21:42:38 -0400
Received: from e38.co.us.ibm.com (e38.co.us.ibm.com [32.97.110.159])
 by mx0a-001b2d01.pphosted.com with ESMTP id 2j48t01x6j-1
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 21 May 2018 21:42:37 -0400
Received: from localhost
 by e38.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <bauerman@linux.ibm.com>;
 Mon, 21 May 2018 19:42:37 -0600
References: <1525464111-1096-1-git-send-email-linuxram@us.ibm.com>
From: Thiago Jung Bauermann <bauerman@linux.ibm.com>
To: Ram Pai <linuxram@us.ibm.com>
Cc: mpe@ellerman.id.au, linuxppc-dev@lists.ozlabs.org,
 benh@kernel.crashing.org, paulus@samba.org,
 aneesh.kumar@linux.vnet.ibm.com, bsingharora@gmail.com,
 hbabu@us.ibm.com, mhocko@kernel.org, bauerman@linux.vnet.ibm.com,
 msuchanek@suse.com, Ulrich.Weigand@de.ibm.com, dave.hansen@intel.com,
 Shakeel Butt <shakeelb@google.com>
Subject: Re: [PATCH ] powerpc/pkeys: Detach execute_only key on !PROT_EXEC
In-reply-to: <1525464111-1096-1-git-send-email-linuxram@us.ibm.com>
Date: Mon, 21 May 2018 22:42:23 -0300
MIME-Version: 1.0
Content-Type: text/plain
Message-Id: <87wovwea9s.fsf@morokweng.localdomain>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


Ram Pai <linuxram@us.ibm.com> writes:

> Disassociate the exec_key from a VMA if the VMA permission is not
> PROT_EXEC anymore.  Otherwise the exec_only key continues to be
> associated with the vma, causing unexpected behavior.
>
> The problem was reported on x86 by Shakeel Butt,
> which is also applicable on powerpc.
>
> cc: Shakeel Butt <shakeelb@google.com>
> Reported-by: Shakeel Butt <shakeelb@google.com>
> Fixes 5586cf6 ("powerpc: introduce execute-only pkey")
       ^
         Missing a colon here.

> Signed-off-by: Ram Pai <linuxram@us.ibm.com>
> ---
>  arch/powerpc/mm/pkeys.c |    4 ++--
>  1 files changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/arch/powerpc/mm/pkeys.c b/arch/powerpc/mm/pkeys.c
> index e81d59e..fdeb9f5 100644
> --- a/arch/powerpc/mm/pkeys.c
> +++ b/arch/powerpc/mm/pkeys.c
> @@ -425,9 +425,9 @@ int __arch_override_mprotect_pkey(struct vm_area_struct *vma, int prot,
>  {
>  	/*
>  	 * If the currently associated pkey is execute-only, but the requested
> -	 * protection requires read or write, move it back to the default pkey.
> +	 * protection is not execute-only, move it back to the default pkey.
>  	 */
> -	if (vma_is_pkey_exec_only(vma) && (prot & (PROT_READ | PROT_WRITE)))
> +	if (vma_is_pkey_exec_only(vma) && (prot != PROT_EXEC))
>  		return 0;
>
>  	/*

I think I'm slow today. It took me a while to figure out why this is
buggy. It will leave the VMA with the execute-only pkey if prot = 0.
Other bit combinations work fine IIUC.

Reviewed-by: Thiago Jung Bauermann <bauerman@linux.ibm.com>

--
Thiago Jung Bauermann
IBM Linux Technology Center
