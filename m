Return-Path: <linuxppc-dev+bounces-24858-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7A5CCC531FC
	for <linuxppc-dev@archiver.kernel.org>; Mon, 27 Jul 2026 06:16:57 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4h7pK36blNz2yhD;
	Mon, 27 Jul 2026 16:16:55 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2607:f8b0:4864:20::436"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1785133015;
	cv=none; b=JsnG6+ch3qlonZBPxNM2tWxHHXXDz/ylLdEcpLpGPcyQnSNWYD/rQM6RxNuS7fKGWeRzxA4BLkDGLa+tDrxOYqqXzRRgPmopzfVULPWVR9OG6j6CHlchCEYLi/xKCouujXr+8Fuqu7vbxvd3l06ec6Wxst0pCZax9VbaqxRiLzwl41BdW9IeG4woHJHY9fyq9v/kPqn4Zd2OFxzz3WR/LSlDKjn9tOfmW4HpB74+3vZr+vOU8vv4lVdO9r11IoExPDywv+8yrIiYpMo9LXZdDZjRIVK75XJPxImgrA4nelsID0FTkBc01kep4JDHlSIUVNE3+wA2DzE4KW7ILQI3Fw==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1785133015; c=relaxed/relaxed;
	bh=xkvd3GaxfP8zwg2THjBwEOUnMuoDnas1hdLWEj3iqG8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=NvciA9wtmAJQqZgf0mB6Jv8TjQ/TYD6xCZsB7J8rXYiAehuqjJKAvMx45Ei1jWenLX6bq7CUpXqQIKwHQTiK9blWpH8SsjEi6mK+/5HIcq8N2XdiKgmjtkOFi3UETQObhL+Q1rjh1Z7p+TdPnpSzeW69teQc23S6g15vHWGtLQCn7W3CF/ekYWLQ1RLzZDZxRk1zZIpAcQhPdIvrf2E5Ki/mGtl8FaC30Sun6bazpSFbSnqjvIPSPEUvuQv/1DErC3FaYfxBhdtEundlOq+romlAWaes5eXS25tPYtVZUVG3JRHLr1cvB+63S8tghTzHjbKbv+Yr9gELdC4QjhAiTQ==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com; dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=szO6Jcnl; dkim-atps=neutral; spf=pass (client-ip=2607:f8b0:4864:20::436; helo=mail-pf1-x436.google.com; envelope-from=mkchauras@gmail.com; receiver=lists.ozlabs.org) smtp.mailfrom=gmail.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=szO6Jcnl;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=gmail.com (client-ip=2607:f8b0:4864:20::436; helo=mail-pf1-x436.google.com; envelope-from=mkchauras@gmail.com; receiver=lists.ozlabs.org)
Received: from mail-pf1-x436.google.com (mail-pf1-x436.google.com [IPv6:2607:f8b0:4864:20::436])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4h7pK240ylz2ygn
	for <linuxppc-dev@lists.ozlabs.org>; Mon, 27 Jul 2026 16:16:53 +1000 (AEST)
Received: by mail-pf1-x436.google.com with SMTP id d2e1a72fcca58-84862b0d5f8so1737739b3a.3
        for <linuxppc-dev@lists.ozlabs.org>; Sun, 26 Jul 2026 23:16:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785133011; x=1785737811; darn=lists.ozlabs.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=xkvd3GaxfP8zwg2THjBwEOUnMuoDnas1hdLWEj3iqG8=;
        b=szO6Jcnl+IdGmRffxlm9rsbmCErk3vei8eF2gPg+snlj/UydtlqrjDjPxR4Xz3hlKO
         QHC/jGX66QPPBYjC1SakHTQfNozR8n3pIb5rAHL4o4OvRJnbTVs3UjX5Jj1Hgu1a7H+p
         Y0tG8go1/nWPwDjBT8C/mcovro/NHypaFd/HMwzrosQOt4Du0T5otnaCfJzooGlkBJQe
         tNNkbMO2xkV3Tu+TI9Py7pPAmInf45XVRM4kMEAuoYBfAuZvdA2RkIwMRNYcnrA6jVvU
         EQhz6JFkrKacngePFx8l8XxV0gLdG5lTRB8nnpCRW4RximMNkp++mK7RtB5PPdZJgSLc
         Vd3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785133011; x=1785737811;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=xkvd3GaxfP8zwg2THjBwEOUnMuoDnas1hdLWEj3iqG8=;
        b=A/oQdTvv/+7CwBpd7fQc6j1kH/hKkG5Nuyibs47hY8SByH1T5LFaTjNyXvYJpiSKmI
         3+ihjVD2/Yg8zVJtbF3jJY30yYh7RTwiyztIdVAQOWq8zvrL6g5bFXVNrHeVIps4goJ8
         GZLsS5WS1L8xQHxM8Azmltpw9VPI2d0Km/kGWtL/t4eso9cW8HFj733ZvaLv3FSYzJzf
         pZpXF3DxdFMMUPogf+8AyC1uDumKc19EOB//eYp0IZU/wwpGwy4ErJzkFEbedTAkCAOR
         mj6wEgGHyYREwRZyo3mOF0KkvAPOgeoXQ+eoW42eKaTDW8toQ0Qy9FkaJXH+sHbei7/s
         dwcQ==
X-Forwarded-Encrypted: i=1; AHgh+RrFs15ypjj1tBdjqnBzeDNZIRzBW64VNxA2F5KK1nratYZEjA+s/XXhh5rWuqlseU72cFpSQHEY+RZRgrw=@lists.ozlabs.org
X-Gm-Message-State: AOJu0YxFjKgwAYEmESx5fdgKDZ45PqeAOpwRK7yE+KXwRRIK/cAh1Y32
	QHhgqTfiw3Sn2CxStfEyFfQuX+0l85wnFKw+u37THznjxibu7y+eEbuGs1Wu6A==
X-Gm-Gg: AR+sD11WhqNI1MAVBXD/NV6+zansocQaOtDjh6Oke653bXYK0h5aBm0ewg8mih6ZcXo
	kQThdFv2A16TGzHqd4ZCcd2oPdVxEcDUMPFj6QoNkhculpbHbrecgiLfUysuIcR4S+JPl2E9rb+
	OFt6tVT8bZ3TwoAWb4PgtQEW9G8rjHni27/JqGxj2G4iIPFUN9Ob2L+a2Ct57LpQv8wl8yjmKZE
	zg8+5IwAy/LttOkRC8ugXAEVXDUP/MrVAT1p/UM8GkiI1ozifwjvcxb6e9BNtSLN4Ao4OP4m3bT
	my4BBwvAsARJ5IkZD5KrhVAYnAU7Cb3FMgWpsows2lnPKMT7J4rvrkS1R80JCvFbr4z/1s0gqtD
	72Z+GFq3qpd9YiFediB71LPjBx7KwQeIF4E5Ym8JfqU1FpsNbma+T264jYpWneuca8FVztm80Cv
	sYg0tdAXuB4m58MItOC0w0tp3PR5t1wsqPdRKtZk3mNXJn9w==
X-Received: by 2002:a05:6a00:4ac8:b0:84e:1db7:2f86 with SMTP id d2e1a72fcca58-84e59572bddmr5479084b3a.49.1785133011409;
        Sun, 26 Jul 2026 23:16:51 -0700 (PDT)
Received: from li-1a3e774c-28e4-11b2-a85c-acc9f2883e29.ibm.com ([129.41.58.4])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-84e5343a9c6sm2607131b3a.51.2026.07.26.23.16.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 26 Jul 2026 23:16:51 -0700 (PDT)
Date: Mon, 27 Jul 2026 11:46:42 +0530
From: Mukesh Kumar Chaurasiya <mkchauras@gmail.com>
To: Gou Hao <gouhao@uniontech.com>
Cc: maddy@linux.ibm.com, mpe@ellerman.id.au, npiggin@gmail.com, 
	chleroy@kernel.org, maarten.lankhorst@linux.intel.com, mripard@kernel.org, 
	tzimmermann@suse.de, airlied@gmail.com, simona@ffwll.ch, bharat@chelsio.com, 
	jgg@ziepe.ca, leon@kernel.org, akpm@linux-foundation.org, namcao@linutronix.de, 
	ynorov@nvidia.com, sshegde@linux.ibm.com, nilay@linux.ibm.com, clg@kaod.org, 
	linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org, 
	linux-rdma@vger.kernel.org, linux-mm@kvack.org, gouhaojake@163.com, kernel@uniontech.com
Subject: Re: [PATCH v2 1/6] powerpc/xive: remove dead NULL check after
 GFP_NOFAIL allocation
Message-ID: <amb3uArRk2MlHRuc@li-1a3e774c-28e4-11b2-a85c-acc9f2883e29.ibm.com>
References: <20260724022851.466017-1-gouhao@uniontech.com>
 <20260724022851.466017-2-gouhao@uniontech.com>
X-Mailing-List: linuxppc-dev@lists.ozlabs.org
List-Id: <linuxppc-dev.lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev+help@lists.ozlabs.org>
List-Owner: <mailto:linuxppc-dev+owner@lists.ozlabs.org>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Archive: <https://lore.kernel.org/linuxppc-dev/>,
  <https://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Subscribe: <mailto:linuxppc-dev+subscribe@lists.ozlabs.org>,
  <mailto:linuxppc-dev+subscribe-digest@lists.ozlabs.org>,
  <mailto:linuxppc-dev+subscribe-nomail@lists.ozlabs.org>
List-Unsubscribe: <mailto:linuxppc-dev+unsubscribe@lists.ozlabs.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260724022851.466017-2-gouhao@uniontech.com>

On Fri, Jul 24, 2026 at 10:28:46AM +0800, Gou Hao wrote:
> kzalloc_objs with the __GFP_NOFAIL flag will never return NULL, so the
> subsequent NULL check is unreachable dead code. Remove it.
> 
> Signed-off-by: Gou Hao <gouhao@uniontech.com>
> Reviewed-by: Wentao Guan <guanwentao@uniontech.com>
> Reviewed-by: jiazhenyuan <jiazhenyuan@uniontech.com>
> ---
>  arch/powerpc/sysdev/xive/common.c | 5 +----
>  1 file changed, 1 insertion(+), 4 deletions(-)
> 
> diff --git a/arch/powerpc/sysdev/xive/common.c b/arch/powerpc/sysdev/xive/common.c
> index dadd1f46ec939..f2904a5c2b7bf 100644
> --- a/arch/powerpc/sysdev/xive/common.c
> +++ b/arch/powerpc/sysdev/xive/common.c
> @@ -1134,9 +1134,6 @@ static int __init xive_init_ipis(void)
>  
>  	xive_ipis = kzalloc_objs(*xive_ipis, nr_node_ids,
>  				 GFP_KERNEL | __GFP_NOFAIL);
> -	if (!xive_ipis)
> -		goto out_free_domain;
> -
>  	for_each_node(node) {
>  		struct xive_ipi_desc *xid = &xive_ipis[node];
>  		struct xive_ipi_alloc_info info = { node };
> @@ -1158,7 +1155,7 @@ static int __init xive_init_ipis(void)
>  
>  out_free_xive_ipis:
>  	kfree(xive_ipis);
> -out_free_domain:
> +	xive_ipis = NULL;
>  	irq_domain_remove(ipi_domain);
>  out_free_fwnode:
>  	irq_domain_free_fwnode(fwnode);
> -- 
> 2.20.1
> 
Reviewed-by: Mukesh Kumar Chaurasiya (IBM) <mkchauras@gmail.com>

