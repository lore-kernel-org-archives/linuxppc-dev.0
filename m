Return-Path: <SRS0=fR6Q=BJ=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 171ABC433E0
	for <linuxppc-dev@archiver.kernel.org>; Thu, 30 Jul 2020 12:26:55 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B97432074B
	for <linuxppc-dev@archiver.kernel.org>; Thu, 30 Jul 2020 12:26:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=globallogic.com header.i=@globallogic.com header.b="BUbn1H2j"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B97432074B
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=globallogic.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from bilbo.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 4BHV5m4nqkzDqys
	for <linuxppc-dev@archiver.kernel.org>; Thu, 30 Jul 2020 22:26:52 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized)
 smtp.mailfrom=globallogic.com (client-ip=2607:f8b0:4864:20::f33;
 helo=mail-qv1-xf33.google.com; envelope-from=maksym.kokhan@globallogic.com;
 receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=reject dis=none)
 header.from=globallogic.com
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=globallogic.com header.i=@globallogic.com
 header.a=rsa-sha256 header.s=google header.b=BUbn1H2j; 
 dkim-atps=neutral
Received: from mail-qv1-xf33.google.com (mail-qv1-xf33.google.com
 [IPv6:2607:f8b0:4864:20::f33])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4BHTv11m2RzDqfs
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 30 Jul 2020 22:17:28 +1000 (AEST)
Received: by mail-qv1-xf33.google.com with SMTP id w2so276656qvh.12
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 30 Jul 2020 05:17:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=globallogic.com; s=google;
 h=mime-version:from:date:message-id:subject:to;
 bh=ffVf0mStpT9zLSrAjfunPJARJXdSTu2jstjnWKnACgY=;
 b=BUbn1H2jycvHOWhGFvh5jH9rt9Ztl1rNzpoM6S67TK+meg21/dETVIBnW6wKZii7XR
 npot3Km9IKsGIJD6gSPbwqV76KKDQKdbmhkDA2ybrJxbNIvWt2V6l/zDCchU6s+zha7K
 shYyVLPxM+TQONVRg8GNp63ZHWOc9FUqyqNhIh830HG5o4gBI1ZRSDGAgOBwtOBK0twc
 L8yx+/M7lMh8pN6Q6rKHdF+th/WkgTFc5m1HYLhgFYREecU7SyHfuKW8GUJ6YXMi6DtC
 bSlVegETctUeyegBy/NAjv/ZtuS+a9Jba/Z22KerdRS3+8MfCKv6wpx5z9cveuCNdtXC
 t6Bw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
 bh=ffVf0mStpT9zLSrAjfunPJARJXdSTu2jstjnWKnACgY=;
 b=ns74ryVDGDTPuWzihGWxOFlCBqSYJEpnGy5Y6EIchFD52DKNfjq/8oYRQlkxCYSHc5
 oud0GX53UdvHNJMdwhHlU0l39xHm1OxhLFnTycwVxNufRDqRc2cdMoi7DHtw+VGP59uY
 ekQTXzTw1ssiGkXARJ0qP+wtEualP0LhGEOdmswASamWy0U0+fa1a9236yQz+hTiDDrM
 KE5fvF43JjwNGcMQ8M8vsWLn8cwyosq00aJJ7uazhQuAbBmwXDNzERYMSrsZ0nMUi3HB
 NeLPJPjag25dsXCbNjLhRnXgFINFbD+G7LvGS40S8Sr5IOBHJUGZtQB+AL6LsDm2fwUC
 7BZg==
X-Gm-Message-State: AOAM532VBgLIbHWtS1qtcQC4HRs/JV00a2PuedXfcHyzkLxiUzJX3qZW
 lrOMKF/wlDr2pBkEHfCeH0SHlVwrc11jR4McKPqV9FtOflo=
X-Google-Smtp-Source: ABdhPJx9Nq4mVvVyhoQSJ1YQ2r8cbuHDXPi0sBCrftabpE2g0dLXzvvax1rdiG+1hu4mH0fCJ4jPnQNZNj/y1NkjjUc=
X-Received: by 2002:ad4:54c6:: with SMTP id j6mr2645806qvx.126.1596111443662; 
 Thu, 30 Jul 2020 05:17:23 -0700 (PDT)
MIME-Version: 1.0
From: Maksym Kokhan <maksym.kokhan@globallogic.com>
Date: Thu, 30 Jul 2020 15:17:12 +0300
Message-ID: <CAMT6-xgFCydUT9CFvsKsZf3YMGzGpJD0A=ek+4dU1F=vEif2eA@mail.gmail.com>
Subject: question about work on CMA integration into DMA
To: linuxppc-dev@lists.ozlabs.org
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
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

Hello!

I am working on some driver, which needs to allocate a big contiguous
memory block (~10 MB) and has to work on multiple platforms (x86, arm,
arm64, mips, powerpc). CMA - is the most appropriate way in this case,
but I have faced an unexpected problem - the fact that the CMA
subsystem is not integrated into the DMA subsystem for powerpc,
and I cannot request memory from CMA area from my kernel module.
The question is: is there any work in progress on CMA to DMA
integration?  Or is it decided not to perform such work at all?
And, is there any legal way to allocate a big contiguous memory block
from the kernel module on powerpc?

Thanks for your help,
Max
