Return-Path: <SRS0=dZYZ=32=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 61806C2D0B1
	for <linuxppc-dev@archiver.kernel.org>; Thu,  6 Feb 2020 06:19:34 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 12A73206CC
	for <linuxppc-dev@archiver.kernel.org>; Thu,  6 Feb 2020 06:19:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=c-s.fr header.i=@c-s.fr header.b="IJc3jder"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 12A73206CC
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=c-s.fr
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 48CpDg5KtRzDqKZ
	for <linuxppc-dev@archiver.kernel.org>; Thu,  6 Feb 2020 17:19:31 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org;
 spf=pass (sender SPF authorized) smtp.mailfrom=c-s.fr
 (client-ip=93.17.236.30; helo=pegase1.c-s.fr;
 envelope-from=christophe.leroy@c-s.fr; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=none (p=none dis=none) header.from=c-s.fr
Authentication-Results: lists.ozlabs.org; dkim=pass (1024-bit key;
 unprotected) header.d=c-s.fr header.i=@c-s.fr header.a=rsa-sha256
 header.s=mail header.b=IJc3jder; dkim-atps=neutral
Received: from pegase1.c-s.fr (pegase1.c-s.fr [93.17.236.30])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 48CpC4595bzDqK5
 for <linuxppc-dev@lists.ozlabs.org>; Thu,  6 Feb 2020 17:18:08 +1100 (AEDT)
Received: from localhost (mailhub1-int [192.168.12.234])
 by localhost (Postfix) with ESMTP id 48CpC01NgvzB09bJ;
 Thu,  6 Feb 2020 07:18:04 +0100 (CET)
Authentication-Results: localhost; dkim=pass
 reason="1024-bit key; insecure key"
 header.d=c-s.fr header.i=@c-s.fr header.b=IJc3jder; dkim-adsp=pass;
 dkim-atps=neutral
X-Virus-Scanned: Debian amavisd-new at c-s.fr
Received: from pegase1.c-s.fr ([192.168.12.234])
 by localhost (pegase1.c-s.fr [192.168.12.234]) (amavisd-new, port 10024)
 with ESMTP id Ff_laLB1i3Yt; Thu,  6 Feb 2020 07:18:04 +0100 (CET)
Received: from messagerie.si.c-s.fr (messagerie.si.c-s.fr [192.168.25.192])
 by pegase1.c-s.fr (Postfix) with ESMTP id 48CpC008FQzB09bG;
 Thu,  6 Feb 2020 07:18:04 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=c-s.fr; s=mail;
 t=1580969884; bh=/zXspG1kSDBchHeXMPNEW4CMohV4cfmd+YhDCREVeRU=;
 h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
 b=IJc3jderGna62CaEbuKOvFjwfgtAoqVWDE/KIjuvt5lVBel/amt4R+kH9JR8F0zKw
 WAex/t5oBpzyaF9Z2SiGAv2B3XAU6NFAGf9SqVrv+8Utda7pe6bWVzA08BRFijg6AW
 z6fcy7RHCPd0QkreMH9zr+46SWRtxYBXVtnBy+Ug=
Received: from localhost (localhost [127.0.0.1])
 by messagerie.si.c-s.fr (Postfix) with ESMTP id CCBF78B85E;
 Thu,  6 Feb 2020 07:18:04 +0100 (CET)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from messagerie.si.c-s.fr ([127.0.0.1])
 by localhost (messagerie.si.c-s.fr [127.0.0.1]) (amavisd-new, port 10023)
 with ESMTP id JUidJKGusZ7Y; Thu,  6 Feb 2020 07:18:04 +0100 (CET)
Received: from [192.168.4.90] (unknown [192.168.4.90])
 by messagerie.si.c-s.fr (Postfix) with ESMTP id 289C18B776;
 Thu,  6 Feb 2020 07:18:03 +0100 (CET)
Subject: Re: [PATCH v6 07/11] powerpc/kvm/e500: Use functions to track
 lockless pgtbl walks
To: Leonardo Bras <leonardo@linux.ibm.com>,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Paul Mackerras <paulus@samba.org>, Michael Ellerman <mpe@ellerman.id.au>,
 Arnd Bergmann <arnd@arndb.de>, Andrew Morton <akpm@linux-foundation.org>,
 "Aneesh Kumar K.V" <aneesh.kumar@linux.ibm.com>,
 Nicholas Piggin <npiggin@gmail.com>, Steven Price <steven.price@arm.com>,
 Robin Murphy <robin.murphy@arm.com>,
 Mahesh Salgaonkar <mahesh@linux.vnet.ibm.com>,
 Balbir Singh <bsingharora@gmail.com>, Reza Arbab <arbab@linux.ibm.com>,
 Thomas Gleixner <tglx@linutronix.de>, Allison Randal <allison@lohutok.net>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Mike Rapoport <rppt@linux.ibm.com>, Michal Suchanek <msuchanek@suse.de>
References: <20200206030900.147032-1-leonardo@linux.ibm.com>
 <20200206030900.147032-8-leonardo@linux.ibm.com>
From: Christophe Leroy <christophe.leroy@c-s.fr>
Message-ID: <fae235d5-78b6-87aa-ed3f-1a908d61abf4@c-s.fr>
Date: Thu, 6 Feb 2020 07:18:02 +0100
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.2
MIME-Version: 1.0
In-Reply-To: <20200206030900.147032-8-leonardo@linux.ibm.com>
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
Cc: linux-arch@vger.kernel.org, linux-mm@kvack.org,
 linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org,
 kvm-ppc@vger.kernel.org
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>



Le 06/02/2020 à 04:08, Leonardo Bras a écrit :
> Applies the new functions used for tracking lockless pgtable walks on
> kvmppc_e500_shadow_map().
> 
> Fixes the place where local_irq_restore() is called: previously, if ptep
> was NULL, local_irq_restore() would never be called.
> 
> local_irq_{save,restore} is already inside {begin,end}_lockless_pgtbl_walk,
> so there is no need to repeat it here.
> 
> Variable that saves the	irq mask was renamed from flags to irq_mask so it
> doesn't lose meaning now it's not directly passed to local_irq_* functions.
> 
> Signed-off-by: Leonardo Bras <leonardo@linux.ibm.com>
> ---
>   arch/powerpc/kvm/e500_mmu_host.c | 9 +++++----
>   1 file changed, 5 insertions(+), 4 deletions(-)
> 
> diff --git a/arch/powerpc/kvm/e500_mmu_host.c b/arch/powerpc/kvm/e500_mmu_host.c
> index 425d13806645..3dcf11f77256 100644
> --- a/arch/powerpc/kvm/e500_mmu_host.c
> +++ b/arch/powerpc/kvm/e500_mmu_host.c
> @@ -336,7 +336,7 @@ static inline int kvmppc_e500_shadow_map(struct kvmppc_vcpu_e500 *vcpu_e500,
>   	pte_t *ptep;
>   	unsigned int wimg = 0;
>   	pgd_t *pgdir;
> -	unsigned long flags;
> +	unsigned long irq_mask;
>   
>   	/* used to check for invalidations in progress */
>   	mmu_seq = kvm->mmu_notifier_seq;
> @@ -473,7 +473,7 @@ static inline int kvmppc_e500_shadow_map(struct kvmppc_vcpu_e500 *vcpu_e500,
>   	 * We are holding kvm->mmu_lock so a notifier invalidate
>   	 * can't run hence pfn won't change.
>   	 */
> -	local_irq_save(flags);
> +	irq_mask = begin_lockless_pgtbl_walk();
>   	ptep = find_linux_pte(pgdir, hva, NULL, NULL);
>   	if (ptep) {
>   		pte_t pte = READ_ONCE(*ptep);
> @@ -481,15 +481,16 @@ static inline int kvmppc_e500_shadow_map(struct kvmppc_vcpu_e500 *vcpu_e500,
>   		if (pte_present(pte)) {
>   			wimg = (pte_val(pte) >> PTE_WIMGE_SHIFT) &
>   				MAS2_WIMGE_MASK;
> -			local_irq_restore(flags);
>   		} else {
> -			local_irq_restore(flags);
> +			end_lockless_pgtbl_walk(irq_mask);
>   			pr_err_ratelimited("%s: pte not present: gfn %lx,pfn %lx\n",
>   					   __func__, (long)gfn, pfn);
>   			ret = -EINVAL;
>   			goto out;
>   		}
>   	}
> +	end_lockless_pgtbl_walk(irq_mask);
> +

I don't really like unbalanced begin/end.

Something like the following would be cleaner:


begin_lockless_pgtbl_walk()
ptep = find()
if (ptep) {
	pte = READ_ONCE()
	if (pte_present(pte))
		wing=
	else
		ret = -EINVAL;
}
end_lockless_pgtbl_walk()

if (ret) {
	pr_err_rate...()
	goto out;
}



>   	kvmppc_e500_ref_setup(ref, gtlbe, pfn, wimg);
>   
>   	kvmppc_e500_setup_stlbe(&vcpu_e500->vcpu, gtlbe, tsize,
> 

Christophe
