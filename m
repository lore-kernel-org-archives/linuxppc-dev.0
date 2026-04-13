Return-Path: <linuxppc-dev+bounces-19719-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8AC42F531C9
	for <linuxppc-dev@archiver.kernel.org>; Mon, 13 Apr 2026 19:31:47 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4fvcwd6SKQz2yv4;
	Tue, 14 Apr 2026 05:31:45 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=103.168.172.139
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1776108705;
	cv=none; b=IxPrR5amMjDM/ypXofKed053Illjsk3bjyDFlN5IsfIPpBylEdtPcykzpdd2W/3ujFpzUeJC7SZcmFem2t19HuFXOwb3LXYarkaEuNC2dmoYb9ccxy+DksBjSn+JXxc2YWUjukAs1kTacHM1hAQdhg9DgN8NyBV/k6OsK9p6+zJYImiPrrL8r6Dc8udSV89XaVkKSapijAQIlgjJ845kJmwvYnB1riLGW86z2aVNuUGj7WGOfKXiRYVD8U4eHugAzkCVEHJEQUcLyScdF252lGxNxA1U9vY2V4ngCG46XiAmTf8GDkz6creai8RhKG6mN5AVSoC9e7esW9p7qgPFGg==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1776108705; c=relaxed/relaxed;
	bh=oF7+4SGRAImH9WMGSId2dJm+4RdrBt2YGrt25aFUZUA=;
	h=MIME-Version:Date:From:To:Cc:Message-Id:In-Reply-To:References:
	 Subject:Content-Type; b=eSE7F4wB3SJym0LuF8XWzXdfwu0ZTvpi0yZL41uZZEvEQNz3IvopeUGwYdUnKivp7dhpdJFSYUyeDHKAcuP4hGs4zi99T7Ff3fK09vk7/QJPiVa628POwaCmAHCUSVlZBuWwLPyvBDuO0+Z7oji9E9xQF7ZJD+OhGq/v5dkPdcPC11/quT9ApgVE99xrl7wD3wrAmYEqlM341547PTQOL8GgYgjr3GVP8A5dRAoVGGIEAGVryjitkA+6dAsDYeIjiBmqAO6SzvDGYJhymJjamVITPLaZBg10OIXOpq3RISSBjo+4v3VvhftJHuthLTvECmJgAOpdkyA3jNj8x7LBDw==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=arndb.de; dkim=pass (2048-bit key; unprotected) header.d=arndb.de header.i=@arndb.de header.a=rsa-sha256 header.s=fm1 header.b=eBEb3+z4; dkim=pass (2048-bit key; unprotected) header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm2 header.b=fK2XbJ97; dkim-atps=neutral; spf=pass (client-ip=103.168.172.139; helo=flow-a4-smtp.messagingengine.com; envelope-from=arnd@arndb.de; receiver=lists.ozlabs.org) smtp.mailfrom=arndb.de
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=arndb.de
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=arndb.de header.i=@arndb.de header.a=rsa-sha256 header.s=fm1 header.b=eBEb3+z4;
	dkim=pass (2048-bit key; unprotected) header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm2 header.b=fK2XbJ97;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=arndb.de (client-ip=103.168.172.139; helo=flow-a4-smtp.messagingengine.com; envelope-from=arnd@arndb.de; receiver=lists.ozlabs.org)
Received: from flow-a4-smtp.messagingengine.com (flow-a4-smtp.messagingengine.com [103.168.172.139])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4fvcwZ0gF7z2yv3
	for <linuxppc-dev@lists.ozlabs.org>; Tue, 14 Apr 2026 05:31:41 +1000 (AEST)
Received: from phl-compute-04.internal (phl-compute-04.internal [10.202.2.44])
	by mailflow.phl.internal (Postfix) with ESMTP id 9BAA81380415;
	Mon, 13 Apr 2026 15:31:38 -0400 (EDT)
Received: from phl-imap-02 ([10.202.2.81])
  by phl-compute-04.internal (MEProxy); Mon, 13 Apr 2026 15:31:38 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arndb.de; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1776108698;
	 x=1776115898; bh=oF7+4SGRAImH9WMGSId2dJm+4RdrBt2YGrt25aFUZUA=; b=
	eBEb3+z4uCJ5XpVJfmMDtd+Hz4pTmn4rIKoszU8vf+435LUmCEc3EJdi4K0/oVv8
	C+yjXVYuraejFdA/rcQOSN6Zfi5pNlS43GslApllsudgHnK44npvkIwaUHWVTtuh
	Dw/4I/j/UNeqyr1LQlKmH5vdXZciz/2GPqFtFHFDNoaInKEsvm7hwh9DYdVnGoah
	lMAIbVhEjH95sryDmrUzci3AfaiCDHHYDZH3oXJ/R4+VlvsfKJPopXWx0JE7CxaE
	ognvTjwa06PAMT31z/DBGKMGBcoGUsjb6Y3k+6cm618rMbyQ7yCpT6T6pE5XH3Hf
	w2SGXNdq7Abx7TrcOF+CrA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1776108698; x=
	1776115898; bh=oF7+4SGRAImH9WMGSId2dJm+4RdrBt2YGrt25aFUZUA=; b=f
	K2XbJ97Y0jsbU1s6LswXOEcaT2AuIJQsZKTCiqB2bsDjsavXFxXjXN24HUjqmHPV
	30lUfZzPVJ0GZrRSLZsyTrPlhAwj+oOp7rzHIcW4Q+ggBxcGWjNT+roTWJQkS80p
	muhmPfZao8pyrAslQS6xE9YgbnnrpBmxpEViK0VuBn5kyHZfCSLFSApLiy8hZEkj
	X3o7U4xt3roWjYEf/0QsKGiNqeP3myXk/e3+BEa4KYIE59wmYsrhudiDwV46CB5d
	E8K4OFv0fHuOdK14nnUUxfff3rCPKj8vJw3X7p6M4i0BpN1E8RSwySIEaUf5sCqK
	alHtK1Rc5jgsKIF8k3s0A==
X-ME-Sender: <xms:l0TdaRMQ1ovC5UjXw9wB_riUJbJZBZQ47VcEC4ozPMlWVwTWyL-hPg>
    <xme:l0Tdaey9qAPkMkkSsq5ZowyLiVSaVZg3Aabqq1QUbhdAX-Y8VC29U600TE9HTIGWj
    W-h6ka_l-N0bKYGG_W-3bzXlHGY0ZcjcSbZR_zuoL-6Ds0X7Q55CQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefhedrtddtgdefledtkecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
    hrpefoggffhffvvefkjghfufgtgfesthhqredtredtjeenucfhrhhomhepfdetrhhnugcu
    uegvrhhgmhgrnhhnfdcuoegrrhhnugesrghrnhgusgdruggvqeenucggtffrrghtthgvrh
    hnpedvhfdvkeeuudevfffftefgvdevfedvleehvddvgeejvdefhedtgeegveehfeeljeen
    ucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpegrrhhnug
    esrghrnhgusgdruggvpdhnsggprhgtphhtthhopeegkedpmhhouggvpehsmhhtphhouhht
    pdhrtghpthhtohepthdrshgrihhlvghrsegrlhhumhhnihdrvghthhiirdgthhdprhgtph
    htthhopegtrghtrghlihhnrdhmrghrihhnrghssegrrhhmrdgtohhmpdhrtghpthhtohep
    lhhinhhugiesrghrmhhlihhnuhigrdhorhhgrdhukhdprhgtphhtthhopegurghvvghmse
    gurghvvghmlhhofhhtrdhnvghtpdhrtghpthhtohepmhhpvgesvghllhgvrhhmrghnrdhi
    ugdrrghupdhrtghpthhtoheprhihrggsihhnihhnrdgrrdgrsehgmhgrihhlrdgtohhmpd
    hrtghpthhtohepuhhrvgiikhhisehgmhgrihhlrdgtohhmpdhrtghpthhtohepuggvlhhl
    vghrsehgmhigrdguvgdprhgtphhtthhopehhvghrsggvrhhtsehgohhnughorhdrrghprg
    hnrgdrohhrghdrrghu
X-ME-Proxy: <xmx:l0TdaTelOssYXt15-FK9p6saYLM_nmrvIO6c-_F3ZyF6_xfZywmCYA>
    <xmx:l0TdaUxOkh6ozfKMIVT4v_qdW_i5Tss0CLMqkf2F01TBmahdCnZo_w>
    <xmx:l0TdaUWn-LdWx2_7oUHRu6zzNshE3wCLw-aFKzbUUXN26D6Q-_6vLw>
    <xmx:l0TdacTwYVtUWJnf_Fdh14nt-sYvlNq7AaQbOTvOw2Uu221fQyzEjQ>
    <xmx:mkTdaTH5uGiAlbaAI17-uSN6CKxYeQsdeWCm3ruscf_j0l2LK_Chakad>
Feedback-ID: i56a14606:Fastmail
Received: by mailuser.phl.internal (Postfix, from userid 501)
	id 04818700069; Mon, 13 Apr 2026 15:31:35 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
X-Mailing-List: linuxppc-dev@lists.ozlabs.org
List-Id: <linuxppc-dev.lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev+help@lists.ozlabs.org>
List-Owner: <mailto:linuxppc-dev+owner@lists.ozlabs.org>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Archive: <https://lore.kernel.org/linuxppc-dev/>,
  <https://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Subscribe: <mailto:linuxppc-dev+subscribe@lists.ozlabs.org>,
  <mailto:linuxppc-dev+subscribe-digest@lists.ozlabs.org>,
  <mailto:linuxppc-dev+subscribe-nomail@lists.ozlabs.org>
List-Unsubscribe: <mailto:linuxppc-dev+unsubscribe@lists.ozlabs.org>
Precedence: list
MIME-Version: 1.0
X-ThreadId: AMdy4yCH1GcR
Date: Mon, 13 Apr 2026 21:30:11 +0200
From: "Arnd Bergmann" <arnd@arndb.de>
To: "David Woodhouse" <dwmw2@infradead.org>,
 "Thomas Gleixner" <tglx@kernel.org>, LKML <linux-kernel@vger.kernel.org>
Cc: x86@kernel.org, "Baolu Lu" <baolu.lu@linux.intel.com>,
 iommu@lists.linux.dev, "Michael Grzeschik" <m.grzeschik@pengutronix.de>,
 Netdev <netdev@vger.kernel.org>, linux-wireless@vger.kernel.org,
 "Herbert Xu" <herbert@gondor.apana.org.au>, linux-crypto@vger.kernel.org,
 "Vlastimil Babka (SUSE)" <vbabka@kernel.org>, linux-mm@kvack.org,
 "Bernie Thompson" <bernie@plugable.com>, linux-fbdev@vger.kernel.org,
 "Theodore Ts'o" <tytso@mit.edu>, linux-ext4@vger.kernel.org,
 "Andrew Morton" <akpm@linux-foundation.org>,
 "Uladzislau Rezki (Sony)" <urezki@gmail.com>,
 "Marco Elver" <elver@google.com>, "Dmitry Vyukov" <dvyukov@google.com>,
 kasan-dev@googlegroups.com, "Andrey Ryabinin" <ryabinin.a.a@gmail.com>,
 "Thomas Sailer" <t.sailer@alumni.ethz.ch>, linux-hams@vger.kernel.org,
 "Jason A . Donenfeld" <Jason@zx2c4.com>,
 "Richard Henderson" <richard.henderson@linaro.org>,
 linux-alpha@vger.kernel.org, "Russell King" <linux@armlinux.org.uk>,
 linux-arm-kernel@lists.infradead.org,
 "Catalin Marinas" <catalin.marinas@arm.com>,
 "Huacai Chen" <chenhuacai@kernel.org>, loongarch@lists.linux.dev,
 "Geert Uytterhoeven" <geert@linux-m68k.org>,
 linux-m68k@lists.linux-m68k.org, "Dinh Nguyen" <dinguyen@kernel.org>,
 "Jonas Bonn" <jonas@southpole.se>,
 "linux-openrisc@vger.kernel.org" <linux-openrisc@vger.kernel.org>,
 "Helge Deller" <deller@gmx.de>, linux-parisc@vger.kernel.org,
 "Michael Ellerman" <mpe@ellerman.id.au>, linuxppc-dev@lists.ozlabs.org,
 "Paul Walmsley" <pjw@kernel.org>, linux-riscv@lists.infradead.org,
 "Heiko Carstens" <hca@linux.ibm.com>, linux-s390@vger.kernel.org,
 "David S . Miller" <davem@davemloft.net>, sparclinux@vger.kernel.org
Message-Id: <07df88e5-208d-4aac-9668-a3b0c65ae529@app.fastmail.com>
In-Reply-To: <7a48b636cb3146f4f7134c6d4fe42070ac2edb43.camel@infradead.org>
References: <20260410120044.031381086@kernel.org>
 <20260410120318.592237447@kernel.org>
 <7a48b636cb3146f4f7134c6d4fe42070ac2edb43.camel@infradead.org>
Subject: Re: [patch 15/38] ptp: ptp_vmclock: Replace get_cycles() usage
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On Mon, Apr 13, 2026, at 17:33, David Woodhouse wrote:
> On Fri, 2026-04-10 at 14:19 +0200, Thomas Gleixner wrote:
>
> ... depend on TSC_RELIABLE=C2=B9, since if the guest doesn't believe t=
hat it
> is, then the guest shouldn't be trying to use it as the basis for
> precise timing.
>
> =C2=B9 (Or... one of the other zoo of TSC flags for the gradually redu=
cing
> brokenness over the years...)

It looks like this is sufficiently handled in the caller:

static int vmclock_get_crosststamp(struct vmclock_state *st,
                                   struct ptp_system_timestamp *sts,
                                   struct system_counterval_t *system_co=
unter,
                                   struct timespec64 *tspec)
{
....
#ifdef CONFIG_X86
        /*
         * We'd expect the hypervisor to know this and to report the clo=
ck
         * status as VMCLOCK_STATUS_UNRELIABLE. But be paranoid.
         */
        if (check_tsc_unstable())
                return -EINVAL;
#endif

With 486 and ELAN out of the way, Winchip6 seems to be the only
one without X86_FEATURE_TSC, so I think the next logical step would
be to turn off Winchip6 as well and remove all X86_FEATURE_TSC
and CONFIG_X86_TSC checks.

      Arnd

