Return-Path: <SRS0=P3hO=RE=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4331DC43381
	for <linuxppc-dev@archiver.kernel.org>; Fri,  1 Mar 2019 04:39:09 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A683720851
	for <linuxppc-dev@archiver.kernel.org>; Fri,  1 Mar 2019 04:39:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=ozlabs-ru.20150623.gappssmtp.com header.i=@ozlabs-ru.20150623.gappssmtp.com header.b="VDR0wAip"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A683720851
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ozlabs.ru
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 449cBf3dNXzDqDs
	for <linuxppc-dev@archiver.kernel.org>; Fri,  1 Mar 2019 15:39:06 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=ozlabs.ru
 (client-ip=2607:f8b0:4864:20::441; helo=mail-pf1-x441.google.com;
 envelope-from=aik@ozlabs.ru; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=none (p=none dis=none) header.from=ozlabs.ru
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=ozlabs-ru.20150623.gappssmtp.com
 header.i=@ozlabs-ru.20150623.gappssmtp.com header.b="VDR0wAip"; 
 dkim-atps=neutral
Received: from mail-pf1-x441.google.com (mail-pf1-x441.google.com
 [IPv6:2607:f8b0:4864:20::441])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 449c6X1RNhzDqRN
 for <linuxppc-dev@lists.ozlabs.org>; Fri,  1 Mar 2019 15:35:32 +1100 (AEDT)
Received: by mail-pf1-x441.google.com with SMTP id s22so10818078pfh.4
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 28 Feb 2019 20:35:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=ozlabs-ru.20150623.gappssmtp.com; s=20150623;
 h=subject:to:cc:references:from:openpgp:autocrypt:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=Rv4SMft36IlvaAsn2hdPqPAJlqIP2bf7XrUxpAA2wuI=;
 b=VDR0wAipumeSfPqxTvfDbcwrTZQ3qtrNK2UY5U6LrH7iuzXFjDG3q/RMzoMAKM5Uuu
 lQrcwI+6XTEPggBnbOHJzHpxrRkCS5Tb8cn++YQMobQ26c5+OxDM6F3eZbH86ezWLaDe
 rvUD9a1SJJTdSfaFk0/TyQGoVSZ//LWMk4I4f4GaWKsseqh5Y6kuVnLuo8s110uzTjoB
 R9KiHyS9l6jodwAnYETp22aJewl/Nu7YarNUuqZ1T+mVrHlS5W8yTekjyRASgAkRUn1i
 JY7kNcfKeFNjo5iRs+Dd0CEPT7z+xDyWIkpzX421Cfulq+1xLx2Iu5xbTALc0SsLRUZj
 Gnag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:openpgp:autocrypt
 :message-id:date:user-agent:mime-version:in-reply-to
 :content-language:content-transfer-encoding;
 bh=Rv4SMft36IlvaAsn2hdPqPAJlqIP2bf7XrUxpAA2wuI=;
 b=AeC2waah6+S518aWva3gF7rQNEXMvYQWixVofGRBC7NAriBmf0mYgj4G0UyitqXJIc
 AZ1V0PiSiHHfskuaEOBZI2HbwEPpRciGnpSquWuldD065lcrbdaRfqp9EQOg0CaRFmpz
 qmb9Iy8PVOQX0vVhcMxHaOv2RDP4ebeYpprH3fVqK3MpMWEuJShSyVwxjIEmMxu+OY8u
 EgZj0A52vq40OOizJabZtA2NWFqj6nTM5V20TRcNHmkuM2MciFGL9zWSWBd2G7zjjtN+
 OSbrUT6/lsDokqzE5FsMvyvN8lMKam4/a3kSL0L+6m87n9MyerM0ppnTTy0VDbAYwX4D
 Cixw==
X-Gm-Message-State: APjAAAXB7T94P45PXFXxll9qYnQLH8D2Yk5H20zFCua72l/7LDja3h7f
 5vdh2gxs0YyrNkmeVzCZ0XzinQ==
X-Google-Smtp-Source: APXvYqwRB2Vb8TqEFq4IA/Y6e/fBiKc6L2J495iFVPbgkmiwSi+HxMc/Qu7VAbjy6/5sm+8VpHZ93w==
X-Received: by 2002:a63:d64:: with SMTP id 36mr2857879pgn.360.1551414929274;
 Thu, 28 Feb 2019 20:35:29 -0800 (PST)
Received: from [10.61.2.175] ([122.99.82.10])
 by smtp.gmail.com with ESMTPSA id o2sm40678729pgq.29.2019.02.28.20.35.26
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Thu, 28 Feb 2019 20:35:28 -0800 (PST)
Subject: ignore this Re: [PATCH kernel v2] KVM: PPC: Allocate guest TCEs on
 demand too
To: linuxppc-dev@lists.ozlabs.org
References: <20190301043411.89935-1-aik@ozlabs.ru>
From: Alexey Kardashevskiy <aik@ozlabs.ru>
Openpgp: preference=signencrypt
Autocrypt: addr=aik@ozlabs.ru; keydata=
 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
Message-ID: <f54c602f-cfcf-91fc-cc09-bde698740efc@ozlabs.ru>
Date: Fri, 1 Mar 2019 15:35:24 +1100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.5.1
MIME-Version: 1.0
In-Reply-To: <20190301043411.89935-1-aik@ozlabs.ru>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
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
Cc: kvm-ppc@vger.kernel.org, David Gibson <david@gibson.dropbear.id.au>
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

Ignore this as I forgot to change v2 to v3 so I reposted this.


On 01/03/2019 15:34, Alexey Kardashevskiy wrote:
> We already allocate hardware TCE tables in multiple levels and skip
> intermediate levels when we can, now it is a turn of the KVM TCE tables.
> Thankfully these are allocated already in 2 levels.
> 
> This moves the table's last level allocation from the creating helper to
> kvmppc_tce_put() and kvm_spapr_tce_fault().
> 
> This adds kvmppc_rm_ioba_validate() to do an additional test if
> the consequent kvmppc_tce_put() needs a page which has not been allocated;
> if this is the case, we bail out to virtual mode handlers.
> 
> Signed-off-by: Alexey Kardashevskiy <aik@ozlabs.ru>
> ---
> Changes:
> v3:
> * fixed alignments in kvmppc_rm_ioba_validate
> 
> v2:
> * added kvm mutex around alloc_page to prevent races; in both place we
> test the pointer, if NULL, then take a lock and check again so on a fast
> path we do not take a lock at all
> 
> 
> ---
> For NVLink2 passthrough guests with 128TiB DMA windows and very fragmented
> system RAM the difference is gigabytes of RAM.
> ---
>  arch/powerpc/kvm/book3s_64_vio.c    | 29 ++++++------
>  arch/powerpc/kvm/book3s_64_vio_hv.c | 71 ++++++++++++++++++++++++++---
>  2 files changed, 81 insertions(+), 19 deletions(-)
> 
> diff --git a/arch/powerpc/kvm/book3s_64_vio.c b/arch/powerpc/kvm/book3s_64_vio.c
> index f02b04973710..7eed8c90ea3d 100644
> --- a/arch/powerpc/kvm/book3s_64_vio.c
> +++ b/arch/powerpc/kvm/book3s_64_vio.c
> @@ -228,7 +228,8 @@ static void release_spapr_tce_table(struct rcu_head *head)
>  	unsigned long i, npages = kvmppc_tce_pages(stt->size);
>  
>  	for (i = 0; i < npages; i++)
> -		__free_page(stt->pages[i]);
> +		if (stt->pages[i])
> +			__free_page(stt->pages[i]);
>  
>  	kfree(stt);
>  }
> @@ -242,6 +243,20 @@ static vm_fault_t kvm_spapr_tce_fault(struct vm_fault *vmf)
>  		return VM_FAULT_SIGBUS;
>  
>  	page = stt->pages[vmf->pgoff];
> +	if (!page) {
> +		mutex_lock(&stt->kvm->lock);
> +		page = stt->pages[vmf->pgoff];
> +		if (!page) {
> +			page  = alloc_page(GFP_KERNEL | __GFP_ZERO);
> +			if (!page) {
> +				mutex_unlock(&stt->kvm->lock);
> +				return VM_FAULT_OOM;
> +			}
> +			stt->pages[vmf->pgoff] = page;
> +		}
> +		mutex_unlock(&stt->kvm->lock);
> +	}
> +
>  	get_page(page);
>  	vmf->page = page;
>  	return 0;
> @@ -296,7 +311,6 @@ long kvm_vm_ioctl_create_spapr_tce(struct kvm *kvm,
>  	struct kvmppc_spapr_tce_table *siter;
>  	unsigned long npages, size = args->size;
>  	int ret = -ENOMEM;
> -	int i;
>  
>  	if (!args->size || args->page_shift < 12 || args->page_shift > 34 ||
>  		(args->offset + args->size > (ULLONG_MAX >> args->page_shift)))
> @@ -320,12 +334,6 @@ long kvm_vm_ioctl_create_spapr_tce(struct kvm *kvm,
>  	stt->kvm = kvm;
>  	INIT_LIST_HEAD_RCU(&stt->iommu_tables);
>  
> -	for (i = 0; i < npages; i++) {
> -		stt->pages[i] = alloc_page(GFP_KERNEL | __GFP_ZERO);
> -		if (!stt->pages[i])
> -			goto fail;
> -	}
> -
>  	mutex_lock(&kvm->lock);
>  
>  	/* Check this LIOBN hasn't been previously allocated */
> @@ -352,11 +360,6 @@ long kvm_vm_ioctl_create_spapr_tce(struct kvm *kvm,
>  	if (ret >= 0)
>  		return ret;
>  
> - fail:
> -	for (i = 0; i < npages; i++)
> -		if (stt->pages[i])
> -			__free_page(stt->pages[i]);
> -
>  	kfree(stt);
>   fail_acct:
>  	kvmppc_account_memlimit(kvmppc_stt_pages(npages), false);
> diff --git a/arch/powerpc/kvm/book3s_64_vio_hv.c b/arch/powerpc/kvm/book3s_64_vio_hv.c
> index 2206bc729b9a..1cd9373f8bdc 100644
> --- a/arch/powerpc/kvm/book3s_64_vio_hv.c
> +++ b/arch/powerpc/kvm/book3s_64_vio_hv.c
> @@ -158,23 +158,78 @@ static u64 *kvmppc_page_address(struct page *page)
>  	return (u64 *) page_address(page);
>  }
>  
> +/*
> + * TCEs pages are allocated in kvmppc_tce_put() which won't be able to do so
> + * in real mode.
> + * Check if kvmppc_tce_put() can succeed in real mode, i.e. a TCEs page is
> + * allocated or not required (when clearing a tce entry).
> + */
> +static long kvmppc_rm_ioba_validate(struct kvmppc_spapr_tce_table *stt,
> +		unsigned long ioba, unsigned long npages, bool clearing)
> +{
> +	unsigned long i, idx, sttpage, sttpages;
> +	unsigned long ret = kvmppc_ioba_validate(stt, ioba, npages);
> +
> +	if (ret)
> +		return ret;
> +	/*
> +	 * clearing==true says kvmppc_tce_put won't be allocating pages
> +	 * for empty tces.
> +	 */
> +	if (clearing)
> +		return H_SUCCESS;
> +
> +	idx = (ioba >> stt->page_shift) - stt->offset;
> +	sttpage = idx / TCES_PER_PAGE;
> +	sttpages = _ALIGN_UP(idx % TCES_PER_PAGE + npages, TCES_PER_PAGE) /
> +			TCES_PER_PAGE;
> +	for (i = sttpage; i < sttpage + sttpages; ++i)
> +		if (!stt->pages[i])
> +			return H_TOO_HARD;
> +
> +	return H_SUCCESS;
> +}
> +
>  /*
>   * Handles TCE requests for emulated devices.
>   * Puts guest TCE values to the table and expects user space to convert them.
>   * Called in both real and virtual modes.
>   * Cannot fail so kvmppc_tce_validate must be called before it.
>   *
> - * WARNING: This will be called in real-mode on HV KVM and virtual
> - *          mode on PR KVM
> + * WARNING: This will be called in real-mode on HV HPT KVM and virtual
> + *          mode on PR KVM or HV radix KVM
>   */
>  void kvmppc_tce_put(struct kvmppc_spapr_tce_table *stt,
>  		unsigned long idx, unsigned long tce)
>  {
>  	struct page *page;
>  	u64 *tbl;
> +	unsigned long sttpage;
>  
>  	idx -= stt->offset;
> -	page = stt->pages[idx / TCES_PER_PAGE];
> +	sttpage = idx / TCES_PER_PAGE;
> +	page = stt->pages[sttpage];
> +
> +	if (!page) {
> +		/* We allow any TCE, not just with read|write permissions */
> +		if (!tce)
> +			return;
> +		/*
> +		 * We must not end up here in real mode,
> +		 * kvmppc_rm_ioba_validate() takes care of this.
> +		 */
> +		mutex_lock(&stt->kvm->lock);
> +		page = stt->pages[sttpage];
> +		if (!page) {
> +			page = alloc_page(GFP_KERNEL | __GFP_ZERO);
> +			if (WARN_ON_ONCE(!page)) {
> +				mutex_unlock(&stt->kvm->lock);
> +				return;
> +			}
> +			stt->pages[sttpage] = page;
> +		}
> +		mutex_unlock(&stt->kvm->lock);
> +	}
>  	tbl = kvmppc_page_address(page);
>  
>  	tbl[idx % TCES_PER_PAGE] = tce;
> @@ -381,7 +436,7 @@ long kvmppc_rm_h_put_tce(struct kvm_vcpu *vcpu, unsigned long liobn,
>  	if (!stt)
>  		return H_TOO_HARD;
>  
> -	ret = kvmppc_ioba_validate(stt, ioba, 1);
> +	ret = kvmppc_rm_ioba_validate(stt, ioba, 1, tce == 0);
>  	if (ret != H_SUCCESS)
>  		return ret;
>  
> @@ -480,7 +535,7 @@ long kvmppc_rm_h_put_tce_indirect(struct kvm_vcpu *vcpu,
>  	if (tce_list & (SZ_4K - 1))
>  		return H_PARAMETER;
>  
> -	ret = kvmppc_ioba_validate(stt, ioba, npages);
> +	ret = kvmppc_rm_ioba_validate(stt, ioba, npages, false);
>  	if (ret != H_SUCCESS)
>  		return ret;
>  
> @@ -583,7 +638,7 @@ long kvmppc_rm_h_stuff_tce(struct kvm_vcpu *vcpu,
>  	if (!stt)
>  		return H_TOO_HARD;
>  
> -	ret = kvmppc_ioba_validate(stt, ioba, npages);
> +	ret = kvmppc_rm_ioba_validate(stt, ioba, npages, tce_value == 0);
>  	if (ret != H_SUCCESS)
>  		return ret;
>  
> @@ -635,6 +690,10 @@ long kvmppc_h_get_tce(struct kvm_vcpu *vcpu, unsigned long liobn,
>  
>  	idx = (ioba >> stt->page_shift) - stt->offset;
>  	page = stt->pages[idx / TCES_PER_PAGE];
> +	if (!page) {
> +		vcpu->arch.regs.gpr[4] = 0;
> +		return H_SUCCESS;
> +	}
>  	tbl = (u64 *)page_address(page);
>  
>  	vcpu->arch.regs.gpr[4] = tbl[idx % TCES_PER_PAGE];
> 

-- 
Alexey
