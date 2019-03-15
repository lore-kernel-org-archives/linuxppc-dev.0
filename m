Return-Path: <SRS0=ejpM=RS=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 44E5FC43381
	for <linuxppc-dev@archiver.kernel.org>; Fri, 15 Mar 2019 16:20:45 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8562A218A1
	for <linuxppc-dev@archiver.kernel.org>; Fri, 15 Mar 2019 16:20:44 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8562A218A1
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 44LW5k1psdzDqV4
	for <linuxppc-dev@archiver.kernel.org>; Sat, 16 Mar 2019 03:20:42 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=gmail.com
 (client-ip=209.85.210.65; helo=mail-ot1-f65.google.com;
 envelope-from=mathieu.malaterre@gmail.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=none (p=none dis=none) header.from=debian.org
Received: from mail-ot1-f65.google.com (mail-ot1-f65.google.com
 [209.85.210.65])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 44LW3p32FpzDqSP
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 16 Mar 2019 03:19:02 +1100 (AEDT)
Received: by mail-ot1-f65.google.com with SMTP id i5so8827297oto.9
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 15 Mar 2019 09:19:01 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=ewAkjJwJpYX3yW9SyR7JgkicO5mIwBEy069OvFBTXUA=;
 b=gaNkyApq4JfA4Had3Y48+DCw0Jhf1i1WRgjhMxNmdej/7LF3n6FxTqs1Ji2uS0gBjH
 k1db5jo7yrSKYXRQcwIiwjvQMIgn7vx7tHbjjnnYLJUXwOL+oFRd5TtMAOyF0WQRMDO9
 y709Z0w8n6Ien8pNM1yJQa4fzuHaOZPBpkBYJ14mnLiW9cbcBbX5DZbcddxim/4aZLZL
 FcUq0ZSGH9QTIfFzYc2lCmLFUi6x1uozwyDgSwWkmnZ7BzzMOcfxPZ/ov9OFs2tFpclO
 L1MbUdyfS+zmLbjqQAyTryvgGPI/6o3SMepiSYFJEwm05rPWkVKMnHi/u2fekNX57MCB
 kPBg==
X-Gm-Message-State: APjAAAUjDqrvqvatQxpJq8WVML/eYK/Yrrd+H2Rk0OGrd3LRBy+ZMtdC
 8hmwGiwCRIt/NdA4ac9TsTKRmNWKiW6ZNDIPl+kjvF4Z
X-Google-Smtp-Source: APXvYqyGXBnE3F2moNN5LkjfW2AvGXUrRbMUqjHq7ndd1dvsn0tjQTlgH/hGlGd27lUthhPI9HA4wu3iiw1wABJKUKs=
X-Received: by 2002:a9d:5616:: with SMTP id e22mr2701820oti.365.1552666739184; 
 Fri, 15 Mar 2019 09:18:59 -0700 (PDT)
MIME-Version: 1.0
References: <cf3327d8-3e04-2f37-4734-5525a5b638b2@ilande.co.uk>
In-Reply-To: <cf3327d8-3e04-2f37-4734-5525a5b638b2@ilande.co.uk>
From: Mathieu Malaterre <malat@debian.org>
Date: Fri, 15 Mar 2019 17:18:47 +0100
Message-ID: <CA+7wUsw5fVu_a7SFjpKGNoDFrBG5g=+VGHZ47BDw_rceESnhgQ@mail.gmail.com>
Subject: Re: Mac Mini G4 hang on boot with git master
To: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
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
Cc: Paul Mackerras <paulus@samba.org>,
 linuxppc-dev <linuxppc-dev@lists.ozlabs.org>
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

Mark,

On Fri, Mar 15, 2019 at 3:08 PM Mark Cave-Ayland
<mark.cave-ayland@ilande.co.uk> wrote:
>
> Hi all,
>
> I've just done a git pull and rebuilt master on my Mac Mini G4 in order to test
> Michael's merge of my KVM PR fix, and unfortunately my kernel now hangs on boot :(

Ouch :(

> My last working git checkout was somewhere around the 5.0-rc stage, so I suspect it's
> something that's been merged for 5.1.

OK. My last kernel is also somewhere around here on same hardware.

> The hang occurs just after the boot console is disabled which makes me wonder if
> something is going wrong during PCI bus enumeration. Does anyone have an idea as to
> what may be causing this? I can obviously bisect it down, but on slow hardware it can
> take some time...

When doing git bisect I compile from my amd64 machine using:

make O=g4 ARCH=powerpc CROSS_COMPILE=powerpc-linux-gnu- my_defconfig
make -j8 O=g4 ARCH=powerpc CROSS_COMPILE=powerpc-linux-gnu- bindeb-pkg
scp *image*.deb macminig4:

On Debian simply install:

# apt-get install crossbuild-essential-powerpc

>
> ATB,
>
> Mark.
