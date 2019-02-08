Return-Path: <SRS0=r06i=QP=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A2FEFC169C4
	for <linuxppc-dev@archiver.kernel.org>; Fri,  8 Feb 2019 15:20:02 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1D1B320855
	for <linuxppc-dev@archiver.kernel.org>; Fri,  8 Feb 2019 15:20:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XlB7haGH"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1D1B320855
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 43wzPr0lYZzDqWR
	for <linuxppc-dev@archiver.kernel.org>; Sat,  9 Feb 2019 02:20:00 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=gmail.com
 (client-ip=2a00:1450:4864:20::42a; helo=mail-wr1-x42a.google.com;
 envelope-from=chunkeey@gmail.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=gmail.com header.i=@gmail.com header.b="XlB7haGH"; 
 dkim-atps=neutral
Received: from mail-wr1-x42a.google.com (mail-wr1-x42a.google.com
 [IPv6:2a00:1450:4864:20::42a])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 43wzMb0LvpzDqWN
 for <linuxppc-dev@lists.ozlabs.org>; Sat,  9 Feb 2019 02:18:01 +1100 (AEDT)
Received: by mail-wr1-x42a.google.com with SMTP id q1so3954009wrp.7
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 08 Feb 2019 07:18:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=IFhcMQXdk+STC2gJ/0WkrkVa5+osKsUyQ0yqgHECJec=;
 b=XlB7haGHqAl7DADrQTpF2RPvgvoBFJYiZrDu7qJYVPFLDYOteRIghEONEHyV5qtqq2
 HnVg/7ssql16dTFLgiT2EXv6vwdGKJiJmcRGVZffdz5gc7WaJFq+vLvxsh7ShT8kgulD
 5fD7k8AjokeFcyw9nWGNOy8CIUVgXkY2NGSde2TxHB2zBWHKm3ljPwvvLZ/mLHOaVIbk
 K4divpXynk2kzczASOUH7glzRrxHG4TuZgBD5mLiOTu9rc1AZe5jd3a+R11Q326wnRIK
 CDGsc9gHi8OeCXPowqjDofSvNHO+PucDF5ItOWU/HorlQnSMnGSuTy4IDnat/FE2VIkD
 KXOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=IFhcMQXdk+STC2gJ/0WkrkVa5+osKsUyQ0yqgHECJec=;
 b=EKhYmwx5asHh5uj0aS98nsTtWhQaQw6cbVYkLi8RzfDya3Z6Ry5f7DT2X/NU8kJI7P
 tpRpb4bM08eXjcywYSDE3+d14Q44CDHmyxvgfQI5fJ5udo9Wh3f/m6YPL8+Mk4xB3nJP
 KYI1nx8vvqO68HCdgAVKehSyneH8UXv2fILjo7cih/K3Ko16ahaiF6dBuzfzoYW4qngk
 YFOBnTqEVk5DnyFVyoILlZ3owtR6wrVDFn2hJXSrP+Gn80Vj0el0pWrM6Qzk5OAj5x3C
 LnEf62Alr2kbD+Zo8msIhMAaDPtBPtM4T66z+1TFQ1sVVasDuosmyPuikvldHQobqeg1
 idfQ==
X-Gm-Message-State: AHQUAuYSS7opZgoXU9r1Dz/OU4Aehn+M4TgmGZ+PS5xV3fFUCk1HdyeZ
 rGdE/Gi4kpSzxoeJMFsNs8o=
X-Google-Smtp-Source: AHgI3IZPLtc93JiTmEgbToPSj8+0CxQ9g1jqjDVdyyKkiqcJN6tdUP3n0V1Jo5ZjMcbnXMpvP3Tg7A==
X-Received: by 2002:adf:9f53:: with SMTP id f19mr9678567wrg.154.1549639078344; 
 Fri, 08 Feb 2019 07:17:58 -0800 (PST)
Received: from debian64.daheim (p5B0D706E.dip0.t-ipconnect.de. [91.13.112.110])
 by smtp.gmail.com with ESMTPSA id i186sm5305532wmd.19.2019.02.08.07.17.56
 (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
 Fri, 08 Feb 2019 07:17:57 -0800 (PST)
Received: from localhost.daheim ([127.0.0.1] helo=debian64.localnet)
 by debian64.daheim with esmtp (Exim 4.92-RC5)
 (envelope-from <chunkeey@gmail.com>)
 id 1gs7ue-0003cP-HM; Fri, 08 Feb 2019 16:17:56 +0100
From: Christian Lamparter <chunkeey@gmail.com>
To: Michael Ellerman <mpe@ellerman.id.au>
Subject: Re: powerpc: Enable kernel XZ compression option on 44x
Date: Fri, 08 Feb 2019 16:17:56 +0100
Message-ID: <2535516.UbJpQZMh7o@debian64>
In-Reply-To: <43wwMR1cjjz9sPG@ozlabs.org>
References: <43wwMR1cjjz9sPG@ozlabs.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
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
Cc: Paul Mackerras <paulus@samba.org>, Pawel Dembicki <paweldembicki@gmail.com>,
 linuxppc-dev@lists.ozlabs.org
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

On Friday, February 8, 2019 2:02:41 PM CET Michael Ellerman wrote:
> On Thu, 2019-01-31 at 20:59:04 UTC, Christian Lamparter wrote:
> > Enable kernel XZ compression option on 44x.
> > Tested on a Western Digital - MyBook Live NAS.
> > It takes 22 seconds for the 800 MHz CPU to decompress
> > and boot a 2.63 MiB XZ-compressed kernel simpleImage.
> > 
> > Signed-off-by: Christian Lamparter <chunkeey@gmail.com>
> 
> Applied to powerpc next, thanks.
> 
> https://git.kernel.org/powerpc/c/423bfc69d7f491c47fc35921f7d460be
> 
> cheers
> 

Hello,

I'm happy to report that a xz compressed kernel (as simpleImage)
also booted on a TP-Link WDR4900-v1 (Freescale P1014):
<https://github.com/openwrt/openwrt/pull/1773#issuecomment-461082045>

Hence, I'm inclined to also add PPC_85xx to list in /arch/powerpc/KConfig

|select HAVE_KERNEL_XZ			if PPC_BOOK3S || 44x || PPC_85xx

But on the other hand, it could very well be that more or all? PPC
would benifit from having HAVE_KERNEL_XZ available. What do you think?
(If you know of any interesting ARCHs, I could ask around too.)

Regards,
Christian


