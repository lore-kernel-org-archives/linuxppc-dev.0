Return-Path: <SRS0=wHv8=RQ=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E1A28C43381
	for <linuxppc-dev@archiver.kernel.org>; Wed, 13 Mar 2019 19:19:31 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CB4CB2075C
	for <linuxppc-dev@archiver.kernel.org>; Wed, 13 Mar 2019 19:19:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=c-s.fr header.i=@c-s.fr header.b="d+UWWuvs"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CB4CB2075C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=c-s.fr
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 44KM8t4zhWzDqKM
	for <linuxppc-dev@archiver.kernel.org>; Thu, 14 Mar 2019 06:19:26 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=c-s.fr
 (client-ip=93.17.236.30; helo=pegase1.c-s.fr;
 envelope-from=christophe.leroy@c-s.fr; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=none (p=none dis=none) header.from=c-s.fr
Authentication-Results: lists.ozlabs.org; dkim=pass (1024-bit key;
 unprotected) header.d=c-s.fr header.i=@c-s.fr header.b="d+UWWuvs"; 
 dkim-atps=neutral
Received: from pegase1.c-s.fr (pegase1.c-s.fr [93.17.236.30])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 44KM5z1SfPzDqKH
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 14 Mar 2019 06:16:49 +1100 (AEDT)
Received: from localhost (mailhub1-int [192.168.12.234])
 by localhost (Postfix) with ESMTP id 44KM5n0SfYz9v0vR;
 Wed, 13 Mar 2019 20:16:45 +0100 (CET)
Authentication-Results: localhost; dkim=pass
 reason="1024-bit key; insecure key"
 header.d=c-s.fr header.i=@c-s.fr header.b=d+UWWuvs; dkim-adsp=pass;
 dkim-atps=neutral
X-Virus-Scanned: Debian amavisd-new at c-s.fr
Received: from pegase1.c-s.fr ([192.168.12.234])
 by localhost (pegase1.c-s.fr [192.168.12.234]) (amavisd-new, port 10024)
 with ESMTP id bM_c9XnkjgWR; Wed, 13 Mar 2019 20:16:44 +0100 (CET)
Received: from messagerie.si.c-s.fr (messagerie.si.c-s.fr [192.168.25.192])
 by pegase1.c-s.fr (Postfix) with ESMTP id 44KM5m6DS6z9v0vF;
 Wed, 13 Mar 2019 20:16:44 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=c-s.fr; s=mail;
 t=1552504604; bh=LI3TBGguDUuLpwtPN7CVlLcbxS9s0qBjVoz/08ibyjI=;
 h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
 b=d+UWWuvslWjlxC0ax3RgMDVErFQPn9gvT0Bss8Ns8wGK890Fq3uDSkpWNRZVpUTty
 BaV1v8t0+ydWGsHROA/1g1+kNjtl+LQJRIw1mip9mnl/gHVgsTea834Atfq/MbRsqq
 20VIP45An2EZMCon0fDlP3hPb6YqLM4xgQgK8bmg=
Received: from localhost (localhost [127.0.0.1])
 by messagerie.si.c-s.fr (Postfix) with ESMTP id CAED98B915;
 Wed, 13 Mar 2019 20:16:44 +0100 (CET)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from messagerie.si.c-s.fr ([127.0.0.1])
 by localhost (messagerie.si.c-s.fr [127.0.0.1]) (amavisd-new, port 10023)
 with ESMTP id 3qqKLOlHcHGC; Wed, 13 Mar 2019 20:16:44 +0100 (CET)
Received: from PO15451 (unknown [192.168.4.90])
 by messagerie.si.c-s.fr (Postfix) with ESMTP id 32F498B8EE;
 Wed, 13 Mar 2019 20:16:44 +0100 (CET)
Subject: Re: [PATCH v3] powerpc/mm: move warning from resize_hpt_for_hotplug()
To: Laurent Vivier <lvivier@redhat.com>, linux-kernel@vger.kernel.org
References: <20190313102528.4632-1-lvivier@redhat.com>
From: Christophe Leroy <christophe.leroy@c-s.fr>
Message-ID: <d0ee0f33-3218-288a-f5c8-d23143196f2e@c-s.fr>
Date: Wed, 13 Mar 2019 20:16:44 +0100
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.5.3
MIME-Version: 1.0
In-Reply-To: <20190313102528.4632-1-lvivier@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: fr
Content-Transfer-Encoding: 8bit
X-BeenThere: linuxppc-dev@lists.ozlabs.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>
Cc: linuxppc-dev@lists.ozlabs.org, David Gibson <david@gibson.dropbear.id.au>
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>



Le 13/03/2019 à 11:25, Laurent Vivier a écrit :
> resize_hpt_for_hotplug() reports a warning when it cannot
> resize the hash page table ("Unable to resize hash page
> table to target order") but in some cases it's not a problem
> and can make user thinks something has not worked properly.
> 
> This patch moves the warning to arch_remove_memory() to
> only report the problem when it is needed.
> 
> Reviewed-by: David Gibson <david@gibson.dropbear.id.au>
> Signed-off-by: Laurent Vivier <lvivier@redhat.com>

Reviewed-by: Christophe Leroy <christophe.leroy@c-s.fr>

> ---
> 
> Notes:
>      v3: move "||" to above line and remove parenthesis
>      v2: add warning messages for H_PARAMETER and H_RESOURCE
> 
>   arch/powerpc/include/asm/sparsemem.h  |  4 ++--
>   arch/powerpc/mm/hash_utils_64.c       | 19 +++++++------------
>   arch/powerpc/mm/mem.c                 |  3 ++-
>   arch/powerpc/platforms/pseries/lpar.c |  3 ++-
>   4 files changed, 13 insertions(+), 16 deletions(-)
> 
> diff --git a/arch/powerpc/include/asm/sparsemem.h b/arch/powerpc/include/asm/sparsemem.h
> index 68da49320592..3192d454a733 100644
> --- a/arch/powerpc/include/asm/sparsemem.h
> +++ b/arch/powerpc/include/asm/sparsemem.h
> @@ -17,9 +17,9 @@ extern int create_section_mapping(unsigned long start, unsigned long end, int ni
>   extern int remove_section_mapping(unsigned long start, unsigned long end);
>   
>   #ifdef CONFIG_PPC_BOOK3S_64
> -extern void resize_hpt_for_hotplug(unsigned long new_mem_size);
> +extern int resize_hpt_for_hotplug(unsigned long new_mem_size);
>   #else
> -static inline void resize_hpt_for_hotplug(unsigned long new_mem_size) { }
> +static inline int resize_hpt_for_hotplug(unsigned long new_mem_size) { return 0; }
>   #endif
>   
>   #ifdef CONFIG_NUMA
> diff --git a/arch/powerpc/mm/hash_utils_64.c b/arch/powerpc/mm/hash_utils_64.c
> index 0cc7fbc3bd1c..5aa7594ee71b 100644
> --- a/arch/powerpc/mm/hash_utils_64.c
> +++ b/arch/powerpc/mm/hash_utils_64.c
> @@ -755,12 +755,12 @@ static unsigned long __init htab_get_table_size(void)
>   }
>   
>   #ifdef CONFIG_MEMORY_HOTPLUG
> -void resize_hpt_for_hotplug(unsigned long new_mem_size)
> +int resize_hpt_for_hotplug(unsigned long new_mem_size)
>   {
>   	unsigned target_hpt_shift;
>   
>   	if (!mmu_hash_ops.resize_hpt)
> -		return;
> +		return 0;
>   
>   	target_hpt_shift = htab_shift_for_mem_size(new_mem_size);
>   
> @@ -772,16 +772,11 @@ void resize_hpt_for_hotplug(unsigned long new_mem_size)
>   	 * reduce unless the target shift is at least 2 below the
>   	 * current shift
>   	 */
> -	if ((target_hpt_shift > ppc64_pft_size)
> -	    || (target_hpt_shift < (ppc64_pft_size - 1))) {
> -		int rc;
> -
> -		rc = mmu_hash_ops.resize_hpt(target_hpt_shift);
> -		if (rc && (rc != -ENODEV))
> -			printk(KERN_WARNING
> -			       "Unable to resize hash page table to target order %d: %d\n",
> -			       target_hpt_shift, rc);
> -	}
> +	if (target_hpt_shift > ppc64_pft_size ||
> +	    target_hpt_shift < ppc64_pft_size - 1)
> +		return mmu_hash_ops.resize_hpt(target_hpt_shift);
> +
> +	return 0;
>   }
>   
>   int hash__create_section_mapping(unsigned long start, unsigned long end, int nid)
> diff --git a/arch/powerpc/mm/mem.c b/arch/powerpc/mm/mem.c
> index 33cc6f676fa6..0d40d970cf4a 100644
> --- a/arch/powerpc/mm/mem.c
> +++ b/arch/powerpc/mm/mem.c
> @@ -169,7 +169,8 @@ int __meminit arch_remove_memory(int nid, u64 start, u64 size,
>   	 */
>   	vm_unmap_aliases();
>   
> -	resize_hpt_for_hotplug(memblock_phys_mem_size());
> +	if (resize_hpt_for_hotplug(memblock_phys_mem_size()) == -ENOSPC)
> +		pr_warn("Hash collision while resizing HPT\n");
>   
>   	return ret;
>   }
> diff --git a/arch/powerpc/platforms/pseries/lpar.c b/arch/powerpc/platforms/pseries/lpar.c
> index f2a9f0adc2d3..1034ef1fe2b4 100644
> --- a/arch/powerpc/platforms/pseries/lpar.c
> +++ b/arch/powerpc/platforms/pseries/lpar.c
> @@ -901,8 +901,10 @@ static int pseries_lpar_resize_hpt(unsigned long shift)
>   		break;
>   
>   	case H_PARAMETER:
> +		pr_warn("Invalid argument from H_RESIZE_HPT_PREPARE\n");
>   		return -EINVAL;
>   	case H_RESOURCE:
> +		pr_warn("Operation not permitted from H_RESIZE_HPT_PREPARE\n");
>   		return -EPERM;
>   	default:
>   		pr_warn("Unexpected error %d from H_RESIZE_HPT_PREPARE\n", rc);
> @@ -918,7 +920,6 @@ static int pseries_lpar_resize_hpt(unsigned long shift)
>   	if (rc != 0) {
>   		switch (state.commit_rc) {
>   		case H_PTEG_FULL:
> -			pr_warn("Hash collision while resizing HPT\n");
>   			return -ENOSPC;
>   
>   		default:
> 
