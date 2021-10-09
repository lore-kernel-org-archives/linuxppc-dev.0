Return-Path: <SRS0=vnEJ=O5=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 93FB7C433EF
	for <linuxppc-dev@archiver.kernel.org>; Sat,  9 Oct 2021 11:31:34 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0B08660F35
	for <linuxppc-dev@archiver.kernel.org>; Sat,  9 Oct 2021 11:31:33 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 0B08660F35
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=svenpeter.dev
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.ozlabs.org
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4HRNDh40bwz3cCY
	for <linuxppc-dev@archiver.kernel.org>; Sat,  9 Oct 2021 22:31:32 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=svenpeter.dev header.i=@svenpeter.dev header.a=rsa-sha256 header.s=fm2 header.b=TtbRWbUc;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm1 header.b=UXA09pFY;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized)
 smtp.mailfrom=svenpeter.dev (client-ip=66.111.4.230;
 helo=new4-smtp.messagingengine.com; envelope-from=sven@svenpeter.dev;
 receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=svenpeter.dev header.i=@svenpeter.dev
 header.a=rsa-sha256 header.s=fm2 header.b=TtbRWbUc; 
 dkim=pass (2048-bit key;
 unprotected) header.d=messagingengine.com header.i=@messagingengine.com
 header.a=rsa-sha256 header.s=fm1 header.b=UXA09pFY; 
 dkim-atps=neutral
Received: from new4-smtp.messagingengine.com (new4-smtp.messagingengine.com
 [66.111.4.230])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4HRNCW3XxCz3bhZ
 for <linuxppc-dev@lists.ozlabs.org>; Sat,  9 Oct 2021 22:30:31 +1100 (AEDT)
Received: from compute1.internal (compute1.nyi.internal [10.202.2.41])
 by mailnew.nyi.internal (Postfix) with ESMTP id 5E8EA580958;
 Sat,  9 Oct 2021 07:30:29 -0400 (EDT)
Received: from imap47 ([10.202.2.97])
 by compute1.internal (MEProxy); Sat, 09 Oct 2021 07:30:29 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=svenpeter.dev;
 h=mime-version:message-id:in-reply-to:references:date:from:to
 :cc:subject:content-type; s=fm2; bh=yjaV+Aq620PMH7q1EGIlum03SV/o
 UJx+i3qPZXiQFDo=; b=TtbRWbUcBV+Pt/wwY/RcU/PWNZf/aE5l2kf3EqdnxHyI
 s/yjd8KH80LtAUZw+tZqwEIE4Zpnz4v3nwG35xb2ggpdkYpzfQBFvQQfO4aPh1lr
 sFbmnXX5WxwoSvpY0X59wJggzlhXTgS9vlHm5QADlFABxj1ayBvSJxKBIXH6sg7E
 gLndLhRj6vPqQfZA1lDNnEEGWiD6ljmj2wjbglk4hT8niJ57x0Sjtyi1vELsXF5u
 yKPsqXK2Xp5YB3bKdaAbkD+sn9lOmyOSzmiOF/kp64QyZMJpY3lmlQHsWwE5qqaE
 E0g8V4wTs3iYwzsSfQjlRtnWziDpFN1a2p/jznFptA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to:x-me-proxy
 :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; bh=yjaV+A
 q620PMH7q1EGIlum03SV/oUJx+i3qPZXiQFDo=; b=UXA09pFYq8poDEewrBZO/U
 fECE+f2C6Yr12nJ2G/gFdQCCUQ4KMqaXRO+qm9jFR2IfTinRAcfUjm07sovsQGNy
 CWP74ZGzFogkt2FtxneokoR/u6NEeD6LaSg0b6sLirYQaOhGWzgpRyepJVu/GBHL
 SAjP8dhjoMqBPXgm6PVcU2vzuGReKr/PXEBtVrVN4ne4eaLYeZ5oiLVOQGR9NGux
 +zjSmlDpr87cAj9Ad4ZVrCrQGzbyY4nyQ9pLvVCJh+4h3q+lUBMvtXV/JjN1lUhD
 m/SOwHsRjBtQEV4ep/hEn62GLicp6xSgGRyEc8xRizkzXDSKz2bGbid6pORLf4+Q
 ==
X-ME-Sender: <xms:VX1hYSHM9wpcHz3dl4pvcwuQ4d0QTZggyf4_5yEDj1DuLTlCXEGFQg>
 <xme:VX1hYTWsSWEri_U3HMEpXyRQN-syL6FGCKjR9PSwnmHGNtW1gIvHKDVhksKWyqeTP
 zYR9w8DLPXVgka6A2s>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvtddrvddtvddgfeelucetufdoteggodetrfdotf
 fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
 uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
 cujfgurhepofgfggfkjghffffhvffutgesthdtredtreertdenucfhrhhomhepfdfuvhgv
 nhcurfgvthgvrhdfuceoshhvvghnsehsvhgvnhhpvghtvghrrdguvghvqeenucggtffrrg
 htthgvrhhnpefgieegieffuefhtedtjefgteejteefleefgfefgfdvvddtgffhffduhedv
 feekffenucevlhhushhtvghrufhiiigvpedunecurfgrrhgrmhepmhgrihhlfhhrohhmpe
 hsvhgvnhesshhvvghnphgvthgvrhdruggvvh
X-ME-Proxy: <xmx:VX1hYcJIUkumBhOboIGcPzOSd3Q68zSU0NnI6cQS0J1SKKV1VH7bGQ>
 <xmx:VX1hYcGyIpP_rA6g78dAqg2XrjxW6uAFwXBUixeruzkYGyKV9_88iQ>
 <xmx:VX1hYYVGjzYwDIq2aDY5MHYgHst_-h-0jaa1kWLSBq62ec5ch2kw5A>
 <xmx:VX1hYZXTR3ZuA4FZ68Uk-RiVbnnvBJslbxivCXImn4Waiv7c4wHgVw>
Received: by mailuser.nyi.internal (Postfix, from userid 501)
 id 3FA6D2740061; Sat,  9 Oct 2021 07:30:29 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.5.0-alpha0-1331-g5ae342296a-fm-20211005.001-g5ae34229
Mime-Version: 1.0
Message-Id: <2f0c7001-475e-4790-b90d-a6d9e1341563@www.fastmail.com>
In-Reply-To: <YWFqr4uQGlNgnT1z@ninjato>
References: <20211008163532.75569-1-sven@svenpeter.dev>
 <YWFqr4uQGlNgnT1z@ninjato>
Date: Sat, 09 Oct 2021 13:30:09 +0200
From: "Sven Peter" <sven@svenpeter.dev>
To: "Wolfram Sang" <wsa@kernel.org>
Subject: Re: [PATCH v2 00/11] Add Apple M1 support to PASemi i2c driver
Content-Type: text/plain
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
Cc: Arnd Bergmann <arnd@arndb.de>, Hector Martin <marcan@marcan.st>,
 linux-kernel@vger.kernel.org, linux-i2c@vger.kernel.org,
 Paul Mackerras <paulus@samba.org>, linux-arm-kernel@lists.infradead.org,
 Christian Zigotzky <chzigotzky@xenosoft.de>, Olof Johansson <olof@lixom.net>,
 Mohamed Mediouni <mohamed.mediouni@caramail.com>,
 Mark Kettenis <mark.kettenis@xs4all.nl>,
 linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
 Alyssa Rosenzweig <alyssa@rosenzweig.io>, Stan Skowronek <stan@corellium.com>
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

On Sat, Oct 9, 2021, at 12:10, Wolfram Sang wrote:
>> I still don't have access to any old PASemi hardware but the changes from
>> v1 are pretty small and I expect them to still work. Would still be nice
>> if someone with access to such hardware could give this a quick test.
>
> Looks good to me. I will wait a few more days so that people can report
> their tests. But it will be in the next merge window.

Sounds great, thanks!


Sven
