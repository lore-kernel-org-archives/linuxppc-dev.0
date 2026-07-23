Return-Path: <linuxppc-dev+bounces-24718-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 945CBC531D0
	for <linuxppc-dev@archiver.kernel.org>; Thu, 23 Jul 2026 09:37:58 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4h5Qyr6xwJz2ygG;
	Thu, 23 Jul 2026 19:37:56 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2607:f8b0:4864:20::433"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1784799476;
	cv=none; b=atnWNxuxYXMezXDv9kCjjMonnRyuxygHUGsU2t6G2usLDDiL3gcotKV0HLU5Efj+YyDE+I65dpOfQFX5rEzgqCWqiOeXmwDNPS4JcMT7MvE/CGsk38LMXhoDlTIBLt69jABcpgANdxj+JfeEeW7tDyZGsrnIN7+ZslfhWUbz4N6UHcVhD7sOSTNSQLY9qv7WQtzdk5q6CTbYOA0epn1/zb85Nvg4XX747Bvn5nVJRuxh6uevcKQ/G+W22ptIoBSdfQoGYRgULJyzXuFcPasA7tgT8wf6Jfi1wnQPxklnDfUN/MtxwodrvAZche53KkV3LHg6qb1Q9qiIEjpWq1I/fg==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1784799476; c=relaxed/relaxed;
	bh=oPUgpb0frsnp1JVUTki2lmBuU8fGYW5E1pXwN+DTdbc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=DDL02wDrB3kplk0L4NYtKX9sLf5BYUh+DXmbhn+IRWRyg0y7oA0r5Pi3r8P6UcqBKS1Vfxd46IVxL4OuPsaNZcn3wDwxssziiHDJ9SDygAEeWKXbmz7fz78fk4+PyKOtTV6xTpKff3Zj9Cr7J6U0QuYRozjr9EgOlnql6ruIv/I/9o2Eq0Yt+z/TI6ngAExpEUvmsAdYtlPXYGqLPG2ipQo3WGzXvibkmQSm8/Y5AlomY6SqMd4qImTBZyfX15E/vggqv4xAwLsQwiUMGovZhZ9dVd/hf9DYh6lWw43Nyr7I6YU6bqztUHMrvNzdWOwQB2R8mKx84ZRzHKX52K/3iA==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com; dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=SiNdsaY2; dkim-atps=neutral; spf=pass (client-ip=2607:f8b0:4864:20::433; helo=mail-pf1-x433.google.com; envelope-from=mkchauras@gmail.com; receiver=lists.ozlabs.org) smtp.mailfrom=gmail.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=SiNdsaY2;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=gmail.com (client-ip=2607:f8b0:4864:20::433; helo=mail-pf1-x433.google.com; envelope-from=mkchauras@gmail.com; receiver=lists.ozlabs.org)
Received: from mail-pf1-x433.google.com (mail-pf1-x433.google.com [IPv6:2607:f8b0:4864:20::433])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4h5Qyr19qrz2xrL
	for <linuxppc-dev@lists.ozlabs.org>; Thu, 23 Jul 2026 19:37:55 +1000 (AEST)
Received: by mail-pf1-x433.google.com with SMTP id d2e1a72fcca58-84a2dcede83so545390b3a.3
        for <linuxppc-dev@lists.ozlabs.org>; Thu, 23 Jul 2026 02:37:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1784799473; x=1785404273; darn=lists.ozlabs.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=oPUgpb0frsnp1JVUTki2lmBuU8fGYW5E1pXwN+DTdbc=;
        b=SiNdsaY2hdsCD00KNmMG7UaObEoDgV7t/v4uGL6sxK5orwEilkGGkPdAr5cVS9kLt4
         rjAxAUTZxvb3KnwUaYzrnevdPUwM8DunT1D6wtu54xliTvnzPYY3S5uaIUIpFvJ9wMZf
         4ILr5wrsVDmC5uOXwzVFqQnqjEqOWMGAkwuQmMfw8e77uZg2bBh/eHTFL9XVxw1H1TgC
         yk1o4zSQP3ZHXnQ6k/PSkpGj5i/kzUCvDqIItQcHlStaMBIFAWGru9hhMISF7+4YAaQp
         +lPBBP0aRrRyGoTNNZm4SiIzeZLcuy5awnQzqIiK4azfiiWJZdylQmfZ+jMksGy5lcR4
         rAzQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784799473; x=1785404273;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=oPUgpb0frsnp1JVUTki2lmBuU8fGYW5E1pXwN+DTdbc=;
        b=Uq/SMo0EVOlWa21R0vWU+y8kf27CErzRpZm6LZKCN9DBYYMaTgk4kL+sf8RINJBotp
         8kLhVhC6OSDfX1kUk8YwWnSi0WyWoGZqeLtpNoIIiLZPhyLmxmCE4Kswf60lLr4hIv5p
         BY/4ifZyGWIJzZHxZ4lVAH9/bF/ORZRPRye2GxSxNBMGlAH7PoNjjXZ9jHqJLioJwooJ
         /KenwC60oJped6rCTGtSYmfSRZz+Uv+xSTZaDXQ6/uVg+0i2oaa/sVlmC/yrhxrpOlan
         GwpYA7aZaeKUCH+sbwzuoyYUUiciQC6aG/CdLrD5zx9BE/FgX2QDRI12j2CUnd+DQd4Z
         KkhA==
X-Forwarded-Encrypted: i=1; AHgh+Rqr2MMqmm2oP1ACdmTCWximyMgti9ZPo76a6uUbeplNDZpQ5DhSQc/TtYa90V9h1Rd0Y1R8eyf9o8T7fhE=@lists.ozlabs.org
X-Gm-Message-State: AOJu0YyocdgV2FyxQ2FIXW6bJt6H5qf1PlYmi8jNBBLOk8kwX4nR+MEC
	77x/GSr6N7PgLVDDgPEAgveQ9P2MCXrcMC88ZFJYpmWrfnnE9HbmQfcO
X-Gm-Gg: AR+sD13dIv17R65XkI3nvuizOa8TvBMuvKCwcudMoutrM0A1QbldzcGFJV5WsF4bLR3
	RQKgHjtqHJQw/S8HHkendMstclZ5LtTN5uCNi4EtcK/mNbx0gtM/Dx4oEuEZowfRsOricy7jf3b
	rNP0epuY+4mV5eGB3Aut0FPhFhHIqrBQwnl5Bi86UbbwLkfvJ+URLarKFvSOZRUFVDZ3dAo9fd8
	smyJqz5AK8m8JQDE3+s+sYAz65Gb1gPmbPukfcu0xwzVEQ0u9oIF/Yu9ivA259dTAf0K+wz4jyR
	9/KGR1agtQ9LxFrN5QBcu/aQjR0fGc+Jxw4hqtG/lWroa7XYEWjnXmv6JLwxm+Kl/oVJ/AzgWoV
	yw6OSSBI/+7ODTnGRJ52VAX9/AxJOeUXIODKqwpgTbM02Whwg1TDaRIKtOBhRf+P8XBj1Dz677v
	iT8G6UVfuP84p8xqQm4k0pRsr6qmji3yFe/K9AbWJ6dZpDqUli
X-Received: by 2002:a05:6a00:409a:b0:847:8650:69cd with SMTP id d2e1a72fcca58-84e2bd889a5mr3035099b3a.33.1784799472690;
        Thu, 23 Jul 2026 02:37:52 -0700 (PDT)
Received: from li-1a3e774c-28e4-11b2-a85c-acc9f2883e29.ibm.com ([106.51.160.24])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-84e175d4133sm2738565b3a.50.2026.07.23.02.37.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 23 Jul 2026 02:37:51 -0700 (PDT)
Date: Thu, 23 Jul 2026 15:07:42 +0530
From: Mukesh Kumar Chaurasiya <mkchauras@gmail.com>
To: Gou Hao <gouhao@uniontech.com>
Cc: maddy@linux.ibm.com, mpe@ellerman.id.au, npiggin@gmail.com, 
	chleroy@kernel.org, maarten.lankhorst@linux.intel.com, mripard@kernel.org, 
	tzimmermann@suse.de, airlied@gmail.com, simona@ffwll.ch, bharat@chelsio.com, 
	jgg@ziepe.ca, leon@kernel.org, akpm@linux-foundation.org, ynorov@nvidia.com, 
	namcao@linutronix.de, sshegde@linux.ibm.com, nilay@linux.ibm.com, kees@kernel.org, 
	linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org, 
	linux-rdma@vger.kernel.org, linux-mm@kvack.org, gouhaojake@163.com, kernel@uniontech.com
Subject: Re: [PATCH 1/4] powerpc/xive: remove dead NULL check after
 GFP_NOFAIL allocation
Message-ID: <amHgkkMT4nrWLSka@li-1a3e774c-28e4-11b2-a85c-acc9f2883e29.ibm.com>
References: <20260723081813.176792-1-gouhao@uniontech.com>
 <20260723081813.176792-2-gouhao@uniontech.com>
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
In-Reply-To: <20260723081813.176792-2-gouhao@uniontech.com>

On Thu, Jul 23, 2026 at 04:18:10PM +0800, Gou Hao wrote:
> kzalloc_objs with the __GFP_NOFAIL flag will never return NULL, so the
> subsequent NULL check is unreachable dead code. Remove it.
> 
> Signed-off-by: Gou Hao <gouhao@uniontech.com>
> ---
>  arch/powerpc/sysdev/xive/common.c | 3 ---
>  1 file changed, 3 deletions(-)
> 
> diff --git a/arch/powerpc/sysdev/xive/common.c b/arch/powerpc/sysdev/xive/common.c
> index dadd1f46ec93..79d7854259cb 100644
> --- a/arch/powerpc/sysdev/xive/common.c
> +++ b/arch/powerpc/sysdev/xive/common.c
> @@ -1134,9 +1134,6 @@ static int __init xive_init_ipis(void)
>  
>  	xive_ipis = kzalloc_objs(*xive_ipis, nr_node_ids,
>  				 GFP_KERNEL | __GFP_NOFAIL);
> -	if (!xive_ipis)
> -		goto out_free_domain;
This will be an unused label after this.

Regards,
Mukesh
> -
>  	for_each_node(node) {
>  		struct xive_ipi_desc *xid = &xive_ipis[node];
>  		struct xive_ipi_alloc_info info = { node };
> -- 
> 2.20.1
> 

