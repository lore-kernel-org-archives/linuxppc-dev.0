Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F477606A32F
	for <linuxppc-dev@archiver.kernel.org>; Wed, 18 Nov 2026 11:15:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=z/RwSVdv
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4jTzYS5SkTz2xns;
	Wed, 18 Nov 2026 22:15:56 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2607:f8b0:4864:20::1333"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1795000556;
	cv=none; b=iHUKmh96BlnIgcT9NWubTssaOCVtSCitmxmsQElvXnPyAeJf7TgBhy8Q3vWOKVXQU2zrW78LwGRnkNpSB56ql/Usxgfb+2uJdZLauCDwNPQqAL13gOIPioLyxzZvzOmAukMaNCpcGIN2uw8TFGez9tC6qx99EbQmqo2Zm1zo+kSnOEYbfzeozN5XciFkAN9qj53NJUENpAoPWe98S5DQodv4M1WJiMBqmtq7pKD9U/7Y0gUwuajm5sQLCZxOmS4vFN51wCpO7LXJEor4sSdTiJjI2ebSuj0FprcVBgt9GAkl0yiO0ntUcsRNbl2dLFKJM1Vz1hOekTMh9gxVMS3bzQ==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1795000556; c=relaxed/relaxed;
	bh=dxJkUC24im2bGryNLkAlqWRfHL6XOBwDY6Gegry7bnQ=;
	h=From:To:Cc:Subject:In-Reply-To:Date:Message-ID:References; b=NPHRbld5hZTWSX+FnEDX0PemWkpAQvIPG7pL5vVb9cLn6N8pK2Jscem9wSaDDBRj9elwfQcsETvgRH2FAScI9PNbOXQL7MUKUIS3ATI/+kOlld5cQil7KKWC3y+s8FNQ50+A3ojt//cXWp3LrArrLXCvE8yjdXZX8E0gRcnoXCfGKdw4GQK6SMh3B/ZmwWycNl2FRUQ+sn2JnrjlyfwAqSXnOGHgAwO9ZxFeLGLMkwWjoi9JRYTOAHvgVMS31RaXy4t8gsbjjPUQ85IEXTE6YazHIucpfKaSU234gx8RKf4Od7iCr7/Cewj1iHBue7Qtw61/8+/BIVlJh2Xn6kP7WQ==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com; dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=z/RwSVdv; dkim-atps=neutral; spf=pass (client-ip=2607:f8b0:4864:20::1333; helo=mail-dy1-x1333.google.com; envelope-from=ritesh.list@gmail.com; receiver=lists.ozlabs.org) smtp.mailfrom=gmail.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=z/RwSVdv;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=gmail.com (client-ip=2607:f8b0:4864:20::1333; helo=mail-dy1-x1333.google.com; envelope-from=ritesh.list@gmail.com; receiver=lists.ozlabs.org)
Received: from mail-dy1-x1333.google.com (mail-dy1-x1333.google.com [IPv6:2607:f8b0:4864:20::1333])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4jTzYR6C84z2xdV
	for <linuxppc-dev@lists.ozlabs.org>; Wed, 18 Nov 2026 22:15:55 +1100 (AEDT)
Received: by mail-dy1-x1333.google.com with SMTP id 5a478bee46e88-382c3c9671fso855275eec.0
        for <linuxppc-dev@lists.ozlabs.org>; Wed, 18 Nov 2026 03:15:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795000553; x=1795605353; darn=lists.ozlabs.org;
        h=references:message-id:date:in-reply-to:subject:cc:to:from:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=dxJkUC24im2bGryNLkAlqWRfHL6XOBwDY6Gegry7bnQ=;
        b=z/RwSVdvN76u3m9XuTRUPL0JmgCez1IKgK1Qb00X8wkSjAtSi4F/W4Y/p6awV6Tahi
         NWghA7GBgUQvHXBAGA+TCes52JZcI3VPzNDo/uHmzSmrkSapjMRvq8G0HcJ4ihfkwFtL
         5i0RCISLnw7yqOlAUd9jL93QVFPP0ENIPIvWtqAiyqTTFL/lmxr6DeRr/03NJV+h0nop
         Y5+VHPcJgtaerRIrZB2epdhgLyXCtdwagrIB06JoyYO0mmy4ur3mqveyY5TwskgxinG6
         6pWDRVy8f3bXjTBkzRK7JQQ3pp5Y49h6RvKvSwUFtNRxY+iMO/YO0Hesag4BRj9Dkq75
         d/rQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795000553; x=1795605353;
        h=references:message-id:date:in-reply-to:subject:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=dxJkUC24im2bGryNLkAlqWRfHL6XOBwDY6Gegry7bnQ=;
        b=deuWNI5hC0xfIEMfIkpc0BqvAtXO7SlQxfnfxZIxd9p4c8JL7MI7M/I1Iu0emew3Sk
         yPBrpxzbDYMiDsyYyUQ8WJzhvQo94UrDNEWF7ITqHwCHJOGj9ToH5VkfpUuolUxHuDuZ
         cmsmvY5s8qWzDzL2tNKUzoZiDjEedACedv7EBXJLksgNmkwpRKlxKPG0syec4Pkx4lZS
         5KyYPvUVIqN+6WKlDAjdjx/ES7rmVHVrctbKyo/hsDfpuPtBJn6mavk7zFsgqbeWWa6h
         6fgbbzlP02p7Grh1H0LVLp2Bw/dXONRpISQ4nvz75wt1xiZyrBnt9jJX3ujLWRhewWAP
         PqSw==
X-Gm-Message-State: APuU4Z9SRTEh2twf32038fzqIGykjn3LtkvDoZ20/FW6KF4/GZxYsHgl
	zIHDh858RUiLNjPCz7wICIAWSZchSMqXhi2f1jQ7POWgD5AEbXMqomvC
X-Gm-Gg: AZFdTZdTuwhOREyuXYqnqnXELmHq2xZVs/D4OiRJOK/Gnj2sK7TMV+mTK9Bl7q2W8Yc
	+mWRlUGU6py92ksWkm7DfHkHhB4fPqUoCmIhFRLU/AkC5qeoX6b6hi7iXYoF8GRSiMeuakVUIFX
	krFqxcAvVeFyWM3j2awo5W0mn39WZdBFU3DCTGhCMBZVA4U/X1dEsgeBaRFB45UPmkKHBDF0CID
	huW3M9DDldiWh1Q05JT9fjPF32eIq6A9E68JDD7p96evbKvHgkfTYUNN4KTtVOBzb5tRfAw+jFA
	qQAettp24ScoVswZYtcK6Hakx1bLTCAkukmZLycY0YRVAB+/x4dCRYamaG1TJL+/i4/T0xfKU4e
	NVelH37UwMWk4eENvoH4bwqY2XbQX3PgatQTrs/Dfwv9n/SfnqgdiwwHbuZMMrKQVN8yijTqddU
	c06WvLwu/vDy/8QRj1LTHuXGu2O6RGPYj2gYXwD0mAx3T7zNFMZNTaNSWysBgQ9C/SM+jYK9yZZ
	36rLg2DSZuFRXtWSb/mrvcVOgEeIWAzBWjWBl2DeRFpu9+ocJPWLX+rrei+0DokE4lwDxTxW/zM
	AtgVjlnvrfqTbMFPwwRjdas+5MA=
X-Received: by 2002:a05:693c:3881:b0:36f:83e7:fb7b with SMTP id 5a478bee46e88-38281cf6999mr2106174eec.40.1795000552950;
        Wed, 18 Nov 2026 03:15:52 -0800 (PST)
Received: from pve-server ([49.205.216.49])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-382a80bc19bsm7085645eec.29.2026.11.18.03.15.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 18 Nov 2026 03:15:52 -0800 (PST)
From: Ritesh Harjani (IBM) <ritesh.list@gmail.com>
To: Haoxiang Li <haoxiang_li2024@163.com>, maddy@linux.ibm.com, npiggin@gmail.com, mpe@ellerman.id.au, chleroy@kernel.org, sshegde@linux.ibm.com, farosas@linux.ibm.com
Cc: linuxppc-dev@lists.ozlabs.org, kvm@vger.kernel.org, linux-kernel@vger.kernel.org, Haoxiang Li <haoxiang_li2024@163.com>
Subject: Re: [PATCH v2] KVM: PPC: Book3S HV: Clean up on uvmem initialization failure
In-Reply-To: <20261118102012.2252221-1-haoxiang_li2024@163.com>
Date: Wed, 18 Nov 2026 16:44:01 +0530
Message-ID: <mrr675om.ritesh.list@gmail.com>
References: <20261118102012.2252221-1-haoxiang_li2024@163.com>
X-Spam-Status: No, score=-7.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,MAILING_LIST_MULTI,
	SPF_HELO_PASS,SPF_PASS autolearn=no autolearn_force=no version=4.0.1
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

Haoxiang Li <haoxiang_li2024@163.com> writes:

> When kvmppc_uvmem_init() fails, kvmppc_book3s_init_hv() returns
> directly, bypassing the existing error path. Jump to the existing
> error path to clean up before returning the error.
>
> Fixes: 175be7e5800e ("KVM: PPC: Book3S HV: Free allocated memory if module init fails")
> Signed-off-by: Haoxiang Li <haoxiang_li2024@163.com>

LGTM. Feel free to add:
Reviewed-by: Ritesh Harjani (IBM) <ritesh.list@gmail.com>


