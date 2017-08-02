Return-Path: <naveen.n.rao@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com
 [148.163.156.1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3xMwQC0CXtzDrK6
 for <linuxppc-dev@lists.ozlabs.org>; Thu,  3 Aug 2017 00:22:58 +1000 (AEST)
Received: from pps.filterd (m0098409.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.21/8.16.0.21) with SMTP id
 v72EM6Ea116523
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 2 Aug 2017 10:22:56 -0400
Received: from e23smtp07.au.ibm.com (e23smtp07.au.ibm.com [202.81.31.140])
 by mx0a-001b2d01.pphosted.com with ESMTP id 2c3cs6m2qn-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 02 Aug 2017 10:22:56 -0400
Received: from localhost
 by e23smtp07.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <naveen.n.rao@linux.vnet.ibm.com>;
 Thu, 3 Aug 2017 00:22:54 +1000
Received: from d23av02.au.ibm.com (d23av02.au.ibm.com [9.190.235.138])
 by d23relay09.au.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 v72EMpsS31129622
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 3 Aug 2017 00:22:51 +1000
Received: from d23av02.au.ibm.com (localhost [127.0.0.1])
 by d23av02.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 v72EMfm6013018
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 3 Aug 2017 00:22:42 +1000
Date: Wed, 2 Aug 2017 19:52:47 +0530
From: "Naveen N. Rao" <naveen.n.rao@linux.vnet.ibm.com>
To: Balbir Singh <bsingharora@gmail.com>
Cc: linuxppc-dev@lists.ozlabs.org, mpe@ellerman.id.au
Subject: Re: [PATCH v1 3/3] arch/powerpc/net/bpf: Basic EBPF support
References: <20170801112535.20765-1-bsingharora@gmail.com>
 <20170801112535.20765-4-bsingharora@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20170801112535.20765-4-bsingharora@gmail.com>
Message-Id: <20170802142247.ccoeerrvrdywlzv6@naverao1-tp.localdomain>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

> arch/powerpc/net/bpf: Basic EBPF support

Perhaps:
powerpc/bpf: Set JIT memory read-only

On 2017/08/01 09:25PM, Balbir Singh wrote:
> Signed-off-by: Balbir Singh <bsingharora@gmail.com>
> ---
>  arch/powerpc/net/bpf_jit_comp64.c | 13 +------------
>  1 file changed, 1 insertion(+), 12 deletions(-)
> 
> diff --git a/arch/powerpc/net/bpf_jit_comp64.c b/arch/powerpc/net/bpf_jit_comp64.c
> index 861c5af..d81110e 100644
> --- a/arch/powerpc/net/bpf_jit_comp64.c
> +++ b/arch/powerpc/net/bpf_jit_comp64.c
> @@ -1054,6 +1054,7 @@ struct bpf_prog *bpf_int_jit_compile(struct bpf_prog *fp)
>  	fp->jited = 1;
>  	fp->jited_len = alloclen;
> 
> +	bpf_jit_binary_lock_ro(bpf_hdr);
>  	bpf_flush_icache(bpf_hdr, (u8 *)bpf_hdr + (bpf_hdr->pages * PAGE_SIZE));

Should we call bpf_flush_icache() _before_ locking the memory?

Thanks,
Naveen

> 
>  out:
> @@ -1064,15 +1065,3 @@ struct bpf_prog *bpf_int_jit_compile(struct bpf_prog *fp)
> 
>  	return fp;
>  }
> -
> -/* Overriding bpf_jit_free() as we don't set images read-only. */
> -void bpf_jit_free(struct bpf_prog *fp)
> -{
> -	unsigned long addr = (unsigned long)fp->bpf_func & PAGE_MASK;
> -	struct bpf_binary_header *bpf_hdr = (void *)addr;
> -
> -	if (fp->jited)
> -		bpf_jit_binary_free(bpf_hdr);
> -
> -	bpf_prog_unlock_free(fp);
> -}
> -- 
> 2.9.4
> 
