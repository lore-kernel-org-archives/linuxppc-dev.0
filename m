Return-Path: <SRS0=psBJ=MK=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	MAILING_LIST_MULTI,SPF_PASS autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 13FD4C43143
	for <linuxppc-dev@archiver.kernel.org>; Fri, 28 Sep 2018 20:09:33 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7EBC92073F
	for <linuxppc-dev@archiver.kernel.org>; Fri, 28 Sep 2018 20:09:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="MBL6cryp"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7EBC92073F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from bilbo.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 42MN7G3YlGzF3Hc
	for <linuxppc-dev@archiver.kernel.org>; Sat, 29 Sep 2018 06:09:30 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org;
	dkim=fail reason="signature verification failed" (1024-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="MBL6cryp";
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=kernel.org
 (client-ip=198.145.29.99; helo=mail.kernel.org;
 envelope-from=robh+dt@kernel.org; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=pass (p=none dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org; dkim=pass (1024-bit key;
 unprotected) header.d=kernel.org header.i=@kernel.org header.b="MBL6cryp"; 
 dkim-atps=neutral
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 42MN4n56M9zF3J5
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 29 Sep 2018 06:07:21 +1000 (AEST)
Received: from mail-qt1-f182.google.com (mail-qt1-f182.google.com
 [209.85.160.182])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id 9AFB220838
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 28 Sep 2018 20:07:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1538165239;
 bh=8ceWlt+FzbQiWADpwWjP3zubqEZymXgsNtv1I1R9vaU=;
 h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
 b=MBL6cryp9Z6vYLJzamJ7TYaHFv4gyUJsPhqAzz0tvNjjePtrhydwp8gxrW3ZoMyJc
 cmHvEJJ1vMLpk75YkqS0mBNL2TbAIzfrC0RVzdyXs66txLQUHvtQau2u035pg0UkjR
 aDepIXyGpQMFgUXbwEt/xE572HWBCsnGWkErytMU=
Received: by mail-qt1-f182.google.com with SMTP id z14-v6so8055336qtn.2
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 28 Sep 2018 13:07:19 -0700 (PDT)
X-Gm-Message-State: ABuFfogfXesYTZmBTi7q0mqrtHCGy0eriRruGvtWbut6l2stHbZrAz4J
 OHu07Q2jd74yEbZC3lB4R6M111q6I8CJtL4ciA==
X-Google-Smtp-Source: ACcGV615ydwOQE5KHku0hZnk45wbAeEPDYPi3wviHcgcLf7nZZu4M38GrG5PEHmoyjmRuIYwMfCqKg7tCHrAf/j/HAs=
X-Received: by 2002:ac8:46d3:: with SMTP id
 h19-v6mr170261qto.188.1538165238817; 
 Fri, 28 Sep 2018 13:07:18 -0700 (PDT)
MIME-Version: 1.0
References: <CADRPPNT0QiBkJtJnxjW95Yf-mirL5OzRrvqj8rC-O8fiz17VnA@mail.gmail.com>
In-Reply-To: <CADRPPNT0QiBkJtJnxjW95Yf-mirL5OzRrvqj8rC-O8fiz17VnA@mail.gmail.com>
From: Rob Herring <robh+dt@kernel.org>
Date: Fri, 28 Sep 2018 15:07:05 -0500
X-Gmail-Original-Message-ID: <CAL_JsqKRH8uEzSx6H6ZSRJF9Ecp4am1cNsxgQqf2OO5_aGR1zw@mail.gmail.com>
Message-ID: <CAL_JsqKRH8uEzSx6H6ZSRJF9Ecp4am1cNsxgQqf2OO5_aGR1zw@mail.gmail.com>
Subject: Re: drivers binding to device node with multiple compatible strings
To: Yang-Leo Li <leoyang.li@nxp.com>
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
Cc: devicetree@vger.kernel.org, linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 Frank Rowand <frowand.list@gmail.com>,
 "moderated list:ARM/FREESCALE IMX / MXC ARM ARCHITECTURE"
 <linux-arm-kernel@lists.infradead.org>
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

On Thu, Sep 27, 2018 at 5:25 PM Li Yang <leoyang.li@nxp.com> wrote:
>
> Hi Rob and Grant,
>
> Various device tree specs are recommending to include all the
> potential compatible strings in the device node, with the order from
> most specific to most general.  But it looks like Linux kernel doesn't
> provide a way to bind the device to the most specific driver, however,
> the first registered compatible driver will be bound.
>
> As more and more generic drivers are added to the Linux kernel, they
> are competing with the more specific vendor drivers and causes problem
> when both are built into the kernel.  I'm wondering if there is a
> generic solution (or in plan) to make the most specific driver bound
> to the device.   Or we have to disable the more general driver or
> remove the more general compatible string from the device tree?

It's been a known limitation for a long time. However, in practice it
doesn't seem to be a common problem. Perhaps folks just remove the
less specific compatible from their DT (though that's not ideal). For
most modern bindings, there's so many other resources beyond
compatible (clocks, resets, pinctrl, etc.) that there are few generic
drivers that can work.

I guess if we want to fix this, we'd need to have weighted matching in
the driver core and unbind drivers when we get a better match. Though
it could get messy if the better driver probe fails. Then we've got to
rebind to the original driver.

Do you have a specific case where you hit this?

Rob
