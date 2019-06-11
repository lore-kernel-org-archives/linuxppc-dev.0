Return-Path: <SRS0=3S3E=UK=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 67FC1C4321A
	for <linuxppc-dev@archiver.kernel.org>; Tue, 11 Jun 2019 12:34:31 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id AED0B20673
	for <linuxppc-dev@archiver.kernel.org>; Tue, 11 Jun 2019 12:34:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HmzY8iGW"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AED0B20673
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 45NTw34b9PzDqY4
	for <linuxppc-dev@archiver.kernel.org>; Tue, 11 Jun 2019 22:34:27 +1000 (AEST)
Received: from ozlabs.org (bilbo.ozlabs.org [203.11.71.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 45NTqf4TPCzDqP0
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 11 Jun 2019 22:30:38 +1000 (AEST)
Authentication-Results: lists.ozlabs.org;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=gmail.com header.i=@gmail.com header.b="HmzY8iGW"; 
 dkim-atps=neutral
Received: from ozlabs.org (bilbo.ozlabs.org [203.11.71.1])
 by bilbo.ozlabs.org (Postfix) with ESMTP id 45NTqf3WPCz8v22
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 11 Jun 2019 22:30:38 +1000 (AEST)
Received: by ozlabs.org (Postfix)
 id 45NTqf2k8cz9sDX; Tue, 11 Jun 2019 22:30:38 +1000 (AEST)
Authentication-Results: ozlabs.org; spf=pass (mailfrom) smtp.mailfrom=gmail.com
 (client-ip=2607:f8b0:4864:20::e31; helo=mail-vs1-xe31.google.com;
 envelope-from=oded.gabbay@gmail.com; receiver=<UNKNOWN>)
Authentication-Results: ozlabs.org;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=gmail.com header.i=@gmail.com header.b="HmzY8iGW"; 
 dkim-atps=neutral
Received: from mail-vs1-xe31.google.com (mail-vs1-xe31.google.com
 [IPv6:2607:f8b0:4864:20::e31])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id 45NTqd6m9mz9sDB
 for <linuxppc-dev@ozlabs.org>; Tue, 11 Jun 2019 22:30:37 +1000 (AEST)
Received: by mail-vs1-xe31.google.com with SMTP id 190so4178131vsf.9
 for <linuxppc-dev@ozlabs.org>; Tue, 11 Jun 2019 05:30:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:from:date:message-id:subject:to:cc;
 bh=gz3HqulYPvDCNfbcUEJOb/UAkc1+ZcJON/gujaAEXD0=;
 b=HmzY8iGWE4Yk2oQRLRu48hKTyF8RzCNOzW/P5czsYYSgeANwSG+7RB8x39I6COkeBo
 JcYesfnyAib72/r4g5eWMnHv+ERjOr4XUa5xuSjLNx78fao7r2xHdDmnsZxIuFEU5Arb
 hlpJV9tcKcmPHjXYIMHc4iaydhZtEr1B20FkFWf01CU4gLjCcj9VUtflJ4c4Gxq/DqK5
 oNgFcgLIEiMItMiuy9SEFaUq8VgiJuEKYouU5HrZ7Jl48rY8yjRy/6j5MwUvDveR//R1
 OT11uoUr7a1M6gPNxJpfetuKgW8J6TbkhZco124MfYsGGWu40AJjTfY+Apv5S7J4VB/d
 5Q0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:from:date:message-id:subject:to:cc;
 bh=gz3HqulYPvDCNfbcUEJOb/UAkc1+ZcJON/gujaAEXD0=;
 b=CU7Qn/9SkOX9fNNksbcRMdDvFHuQTsRoH3wONO5ljtQB77VkDgqnKbl+OppeR/EjZo
 sDsMRvTtXkwFKwKHi78sEUas7sVjmulrvIxHvwZsout2r7YebHU9V+NInbzRS3wBQDW+
 p6XdpaKU+kYFMRQ24B9yUIuDpUuXxFN+yQO19QrrfZ3xcwBvivFT7poaUtF7+D3JHZ7M
 4Et0nyXlCnWfhuIRPJhkpXT8YENTqmjv7ebfIrnJY5fwrshfnGB4WNafK3H+VdojdzIm
 KAkAZCaI2EpBZGPrG++FGgezTXdc17jDg7EcZoBTdWeRsdSvlu3P8boCMpgD+QruGINR
 gU3g==
X-Gm-Message-State: APjAAAWpD+lGW/mK6Imnxvxc+ei2NB3OdMtb7xNN+FX9rTcrRRA9ETem
 7rWGPn1G+LE4GFoYEzDp3ZiLfIdIc8j3ZyTlheBAQ3Mk7Ws=
X-Google-Smtp-Source: APXvYqxI2htrUVQ9hXzBCZmaHeqhE6ujSVrkHU5bi67mzovbs8gfkWsrmJRj2Q+VZ4j3ipY/gTnP/L8YtSnmQPjiPuA=
X-Received: by 2002:a67:eada:: with SMTP id s26mr24905937vso.163.1560256234020; 
 Tue, 11 Jun 2019 05:30:34 -0700 (PDT)
MIME-Version: 1.0
From: Oded Gabbay <oded.gabbay@gmail.com>
Date: Tue, 11 Jun 2019 15:30:08 +0300
Message-ID: <CAFCwf11EM9+NDML9hQmk9-rPzSmDmAyVLW+qOfs6h62dGK6H9A@mail.gmail.com>
Subject: Question - check in runtime which architecture am I running on
To: linuxppc-dev@ozlabs.org
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
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 "Linux-Kernel@Vger. Kernel. Org" <linux-kernel@vger.kernel.org>
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

Hello POWER developers,

I'm trying to find out if there is an internal kernel API so that a
PCI driver can call it to check if its PCI device is running inside a
POWER9 machine. Alternatively, if that's not available, if it is
running on a machine with powerpc architecture.

I need this information as my device (Goya AI accelerator)
unfortunately needs a slightly different configuration of its PCIe
controller in case of POWER9 (need to set bit 59 to be 1 in all
outbound transactions).

Currently I'm reading the PCI vendor and device ID of the parent PCI
bus device and checking if it is PHB4 but that is an ugly hack. (see
this commit - https://github.com/HabanaAI/linux/commit/1efd75ad5c9779b99a9a38c899e4e25e227626bf)

I dug through the code but didn't find anything that can help me so I
thought of asking more experienced people.

Thanks,
Oded
