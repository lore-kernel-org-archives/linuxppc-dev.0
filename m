Return-Path: <SRS0=JEJ8=7P=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 711BAC433DF
	for <linuxppc-dev@archiver.kernel.org>; Tue,  2 Jun 2020 15:05:21 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C1D8B20679
	for <linuxppc-dev@archiver.kernel.org>; Tue,  2 Jun 2020 15:05:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=octaforge.org header.i=@octaforge.org header.b="U0e0xcq9";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="zR/u/KrJ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C1D8B20679
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=octaforge.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from bilbo.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 49bwML2m8LzDqWc
	for <linuxppc-dev@archiver.kernel.org>; Wed,  3 Jun 2020 01:05:18 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized)
 smtp.mailfrom=octaforge.org (client-ip=64.147.123.25;
 helo=wout2-smtp.messagingengine.com; envelope-from=daniel@octaforge.org;
 receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=none (p=none dis=none) header.from=octaforge.org
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=octaforge.org header.i=@octaforge.org
 header.a=rsa-sha256 header.s=fm3 header.b=U0e0xcq9; 
 dkim=pass (2048-bit key;
 unprotected) header.d=messagingengine.com header.i=@messagingengine.com
 header.a=rsa-sha256 header.s=fm2 header.b=zR/u/KrJ; 
 dkim-atps=neutral
Received: from wout2-smtp.messagingengine.com (wout2-smtp.messagingengine.com
 [64.147.123.25])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 49bw5920P2zDqRn
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  3 Jun 2020 00:53:00 +1000 (AEST)
Received: from compute7.internal (compute7.nyi.internal [10.202.2.47])
 by mailout.west.internal (Postfix) with ESMTP id 482872A5;
 Tue,  2 Jun 2020 10:52:56 -0400 (EDT)
Received: from imap1 ([10.202.2.51])
 by compute7.internal (MEProxy); Tue, 02 Jun 2020 10:52:56 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=octaforge.org;
 h=mime-version:message-id:in-reply-to:references:date:from:to
 :cc:subject:content-type; s=fm3; bh=YwgnsG0EPjkwAlBojTwB2vGpwgVB
 IAlNNBLYkHOfkoE=; b=U0e0xcq9dG+TN04k8RcidCbeBbxs6poaysZHhn9Hg4m9
 m3L5NC8S9f0GHSScHO//xuPxJqJHiTverWjBjoipnt8h+aNgHK0mwnUgegwDBQfd
 22iouJpEnq4JVVagPDlpKOfs+lnXCMpgkOvMSKVRSTx50wu4IE3QRHoCgOnczwG9
 BksTLHfym4Sl0njYKysjvP5u7H4gKhKUwIyCSrl38LTFc2LndMzGQ7Cid9O1pQyi
 qnAF9JN4+0UCZIiEx/Y3SR00TloswHnbaubbS4idETjW6RFzcbPOYFppI+SczBrS
 yx3gsr1Z6DUrEnjORQRVqA8GLrEaoI3N79XhvdSBAQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to:x-me-proxy
 :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; bh=YwgnsG
 0EPjkwAlBojTwB2vGpwgVBIAlNNBLYkHOfkoE=; b=zR/u/KrJ8Xb7M8BFFpY1B8
 eTE0gB/BoDtwyEuTnqIqk1sfGS0GViZmrpxmqNcDXwP9hvSNLeFQ7Xu9takBXLVR
 FZBNRXrGX5KHquv1sQiu0cvrdH420JscE73KPhmzExQwEo2WwF1+b/wc13TrFGA1
 ld2NnZs5O00ArB23EXn7Xi0y8w2q5FWBxS4a2gsGYNupmBHTia9Ay4g1tvH1a6oA
 bi5x6z08jq/dGXP5oUkyNTcW9AdsLPGuu1JibhBqXvZc3nT2BcbohbW7y1UCqh69
 E9HXQPPLEOPGR8hCQzF9WSWnWub9nx2fb8WKepx3qz1bN85zLWYqREBe1xPEJzzA
 ==
X-ME-Sender: <xms:xmfWXo-CXH03Pj_8mzJI4dHxHIJxZ14UVLNSdkM9D0QL2uqTut4dLg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeduhedrudefjedgiedvucetufdoteggodetrfdotf
 fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
 uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
 cujfgurhepofgfggfkjghffffhvffutgesthdtredtreertdenucfhrhhomhepfdffrghn
 ihgvlhcumfholhgvshgrfdcuoegurghnihgvlhesohgtthgrfhhorhhgvgdrohhrgheqne
 cuggftrfgrthhtvghrnhepieevvddvjeehiedtvdelgfeuiefhgfetvdeuhfffteehuddu
 fffgudfhfffhleefnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilh
 hfrhhomhepuggrnhhivghlsehotghtrghfohhrghgvrdhorhhg
X-ME-Proxy: <xmx:xmfWXgsteiOqqo0cLmXRFh9TkshO14pSEuEsgKyp6AWhO7m2D06AmQ>
 <xmx:xmfWXuBnAef08VmjAPu-M-cNgnojKCzti_ULp2q9I0oM_8WzqAhcHw>
 <xmx:xmfWXofmT-ZN2XC0Trz12N_7oEQeWKrPQhjsU8S6pLCY3aTlt294jA>
 <xmx:x2fWXipRrezhp4rG-mYV25WcKmsy1eXb8HIfktaWSHXSSi7I_-kvvQ>
Received: by mailuser.nyi.internal (Postfix, from userid 501)
 id 794B9C200A4; Tue,  2 Jun 2020 10:52:54 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.3.0-dev0-519-g0f677ba-fm-20200601.001-g0f677ba6
Mime-Version: 1.0
Message-Id: <af12e627-02af-4043-86da-4b1aa6b78e43@www.fastmail.com>
In-Reply-To: <alpine.DEB.2.21.2006021334170.24059@digraph.polyomino.org.uk>
References: <2047231.C4sosBPzcN@sheen>
 <alpine.DEB.2.21.2006012119010.11121@digraph.polyomino.org.uk>
 <c821b608-f14f-4a68-bbec-b7b6c1d8bddc@www.fastmail.com>
 <alpine.DEB.2.21.2006012329420.11121@digraph.polyomino.org.uk>
 <b44b3aa7-f9cc-43e1-b2c4-0edb6ea06189@www.fastmail.com>
 <alpine.DEB.2.21.2006021334170.24059@digraph.polyomino.org.uk>
Date: Tue, 02 Jun 2020 16:52:34 +0200
From: "Daniel Kolesa" <daniel@octaforge.org>
To: "Joseph Myers" <joseph@codesourcery.com>
Subject: Re: ppc64le and 32-bit LE userland compatibility
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
Cc: libc-alpha@sourceware.org, eery@paperfox.es, musl@lists.openwall.com,
 Will Springer <skirmisher@protonmail.com>,
 Palmer Dabbelt via binutils <binutils@sourceware.org>,
 via libc-dev <libc-dev@lists.llvm.org>, linuxppc-dev@lists.ozlabs.org
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

On Tue, Jun 2, 2020, at 15:40, Joseph Myers wrote:
> On Tue, 2 Jun 2020, Daniel Kolesa wrote:
> 
> > not be limited to being just userspace under ppc64le, but should be 
> > runnable on a native kernel as well, which should not be limited to any 
> > particular baseline other than just PowerPC.
> 
> This is a fairly unusual approach to bringing up a new ABI.  Since new 
> ABIs are more likely to be used on new systems rather than switching ABI 
> on an existing installation, and since it can take quite some time for all 
> the software support for a new ABI to become widely available in 
> distributions, people developing new ABIs are likely to think about what 
> new systems are going to be relevant in a few years' time when working out 
> the minimum hardware requirements for the new ABI.  (The POWER8 minimum 
> for powerpc64le fits in with that, for example.)

In this case the whole point is targeting existing hardware that we already have. It also aims to largely utilize things that are already present in all parts of the toolchain, otherwise it's a lot of effort with questionable benefit and artificially limits the baseline for no good reason.

> 
> > either the AIX/ELFv1 nor the ELFv2 ABIs) If we were to introduce new 
> > ports, what would those use? ld64.so.3 for BE/v2? ld.so.2 for LE/32-bit? 
> 
> Rather than relying on numbers such as "3" or 2" in a particular place 
> being unique across all (architecture, ABI) pairs supported by glibc, 
> something more obviously specific to a particular architecture and ABI, 
> e.g. ld-linux-powerpc64be-elfv2.so.1, would be better.

Yes, agreed on that - probably ld-linux-powerpc64-elfv2.so.1, to match existing conventions (powerpc64 implicitly refers to BE in target triples, etc). It's just inconsistent with the existing ports, but I guess the reason in those is legacy in the first place, so not much point in worrying about that.

> 
> -- 
> Joseph S. Myers
> joseph@codesourcery.com
>

Daniel
