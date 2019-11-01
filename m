Return-Path: <SRS0=PnYa=YZ=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8ACAACA9ED1
	for <linuxppc-dev@archiver.kernel.org>; Fri,  1 Nov 2019 21:04:52 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 35D6021897
	for <linuxppc-dev@archiver.kernel.org>; Fri,  1 Nov 2019 21:04:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=rajagiritech-edu-in.20150623.gappssmtp.com header.i=@rajagiritech-edu-in.20150623.gappssmtp.com header.b="pZeGw3P0"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 35D6021897
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=rajagiritech.edu.in
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from bilbo.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 474ZSy19mmzF7KP
	for <linuxppc-dev@archiver.kernel.org>; Sat,  2 Nov 2019 08:04:50 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; spf=none (no SPF record)
 smtp.mailfrom=rajagiritech.edu.in (client-ip=2607:f8b0:4864:20::841;
 helo=mail-qt1-x841.google.com; envelope-from=jeffrin@rajagiritech.edu.in;
 receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none)
 header.from=rajagiritech.edu.in
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=rajagiritech-edu-in.20150623.gappssmtp.com
 header.i=@rajagiritech-edu-in.20150623.gappssmtp.com header.b="pZeGw3P0"; 
 dkim-atps=neutral
Received: from mail-qt1-x841.google.com (mail-qt1-x841.google.com
 [IPv6:2607:f8b0:4864:20::841])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 474WpJ5tYpzF6jB
 for <linuxppc-dev@lists.ozlabs.org>; Sat,  2 Nov 2019 06:04:40 +1100 (AEDT)
Received: by mail-qt1-x841.google.com with SMTP id x21so14200222qto.12
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 01 Nov 2019 12:04:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=rajagiritech-edu-in.20150623.gappssmtp.com; s=20150623;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=XhqExbZh5kPvj3K4NZnoOcF081VOsziHuz7IlqtxrcQ=;
 b=pZeGw3P0RHdQki9K0gEObnP8OHglDuZpmvPq+OFKsU6xgeQL13BnAHlulP/AXJaNhH
 ZwTok1P9GNkau5IjixzgvwHoRsMHZDO4mQHl58gONYUVmICu+ICmGAtlNEveE0COrV9y
 /Xa/uFFqFErQaCPkaMjXEPyOF3xZXKviJzxY5RswiEk3RU1cFRsNAAq86vhLr+M4iejN
 DUSzb9XHpmVLLc2pvB9NkEKqyofyX55556V+I2ArroDUo1pUEBLty4g6IEse0WyTjh8w
 PDU5nOG+jTcNTKTvoqF9nxDfT1BF6OsABjs+f7dv3bSZ1ICuWpkn9uNUWSuindYPhE30
 ehAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=XhqExbZh5kPvj3K4NZnoOcF081VOsziHuz7IlqtxrcQ=;
 b=oU6QVEDXRrmJVlVegvSx0DE6/jJBm0ujsLGK4MySBMU/oLWpcjsrVa8XPPmvmGMrYV
 AvC3tq7qLCNTnGFqnO/S4j8m2MGBykUWMsGVAiVUQDHKcz2E/LaelilsgT+zD7lTgrTY
 GCbqpB9+gf7tpWt157h4deCR2C4MAmKe+wecYz9lVBJfiaCqoknjjn31TrWjztt7dDH/
 TaztsoNJW2rbo4u7FBZujxjESIoryyw0e9g0zXBbPisaSyqWvlUNRIi/ZZkag1h36IxK
 uBiRn7n21IeIsJwv+CJ0CFRvHNKV0mbmIASFaN1TNr7BZz1N0juiWr1Bs2yXEiPRxWZy
 e/Pw==
X-Gm-Message-State: APjAAAX7N0nXoVOgxcPRhT4i2DvlPK8myn+jJOb9x02KF8vzMtGcxaMa
 w1/Sdh3kJUi+5BK8gJvFXOo5r6h7KP1p1HW317qDaQ==
X-Google-Smtp-Source: APXvYqzaVfaVFf4/E1qtu06OCKxRakja8j6eb7eFWaPT90bJMEaqpKJybo0BQto3pfGWV02Havz8W/MP/51N1VZFBBk=
X-Received: by 2002:a0c:c392:: with SMTP id o18mr11435117qvi.75.1572635077831; 
 Fri, 01 Nov 2019 12:04:37 -0700 (PDT)
MIME-Version: 1.0
References: <CAG=yYwmQHyp62qKDoiM091iXKs5iP8rNBLs9kc7Wi_PDCgMrbw@mail.gmail.com>
In-Reply-To: <CAG=yYwmQHyp62qKDoiM091iXKs5iP8rNBLs9kc7Wi_PDCgMrbw@mail.gmail.com>
From: Jeffrin Thalakkottoor <jeffrin@rajagiritech.edu.in>
Date: Sat, 2 Nov 2019 00:34:01 +0530
Message-ID: <CAG=yYwmYCLOktQxhsyjarybbR+aF2Z3RuXVj4hfE5wD_6nJjNA@mail.gmail.com>
Subject: Re: PROBLEM: PCIe Bus Error atleast
To: ruscur@russell.cc, sbobroff@linux.ibm.com, oohall@gmail.com, 
 Bjorn Helgaas <bhelgaas@google.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailman-Approved-At: Sat, 02 Nov 2019 08:00:22 +1100
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
Cc: linux-pci@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
 lkml <linux-kernel@vger.kernel.org>, stable@vger.kernel.org
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

On Sat, Nov 2, 2019 at 12:15 AM Jeffrin Thalakkottoor
<jeffrin@rajagiritech.edu.in> wrote:

> But i think when i tried again today i could not reprodu....
i do not know why, but now iam able to reproduce the error

more details follows
---------------------x------x------------------------------------------
GNU Make            4.2.1
Binutils            2.33.1
Util-linux          2.33.1
Mount                2.33.1
Linux C Library      2.29
Dynamic linker (ldd) 2.29
Procps              3.3.15
Kbd                  2.0.4
Console-tools        2.0.4
Sh-utils            8.30
Udev                241
------------------------x-----------------x---------------------------

$gcc --version
gcc (Debian 9.2.1-14) 9.2.1 20191025
Copyright (C) 2019 Free Software Foundation, Inc.
This is free software; see the source for copying conditions.  There is NO
warranty; not even for MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.

---------------------x----------x----------------------------------

-- 
software engineer
rajagiri school of engineering and technology
