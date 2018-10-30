Return-Path: <SRS0=S6eX=NK=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 81261C2BC61
	for <linuxppc-dev@archiver.kernel.org>; Tue, 30 Oct 2018 05:35:46 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C3E6B20664
	for <linuxppc-dev@archiver.kernel.org>; Tue, 30 Oct 2018 05:35:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=ozlabs.org header.i=@ozlabs.org header.b="h2ExxK/k"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C3E6B20664
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ozlabs.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 42kgDH5kv0zF1Q0
	for <linuxppc-dev@archiver.kernel.org>; Tue, 30 Oct 2018 16:35:43 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none) header.from=ozlabs.org
Authentication-Results: lists.ozlabs.org;
	dkim=fail reason="signature verification failed" (2048-bit key; secure) header.d=ozlabs.org header.i=@ozlabs.org header.b="h2ExxK/k";
	dkim-atps=neutral
Received: from ozlabs.org (bilbo.ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 42kg721td6zDrPy
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 30 Oct 2018 16:31:10 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org;
 dmarc=none (p=none dis=none) header.from=ozlabs.org
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 secure) header.d=ozlabs.org header.i=@ozlabs.org header.b="h2ExxK/k"; 
 dkim-atps=neutral
Received: by ozlabs.org (Postfix, from userid 1003)
 id 42kg716Zqpz9s5c; Tue, 30 Oct 2018 16:31:09 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ozlabs.org; s=201707;
 t=1540877469; bh=xd9ydww8gS29Rw1cBwuvThzBA7hOWHhPVkHqbT5SIsY=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=h2ExxK/kHtA1O0hXERTk6wuIwBQ29R3ytACygD7W80LlBTzXj1+4mnnQemQhycsOs
 TzYTRj9B74ejT9g7TBvZW9em+6ohjKha5d+YhNTtrvmy3buHXUduimaRWwU0mG32VC
 R7kv2scxWseBLbiCsvn+OqjIon7J5igYnVk7UQksLIUZxLLhPyaWkvGLw0wK+IJqev
 kvGcGxXs784v5B+fVkMvW9pVZa9s4CivAOXD1F3AedeytaB/9LXxwm6vYDHAZy4Gkt
 tpT7w+6rz78PK8tha0R1usY08oYKNyM6tzvja+i36GTvC58jrbEDRt0xZRUV6MnnDZ
 5a9K4emqQ8fNg==
Date: Tue, 30 Oct 2018 16:26:46 +1100
From: Paul Mackerras <paulus@ozlabs.org>
To: Bharata B Rao <bharata@linux.ibm.com>
Subject: Re: [RFC PATCH v1 2/4] kvmppc: Add support for shared pages in HMM
 driver
Message-ID: <20181030052646.GB11072@blackberry>
References: <20181022051837.1165-1-bharata@linux.ibm.com>
 <20181022051837.1165-3-bharata@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181022051837.1165-3-bharata@linux.ibm.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
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
Cc: linuxram@us.ibm.com, kvm-ppc@vger.kernel.org, benh@linux.ibm.com,
 linux-mm@kvack.org, jglisse@redhat.com, aneesh.kumar@linux.vnet.ibm.com,
 paulus@au1.ibm.com, linuxppc-dev@lists.ozlabs.org
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

On Mon, Oct 22, 2018 at 10:48:35AM +0530, Bharata B Rao wrote:
> A secure guest will share some of its pages with hypervisor (Eg. virtio
> bounce buffers etc). Support shared pages in HMM driver.
> 
> Signed-off-by: Bharata B Rao <bharata@linux.ibm.com>

Comments below...

> ---
>  arch/powerpc/kvm/book3s_hv_hmm.c | 69 ++++++++++++++++++++++++++++++--
>  1 file changed, 65 insertions(+), 4 deletions(-)
> 
> diff --git a/arch/powerpc/kvm/book3s_hv_hmm.c b/arch/powerpc/kvm/book3s_hv_hmm.c
> index a2ee3163a312..09b8e19b7605 100644
> --- a/arch/powerpc/kvm/book3s_hv_hmm.c
> +++ b/arch/powerpc/kvm/book3s_hv_hmm.c
> @@ -50,6 +50,7 @@ struct kvmppc_hmm_page_pvt {
>  	struct hlist_head *hmm_hash;
>  	unsigned int lpid;
>  	unsigned long gpa;
> +	bool skip_page_out;
>  };
>  
>  struct kvmppc_hmm_migrate_args {
> @@ -278,6 +279,65 @@ static unsigned long kvmppc_gpa_to_hva(struct kvm *kvm, unsigned long gpa,
>  	return hva;
>  }
>  
> +/*
> + * Shares the page with HV, thus making it a normal page.
> + *
> + * - If the page is already secure, then provision a new page and share
> + * - If the page is a normal page, share the existing page
> + *
> + * In the former case, uses the HMM fault handler to release the HMM page.
> + */
> +static unsigned long
> +kvmppc_share_page(struct kvm *kvm, unsigned long gpa,
> +		  unsigned long addr, unsigned long page_shift)
> +{
> +
> +	int ret;
> +	struct hlist_head *list, *hmm_hash;
> +	unsigned int lpid = kvm->arch.lpid;
> +	unsigned long flags;
> +	struct kvmppc_hmm_pfn_entry *p;
> +	struct page *hmm_page, *page;
> +	struct kvmppc_hmm_page_pvt *pvt;
> +	unsigned long pfn;
> +
> +	/*
> +	 * First check if the requested page has already been given to
> +	 * UV as a secure page. If so, ensure that we don't issue a
> +	 * UV_PAGE_OUT but instead directly send the page
> +	 */
> +	spin_lock_irqsave(&kvmppc_hmm_lock, flags);
> +	hmm_hash = kvm->arch.hmm_hash;
> +	list = &hmm_hash[kvmppc_hmm_pfn_hash_fn(gpa)];
> +	hlist_for_each_entry(p, list, hlist) {
> +		if (p->addr == gpa) {
> +			hmm_page = pfn_to_page(p->hmm_pfn);
> +			get_page(hmm_page); /* TODO: Necessary ? */
> +			pvt = (struct kvmppc_hmm_page_pvt *)
> +				hmm_devmem_page_get_drvdata(hmm_page);
> +			pvt->skip_page_out = true;
> +			put_page(hmm_page);
> +			break;
> +		}
> +	}
> +	spin_unlock_irqrestore(&kvmppc_hmm_lock, flags);
> +
> +	ret = get_user_pages_fast(addr, 1, 0, &page);

Why are we calling this with write==0?  Surely in general the secure
guest will expect to be able to write to the shared page?

Also, in general get_user_pages_fast isn't sufficient to translate a
host virtual address (derived from a guest real address) into a pfn.
See for example hva_to_pfn() in virt/kvm/kvm_main.c and the things it
does to cope with the various cases that one can hit.  I can imagine
in future that the secure guest might want to establish a shared
mapping to a PCI device, for instance.

> +	if (ret != 1)
> +		return H_PARAMETER;
> +
> +	pfn = page_to_pfn(page);
> +	if (is_zero_pfn(pfn)) {
> +		put_page(page);
> +		return H_SUCCESS;
> +	}

The ultravisor still needs a page to map into the guest in this case,
doesn't it?  What's the point of returning without giving the
ultravisor a page to use?

> +
> +	ret = uv_page_in(lpid, pfn << page_shift, gpa, 0, page_shift);
> +	put_page(page);
> +
> +	return (ret == U_SUCCESS) ? H_SUCCESS : H_PARAMETER;
> +}
> +
>  /*
>   * Move page from normal memory to secure memory.
>   */
> @@ -300,8 +360,8 @@ kvmppc_h_svm_page_in(struct kvm *kvm, unsigned long gpa,
>  		return H_PARAMETER;
>  	end = addr + (1UL << page_shift);
>  
> -	if (flags)
> -		return H_P2;
> +	if (flags & H_PAGE_IN_SHARED)
> +		return kvmppc_share_page(kvm, gpa, addr, page_shift);

Would be best to fail if any unknown flags are set, I would think.

>  
>  	args.hmm_hash = kvm->arch.hmm_hash;
>  	args.lpid = kvm->arch.lpid;
> @@ -349,8 +409,9 @@ kvmppc_hmm_fault_migrate_alloc_and_copy(struct vm_area_struct *vma,
>  	       hmm_devmem_page_get_drvdata(spage);
>  
>  	pfn = page_to_pfn(dpage);
> -	ret = uv_page_out(pvt->lpid, pfn << PAGE_SHIFT,
> -			  pvt->gpa, 0, PAGE_SHIFT);
> +	if (!pvt->skip_page_out)
> +		ret = uv_page_out(pvt->lpid, pfn << PAGE_SHIFT,
> +				  pvt->gpa, 0, PAGE_SHIFT);
>  	if (ret == U_SUCCESS)
>  		*dst_pfn = migrate_pfn(pfn) | MIGRATE_PFN_LOCKED;
>  }
> -- 
> 2.17.1

Paul.
