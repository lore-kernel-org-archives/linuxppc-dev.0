Return-Path: <SRS0=psBJ=MK=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5AD78C43143
	for <linuxppc-dev@archiver.kernel.org>; Fri, 28 Sep 2018 19:46:19 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B812C206B7
	for <linuxppc-dev@archiver.kernel.org>; Fri, 28 Sep 2018 19:46:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="L0la1++K"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B812C206B7
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from bilbo.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 42MMcS37XgzF38T
	for <linuxppc-dev@archiver.kernel.org>; Sat, 29 Sep 2018 05:46:16 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="L0la1++K";
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=gmail.com
 (client-ip=2607:f8b0:4864:20::443; helo=mail-pf1-x443.google.com;
 envelope-from=frowand.list@gmail.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=gmail.com header.i=@gmail.com header.b="L0la1++K"; 
 dkim-atps=neutral
Received: from mail-pf1-x443.google.com (mail-pf1-x443.google.com
 [IPv6:2607:f8b0:4864:20::443])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 42MMYZ3bDBzF3D5
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 29 Sep 2018 05:43:45 +1000 (AEST)
Received: by mail-pf1-x443.google.com with SMTP id m77-v6so4973092pfi.8
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 28 Sep 2018 12:43:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=subject:to:references:from:message-id:date:user-agent:mime-version
 :in-reply-to:content-language:content-transfer-encoding;
 bh=qaPhD6rv8H89D7FJbfdnco6OZQTc6wBSoptqEJoVefg=;
 b=L0la1++Ko4JUBdPvRXO2icIbw5IY1p3cE22UDvKo3xGZ5qYOBLGt5wkhExKUJMfg6X
 6R6K5vdge37mQytFGnZVM7SP8HR6krvXygH2iRiIQLeZD4IkDHQSlfnFs5sF20qoSMBt
 OmA984k7WorJMCnrQEph+8GiHdcINRAN+Gij22EkxxRRCEwWE1JqJkyiOFOGpozv1cln
 z8Cwm3pu4Y0mUW8uEO4mbUPHyG4UD8jBgNM0mRautZ2bHc73mSuwnJYBmSQEoDkEmUB5
 /JTKEFGpDWsLCHRdmqXJsOWqMrupqQhk1a87ZozpMV7lfEORmB9frVrkKRneW4zpipwG
 OixA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=qaPhD6rv8H89D7FJbfdnco6OZQTc6wBSoptqEJoVefg=;
 b=pGKz+DhasHTRNAYyy6Lt9hspkQXHXS9VOv90sW+ScX5x+IgRCjio0bpcHiX0wvNcF9
 4OVx1bWID7g2ZaDWOTZlO86pkugxTJiwFrbp0dFCsZw3x+FDd7cWXgahmG/TSKvfH5mK
 ohVV0vdumUE5C0v6ncTi3AJDk7G1cmKgXCss6bX/1mSzbTG/OEjRv6wzehjcC6fSDiHl
 9zCun2K0B+lXlLeM5Rome8o/Fphk96AhoCkUrKoaxluN4XLHu8osm7CKsPIksHmoN/gZ
 17S3jMNQNiVAGS704Ki8kdKqQDbF9rvUaj+0kmgbmyiHLV62ae1SMhBMvB07MPFWwZMR
 O8Fg==
X-Gm-Message-State: ABuFfoiF1oOA58er3otibR1H5YRoB+EItjST+93hNKMaE0vQVY5J4dDa
 lHOZi9W1eetk0t9kwKdFsUM=
X-Google-Smtp-Source: ACcGV6365sUTWzdOq8ocJpwKVKkB1rOXhfyHa0pd1EIa1HPQ9PRuP/hM2OMrvXje0ogzebkHycxqMg==
X-Received: by 2002:a17:902:6907:: with SMTP id
 j7-v6mr112200plk.232.1538163823229; 
 Fri, 28 Sep 2018 12:43:43 -0700 (PDT)
Received: from [192.168.1.70] (c-24-6-192-50.hsd1.ca.comcast.net.
 [24.6.192.50])
 by smtp.gmail.com with ESMTPSA id 77-v6sm8181310pfw.159.2018.09.28.12.43.42
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Fri, 28 Sep 2018 12:43:42 -0700 (PDT)
Subject: Re: drivers binding to device node with multiple compatible strings
To: Li Yang <leoyang.li@nxp.com>, Rob Herring <robh+dt@kernel.org>,
 Grant Likely <grant.likely@secretlab.ca>,
 "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS"
 <devicetree@vger.kernel.org>, lkml <linux-kernel@vger.kernel.org>,
 "moderated list:ARM/FREESCALE IMX / MXC ARM ARCHITECTURE"
 <linux-arm-kernel@lists.infradead.org>,
 linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
 Frank Rowand <frowand.list@gmail.com>
References: <CADRPPNT0QiBkJtJnxjW95Yf-mirL5OzRrvqj8rC-O8fiz17VnA@mail.gmail.com>
From: Frank Rowand <frowand.list@gmail.com>
Message-ID: <ecbf11cd-a140-fe7e-392a-bccbf8224d14@gmail.com>
Date: Fri, 28 Sep 2018 12:43:41 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <CADRPPNT0QiBkJtJnxjW95Yf-mirL5OzRrvqj8rC-O8fiz17VnA@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
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


+ Frank

On 09/27/18 15:25, Li Yang wrote:
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
> 
> Regards,
> Leo
> 

