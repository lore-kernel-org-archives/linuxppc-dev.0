Return-Path: <SRS0=S6eX=NK=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2F566C2BC61
	for <linuxppc-dev@archiver.kernel.org>; Tue, 30 Oct 2018 07:16:15 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 858352082B
	for <linuxppc-dev@archiver.kernel.org>; Tue, 30 Oct 2018 07:16:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=google.com header.i=@google.com header.b="gGVo453w"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 858352082B
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=google.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 42kjHG68wWzF22T
	for <linuxppc-dev@archiver.kernel.org>; Tue, 30 Oct 2018 18:08:26 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: lists.ozlabs.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=google.com header.i=@google.com header.b="gGVo453w";
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=google.com
 (client-ip=2607:f8b0:4864:20::144; helo=mail-it1-x144.google.com;
 envelope-from=edumazet@google.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=google.com header.i=@google.com header.b="gGVo453w"; 
 dkim-atps=neutral
Received: from mail-it1-x144.google.com (mail-it1-x144.google.com
 [IPv6:2607:f8b0:4864:20::144])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 42kjDf2X9HzF1Pt
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 30 Oct 2018 18:06:03 +1100 (AEDT)
Received: by mail-it1-x144.google.com with SMTP id j9so641258itl.3
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 30 Oct 2018 00:06:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=DI7Os5ztz1YkuX9GcHkyfoOe0ZK7Ez27MR+mHaIdmiA=;
 b=gGVo453w0KKQL4OXpx6TFohPGyQblkcXQcCLkUNQlCHjT3yzciNz/54RNh8EpVp9rg
 Y7neW3lRrWNu/qn8WZUAEjWzNdqY5gGkhgvZUtWrS4+dMSfkbr34oCM+dst1nClZYoo6
 7DrtptuBMCsiaBniFb8sdJblnqpH1hCrTc4JYlWUpPFCGupeJoIEu/bJ/PPX0XvCxucT
 y7FyqLmerN4ioAEXHZzec7hEgyJkKbiJksdIoJWOsUm3tRDSPYEWR82c1rHhFg+u0PSM
 kIGd/akRywKFQiLcb4Ptj3ku/Ntkp3aoIrvOAYzxgsZn9obeKm/f3GkZPr/+zS/rqNOg
 FIQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=DI7Os5ztz1YkuX9GcHkyfoOe0ZK7Ez27MR+mHaIdmiA=;
 b=K1O5zy3gndZ075Eohstl8qgElmMqS7nezuTEIdxm5f2j9kB9Ec5fEgwftGKRTSxOPf
 0+MHRT3nI36dmHUXejdNWfmkm6Q+ww1hsigzNxgJCTUEfD8x83TrWI5emZh9VoaWedrh
 Ay6eQuUpB5oL6j0MpYGeOfRpbrxYjNnJyM5m28Z89d5oaB/hjs1Tay+lSugvJEF1P6Bv
 vxBIqk+Oke2+uuk0QtidEHKv/C8fd1DzhuF2eyHzOfuGui9Ph3l3SXHnYm1d/B4MnXUq
 bXuJ6KvjlKcuM01JEJH7Vjk4zh1D6AG082B9qzxrRefGJ9lOGu8F4+hp0QDAikbT6Bw9
 U1Pw==
X-Gm-Message-State: AGRZ1gLyAfEdAYhNj7GgF18uftzw7SvCFdqAhMDKcWSqV3oF4nxgKDMh
 HpH3n7B2R5bGhPGdDkbDAIf6OvJWCLSGLC2R34O6Gw==
X-Google-Smtp-Source: AJdET5efpzfZE/ulkWBtwXS6LOWJX0Q6mUhNNEDIqDFnup3zS8w6UOxAx7jmlrgQD2l+930f4AneS+SJi9oWPoI2mZw=
X-Received: by 2002:a24:7406:: with SMTP id o6-v6mr291362itc.81.1540883161077; 
 Tue, 30 Oct 2018 00:06:01 -0700 (PDT)
MIME-Version: 1.0
References: <1540881776.20660.9.camel@abdul.in.ibm.com>
In-Reply-To: <1540881776.20660.9.camel@abdul.in.ibm.com>
From: Eric Dumazet <edumazet@google.com>
Date: Tue, 30 Oct 2018 00:05:49 -0700
Message-ID: <CANn89iJGgCMYRp7h=h+g=o+P9VA+8U+NxFhXP70B_PSG_mp7OQ@mail.gmail.com>
Subject: Re: [mainline][bisected 55469b][ppc] build error at
 drivers/net/ethernet/mellanox/mlx4/en_rx.c
To: abdhalee@linux.vnet.ibm.com
Content-Type: text/plain; charset="UTF-8"
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
Cc: sachinp@linux.vnet.ibm.com, manvanth@linux.vnet.ibm.com,
 linux-rdma <linux-rdma@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>,
 aneesh.kumar@linux.vnet.ibm.com, netdev <netdev@vger.kernel.org>,
 brking@linux.vnet.ibm.com, linuxppc-dev@lists.ozlabs.org,
 Tariq Toukan <tariqt@mellanox.com>
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

On Mon, Oct 29, 2018 at 11:43 PM Abdul Haleem
<abdhalee@linux.vnet.ibm.com> wrote:
>
> Greeting's
>
> mainline build fails on my powerpc with commit 55469b : drivers: net:
> remove <net/busy_poll.h> inclusion when not needed
>
> Machine type: PowerPC power 8 bare-metal
> kernel : 4.19.0
> gcc :  4.8.5
> config attached
>

Thanks for the report, but this patch is not in 4.19 kernel ? It is
scheduled for 4.20 only.

Anyway, mlx4 needs to include  <net/ip.h> directly, instead of
assuming it is indirectly included by another file.
