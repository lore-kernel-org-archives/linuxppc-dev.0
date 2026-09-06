Return-Path: <linuxppc-dev+bounces-26612-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 83767C79F8B
	for <linuxppc-dev@archiver.kernel.org>; Sun,  6 Sep 2026 03:16:08 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4hcwMV3gG4z2yqP;
	Sun, 06 Sep 2026 13:16:06 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2607:f8b0:4864:20::635"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1788664566;
	cv=none; b=iCu87rhcBulD7UktkzsYs9e8VqfxBDeMN+KVqSxo6BQePm3b3iCtr0Eq+iF870alieVParETcBl5l9OZbJJrYwqrl5yE7MPuE8a3cuvEo4ZR/GCa/+2DnGl9ZyY+zK+1ZproEiphyhMlHL2nOIbcMoQK2+4gOMPXL98vaqcLq5GNE73FWmkaMV0smOWDLt9YfPAV5PxkgNZR6Lf/AGRjBUh9Q/dbLX3OKnIyb3yz26fp/zPUUaB1ShTY/aWEh0n7erjP3xdzl3vVOzmTj5Zyqd3VNjSt5FxSP7qhC0iTDqKP/h0YNimGPTnJ6Y0S+HdU4KY61Mty8/8OvOYbnqft5A==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1788664566; c=relaxed/relaxed;
	bh=PzRSn99Z1yk+7HFJo/h+LBTWNWv/4UJ5Z3BeXY+6DqA=;
	h=From:To:Cc:Subject:In-Reply-To:Date:Message-ID:References; b=b38tmZzd3uLhT1L606Dtao0Rb89VB+TaT0gDqyZe5rdQDUygdRwbB0WKraq8TGRi6m//cCl3QkOP+nMZ8SvR6GPlY7JcKSCVSnZc23mABRugAnSIgIIHZ4OksPokM/g6rX7qvj7g449v565libvEEzCi/JFf90lOZvODFlI7AJjccjT9Cp/CO11BD/60LhkM1AZh6kngBcnZd1hdW7h8Ve+6SaxaRZPxXiXeJCfn8x32veKYgq83p2HODKHVKQYO8TBTxskxl7iarjhac8W/7dZJUIc8gKZYb7N5tO1+pPXKxJaUlAQBhQav8EtkNWMfUfRD1Mt0kfobQ8xptXOjiw==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com; dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=H2HfXtJR; dkim-atps=neutral; spf=pass (client-ip=2607:f8b0:4864:20::635; helo=mail-pl1-x635.google.com; envelope-from=ritesh.list@gmail.com; receiver=lists.ozlabs.org) smtp.mailfrom=gmail.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=H2HfXtJR;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=gmail.com (client-ip=2607:f8b0:4864:20::635; helo=mail-pl1-x635.google.com; envelope-from=ritesh.list@gmail.com; receiver=lists.ozlabs.org)
Received: from mail-pl1-x635.google.com (mail-pl1-x635.google.com [IPv6:2607:f8b0:4864:20::635])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4hcwMS4MFrz2xlw
	for <linuxppc-dev@lists.ozlabs.org>; Sun, 06 Sep 2026 13:16:03 +1000 (AEST)
Received: by mail-pl1-x635.google.com with SMTP id d9443c01a7336-2d6f9e2f681so26210835ad.3
        for <linuxppc-dev@lists.ozlabs.org>; Sat, 05 Sep 2026 20:16:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788664560; x=1789269360; darn=lists.ozlabs.org;
        h=references:message-id:date:in-reply-to:subject:cc:to:from:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=PzRSn99Z1yk+7HFJo/h+LBTWNWv/4UJ5Z3BeXY+6DqA=;
        b=H2HfXtJRDYf2iaVXEszHY5B1X5b8dSVR2sGfB77t4YMi/S7k0xOccMHuDrZnwIPMsw
         gloVwp5IoOknOfWUybauAQjT/nYxsWXibqxERBnVinOlRaQSMgdR2JL9D10DtKkYooCt
         VgVD2YlHGxvDzyDaVU54FGoxP81rANNxIl2qMBYGNylSw83zHJdes8nWEEpECpu+anuK
         bZDDtTpbWSH8BaJHOZOsGwElSVKtKhyncRjarM84yGtWIV33QYDlIO2JMF8mWDlMu/VQ
         quVLIfzHiCvfeSO4/qJM5wR0PxpFsBfZuUeIo+PzKLwmdhu095nqyUogmhv0vKVbs0tC
         0ENg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788664560; x=1789269360;
        h=references:message-id:date:in-reply-to:subject:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=PzRSn99Z1yk+7HFJo/h+LBTWNWv/4UJ5Z3BeXY+6DqA=;
        b=HXxStri0zJRlJ8RuykVfMQT0sLgeOv2md60HIla+TuH6oQAe6ofTPvO4HaBni7xypC
         2wabceVe2MBloRxOusS60zhzH2Y1D6JjrT9rO6kTby+Pom8TgjjRP+9WPUJ+0t7L17D4
         2DsHEyw4/oMl5FVCy/76kEhjVGQ2I/H3RUA7MsLV9RoAIlu1zjE0mpdfNRqPg4S+DOr1
         LZbe5q3a7pez16M7vbycBNcvB71fstvqLYuNKaZco645FN4MyT4LHcYMb7A+0w4I1lyt
         ipu/Y5L5JcLPtKvSxc+3kqWd9hnUGlc+yOHIWcutCTB7TzqJrirwumXRABXwmq4vqoUB
         nS/Q==
X-Forwarded-Encrypted: i=1; AKwUvBw1toUKrOjHX9bud3000n4p8/Rq5TlZe1pfFi7rLyPjOUl/7HxU/k2qqcOEg+2/uWZZOlprqw5l9Qr/3Ws=@lists.ozlabs.org
X-Gm-Message-State: AFuF++m3E5rQqhmtJTwggVaHOCj37fbbBro6vxDp7lnHKtjxDz9rhUdk
	SVsdq5Thp5VzHV9uyioTtVfCPbeVYhAyPV5Krj0lSCox/+fWEg2GFTP/
X-Gm-Gg: AYBFou0oYeTn5YlUJygy0ooHt+HgcV3bBKOE8nn7OGGuwMNvQdCoH5t//1wMmfaM/ek
	/ZzZ+tI5Bieil8k62Rrjeh8lzn91jqO6nsfrdyZs+iCOmWJE8EetuQSkIzilfXVb0fK6MKrzJ6N
	WHJsfMRSvQVIw8DZslE0W5mkMUOfedMIA36fmr7c8MC6rXJQDdqF1SngdvDWxDP1sWrMGrbBbtO
	daDeWqKDxkTl02wm2LXB8t2nrNswCYXYdTMtpZ3l3+X6pipbiw5hdq1DaPwfnateCO7jvYDSNqB
	/LX0NprtBr2dNNswGvF//iThMook98L0c9SarFXjLZnMzkb8gg902Xx/QrYwlNkG/vQzhsveK24
	arWKYrYu/KHNbtvt/T+YQCtf9ib93UF4FJ4dhug3ME0eHfu91goRdCeoDF8zqeRGvQa5MaOBVt9
	IXHr3fzKgKmgLAxpKsmiVsNN9LO6zBNErHpU+IWrwL76CMTmwIL520YxpbTIJ58yWHdcVpVMKkZ
	03nvnpgRrHdENMn8SAeBsSfH7Y9JId/SQ05Ajt+UQ49
X-Received: by 2002:a17:90b:3ec5:b0:398:9c00:29ed with SMTP id 98e67ed59e1d1-39b26277673mr23116093a91.21.1788664559815;
        Sat, 05 Sep 2026 20:15:59 -0700 (PDT)
Received: from pve-server ([49.205.216.49])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-143243767e1sm14664532c88.6.2026.09.05.20.15.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 05 Sep 2026 20:15:59 -0700 (PDT)
From: Ritesh Harjani (IBM) <ritesh.list@gmail.com>
To: Karl Mehltretter <kmehltretter@gmail.com>, Madhavan Srinivasan <maddy@linux.ibm.com>
Cc: Karl Mehltretter <kmehltretter@gmail.com>, Haren Myneni <haren@us.ibm.com>, Michael Ellerman <mpe@ellerman.id.au>, linuxppc-dev@lists.ozlabs.org, Jonathan Corbet <corbet@lwn.net>, linux-doc@vger.kernel.org, Shuah Khan <skhan@linuxfoundation.org>, Randy Dunlap <rdunlap@infradead.org>
Subject: Re: [PATCH] docs: powerpc: vas-api: Use the uapi structure name in the example
In-Reply-To: <20260905104313.43620-1-kmehltretter@gmail.com>
Date: Sun, 06 Sep 2026 08:27:27 +0530
Message-ID: <qzj7xf1k.ritesh.list@gmail.com>
References: <20260905104313.43620-1-kmehltretter@gmail.com>
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

Karl Mehltretter <kmehltretter@gmail.com> writes:

> struct vas_setup_attr does not exist; the name is struct
> vas_tx_win_open_attr.
>
> Use struct vas_tx_win_open_attr.
>
Thanks for fixing this.

> Fixes: c12e38b1d52e ("Documentation/powerpc: VAS API")

yup. Looks like this UAPI name was wrong since day one.

While at it - would you like to fix the ioctl definition too in the same
file?

                #define VAS_MAGIC 'v'
-               #define VAS_TX_WIN_OPEN _IOW(VAS_MAGIC, 1,
+               #define VAS_TX_WIN_OPEN _IOW(VAS_MAGIC, 0x20,
                                                struct vas_tx_win_open_attr)

                struct vas_tx_win_open_attr attr;



-ritesh


