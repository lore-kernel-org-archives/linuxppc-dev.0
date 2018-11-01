Return-Path: <SRS0=OEx3=NM=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.0 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F37A1C0044C
	for <linuxppc-dev@archiver.kernel.org>; Thu,  1 Nov 2018 10:48:12 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 398BB205F4
	for <linuxppc-dev@archiver.kernel.org>; Thu,  1 Nov 2018 10:48:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="opHNDbaW"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 398BB205F4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 42m23s3wDXzF3N2
	for <linuxppc-dev@archiver.kernel.org>; Thu,  1 Nov 2018 21:48:09 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="opHNDbaW";
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=gmail.com
 (client-ip=2607:f8b0:4864:20::641; helo=mail-pl1-x641.google.com;
 envelope-from=bsingharora@gmail.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=gmail.com header.i=@gmail.com header.b="opHNDbaW"; 
 dkim-atps=neutral
Received: from mail-pl1-x641.google.com (mail-pl1-x641.google.com
 [IPv6:2607:f8b0:4864:20::641])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 42m21M1dR6zF3N0
 for <linuxppc-dev@lists.ozlabs.org>; Thu,  1 Nov 2018 21:45:58 +1100 (AEDT)
Received: by mail-pl1-x641.google.com with SMTP id o19-v6so8745149pll.12
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 01 Nov 2018 03:45:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:in-reply-to:user-agent;
 bh=ncfXRDAuuV0ZYDfd10356XalKCDeVE5F1APt++m+qT4=;
 b=opHNDbaW6l+w6u7rQWYTGOcGLM7wEYRMHvCYqsVZR/xsoj1jqJkm3e1iZCBGfTATDP
 MKoiH4B2fCcvG4Omrg8Z81KZ9vRT7fOuDBiWv4/kyoPedskuQcyb2+erEYw/U9NJR5Oz
 TAPCmllf9jZJuaVGV92kAeTvenZ0sbv4JO/A53fpJTQaIBKJphyu7b4orgWzb9U+oHOG
 RihWcHZC2BmQyiWmS4esJzguX5rpWfxdIG75uryXBWpTddFAlaB9hx4mcUP+/EoXsLAB
 XEAP5G/SXdW0XG0TzdEixKlXy7OdDoJPzcJJio1q+ehiVwuB7ASrxroXcS/hx0aVJCVt
 8+Kg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to:user-agent;
 bh=ncfXRDAuuV0ZYDfd10356XalKCDeVE5F1APt++m+qT4=;
 b=MTPbGKjjp1qRRssDzPMdeiRLxSo6C9/7BQS7TeX3zxJwVG1S5+4cbttMLNHU2ql+vE
 UQpM27bCHW+Ja66Zx9t79XA1lYl8N8oJ9hOa8Ln9jzJUSdauNezpzeqqCA8n93o9w6hX
 WgeSizcy6ZGHGVdCVP3KN7IOyqeuzJRj7zCyG2sEJ/udGqyYOiqcEaN11fNSYoGXybpl
 dXs1w1aI5yVTIre7tG+NXFPkAzbzZXjZ3VZLOlcCrs8/lORwfUYSiAfWeJ6WZ38uvCyz
 M6ErBalF3gDKRER20JGjm9GoEDofLSlSnhwe5qtGWi97q9WXY7cdrzG2O0HTLaw59KMX
 WagQ==
X-Gm-Message-State: AGRZ1gIJPssx46lyea7aXU6AV1jGj72BLPRoenyQ5F+SCzYT7IrdZ5z4
 keX+JtgfEUW50iuprADdcQo=
X-Google-Smtp-Source: AJdET5ebqzhHoVoLMxNAfG/+lku7YXUVBUHMldyJklAKSo+NuBGRj/fSBNPYy9t4kMo/c2wG8lqERQ==
X-Received: by 2002:a17:902:7484:: with SMTP id
 h4-v6mr6978255pll.227.1541069156786; 
 Thu, 01 Nov 2018 03:45:56 -0700 (PDT)
Received: from localhost (14-202-194-140.static.tpgi.com.au. [14.202.194.140])
 by smtp.gmail.com with ESMTPSA id
 h17-v6sm12032352pfj.125.2018.11.01.03.45.55
 (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
 Thu, 01 Nov 2018 03:45:55 -0700 (PDT)
Date: Thu, 1 Nov 2018 21:45:52 +1100
From: Balbir Singh <bsingharora@gmail.com>
To: Bharata B Rao <bharata@linux.ibm.com>
Subject: Re: [RFC PATCH v1 2/4] kvmppc: Add support for shared pages in HMM
 driver
Message-ID: <20181101104552.GE16399@350D>
References: <20181022051837.1165-1-bharata@linux.ibm.com>
 <20181022051837.1165-3-bharata@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181022051837.1165-3-bharata@linux.ibm.com>
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

So this is a special flag passed via the hypercall to say
this page can be skipped from page_out from secure memory?
Who has the master copy of the page at this point?

In which case the question is

Why did we get a fault on the page which resulted in the
fault migration ops being called?
What category of pages are considered shared?

Balbir
