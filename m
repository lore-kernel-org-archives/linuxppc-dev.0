Return-Path: <SRS0=tbgD=FI=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E9714C433FE
	for <linuxppc-dev@archiver.kernel.org>; Fri,  4 Dec 2020 10:05:36 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 19A7422795
	for <linuxppc-dev@archiver.kernel.org>; Fri,  4 Dec 2020 10:05:35 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 19A7422795
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from bilbo.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 4CnSy474HvzDrVb
	for <linuxppc-dev@archiver.kernel.org>; Fri,  4 Dec 2020 21:05:32 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized)
 smtp.mailfrom=gmail.com (client-ip=209.85.210.68; helo=mail-ot1-f68.google.com;
 envelope-from=geert.uytterhoeven@gmail.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none)
 header.from=linux-m68k.org
Received: from mail-ot1-f68.google.com (mail-ot1-f68.google.com
 [209.85.210.68])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4CnSw06J7QzDqcX
 for <linuxppc-dev@lists.ozlabs.org>; Fri,  4 Dec 2020 21:03:43 +1100 (AEDT)
Received: by mail-ot1-f68.google.com with SMTP id j12so4639001ota.7
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 04 Dec 2020 02:03:43 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=GLHkAaCfT5pWLivXy5Xgz7u2ThT5u7Up7pqYnjb3zk4=;
 b=ctkmL2sBdgEAnWSVCnqpDUBDI1j4vDsdSbh9v8mKJb3z7L7lHDbyr5u/v8q37LGQEa
 vHOyh91im0m01uXbiet0fP14t4QPx63p2BxauD5EWvh2UCPY9IwzAXyITYy8S7JsZ2Qm
 OLT4otflN+PT4Dp5LQaY+iBoBWPaoebZ36hh84Mot6rMPTMqN8tdDv+QlGUuNpI/GGnp
 nlo8KQGNJ0JjcvLagVsrOPy9GUN3b8WmrEAmBEbqLoBMBd1mFSAHi7PjO4SmqzKAevbZ
 +ddqHbVB3y+Fpfbre/wBgvaljyLvlQ69HQB7zGGEToGbAbWNO2qKDt9DDLjf1HFBIRb9
 Yxew==
X-Gm-Message-State: AOAM530TiIQTGlciLeT468iTdGQcZIq/oZka7ipswuWVXYWcWMii54js
 PKDAHDaA4kIsRGIV/afVetO3YLcWSPUNoRw3Qfg=
X-Google-Smtp-Source: ABdhPJwneqGTjDCkbUTC2ItnGioumAlpRvEPmt3RmzMhCsLQ/Q/or7PoHA7wd7YwsmnMcli7X16du4mh6qdRhD9gAXg=
X-Received: by 2002:a9d:2203:: with SMTP id o3mr3024405ota.107.1607076220971; 
 Fri, 04 Dec 2020 02:03:40 -0800 (PST)
MIME-Version: 1.0
References: <58bba4310da4c29b068345a4b36af8a531397ff7.1605847196.git.fthain@telegraphics.com.au>
In-Reply-To: <58bba4310da4c29b068345a4b36af8a531397ff7.1605847196.git.fthain@telegraphics.com.au>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Fri, 4 Dec 2020 11:03:30 +0100
Message-ID: <CAMuHMdVYf83+y1aUR6HqCgr-CLfWYvbuynpfogLrt3cXA-9_aA@mail.gmail.com>
Subject: Re: [PATCH] macintosh/adb-iop: Send correct poll command
To: Finn Thain <fthain@telegraphics.com.au>
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
Cc: linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
 Joshua Thompson <funaho@jurai.org>
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

Hi Finn,

On Fri, Nov 20, 2020 at 5:54 AM Finn Thain <fthain@telegraphics.com.au> wrote:
> The behaviour of the IOP firmware is not well documented but we do know
> that IOP message reply data can be used to issue new ADB commands.
> Use the message reply to better control autopoll behaviour by sending
> a Talk Register 0 command after every ADB response, not unlike the
> algorithm in the via-macii driver. This poll command is addressed to
> that device which last received a Talk command (explicit or otherwise).
>
> Cc: Joshua Thompson <funaho@jurai.org>
> Fixes: fa3b5a9929fc ("macintosh/adb-iop: Implement idle -> sending state transition")

WARNING: Unknown commit id 'fa3b5a9929fc', maybe rebased or not pulled?

32226e817043?

> Tested-by: Stan Johnson <userm57@yahoo.com>
> Signed-off-by: Finn Thain <fthain@telegraphics.com.au>

Thanks, will queue in the m68k for-v5.11 branch.

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
