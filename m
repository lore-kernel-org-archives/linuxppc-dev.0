Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3675B606A31A
	for <linuxppc-dev@archiver.kernel.org>; Fri, 30 Oct 2026 00:43:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=qqE9WJyB
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4jG2QB3FkDz2yYK;
	Fri, 30 Oct 2026 11:43:14 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2607:f8b0:4864:20::1234"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1793320994;
	cv=none; b=jHSzH60iD1GB+dOOPi9SnxiWbQM5aX+caEM8jC8/UV8RKEOysy1PynVNhl+DVb6j2xDbLZmxDEGfOSY+DgyUINeCi2rrlTI+sIW6WuNnKL/LUZgrLe9Q2kOZUadBd60FJjPXChgejhfUvkUIr3W7g2nr+N/uTdPEc0blFe7wb0m+kdIZVEQnCz0EN21e+Cs8caFgGROOIBcSMFVWYU4RV9UrOXUmGnU+Ruvlj1ZZmejgbCO6NAhZzNqt87v2jwqKXlBkVj5A7cgxSIG6fRqjF2PgGXlX1rioJwC6BoHO7MUzh3F7I2mEFMxCwY/vW5KmXe47wyP2ph8h0f9ATNNkKA==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1793320994; c=relaxed/relaxed;
	bh=A1dnHGd/ojY9RvLwvT0//fyZZl5qZJVT0RGCrdHRWvM=;
	h=From:To:Cc:Subject:In-Reply-To:Date:Message-ID:References; b=GGU7AfdsGRwUUJzgMqoQELKl+fYW41CEVmQv0QqPc7DO3QFM7Ssb/FKbocO4IM/t0c2VkzNpUWA/BKFmH7NRov+jgWPMjCJGl16lx2sKhFI0k40MtIw9Ch5aBPdgL/TWmnOXH2rUlafd2jEYIqX0oK3kPNA6XNIehKxR20dLm44IbVrjER2kKelZpb++v/9Dy9ZVA7tVAAdIthtBCNQ+t/18hGuda0kOGBJyAVgvCvsmJ4iixYGQwCX7Jyct6EMBDPqPU572NdhYUQbvg2meD6rY8d/w8MzPnBPrTvJ7jSAs/zQgWorTJJESnzl4codWgVOEHWhVw+T40X2BqoKdxw==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com; dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=qqE9WJyB; dkim-atps=neutral; spf=pass (client-ip=2607:f8b0:4864:20::1234; helo=mail-dl1-x1234.google.com; envelope-from=ritesh.list@gmail.com; receiver=lists.ozlabs.org) smtp.mailfrom=gmail.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=qqE9WJyB;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=gmail.com (client-ip=2607:f8b0:4864:20::1234; helo=mail-dl1-x1234.google.com; envelope-from=ritesh.list@gmail.com; receiver=lists.ozlabs.org)
Received: from mail-dl1-x1234.google.com (mail-dl1-x1234.google.com [IPv6:2607:f8b0:4864:20::1234])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4jG2Q92CVXz2xSl
	for <linuxppc-dev@lists.ozlabs.org>; Fri, 30 Oct 2026 11:43:12 +1100 (AEDT)
Received: by mail-dl1-x1234.google.com with SMTP id a92af1059eb24-19305bcb72cso113075c88.1
        for <linuxppc-dev@lists.ozlabs.org>; Thu, 29 Oct 2026 17:43:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793320990; x=1793925790; darn=lists.ozlabs.org;
        h=references:message-id:date:in-reply-to:subject:cc:to:from:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=A1dnHGd/ojY9RvLwvT0//fyZZl5qZJVT0RGCrdHRWvM=;
        b=qqE9WJyBlHHqfa4xCY2CgVPena8NIQNF63GqhXclczQK6h9BFv5tR1fkzGYcSOzF/r
         CySgipYVGMzs9gESdaLvBqzn/B3Uu9vtNxQCJOxp90Yok2hTIGPCh4pcbTVzhH3G/2RQ
         IXVbwWoVIxxz0RDUIkbJvphp1D3pLDRSlR8r96+2JtsZb4+5u6PZV9svT+MJIxGL7KIv
         wwVGz3DNFtSEU4ZNqgb33DR44o+HnRe+0NcigPAYNP/XRnpgeAPdxxAj+gJKot+SaBpl
         yjpByRQmzTkqC0gPS5TU5JpMcZOlncIPVPfBACBSOrH3F/WbtVpP2DwUGHYrX+wqQB+F
         aCpg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793320990; x=1793925790;
        h=references:message-id:date:in-reply-to:subject:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=A1dnHGd/ojY9RvLwvT0//fyZZl5qZJVT0RGCrdHRWvM=;
        b=AD+Oz/eQ9VUNXdXlXhFnJ+PysJbf2pBqULVuxWX9kyFdh38f7QfHIg6PECPBh5vRb1
         Z6xqJcVR04GinhPMPkgnIvZOyYxSHuPCxZgWQSaZCXt8cWW6EsKhxPghfGQvuZmJ0eVU
         RU5QZ+nd4UacdvvNygwUplVXbhfCHyEe5xfu/C5llYOylk4Akd8T+hgibRkQxTQoL0DA
         QLzhY+ozDCXxERmyZ/zwFn9CNl5miZSmUj+e4m7+tM2BVrYIFSa+p3bplh5ZMS3svk4Z
         fvpxIjqFK61zTjbhCMo8ONrD5tbytFbcmKMjt4eZ521GrY6ygFzO5EjmdMGmEi5Rpy03
         2BSQ==
X-Forwarded-Encrypted: i=1; AKwUvBxP3k45kSsi84UVqNx4MW7H99Md6z1s6Y7lN9foa8kqraDNl0xByqthSLeXLLzGTxa43OryBjJ9otOOWIw=@lists.ozlabs.org
X-Gm-Message-State: AFq9FYJaBNmIxAWPCHwYyKk2tt6Yl2R5Orsb7quxW3mmJfUopg8vlHCF
	GpsSn37cFCfbCJ0Jkz/XZ+g+iflHYnuJIV1ZRecmwkC4hDoOgB7EIoVz
X-Gm-Gg: AYBFou2gMoqR9xB1H05qq2mVJHsGnFYk9tpDSnK2fuD+A4cKUux57LITHGcFlHNScvB
	ov9msVPUQz2zy4omcWHlFh/5Pwrcl8hz+pAY2cliDI0+rxYp9TtuxrWqDK7lYLGm5+gm7K6wuDW
	Dr8JXDtNz+K666/yfEuf0H9gW5zZhkBKes4IZQE1gT5bzj3OLonQTLyEvHjfs6t0TXcjRutzCYp
	yGVFy0YExqkXZjDaPVfMlmFstL99+NeaEvM+yMdYMT1FH4vYL0QtQzvBimRr55jIO5O/3k3sOuw
	0aRLyKBkqKq8cR4UnTKHO0MTvepMPIqqM4JjUOYcwZwdufjO7SJr+KN0DJDVZZ9y76v4roYA7Gz
	IzVZzDATHWhlzWpe4CWcUf5VqwZ0HCn4wr94PTD45lQ++Yoq01P01leDA81x5MUWquJ44E2MXvK
	AD+Kui9gNuDNZ8SHpcz0NuYHZAa2C/31/BFzYGit3JKzvmHRvCovgZNzJox+rckiL+OSPAT29v7
	OIxO6WxRse4l8/G2ItCx/ipUCjX9+5Vx+0voCrCgdw+ANKrGi1sGv9zBSZX7ybcTCxXzPNeslOT
	42WpGA6AspGyNsjR6lcifN0Iek00otIBusCIJXXvzJmfCZwe
X-Received: by 2002:a05:701b:240f:b0:15e:6541:3099 with SMTP id a92af1059eb24-1ac5a0b8b3amr917862c88.7.1793320990113;
        Thu, 29 Oct 2026 17:43:10 -0700 (PDT)
Received: from pve-server ([49.205.216.49])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-1ac18458e07sm2097351c88.8.2026.10.29.17.43.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 29 Oct 2026 17:43:09 -0700 (PDT)
From: Ritesh Harjani (IBM) <ritesh.list@gmail.com>
To: Jiale Yao <yaojiale02@163.com>, Mahesh J Salgaonkar <mahesh@linux.ibm.com>, Oliver O'Halloran <oohall@gmail.com>, Madhavan Srinivasan <maddy@linux.ibm.com>, Michael Ellerman <mpe@ellerman.id.au>, Nicholas Piggin <npiggin@gmail.com>, "Christophe Leroy (CS GROUP)" <chleroy@kernel.org>, Shrikanth Hegde <sshegde@linux.ibm.com>, linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
Cc: stable@vger.kernel.org
Subject: Re: [PATCH] powerpc/eeh: NUL-terminate force recovery input
In-Reply-To: <20261029052948.2525048-1-yaojiale02@163.com>
Date: Fri, 30 Oct 2026 06:11:38 +0530
Message-ID: <ecd8vx31.ritesh.list@gmail.com>
References: <20261029052948.2525048-1-yaojiale02@163.com>
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_PASS,SPF_PASS autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1
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
Precedence: list
X-Archived-By: <archiver.kernel.org>

Jiale Yao <yaojiale02@163.com> writes:

> eeh_force_recover_write() can fill its entire stack buffer from userspace
> and then pass the unterminated data to strncmp() and sscanf(). This can
> make the string helpers read beyond the buffer.
>
> Reserve the last byte and initialize the buffer so every accepted input is
> NUL-terminated. Propagate copy errors before parsing as well.
>
> Fixes: 954bd99435b8 ("powerpc/eeh: Add eeh_force_recover to debugfs")
> Cc: stable@vger.kernel.org
> Signed-off-by: Jiale Yao <yaojiale02@163.com>
> ---
>  arch/powerpc/kernel/eeh.c | 6 ++++--
>  1 file changed, 4 insertions(+), 2 deletions(-)
>

Nice catch! Thanks for fixing it.

LGTM, so please feel free to add:
Reviewed-by: Ritesh Harjani (IBM) <ritesh.list@gmail.com>


