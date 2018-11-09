Return-Path: <SRS0=4MsH=NU=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.5 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C4F5DC43441
	for <linuxppc-dev@archiver.kernel.org>; Fri,  9 Nov 2018 03:49:24 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1424D20855
	for <linuxppc-dev@archiver.kernel.org>; Fri,  9 Nov 2018 03:49:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JeoZMXM3"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1424D20855
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 42rmNx4XC9zF3VT
	for <linuxppc-dev@archiver.kernel.org>; Fri,  9 Nov 2018 14:49:21 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="JeoZMXM3";
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=gmail.com
 (client-ip=2607:f8b0:4864:20::d41; helo=mail-io1-xd41.google.com;
 envelope-from=oohall@gmail.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=gmail.com header.i=@gmail.com header.b="JeoZMXM3"; 
 dkim-atps=neutral
Received: from mail-io1-xd41.google.com (mail-io1-xd41.google.com
 [IPv6:2607:f8b0:4864:20::d41])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 42rmLQ3dkjzF3WL;
 Fri,  9 Nov 2018 14:47:10 +1100 (AEDT)
Received: by mail-io1-xd41.google.com with SMTP id k17-v6so364298ioc.4;
 Thu, 08 Nov 2018 19:47:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=//rZIsKjV+wKZ6y0Ln1h5iGAWqFDeFSqFcdGvvx2ylU=;
 b=JeoZMXM36BRbgAKp+lBltAxQhlnTh/ImuSdJ2/DVPiM3VV8UIFPHnP1LmT+1n//93o
 LIfpqwjzTai+Rr8DqQJqXRfOZye8hrzjVVOHpiViMQJ94Xp8mHR9jkuOolXpZzc/+GVe
 g87c+Ydvl2WMVMGXlPkNdQKoAtRWy6gTBQdsf+svFMo0S4asaKx3PcSYQDbVd8RdxNiD
 BZU4IFvpN7Ncd/mP+ihhC9W/qrGJBstB3SWBwynxv1sOw4cjjDAjuglEbVcJnYxIk7c0
 xygynT3UBJ3gblW8FjAeJ0u0W1B4dCMg9BmysAdHmkvXqMhZ7jLuJtiLNucjxOwVamS3
 nIsQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=//rZIsKjV+wKZ6y0Ln1h5iGAWqFDeFSqFcdGvvx2ylU=;
 b=tcTcNZ13Hk2xFPOr4wPRIi2DOuSZHDT1DzHOWYxLUMcw4GgaTlwMpeQ1eClcEzeoxt
 HViwB4qyJXaISU44u5xPqw4lQrUW7g+Q21dImnUaxOF1JGaBOvLilovvGgK01f/0K9lo
 rP1VOTvLPX8Zjw3TujzlTy8d9a6ncG8nh92DjhUzHr40o8jz4X7hpcerGtA4gxMdpcrq
 xQMiGIzJn5LSQX8eYKJ/hDA1X3UBgJXY8zFzHZ1Tu2caVNg+BCPqxzw7fraMIpYTAbsQ
 gb8JB3PGhgWuRx5bbRDcNm9HEnWUqzf/tG5+X+xpTajEkTSF9Us66gDyDtB++2OGs4UN
 Yzgw==
X-Gm-Message-State: AGRZ1gKQiHzC2RCR7AOMdC24JXrWgjo6nUr3sFa1LLkyVU/7vwIrt4lv
 07aMLBO8GAinfDajgT9Uytti55C7UV4EskrL6K8=
X-Google-Smtp-Source: AJdET5flp7aek8/TtI+v9Tsa7Em/p1OXdhw3q//op6HSjmkNovXxobYD7XMMFa4disRp7R/ggLGKOeTf2+WfDrQVJEg=
X-Received: by 2002:a6b:3a08:: with SMTP id h8-v6mr6278519ioa.32.1541735227960; 
 Thu, 08 Nov 2018 19:47:07 -0800 (PST)
MIME-Version: 1.0
References: <81e9a13c-3f8e-41bb-4aae-c7680817dbd3@yadro.com>
 <CAOSf1CEAqOgekkz3iq53n2mcn0MqFAUp1rbTAHdyDBFgajFpBw@mail.gmail.com>
 <a8bdf661-e7b8-6b8b-ed6b-afb29f8a6249@yadro.com>
In-Reply-To: <a8bdf661-e7b8-6b8b-ed6b-afb29f8a6249@yadro.com>
From: Oliver <oohall@gmail.com>
Date: Fri, 9 Nov 2018 14:46:55 +1100
Message-ID: <CAOSf1CFmREjv1EP-XaGGahD+ze8G+c+5vu4NRz-+TN2t7nDpHQ@mail.gmail.com>
Subject: Re: [Skiboot] Important details about race condition in
 EEH/NVMe-issue on ppc64le.
To: d.koltsov@yadro.com
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
Cc: a.senichev@yadro.com, Sergey Miroshnichenko <s.miroshnichenko@yadro.com>,
 s.kachkin@yadro.com, m.polyakov@yadro.com,
 skiboot list <skiboot@lists.ozlabs.org>,
 linuxppc-dev <linuxppc-dev@lists.ozlabs.org>
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

On Fri, Nov 9, 2018 at 2:30 AM Koltsov Dmitriy <d.koltsov@yadro.com> wrote:
>
> Hi, Oliver.
>
> Your version of EEH/NVMe-issue looks close to be true.
>
> I've applied simple patch to ./drivers/nvme/host/pci.c file:
>
> @@ -29,6 +29,7 @@
>  #include <linux/types.h>
>  #include <linux/io-64-nonatomic-lo-hi.h>
>  #include <linux/sed-opal.h>
> +#include <linux/delay.h>
>
>  #include "nvme.h"
>
> @@ -2073,11 +2074,14 @@
>
>  static int nvme_pci_enable(struct nvme_dev *dev)
>  {
> +    static int num=0;
>      int result = -ENOMEM;
>      struct pci_dev *pdev = to_pci_dev(dev->dev);
> +    num=num+1;
>
>      if (pci_enable_device_mem(pdev))
>          return result;
> +    msleep(num);
>
>      pci_set_master(pdev);
>
>
> and find out approximate minimal estimation of delay which removes the EEH/NVMe-issue.
> This delay is about 1 millisecond (see in the code above). So, it's a stable phenomena
> that when all nvme disks have minimum mutual interval of 1(one) millisecond (each) to
> enable upstream bridge then EEH/NVMe-issue is not reproducible. Hence, I have the
> hypothesis that due to bar alignment patch (see prev message) the bridge enabling procedure
> lasts significantly more time than in case of alignment=0.

> So, in correspondence with your
> hypothesis about several threads "pinging" PHB, it turns out that one of that threads
> begins to write to PHB, while necessary time is not passed yet (~1 ms).

No, only the first thread ever touches the hardware (PCI config space,
really). The first thread will set an in-memory flag which is seen by
the other threads and taken to mean that the bridge is already
enabled.

> HW error follows and readl() of NVME_REG_CSTS returns 0xffffffff in nvme_pci_enable().
> (And when align=0 the PHB enable procedure duration is significantly less than 1ms so
> other threads which don't enable PHB themselves - has no conflict, because by the time
> they tries to write to PHB - PHB is already really enabled).
> I don't see here contradictions in such version of events sequence leading
> to EEH/NVMe-issue.
>
> So, there are two questions:
>
> Q.1. Does my hypothesis about delay=1ms and about difference of PHB enable procedure
> duration in two cases (align=0 and align=64K) looks close to be true ?

*shrug*

Probably? Even if there is a difference in timing I don't see why that
is a problem. You might be taking (or not taking) a page fault due to
the alignment patch, or maybe there's some extra state inside of linux
that needed to be updated for some reason. It could be anything.
Fundamentally, the problem here is that Linux has a race condition.
Debugging the exact set of circumstances required to trigger the race
is sometimes worth it, but I don't think this is one of those cases.

If you honestly believe that there is a problem here then can you
provide us with some actual data rather than speculating about HW
bugs? The Linux ftrace (function_graph is useful) infrastructure
should allow you to do accurate measurements of the whole process and
get a breakdown of what the slow parts are. Once you have a good
overview of what code paths are being exercised in each case then you
can do more detailed measurements of specific functions.


> Q.2. If answer is 'yes' to Q.1 - are there some procedures in FW or HW implementation in
> POWER8 PHB that may "extend" phb enable procedure time execution because of alignment change
> to 64K ? May be in OPAL or on-chip ? Or the only "suspected area" for EEH/NVMe-issue -
> is in linux kernel procedures ?

I don't see any reason to suspect OPAL or the chip here.

Oliver

>
>
>
> Regards,
> Dmitriy.
>
