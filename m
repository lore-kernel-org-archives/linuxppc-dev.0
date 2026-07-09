Return-Path: <linuxppc-dev+bounces-23941-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4FA98C43458
	for <linuxppc-dev@archiver.kernel.org>; Thu,  9 Jul 2026 15:55:30 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4gx00w5gqyz3c9k;
	Fri, 10 Jul 2026 01:55:28 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2607:f8b0:4864:20::1033"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1783612528;
	cv=none; b=jDZ2D2jJv49HiJFF77tX8LrS5rAu3K/04HKmj/GQt0C7PU8UQnIwrZX+A6KPe0cpmT2sUAl93wVg+xw/aeIXWNvrfs+rQ2zCq3P/LOsjRPr0II4+TuXApAmjFlCRLFeYsm54O6p8rPFCF772Wq6Lm98gkaTYzH4bO598uBLOmNo3UTcA17Qo60Yn3CWBCAGnlIfqvUyUxEW5C8nbBU6I+Qu6lPOCvYDoIkdZ74My11bXApBPkrCApTGOc1qrXZNjwjRdCd92hm8v1P/1QEEdOrM5Nw18+I2ngOf98pAVTCmPqTjLZchoJfU4zqzjrplK4VBtSZn/N1xHogZd4WGxLQ==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1783612528; c=relaxed/relaxed;
	bh=wCyya2sd3Nbuy5zuy6zvw9VrcqtHtZYtc/26a/Pi/PY=;
	h=From:To:Cc:Subject:In-Reply-To:Date:Message-ID:References; b=L36LSr8xpaIcuFhq7/a5MwIjEurCeUVpWr3WsuEDsnMT91/+DwxWOaSmyhWYggk3ZkZ7AsUFhff2R1s5iod7f0ZwOJco+VD5aUYXT0tbMWOqH2SW+qEuTMwfl9/4NEErbUpKEBGZqjCGoIB/m3v09euyWjIHip7kDhwuR1XWYbpsIYBS//vLlp77mq4uCLy8XJApzn7jKhXdX8WulOBO8krkA4QmhwiVgpKvdusRcYIdYS8z6xXm11xfQunmAyTVgSEuId1REsq4MMaSnKCB+4RPdMFU87RGVfmMQT4SY7VK7Gca8wN8z2fcsL7E2sdfdC3H4sIsi81l6icxIpNfQw==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com; dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=rkTEJvsI; dkim-atps=neutral; spf=pass (client-ip=2607:f8b0:4864:20::1033; helo=mail-pj1-x1033.google.com; envelope-from=ritesh.list@gmail.com; receiver=lists.ozlabs.org) smtp.mailfrom=gmail.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=rkTEJvsI;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=gmail.com (client-ip=2607:f8b0:4864:20::1033; helo=mail-pj1-x1033.google.com; envelope-from=ritesh.list@gmail.com; receiver=lists.ozlabs.org)
Received: from mail-pj1-x1033.google.com (mail-pj1-x1033.google.com [IPv6:2607:f8b0:4864:20::1033])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4gx00t6r0hz3c6b
	for <linuxppc-dev@lists.ozlabs.org>; Fri, 10 Jul 2026 01:55:26 +1000 (AEST)
Received: by mail-pj1-x1033.google.com with SMTP id 98e67ed59e1d1-38a0c7e841fso88869a91.2
        for <linuxppc-dev@lists.ozlabs.org>; Thu, 09 Jul 2026 08:55:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1783612524; x=1784217324; darn=lists.ozlabs.org;
        h=references:message-id:date:in-reply-to:subject:cc:to:from:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=wCyya2sd3Nbuy5zuy6zvw9VrcqtHtZYtc/26a/Pi/PY=;
        b=rkTEJvsI5+3iyebzQW8zEjwTI55QcyoZTG56w1T3u5kbi5N+nwHrvbpmTYLTioJHgI
         XnUh006QJpE2M0I3EV4eak5n2/dwx9YtHwqAGcSNSGgEJTEx5/tPTFyVkoF2lPVLOtyw
         wjydkRS3n16duuHzIPZ/Kvj36bKX+zdOPeAMe5YeDUE95WCVMDVMV79oeVUZWHGdpc/Y
         Cozw3jDWUOYNakCrxprBZOjXs6y/Rn7y5U/aBuI+gnpF4O+If8v6R1omFfS1mIf/yK4A
         IDpjzBZVSUJhNeEyao6iYGOGr5atoWFRj93E7X6PrgC/aaT/T/uJ69zNRhHLg9cWLXDa
         bYCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783612524; x=1784217324;
        h=references:message-id:date:in-reply-to:subject:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=wCyya2sd3Nbuy5zuy6zvw9VrcqtHtZYtc/26a/Pi/PY=;
        b=VrRFizNslYfn2Fnx9RtPEOW0lbkAlFS3mVf0HwVqTPEeFzQnbhBHlrSX1xIe1KdgXQ
         4TtFAzTTiPwouQPhYzJQo+5lm3xX6VNiZwN4GEXfgMDU0PDX2iYfcdQXlgFt7DvTYMH+
         AS8UsGY7XQYco3Ov9p3m12q44JAIdt9jfAaX0aXJPAKiIQBF9yZkoCXqyxO0vHBhFt+k
         cr+tfa5JauX+Uca68QRE3xT/oLgvSXVq/+yzdjb7xzElHcoYLuDnbzi5F6Ff8sOq7/qw
         MFHKdVwWLWqFlVaMS0fKVyUcxKlXfwS6zrlNIZbKj26NWEYaydwi8PtmzFsWNGM5R977
         OyRw==
X-Forwarded-Encrypted: i=1; AHgh+Ro9gEiXcyRjtJDTKfIQMACwylenMygb5HqS6FGA+p65oAloZBHk05R+xgqm8HfqLz0icx3+djvgmYXZszs=@lists.ozlabs.org
X-Gm-Message-State: AOJu0YyxWikHO8JrfaGFR9KuUWJRMuPxmEmij5GjSFBCBp/xbz9e1HjY
	sLS4PS+dOoV9imUJe1YS9BNyL+4grkpyCbnp5wmOdiO25NZpZYtb6fwk
X-Gm-Gg: AfdE7clf8GdRZ6zRwOwskRGo9ZWROILylp7fdrN9SXW+txRQZm+EijljXPBaQfqgRYP
	bjBSjcqTAkw6HN+DkKpfY4U1RE1OZlqEdAoVaffJ4ARyEsL5Oo93upduH4UV5532N6A3tvyhBVS
	GHxZO8uRGkWe2G4X0wOCm3zpoT2He8lqUlG+nnx/mw9h3jUrUwq3xYCUeecy1mF31FhcNIjxabh
	8Cilf1+jL3r6DoA6mFZ27DKRU8Bsj7Ke0j16sWkcOPecS8TCPZ+25dX4bwzT38rJefLB2+MtFNR
	JmmXBkEWQEnpv5Ze+vxTGgx/8OmmHi6+rwgzmWRTeVNEhQsLGi1gv1gMsTtIRT17oMWx3b//UpX
	qq8vP3y1TtkMdXacJ7GHUnnxiD0qWpnjakSprLfS29+LNQuv+A5I94W/iHZk5NOwJfhq9SLPyq/
	Rkvy3jaakCaKk=
X-Received: by 2002:a17:90b:2641:b0:387:e0db:3fab with SMTP id 98e67ed59e1d1-389424990fbmr8089510a91.36.1783612524554;
        Thu, 09 Jul 2026 08:55:24 -0700 (PDT)
Received: from pve-server ([49.205.216.49])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-311b00048a3sm2489614eec.5.2026.07.09.08.55.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 Jul 2026 08:55:23 -0700 (PDT)
From: Ritesh Harjani (IBM) <ritesh.list@gmail.com>
To: Sourabh Jain <sourabhjain@linux.ibm.com>, linuxppc-dev@lists.ozlabs.org
Cc: Sourabh Jain <sourabhjain@linux.ibm.com>, Aditya Gupta <adityag@linux.ibm.com>, "Christophe Leroy (CS GROUP)" <chleroy@kernel.org>, Hari Bathini <hbathini@linux.ibm.com>, Madhavan Srinivasan <maddy@linux.ibm.com>, Mahesh Salgaonkar <mahesh@linux.ibm.com>, Michael Ellerman <mpe@ellerman.id.au>, Nicholas Piggin <npiggin@gmail.com>, Shivang Upadhyay <shivangu@linux.ibm.com>, Venkat Rao Bagalkote <venkat88@linux.ibm.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] powerpc/prom: Remove redundant early_init_dt_scan_root() call
In-Reply-To: <20260418091250.134111-1-sourabhjain@linux.ibm.com>
Date: Thu, 09 Jul 2026 21:24:02 +0530
Message-ID: <5x2ow44l.ritesh.list@gmail.com>
References: <20260418091250.134111-1-sourabhjain@linux.ibm.com>
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

Sourabh Jain <sourabhjain@linux.ibm.com> writes:

> Commit 554b66233623 ("of/fdt: Scan the root node properties earlier")
> moved the invocation of early_init_dt_scan_root() into
> early_init_dt_verify().
>
> early_init_devtree() already calls early_init_dt_verify(), so the root
> node properties are parsed before reaching the explicit call in this
> function.
>
> Keeping the call here results in scanning the root node twice. Remove
> the redundant call and rely on the invocation from
> early_init_dt_verify().
>
> This change keeps the behavior the same and removes an unnecessary
> duplicate call.
>

yup. Nice catch! LGTM. Feel free to add:
Reviewed-by: Ritesh Harjani (IBM) <ritesh.list@gmail.com>


