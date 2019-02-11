Return-Path: <SRS0=3oxj=QS=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_MUTT autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A5614C169C4
	for <linuxppc-dev@archiver.kernel.org>; Mon, 11 Feb 2019 23:02:48 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 176C7204FD
	for <linuxppc-dev@archiver.kernel.org>; Mon, 11 Feb 2019 23:02:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="C4tTREA7"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 176C7204FD
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 43z1XQ197mzDqcy
	for <linuxppc-dev@archiver.kernel.org>; Tue, 12 Feb 2019 10:02:46 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=ziepe.ca
 (client-ip=2607:f8b0:4864:20::642; helo=mail-pl1-x642.google.com;
 envelope-from=jgg@ziepe.ca; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=ziepe.ca header.i=@ziepe.ca header.b="C4tTREA7"; 
 dkim-atps=neutral
Received: from mail-pl1-x642.google.com (mail-pl1-x642.google.com
 [IPv6:2607:f8b0:4864:20::642])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 43z1P270ZbzDqb1
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 12 Feb 2019 09:56:22 +1100 (AEDT)
Received: by mail-pl1-x642.google.com with SMTP id g9so275454plo.3
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 11 Feb 2019 14:56:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ziepe.ca; s=google;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:in-reply-to:user-agent;
 bh=HpEhd1hjAxTw2MvV1T4BxjxIfyr9u34ZDCNveDCt9pw=;
 b=C4tTREA7HJPtDyU1uVPrhGE+tenWueSaGN0k0ef/Kh8wHOc+eeRjHW4eNci/W1sNVZ
 nYdNIvPBh0jkuMGegVaVI7ZknSEEmTYjVQ9lkUqwq808jxLyjhyYKUS7PTcL9UCxtB/s
 it+yq0CUlai76H0E960zYXqbQR8MnnrS6MK8skX1EzEWnStU+4GlmKuGyXCUjmhBbpIA
 ESTHk+JdGDgc7/Ph4KMGJJYmCHTvk5TWeSG1yrZVMPtAk3pw1nN/51xgX4GuqGMCDsdQ
 v3NegYxwcxTIMySPBLYjq6QADfr8Cbj0sw8JmSoiCEdCAL1NAbCqVFX55zltezDUhzh9
 STEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to:user-agent;
 bh=HpEhd1hjAxTw2MvV1T4BxjxIfyr9u34ZDCNveDCt9pw=;
 b=jlpNJyqNauBDccauRwJHqKtBnycXG2rE0uXd80sKm5o7/e0adkQZCLAqXxEv1tbo0n
 Q5GNrzKUvZNhv5frbTelpo7pVEuhtDRJVOcfu0mbYzW4ikw+6dKhef1s+bwWlioXFl2r
 seFFhDhj2UgDsUwLwiAlN4ql0linzu0roCltOZFvd6c18mDwAEx+YPmQH4dBvvSAkYFQ
 qHgRoqh5MxPPIRTwHOMGedp78hWWq4P2KrAVLt0qM4Ji4W1RBdA46vKWy0g08+tuHO5O
 rUFoW3ClhH8go35ZqyVUC4pGcqWF5mJp7cG+q3bciiQ4imiOiE8InFTZfAjlmATcrvZN
 XIWA==
X-Gm-Message-State: AHQUAuZ2BoBbR9/kJdtHNuADDeQMDhzuiD8inHZREIa/cF/ieN3z+ql/
 ga7cZfSLUqZAlyk4z1siR7np6Q==
X-Google-Smtp-Source: AHgI3IZZHskA3za69Xpd8+FHO3LEV/xrV2vOJSA9kBqr3FxTMFSCZDXTbx2Vmep3HV1eRHv9cAoOVw==
X-Received: by 2002:a17:902:fa2:: with SMTP id 31mr677704plz.75.1549925781226; 
 Mon, 11 Feb 2019 14:56:21 -0800 (PST)
Received: from ziepe.ca (S010614cc2056d97f.ed.shawcable.net. [174.3.196.123])
 by smtp.gmail.com with ESMTPSA id
 e65sm16713492pfc.184.2019.02.11.14.56.20
 (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
 Mon, 11 Feb 2019 14:56:20 -0800 (PST)
Received: from jgg by mlx.ziepe.ca with local (Exim 4.90_1)
 (envelope-from <jgg@ziepe.ca>)
 id 1gtKUu-0003Rw-6N; Mon, 11 Feb 2019 15:56:20 -0700
Date: Mon, 11 Feb 2019 15:56:20 -0700
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Daniel Jordan <daniel.m.jordan@oracle.com>
Subject: Re: [PATCH 1/5] vfio/type1: use pinned_vm instead of locked_vm to
 account pinned pages
Message-ID: <20190211225620.GO24692@ziepe.ca>
References: <20190211224437.25267-1-daniel.m.jordan@oracle.com>
 <20190211224437.25267-2-daniel.m.jordan@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190211224437.25267-2-daniel.m.jordan@oracle.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
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
Cc: dave@stgolabs.net, jack@suse.cz, kvm@vger.kernel.org, atull@kernel.org,
 aik@ozlabs.ru, linux-fpga@vger.kernel.org, linux-kernel@vger.kernel.org,
 kvm-ppc@vger.kernel.org, linux-mm@kvack.org, alex.williamson@redhat.com,
 mdf@kernel.org, akpm@linux-foundation.org, linuxppc-dev@lists.ozlabs.org,
 cl@linux.com, hao.wu@intel.com
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

On Mon, Feb 11, 2019 at 05:44:33PM -0500, Daniel Jordan wrote:
> Beginning with bc3e53f682d9 ("mm: distinguish between mlocked and pinned
> pages"), locked and pinned pages are accounted separately.  Type1
> accounts pinned pages to locked_vm; use pinned_vm instead.
> 
> pinned_vm recently became atomic and so no longer relies on mmap_sem
> held as writer: delete.
> 
> Signed-off-by: Daniel Jordan <daniel.m.jordan@oracle.com>
>  drivers/vfio/vfio_iommu_type1.c | 31 ++++++++++++-------------------
>  1 file changed, 12 insertions(+), 19 deletions(-)
> 
> diff --git a/drivers/vfio/vfio_iommu_type1.c b/drivers/vfio/vfio_iommu_type1.c
> index 73652e21efec..a56cc341813f 100644
> +++ b/drivers/vfio/vfio_iommu_type1.c
> @@ -257,7 +257,8 @@ static int vfio_iova_put_vfio_pfn(struct vfio_dma *dma, struct vfio_pfn *vpfn)
>  static int vfio_lock_acct(struct vfio_dma *dma, long npage, bool async)
>  {
>  	struct mm_struct *mm;
> -	int ret;
> +	s64 pinned_vm;
> +	int ret = 0;
>  
>  	if (!npage)
>  		return 0;
> @@ -266,24 +267,15 @@ static int vfio_lock_acct(struct vfio_dma *dma, long npage, bool async)
>  	if (!mm)
>  		return -ESRCH; /* process exited */
>  
> -	ret = down_write_killable(&mm->mmap_sem);
> -	if (!ret) {
> -		if (npage > 0) {
> -			if (!dma->lock_cap) {
> -				unsigned long limit;
> -
> -				limit = task_rlimit(dma->task,
> -						RLIMIT_MEMLOCK) >> PAGE_SHIFT;
> +	pinned_vm = atomic64_add_return(npage, &mm->pinned_vm);
>  
> -				if (mm->locked_vm + npage > limit)
> -					ret = -ENOMEM;
> -			}
> +	if (npage > 0 && !dma->lock_cap) {
> +		unsigned long limit = task_rlimit(dma->task, RLIMIT_MEMLOCK) >>
> +
> -					PAGE_SHIFT;

I haven't looked at this super closely, but how does this stuff work?

do_mlock doesn't touch pinned_vm, and this doesn't touch locked_vm...

Shouldn't all this be 'if (locked_vm + pinned_vm < RLIMIT_MEMLOCK)' ?

Otherwise MEMLOCK is really doubled..

Jason
