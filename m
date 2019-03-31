Return-Path: <SRS0=rJbe=SC=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F258FC43381
	for <linuxppc-dev@archiver.kernel.org>; Sun, 31 Mar 2019 09:52:25 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6A20C20850
	for <linuxppc-dev@archiver.kernel.org>; Sun, 31 Mar 2019 09:52:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PUhFmmlX"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6A20C20850
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 44X9kH1jW4zDqCK
	for <linuxppc-dev@archiver.kernel.org>; Sun, 31 Mar 2019 20:52:23 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=gmail.com
 (client-ip=2607:f8b0:4864:20::92e; helo=mail-ua1-x92e.google.com;
 envelope-from=oded.gabbay@gmail.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=gmail.com header.i=@gmail.com header.b="PUhFmmlX"; 
 dkim-atps=neutral
Received: from mail-ua1-x92e.google.com (mail-ua1-x92e.google.com
 [IPv6:2607:f8b0:4864:20::92e])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 44X9hZ48v1zDqLt
 for <linuxppc-dev@lists.ozlabs.org>; Sun, 31 Mar 2019 20:50:51 +1100 (AEDT)
Received: by mail-ua1-x92e.google.com with SMTP id n16so2006794uae.10
 for <linuxppc-dev@lists.ozlabs.org>; Sun, 31 Mar 2019 02:50:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:from:date:message-id:subject:to;
 bh=bYPv7rlyBptvYJPvd1tcBI4BYjF293vZFkR1AO85ci4=;
 b=PUhFmmlXS7u6F+gcaaNkBLYNwdzFj6xnHhREgiQF1cCn/F/zyfuqueNLwn8OPXeXjB
 HjiqqhLArdFsSU1HSkxS3A6vEtiesCSbx0wa/Fu/9g4GE4vGhN+awyA6jnkfaNOOadjh
 FR9bfuPAqV1I/5HFB2rniHKnA6mZBp9Kig2fYjdDnb4CuQCPhmXHqXeYFUjo6O5saLT3
 gDGmy9CCEvSDFqOJ1zEO8INHYpeX05DEyryaqveVVaLGz6qWjcUg+ZjvOo5iWbaIBNra
 jwfywyNtyj0rYax85dNHPw2fSiK9yLH0ymyKqJXFRoVpDzCLYBp7kZhKqBKE4wAQk9g4
 FdwA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
 bh=bYPv7rlyBptvYJPvd1tcBI4BYjF293vZFkR1AO85ci4=;
 b=QL1cMOef+ORPnFsK/XJaY3HlPoQkAIw1N17KUuJa2nskOc59AhNafVf6oXJuB7+mfA
 k296t3x3MOQYcXcVS4YVqXXKstQ/CVE3KVa+TBpdxIfEUby6fbC7YwrbjjkcObzdPYA1
 t5lY4eiYeqDYnJ5deHhZkmqIzpbIrxxOq4FgQg38bfD4SZQgSWy1DMpHf5sepVgrDh7Y
 0XCQN2Bb5b/ZldfnJVRzbCYbSSYrM3OX7nKTZuwOEOMw6EHMReMpmD0AYwEkbEMsU4CI
 xd88wGMCQw8SClq6G52l4EYuQhn6BKmnlYg1j1fVhpDeaNiRNz2uTbyqWpv4W+HwKSIU
 FZeA==
X-Gm-Message-State: APjAAAWMMBrADguOTb4DoKb7nKlHqfY9jDn/XTMBXBAM8uTnGBRwEVxQ
 p1+ARKdb4cVtVzV8uVHe9RgmcMURQPV1F2CzD48=
X-Google-Smtp-Source: APXvYqyj+uEqRtD6cI4qTcg20UupWPutlfEs6aJgmGlgYGreLhpzrY1hHy1myYK874Zsbj4mvfvcxlRFDLrvJEqhYrI=
X-Received: by 2002:ab0:6455:: with SMTP id j21mr33309992uap.133.1554025847594; 
 Sun, 31 Mar 2019 02:50:47 -0700 (PDT)
MIME-Version: 1.0
From: Oded Gabbay <oded.gabbay@gmail.com>
Date: Sun, 31 Mar 2019 12:50:21 +0300
Message-ID: <CAFCwf13rpx4HdWeW_Gw5NaaPnFB95z3qw5ATN=uDOMz2if_X5g@mail.gmail.com>
Subject: Question about Power8/9, PHB3/4 and setting of DMA mask
To: Christoph Hellwig <hch@lst.de>, Russell Currey <ruscur@russell.cc>,
 linuxppc-dev@lists.ozlabs.org
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

Hello,
I'm working in a startup called HabanaLabs, and we have an ASIC
accelerator for AI called Goya. It is assembled on a PCIe Gen4 card.
Driver is going to be in kernel 5.1

We are trying to plug the card into a Power8 machine and load the
driver, and we get a failure during the loading of the driver in
regard to the driver trying to set the DMA mask.

Due to some limitation in Goya, the driver first need to allocate a
2MB chunk in a DMA-able address under 39 bits and then we would like
to move to using up to 48 bits. Therefore, the driver first tries to
set the DMA mask to 39 bits, allocate the 2MB area and later on,
change the DMA mask to 48 bits. On x86 this works fine.

However, as I said, on Power8 we got a failure when trying to set to
39 bits. After tracking the code, I reached to this function:
pnv_pci_ioda_dma_set_mask()

In that function, there is a check (composed of 4 conditions) about
the requested dma mask, which appears that we fail and I suspect this
is due to the memory_hotplug_max() returning more then 39 bits.

My questions are:
1. Is this logic applies to Power9 as well ?
2. Why this condition is mandatory ? Is there some kind of workaround
available ?

Thanks in advance,
Oded
