Return-Path: <SRS0=mkti=OU=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ED66BC67839
	for <linuxppc-dev@archiver.kernel.org>; Tue, 11 Dec 2018 23:20:55 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C084320672
	for <linuxppc-dev@archiver.kernel.org>; Tue, 11 Dec 2018 23:20:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="TFezmnL6"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C084320672
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=russell.cc
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 43Dwsw2xDwzDr7C
	for <linuxppc-dev@archiver.kernel.org>; Wed, 12 Dec 2018 10:20:52 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none) header.from=russell.cc
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=messagingengine.com header.i=@messagingengine.com header.b="TFezmnL6";
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (helo)
 smtp.helo=out1-smtp.messagingengine.com (client-ip=66.111.4.25;
 helo=out1-smtp.messagingengine.com; envelope-from=ruscur@russell.cc;
 receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=none (p=none dis=none) header.from=russell.cc
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=messagingengine.com header.i=@messagingengine.com
 header.b="TFezmnL6"; dkim-atps=neutral
Received: from out1-smtp.messagingengine.com (out1-smtp.messagingengine.com
 [66.111.4.25])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 43Dwq72M6dzDqnV
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 12 Dec 2018 10:18:25 +1100 (AEDT)
Received: from compute6.internal (compute6.nyi.internal [10.202.2.46])
 by mailout.nyi.internal (Postfix) with ESMTP id 5266B2221C;
 Tue, 11 Dec 2018 18:18:20 -0500 (EST)
Received: from web2 ([10.202.2.212])
 by compute6.internal (MEProxy); Tue, 11 Dec 2018 18:18:20 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:content-transfer-encoding:content-type
 :date:from:in-reply-to:message-id:mime-version:references
 :subject:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
 :x-sasl-enc; s=fm1; bh=LhuvvC+6X41X1v4KGyqdvsOrPQLESGM9Z0KNLUZP4
 oY=; b=TFezmnL6oisYZlkJDglaxjXAJjg8VjYRDSRwKAGvsx1kLw2T3Nk1tV1/9
 PdE9IPluz6zxc61NwF9PbckNY03tRxinN/XHHbyFQLZG0DCc6vUxvzMNo6aZG45P
 wJlM0CE8jqHMdxcAXPzgUSJaFrWXaCVkK1NKKQlSToe7zMXZjSlUSW9o/Y2ak027
 C+kF7b96Q2Qx6TgkoiJx88SuQ607Tn2Ps+UUdLs7FCVoC3yOFQS1mTIWkszbzCyn
 VFnfUGuvuoa25hkIAta61m/c2oxBsz5PAL8NgzXTi7UezyIbYjc74YmhkHGXSuDu
 XGKgmL76GQ0PzULyP58xGdXRNvcOQ==
X-ME-Sender: <xms:u0UQXJvVGl5l4hVnil-am1xcuGEFOJoP9qMQdcQG-mDyVx6Fk6ZaAw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedtkedrudegkedgtdelucetufdoteggodetrfdotf
 fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfquhhtnecuuegrihhlohhuthemucef
 tddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenfghrlhcuvffnffculddutd
 dmnecujfgurhepkffhvfgggfgtofffjghfufesthejredtredtjeenucfhrhhomheptfhu
 shhsvghllhcuvehurhhrvgihuceorhhushgtuhhrsehruhhsshgvlhhlrdgttgeqnecuff
 homhgrihhnpehoiihlrggsshdrohhrghenucfrrghrrghmpehmrghilhhfrhhomheprhhu
 shgtuhhrsehruhhsshgvlhhlrdgttgenucevlhhushhtvghrufhiiigvpedt
X-ME-Proxy: <xmx:u0UQXJZNcf72scyYMEj39kYu_Odp7rnhJYt8qFfjd3GZ18KZCyugrw>
 <xmx:u0UQXG8Ng2Lx6Sp3fXZDGz5IM2upbarrXElIOJu04TPnpPqDZ5obMw>
 <xmx:u0UQXJKeu8Xi1Zx-OQuqXAvCRVHPA6866iH23kVuQBJl5MX894HIRA>
 <xmx:u0UQXJuRJpnig-TW57TMhgkd1eC94NqjTEUWnfQn8ilnFrmQHkW8_Q>
 <xmx:u0UQXNkxCPj0Br5TAURY0AeAnKZCX3DgXw4DRYSrV_ntn6kUJYxNzQ>
 <xmx:vEUQXAs1AsPIQTIyJVz92JTtZ74pY6cOl0k8XY6Z-VMdzL0iuC9HKA>
Received: by mailuser.nyi.internal (Postfix, from userid 99)
 id 567EB6229D; Tue, 11 Dec 2018 18:18:19 -0500 (EST)
Message-Id: <1544570299.3422798.1606440520.1D651F72@webmail.messagingengine.com>
From: Russell Currey <ruscur@russell.cc>
To: Christophe Leroy <christophe.leroy@c-s.fr>,
 Michael Ellerman <mpe@ellerman.id.au>
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="utf-8"
X-Mailer: MessagingEngine.com Webmail Interface - ajax-2f590f9a
Date: Wed, 12 Dec 2018 10:18:19 +1100
In-Reply-To: <d76e02ff-97dd-fe59-eec9-2756f77bd2a4@c-s.fr>
References: <d76e02ff-97dd-fe59-eec9-2756f77bd2a4@c-s.fr>
Subject: Re: Snowpatch
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
Cc: linuxppc-dev@lists.ozlabs.org
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>


On Wed, Dec 12, 2018, at 8:41 AM, Christophe Leroy wrote:
> snowpatch is pretty surprising on 
> https://patchwork.ozlabs.org/patch/1003954/
> 
> How can such a trivial patch for 8xx alter compilation of all other 
> targets that much (ie add or remove sparse warnings) ?

It was a bug I fixed as soon as I noticed and shouldn't happen any more.

> 
> Christophe
