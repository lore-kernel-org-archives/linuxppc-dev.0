Return-Path: <SRS0=LqqS=B4=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.3 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5BF68C433E1
	for <linuxppc-dev@archiver.kernel.org>; Tue, 18 Aug 2020 09:17:55 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A885820786
	for <linuxppc-dev@archiver.kernel.org>; Tue, 18 Aug 2020 09:17:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="eGoDITci"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A885820786
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from bilbo.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 4BW50v4vtQzDqZk
	for <linuxppc-dev@archiver.kernel.org>; Tue, 18 Aug 2020 19:17:51 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized)
 smtp.mailfrom=gmail.com (client-ip=2607:f8b0:4864:20::341;
 helo=mail-ot1-x341.google.com; envelope-from=allen.lkml@gmail.com;
 receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256
 header.s=20161025 header.b=eGoDITci; dkim-atps=neutral
Received: from mail-ot1-x341.google.com (mail-ot1-x341.google.com
 [IPv6:2607:f8b0:4864:20::341])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4BW4xk3dZ2zDqWs
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 18 Aug 2020 19:15:06 +1000 (AEST)
Received: by mail-ot1-x341.google.com with SMTP id v21so15699892otj.9
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 18 Aug 2020 02:15:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=W2hKsTS1LvaI0SOO9W3/5fRfJY5aEh/BZWVO9XitBWs=;
 b=eGoDITciADrWQe3gs29cyT8xT1NKm5rz9rVcVLDn/bbuYp8fgY1hSDfcgcO2Y8A/FE
 zDJ9bm6G+z2N4IP6u1ELlhwB/iZ+1A+IwLuPDXV50yqTfWBpi2yoklrT0psD6GdMzRGm
 mKZXpjNtcSxOPcLuAlO8t6rlea5KpMBIJZl+zd87Fs8FGCP4YglR+Cy8uqT+GzI0stq3
 viuaxAQxm/6lWfM0J1ue15DTH6MQ6CtMtlUoD1oYGIxuyF9v8tv3Vn0TjcM5dSCK8JbS
 fjcwz39yKbHCwapnbDs3GWnek7Qbumu+oEcYnimX4XO6Q66JRWEkGZLHrLAcc8kim4hs
 +0yA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=W2hKsTS1LvaI0SOO9W3/5fRfJY5aEh/BZWVO9XitBWs=;
 b=oEZtxO9egdgsO0ma0oI555UL0pQpWEE78t+Np2+3i3RFyT9eQwL1m5MCKt4ea09kVe
 vBoK5ukJreCfFhGqGx/MjnKFgQKD7PdgiNUu1GooaihaXGJoBVa3vx4sxJVqCw7VjAk2
 nivpLZTzq86KQMM4LmWhilaOTvmcp4ec5q9ifNPDFr7pRT9PYGb8kq7uNrCx/qjDvjv3
 7JEVfPkIutR6erf5VV9gsOIZtM0sr39QjRFHmaC5nlR4A3leX6qZ6ow7oHg7j7Osmt/f
 by6g7SJZupd3lCk2pbg7GpvObjgKRonrU/OmYey0R+F83WGm57iPW0mlBoAI5NUGkDV4
 wS3w==
X-Gm-Message-State: AOAM530w8WTvOc6YjTKDhu2TcFv/sgbx3ka3sbIsst8ppgVuOBK8lNGd
 44YRJOZ2wtrqJEWO4gcbfP5JdZjMfJUl4iAddrk=
X-Google-Smtp-Source: ABdhPJzzm5zuxz1BYxytortJNZi40aPY4mo/p0dwJ/cgscBmXy1XrUh5q88EuMzxIjKgJBVv2+jBuBgNQfstKNEw2u4=
X-Received: by 2002:a9d:774d:: with SMTP id t13mr13781704otl.108.1597742104000; 
 Tue, 18 Aug 2020 02:15:04 -0700 (PDT)
MIME-Version: 1.0
References: <20200817082434.21176-1-allen.lkml@gmail.com>
 <20200817082434.21176-8-allen.lkml@gmail.com>
 <20200817083216.5367f56a@kicinski-fedora-pc1c0hjn.dhcp.thefacebook.com>
In-Reply-To: <20200817083216.5367f56a@kicinski-fedora-pc1c0hjn.dhcp.thefacebook.com>
From: Allen <allen.lkml@gmail.com>
Date: Tue, 18 Aug 2020 14:44:52 +0530
Message-ID: <CAOMdWSL0e8iakwc2FUnF8epMme5eofrUMzrG0MjcBvEz4cimKA@mail.gmail.com>
Subject: Re: [PATCH 06/20] ethernet: chelsio: convert tasklets to use new
 tasklet_setup() API
To: Jakub Kicinski <kuba@kernel.org>
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
Cc: jes@trained-monkey.org, borisp@mellanox.com,
 Kees Cook <keescook@chromium.org>, linux-rdma@vger.kernel.org,
 netdev@vger.kernel.org, kda@linux-powerpc.org, cooldavid@cooldavid.org,
 dougmill@linux.ibm.com, linux-kernel@vger.kernel.org, linux-acenic@sunsite.dk,
 oss-drivers@netronome.com, Romain Perier <romain.perier@gmail.com>,
 linuxppc-dev@lists.ozlabs.org, David Miller <davem@davemloft.net>,
 linux-arm-kernel@lists.infradead.org, mlindner@marvell.com
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

>
> You need to adjust kdoc when you change functions:
>
> drivers/net/ethernet/chelsio/cxgb4/sge.c:2664: warning: Function parameter or member 't' not described in 'restart_ctrlq'
> drivers/net/ethernet/chelsio/cxgb4/sge.c:2664: warning: Excess function parameter 'data' description in 'restart_ctrlq'
> drivers/net/ethernet/chelsio/cxgb4/sge.c:2965: warning: Function parameter or member 't' not described in 'restart_ofldq'
> drivers/net/ethernet/chelsio/cxgb4/sge.c:2965: warning: Excess function parameter 'data' description in 'restart_ofldq'


Thanks, will fix it and spin V2.

-- 
       - Allen
