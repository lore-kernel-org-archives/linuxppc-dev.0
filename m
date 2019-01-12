Return-Path: <SRS0=eeko=PU=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 90CF6C43387
	for <linuxppc-dev@archiver.kernel.org>; Sat, 12 Jan 2019 00:32:22 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D58FD2084E
	for <linuxppc-dev@archiver.kernel.org>; Sat, 12 Jan 2019 00:32:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HZ1Wn1oH"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D58FD2084E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 43c1033gbczDr7C
	for <linuxppc-dev@archiver.kernel.org>; Sat, 12 Jan 2019 11:32:19 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=gmail.com
 (client-ip=2607:f8b0:4864:20::443; helo=mail-pf1-x443.google.com;
 envelope-from=bsingharora@gmail.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=gmail.com header.i=@gmail.com header.b="HZ1Wn1oH"; 
 dkim-atps=neutral
Received: from mail-pf1-x443.google.com (mail-pf1-x443.google.com
 [IPv6:2607:f8b0:4864:20::443])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 43c0yG3FkwzDr5X
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 12 Jan 2019 11:30:42 +1100 (AEDT)
Received: by mail-pf1-x443.google.com with SMTP id z9so7704361pfi.2
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 11 Jan 2019 16:30:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:in-reply-to:user-agent;
 bh=Pi9VOAle/zalxoreH3upjHwyyBtpjaKJishRZNpqXEM=;
 b=HZ1Wn1oHvVn+GxYmyduszSgaCVYXEXWmbn++ClmxN4XSgr2hKQIfpl3hJCz+L660cQ
 jmBuQ9uXVrpzH6B4d0xJUIVOb8z0LDe1a1D5X3sHa27KRG1Y1jZtkgrhC8XNvcDkTWMs
 nmGL7yghcDGCxseBMMgyOd7YVzhMFT30jVrPQXCQqO/wsZ5v3WJeoBWx7cDxzVS79R7F
 C5CHLTCdwiDOnD2mco8l/U3mMB+C9eyVZ56XuAQtzl8jaL5YeMFZSG+/pMScWnkYABs3
 KcP/my4/9LeOzv0UdlNlHZbSLEnhhWGCE/HL9wl7x+MD/FwXCfM3I27uE+O5zIvpRoDH
 01HA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to:user-agent;
 bh=Pi9VOAle/zalxoreH3upjHwyyBtpjaKJishRZNpqXEM=;
 b=BhwFA7XL/N10krLbLrnP7ptTOcKgW1BHMHiAypOeqprBcdwMQy26Gr2lZBc6+5h6lh
 hjOB7flQdZ9G3vXwZDmRANrhSpC9lipFv+Xe1bQVyzZTfPign7nbk4WH3njlzWNO7Ikw
 IEI3RAp73IR778I6WThHTQ83LpV7pDo1MqWQpbC5xlbbha+Zsk1jyoZwJ4EcOB4Znizd
 fZ5Y9ZARceumugtCUaHOQpKv1Aq5BE2V3Pkl7eFGrE2llXhltnFlbbBtnnW3oqltZOGI
 iSGV6iWKrZ1drhkApFs4d36UGCdqpKGO5ASaOrY4uAddzK8j8wf+85jumsNjU3cIZxbF
 9reQ==
X-Gm-Message-State: AJcUukfOfe4xk3Sik1BCVhS1elEq6HP/9xLTh5DHoxpImo0DtMDGHAF9
 ltf8GNZW9bxPwGjkLqLW8gU=
X-Google-Smtp-Source: ALg8bN4KxPHotRvUh8kpC75ihQW+aP3ktofUgJWQTESriw8ETgGl7S/qYh6iew1cysswmsV1c8KBlA==
X-Received: by 2002:a63:6442:: with SMTP id y63mr15171875pgb.450.1547253040596; 
 Fri, 11 Jan 2019 16:30:40 -0800 (PST)
Received: from localhost (14-202-194-140.static.tpgi.com.au. [14.202.194.140])
 by smtp.gmail.com with ESMTPSA id
 v184sm110275001pfb.182.2019.01.11.16.30.39
 (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
 Fri, 11 Jan 2019 16:30:39 -0800 (PST)
Date: Sat, 12 Jan 2019 11:30:35 +1100
From: Balbir Singh <bsingharora@gmail.com>
To: Dan Carpenter <dan.carpenter@oracle.com>
Subject: Re: [PATCH] powerpc/powernv/npu: Allocate enough memory in
 pnv_try_setup_npu_table_group()
Message-ID: <20190112003035.GA10427@350D>
References: <20190109102328.GB5476@kadam>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190109102328.GB5476@kadam>
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
Cc: Alexey Kardashevskiy <aik@ozlabs.ru>,
 Mark Hairgrove <mhairgrove@nvidia.com>, kernel-janitors@vger.kernel.org,
 Paul Mackerras <paulus@samba.org>, Alistair Popple <alistair@popple.id.au>,
 linuxppc-dev@lists.ozlabs.org
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

On Wed, Jan 09, 2019 at 01:23:29PM +0300, Dan Carpenter wrote:
> There is a typo so we accidentally allocate enough memory for a pointer
> when we wanted to allocate enough for a struct.
> 
> Fixes: 0bd971676e68 ("powerpc/powernv/npu: Add compound IOMMU groups")
> Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>
> ---
>  arch/powerpc/platforms/powernv/npu-dma.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/arch/powerpc/platforms/powernv/npu-dma.c b/arch/powerpc/platforms/powernv/npu-dma.c
> index d7f742ed48ba..3f58c7dbd581 100644
> --- a/arch/powerpc/platforms/powernv/npu-dma.c
> +++ b/arch/powerpc/platforms/powernv/npu-dma.c
> @@ -564,7 +564,7 @@ struct iommu_table_group *pnv_try_setup_npu_table_group(struct pnv_ioda_pe *pe)
>  		}
>  	} else {
>  		/* Create a group for 1 GPU and attached NPUs for POWER8 */
> -		pe->npucomp = kzalloc(sizeof(pe->npucomp), GFP_KERNEL);
> +		pe->npucomp = kzalloc(sizeof(*pe->npucomp), GFP_KERNEL);

To avoid these in the future, I wonder if instead of sizeof(pe->npucomp), we insist on
sizeof structure

pe->npucomp = kzalloc(sizeof(struct npucomp), GFP_KERNEL);

Acked-by: Balbir Singh <bsingharora@gmail.com>
