Return-Path: <SRS0=c12Q=ID=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 35459C433DB
	for <linuxppc-dev@archiver.kernel.org>; Fri,  5 Mar 2021 06:31:06 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 91DEB65014
	for <linuxppc-dev@archiver.kernel.org>; Fri,  5 Mar 2021 06:31:05 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 91DEB65014
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kroah.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4DsHtc1B8jz3cKP
	for <linuxppc-dev@archiver.kernel.org>; Fri,  5 Mar 2021 17:31:04 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=kroah.com header.i=@kroah.com header.a=rsa-sha256 header.s=fm3 header.b=PjBL2jSn;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm2 header.b=b4SrAHEA;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized)
 smtp.mailfrom=kroah.com (client-ip=64.147.123.20;
 helo=wout4-smtp.messagingengine.com; envelope-from=greg@kroah.com;
 receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=kroah.com header.i=@kroah.com header.a=rsa-sha256
 header.s=fm3 header.b=PjBL2jSn; 
 dkim=pass (2048-bit key;
 unprotected) header.d=messagingengine.com header.i=@messagingengine.com
 header.a=rsa-sha256 header.s=fm2 header.b=b4SrAHEA; 
 dkim-atps=neutral
Received: from wout4-smtp.messagingengine.com (wout4-smtp.messagingengine.com
 [64.147.123.20])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4DsHt408TDz2xb3
 for <linuxppc-dev@lists.ozlabs.org>; Fri,  5 Mar 2021 17:30:34 +1100 (AEDT)
Received: from compute2.internal (compute2.nyi.internal [10.202.2.42])
 by mailout.west.internal (Postfix) with ESMTP id 5F7642A00;
 Fri,  5 Mar 2021 01:30:30 -0500 (EST)
Received: from mailfrontend2 ([10.202.2.163])
 by compute2.internal (MEProxy); Fri, 05 Mar 2021 01:30:30 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kroah.com; h=
 date:from:to:cc:subject:message-id:references:mime-version
 :content-type:in-reply-to; s=fm3; bh=z0riIZi5FSZ5sfGxEHxuYs+9uZd
 cZEnOkxz+llR8sCA=; b=PjBL2jSnh2FJkdiQgeBfXVFETmKAg2kP824aPWYPXuC
 5wK+E07/2EyPkMZseT+8pCoLv8h5ZUTTWyw7OItXY4DttekdgoNKA2sIwr47+yHJ
 Q+gbQ/z/RTm2OwkZuICa3vDkhpN02RudG6or97wyqURtQNEO3kDQkAOJtBIXdwxm
 UY46eT9hgFJ646M0YmDnAw+e1R6mT1YFvP8tfDcvvYD+AzDCAiNAUIp544O+ijyf
 pqGJP+pHLweu1zC6vXLlDPVXoL5BuZTXY+7KbkS5moBEs3ruo6CDA/gIIDQcaZaT
 5UwUjBZ4tMa63fT/kVLpAO1E7XkY1vhURkwwJgiE+PA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to:x-me-proxy
 :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; bh=z0riIZ
 i5FSZ5sfGxEHxuYs+9uZdcZEnOkxz+llR8sCA=; b=b4SrAHEAfD4C5m0bxvDeuT
 08BGpIxulyKA63AYN8PkUrZdBBT1FKzdaT0ZWfb+L36VX/GEl/ywECY6MWsaCQJj
 w19ZO6HFKS+OD4bDPEKM0hK/kYa/LvTPxjSjQDPSa4Ae7rQxoWX4hnrs7xfoXyzH
 nL2E8+ogXweEIe2rIo/HvSj9SxJGU41bgShlIN8Zmsm0+RGrRWhfDd45s5duNEut
 l1X5Ck1erzKlGnZQMFcEZ90UTT7hqQV/nkLGi5YV+7cjZ5OzOMQ//fM2V8EdxJJ4
 Qv1vGqzQZK8w4MZJNu9X++KylorgZg65jEU7BKoUFSlAaG2nORrSLb9l4vLBCHaQ
 ==
X-ME-Sender: <xms:A9BBYBkEz693eVoo53pKuk8fOT2vgzuRE26BZcsxyqfbF-NyrwHRvw>
 <xme:A9BBYO2fAcrf1s-k8SxxaRJQpwJKacfhR5ozFldEXjUWp2BmEzU2jT_FCs84w-8dM
 jh9TnihYHGAvg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeduledruddthedgleduucetufdoteggodetrfdotf
 fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
 uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
 cujfgurhepfffhvffukfhfgggtuggjsehttdortddttddvnecuhfhrohhmpefirhgvghcu
 mffjuceoghhrvghgsehkrhhorghhrdgtohhmqeenucggtffrrghtthgvrhhnpeevhefgje
 eitdfffefhvdegleeigeejgeeiffekieffjeeflefhieegtefhudejueenucfkphepkeef
 rdekiedrjeegrdeigeenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrih
 hlfhhrohhmpehgrhgvgheskhhrohgrhhdrtghomh
X-ME-Proxy: <xmx:A9BBYBCHUdXlyl2UT7G8meCWAYWvH8nMpzltBitUJY3LL8Hs9461aA>
 <xmx:A9BBYDzX8xbVOozkvAxLFN1aiFOfVrMzECpQzQHXUpfAMSOwq3yQ7w>
 <xmx:A9BBYHl5LQ6qhcDuCsfCztM8ZyQ2Zld-h8o_VWDL_JwSzyOber4b2Q>
 <xmx:BtBBYIom52OyslhRNZgtWwueM3F8BlQYwmfKhErior7VyiT9Q2m9tA>
Received: from localhost (83-86-74-64.cable.dynamic.v4.ziggo.nl [83.86.74.64])
 by mail.messagingengine.com (Postfix) with ESMTPA id A6D721080057;
 Fri,  5 Mar 2021 01:30:27 -0500 (EST)
Date: Fri, 5 Mar 2021 07:30:25 +0100
From: Greg KH <greg@kroah.com>
To: Stephen Rothwell <sfr@canb.auug.org.au>
Subject: Re: linux-next: manual merge of the tty tree with the powerpc-fixes
 tree
Message-ID: <YEHQAebXAyAkfnuz@kroah.com>
References: <20210305120523.0cb114b9@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210305120523.0cb114b9@canb.auug.org.au>
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
Cc: Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= <uwe@kleine-koenig.org>,
 Jiri Slaby <jirislaby@kernel.org>, PowerPC <linuxppc-dev@lists.ozlabs.org>,
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
 Linux Next Mailing List <linux-next@vger.kernel.org>,
 Jiri Slaby <jslaby@suse.cz>
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

On Fri, Mar 05, 2021 at 12:05:23PM +1100, Stephen Rothwell wrote:
> Hi all,
> 
> Today's linux-next merge of the tty tree got a conflict in:
> 
>   drivers/tty/hvc/hvcs.c
> 
> between commit:
> 
>   386a966f5ce7 ("vio: make remove callback return void")
> 
> from the powerpc-fixes tree and commit:
> 
>   fb8d350c291c ("tty: hvc, drop unneeded forward declarations")
> 
> from the tty tree.
> 
> I fixed it up (they both removed the forward decalrartion of
> hvcs_remove(), but the latter removed more) and can carry the fix as
> necessary. This is now fixed as far as linux-next is concerned, but any
> non trivial conflicts should be mentioned to your upstream maintainer
> when your tree is submitted for merging.  You may also want to consider
> cooperating with the maintainer of the conflicting tree to minimise any
> particularly complex conflicts.

Thanks, that's the correct fix, we knew this was going to happen :(

greg k-h
