Return-Path: <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5E985C3DA7F
	for <linuxppc-dev@archiver.kernel.org>; Fri, 26 Jul 2024 12:49:28 +0000 (UTC)
Authentication-Results: lists.ozlabs.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=arndb.de header.i=@arndb.de header.a=rsa-sha256 header.s=fm2 header.b=mHIMATIp;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm3 header.b=i/E6bZ9T;
	dkim-atps=neutral
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4WVndL6SQ7z3cK8
	for <linuxppc-dev@archiver.kernel.org>; Fri, 26 Jul 2024 22:49:26 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=arndb.de
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=arndb.de header.i=@arndb.de header.a=rsa-sha256 header.s=fm2 header.b=mHIMATIp;
	dkim=pass (2048-bit key; unprotected) header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm3 header.b=i/E6bZ9T;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=arndb.de (client-ip=103.168.172.148; helo=fout5-smtp.messagingengine.com; envelope-from=arnd@arndb.de; receiver=lists.ozlabs.org)
Received: from fout5-smtp.messagingengine.com (fout5-smtp.messagingengine.com [103.168.172.148])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4WVncV6BWvz3cK8
	for <linuxppc-dev@lists.ozlabs.org>; Fri, 26 Jul 2024 22:48:41 +1000 (AEST)
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
	by mailfout.nyi.internal (Postfix) with ESMTP id 1FD901380521;
	Fri, 26 Jul 2024 08:48:38 -0400 (EDT)
Received: from imap51 ([10.202.2.101])
  by compute4.internal (MEProxy); Fri, 26 Jul 2024 08:48:38 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arndb.de; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1721998118; x=1722084518; bh=wG7DINiILI
	fbNkkwvhfiokMcruI2DZpylYo6zLZp1oU=; b=mHIMATIpQ07LiRYL4a3NxN7hO1
	ua3QUlfnyxxnzs3Of4CkwRXYK6sLw5TGZX/LI+NjjLl7Ttg/FbG5pxUu8mC3KGdY
	JWhU7f3cR3x06QoseWX4FybzUiBdmdsEmf710Fm88NUfFcM+owWjIagdUF4W7HnT
	WlgrCh0chTrT7k1KBac10bsh817d7A86oBC+DWi1HlE7nq8yd/LVQCPIq+ZSxP7r
	Cic+Ho59T5eAWFp+RdTx3SY0Ilfjn6SFzHxHXj98szIni2gMTjQQB6dds57Itt/i
	X55DY2u5v2ikf4xojqrWKoGlDu48wEC9rX2PNoAJ2EfH4K+v1Ny+9mZRRKzw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm3; t=1721998118; x=1722084518; bh=wG7DINiILIfbNkkwvhfiokMcruI2
	DZpylYo6zLZp1oU=; b=i/E6bZ9TrbSU62Om7qZ1ZIFIVp74n2m0qCCSRITnG3e0
	x/Xh3D0pgtndpDm3j3qSCKBG7Q4yNGIVbPdIdSZzTKsxOLKwUyqXeW3LxVThYCUp
	Pq/7vYd2Gr4LhjGSchzFtV5QT3JNQpkTKBqZLgby05lUIQhAxaSbkGWffvH52ZOM
	ur37lyVNyyoRoXquyTI/l0j58IhjegkByR0VqlOcNz95k5d7btwuar10G3yIlm/K
	0DClQ04zT9Y5dN2TA4C5Rx/IdECeiE6mBC6HRrbZ55VofuVMcAB1SvfaDgw3MZMY
	T1KJDB4OV3RWQOBbuU4w/fOMXRqpxNDHzVqYRWidgQ==
X-ME-Sender: <xms:JZujZgeseyf9tkcioFBX5O3In3mzaQu_ml8LB3U1aWksiMs178e0Nw>
    <xme:JZujZiOloNyQCbHp5EPs5oTx_Phb9ogF621PePjnIzFggLNLJL6CmhIWBDoMYfWPn
    9aTMYkrpBrcc66fV4A>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddrieehgdehjecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpefofgggkfgjfhffhffvvefutgesthdtredtreertdenucfhrhhomhepfdetrhhn
    ugcuuegvrhhgmhgrnhhnfdcuoegrrhhnugesrghrnhgusgdruggvqeenucggtffrrghtth
    gvrhhnpeffheeugeetiefhgeethfejgfdtuefggeejleehjeeutefhfeeggefhkedtkeet
    ffenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpegrrh
    hnugesrghrnhgusgdruggvpdhnsggprhgtphhtthhopedt
X-ME-Proxy: <xmx:JpujZhgaaNKxUN2CRVtyhs1ZYB2E9uO38zKxxhdtPdwQykzwKSpFrw>
    <xmx:JpujZl8YyED7AkcNJzg_y_vB4i5TB92MTVfOAjZqVPVyjtASoSjRrw>
    <xmx:JpujZst-73Dhll7qTrKExlmpgSNJQa_dKtBmLEp3AnBahrDWMPc4BA>
    <xmx:JpujZsH67a_TaL8Ct8NZPAcoKlfg1am7qTj-zx6kVqYISuQ5IiIe6Q>
    <xmx:JpujZuLtYqi4uaooqpCQwciA_Ub9RogK3nzXLICsCcZfw_P8-UuD7iWM>
Feedback-ID: i56a14606:Fastmail
Received: by mailuser.nyi.internal (Postfix, from userid 501)
	id DF419B6008D; Fri, 26 Jul 2024 08:48:37 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.11.0-alpha0-582-g5a02f8850-fm-20240719.002-g5a02f885
MIME-Version: 1.0
Message-Id: <f8dcfe08-487b-4c90-a1e5-397262d1e77f@app.fastmail.com>
In-Reply-To: <20240726123322.1165562-2-mpe@ellerman.id.au>
References: <20240726123322.1165562-1-mpe@ellerman.id.au>
 <20240726123322.1165562-2-mpe@ellerman.id.au>
Date: Fri, 26 Jul 2024 14:48:17 +0200
From: "Arnd Bergmann" <arnd@arndb.de>
To: "Michael Ellerman" <mpe@ellerman.id.au>, linuxppc-dev@lists.ozlabs.org
Subject: Re: [PATCH 2/2] MAINTAINERS: Mark powerpc spufs as orphaned
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
Cc: Geoff Levand <geoff@infradead.org>, Jeremy Kerr <jk@ozlabs.org>, linux-kernel@vger.kernel.org
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev" <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

On Fri, Jul 26, 2024, at 14:33, Michael Ellerman wrote:
> Jeremy is no longer actively maintaining spufs, mark it as orphan.
>
> Also drop the dead developerworks link.
>
> Signed-off-by: Michael Ellerman <mpe@ellerman.id.au>
> Acked-by: Jeremy Kerr <jk@ozlabs.org>

Acked-by: Arnd Bergmann <arnd@arndb.de>
