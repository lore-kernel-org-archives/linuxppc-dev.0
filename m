Return-Path: <linuxppc-dev+bounces-24886-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E6926C531D0
	for <linuxppc-dev@archiver.kernel.org>; Mon, 27 Jul 2026 11:32:51 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4h7xKZ0vH1z2yhY;
	Mon, 27 Jul 2026 21:32:50 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2607:f8b0:4864:20::430"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1785151970;
	cv=none; b=bU0QFwDkBoL45Jq8BuNM2c2iebRFhEa/g7EKv9aygZuXo/KWzdyD7d6dec42liEqFa5llt+Cxv4HCUmsMwoZQu2xdzLmfxZ7xZ3HaL7S18pcl4mPGR6p6l0kZts6nsVYuMndRRwmtJiXT2/b70c710rd0+xR71EvKKJcdSb2EV+FuxBX6TOOHAVB65PsgjTgTtnp7yKzPD5ICseNiVP0RZk9+DO9xGyXUs5w2YTSS5CxUMapyJotnMBgvsMbZeMYpF6vdWZ5oNSBkvg6Jm0ZrMHUnUvaDMun9xO9sxqAEtu2zy46vv4S090Pr4htM9UB8JZrmljQM3b4ksvmWc3xNQ==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1785151970; c=relaxed/relaxed;
	bh=zEenGUm5RioXWNnfd2RzwGu/SqP7QkoWXITZGeqYw+o=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Njdj/FQOYhLnwolY3+i192Bh2ftk78aFYHjn9RIvkBYCNXbKzbo738YOZV22+pEtllEuVMA4E8S/5sXv4SZGt9Ks6qwvRiW6K40iLWSWBaVIboxmkoNcCi0i5bMuuvfhN/YerwUvNcFRhTp43ATtgEMydw9rbM0W/vRsZpAuyA27QLwGrE+urtX5edP23TmFOkXESRDxQV2Z7yBT0bX/3jI0r32Mtzw7v1/pkcOuVWc4ZdleWJdb66flEiB7LTrqRe+eqIirNDVqIuXBs+05JxMWYjF2oYumxgjMA5l8ypBkHjNrRq/WMwlK4g0ONNm0rmhxP6Al0+3n7/eLEb/83g==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com; dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=SXIGb6Op; dkim-atps=neutral; spf=pass (client-ip=2607:f8b0:4864:20::430; helo=mail-pf1-x430.google.com; envelope-from=error27@gmail.com; receiver=lists.ozlabs.org) smtp.mailfrom=gmail.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=SXIGb6Op;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=gmail.com (client-ip=2607:f8b0:4864:20::430; helo=mail-pf1-x430.google.com; envelope-from=error27@gmail.com; receiver=lists.ozlabs.org)
Received: from mail-pf1-x430.google.com (mail-pf1-x430.google.com [IPv6:2607:f8b0:4864:20::430])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4h7xKY17cGz2yhD
	for <linuxppc-dev@lists.ozlabs.org>; Mon, 27 Jul 2026 21:32:49 +1000 (AEST)
Received: by mail-pf1-x430.google.com with SMTP id d2e1a72fcca58-84a652535dcso1435463b3a.3
        for <linuxppc-dev@lists.ozlabs.org>; Mon, 27 Jul 2026 04:32:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785151966; x=1785756766; darn=lists.ozlabs.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :content-type:mime-version:references:message-id:subject:cc:to:from
         :date:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=zEenGUm5RioXWNnfd2RzwGu/SqP7QkoWXITZGeqYw+o=;
        b=SXIGb6OpeouA7qUNduKtk7roiVd4kNIC4IkVX8jQxnapok6infwVP+tsuPc7LUhb2u
         u6ujT1o/bBAAd4+ZqUh9CYdIgomG6tRGvP3gUUfNBiWZh/UWH5ROfnxql+PkDzfgurFh
         jlqYdnnuAzCgBrZ9QkON/Ia30NWinLoEW9GQvzM0km1E31WSO05E2K8yfjVne6Xtbka6
         NkSUfCaPwQS3JFE7qXIcvsyq4HtBMSCY9+zqbiTWnmFgcuvEwrzUY5/6PNI5GcvZ9DY2
         4XA7lpW8mR2u8irUDAfnBn9oBN5w0twKAWKyhoeLAhaOjjj0Cs05B2MQkgYIFCYO3tH+
         TE1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785151966; x=1785756766;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :content-type:mime-version:references:message-id:subject:cc:to:from
         :date:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=zEenGUm5RioXWNnfd2RzwGu/SqP7QkoWXITZGeqYw+o=;
        b=gVvlbOpeBqDTDdLGrHnftYah7JXXqCZcNrxqE2n+p5uhtA8K7uyz1C78FnY04K7ibg
         jUSDQlELPnPmcPG24T/i7WZJ7uuH56xyfEcnIAMZmwNpFAepccTrHpvHtVHb1rm2z1IT
         IeY5eaQtHwzi2ydQih1Aw7EUeA/GFmYCgLaTBxPcURXwq39eYc7n8wo7zxxQ2UtdmfKM
         NDOu7K0mknf+BdCXu8Pi29SceqBcUubCz+/DeqjHggX9YN7/LLQc4YiePzPqKw2rvNtf
         qQqMOYxbDFb98kj8inE83+ARcmJOoG3ki6o5rU1Jzr1ZkEo8dZ5+rX1K60xxSSzl2jl8
         vw9Q==
X-Forwarded-Encrypted: i=1; AHgh+Rq9fOkYUaGPGpLn3pxxFnSP1s3Zs//WazZ6trByB7kXtgGfQkHzZlQ7qP7E8COkVmEnhyUpid3uWKERMLw=@lists.ozlabs.org
X-Gm-Message-State: AOJu0YxjjTA8WbvMmAxdIZNxyHC0bYzdbr6goFBeydnbrIJTrPUWIIbY
	GqlmF/qqj3CoZjfcBJZhkzYY+MPa1eL+gnuKcc18PbTDJOWg5iTe7EIs
X-Gm-Gg: AR+sD11qHSNqduNvXVlD5p277iih54lx+FGONIJYuAeQ+Saz3zaFKqcLeLFe0QOSMN0
	0qDfFQtLiZWdObOAQbyAR3tJdo6g3AiyxH0HbaGAlMr+hsIq68YJ1bm4JbidEmbIbYT1mpiRFJb
	KezZ1n+SN1+zYnMcgXUOkrL6fXqlW5zU57iGnHC36ebZFpbADrbw3JfPC31HayT0rf7VFEQNP1D
	37TlKSPe0QDu1j1ycI7aE60HywrPaZC0hvI7Qrp0tLhzv/RXgGK9/mIdhxALOQGW6X6pVqVGnA0
	2OCoSheCwSxgOWL0JQwSx3MIfoZzinv/aK2eBQubWr5AT9TIefa/yq78T1S5iRWTUbuEf9Sshig
	N73jNMAWMIFzGf/dkAf7LyVgwuk034QPqbh84cFEM9iGU8Jelm3F7Hlc44fidjpe1d0XpoawE/j
	nVSjzE9vc=
X-Received: by 2002:a05:6a00:f03:b0:848:469b:3d19 with SMTP id d2e1a72fcca58-84e59462fcemr6582221b3a.29.1785151966109;
        Mon, 27 Jul 2026 04:32:46 -0700 (PDT)
Received: from localhost ([172.216.252.11])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-84e53253d70sm2900157b3a.2.2026.07.27.04.32.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 Jul 2026 04:32:45 -0700 (PDT)
Date: Mon, 27 Jul 2026 14:32:40 +0300
From: Dan Carpenter <error27@gmail.com>
To: Markus Elfring <Markus.Elfring@web.de>
Cc: linux-arm-kernel@lists.infradead.org, linuxppc-dev@lists.ozlabs.org,
	Christophe Leroy <chleroy@kernel.org>,
	Roy Pledge <Roy.Pledge@nxp.com>,
	LKML <linux-kernel@vger.kernel.org>,
	kernel-janitors@vger.kernel.org
Subject: Re: [PATCH v2 2/2] soc: fsl: dpio: Use scope-based resource
 management in dpaa2_io_create()
Message-ID: <amdB2K43gRBDhBPI@stanley.mountain>
References: <690827f2-e746-4378-bb7c-9948cd69dc15@web.de>
 <d95d2f4c-f3cf-44eb-b61b-79ba7891674d@kernel.org>
 <d2e5df25-c8b7-4ee6-8ebf-1725542baabd@web.de>
 <f47abd6e-9337-404c-a24f-39a9dd7454d2@web.de>
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
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <f47abd6e-9337-404c-a24f-39a9dd7454d2@web.de>

On Mon, Jul 06, 2026 at 12:40:09PM +0200, Markus Elfring wrote:
> From: Markus Elfring <elfring@users.sourceforge.net>
> Date: Mon, 6 Jul 2026 11:18:39 +0200
> 
> Scope-based resource management became supported for some
> programming interfaces by contributions of Peter Zijlstra on 2023-05-26.
> See also the commit 54da6a0924311c7cf5015533991e44fb8eb12773 ("locking:
> Introduce __cleanup() based infrastructure").
> 
> * Thus use the attribute “__free(kfree)”.
> 
> * Omit two kfree() calls accordingly.
> 
> * Reduce the scopes for the local variables “obj”
>   and “qman_256_cycles_per_ns”.

Why?  No one does this except bcachefs and that was removed.

regards,
dan carpenter



