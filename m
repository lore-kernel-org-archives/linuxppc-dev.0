Return-Path: <linuxppc-dev+bounces-22671-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 94D5CCD98DE
	for <linuxppc-dev@archiver.kernel.org>; Mon, 15 Jun 2026 23:34:26 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4gfRKX6BFvz2yv0;
	Tue, 16 Jun 2026 09:34:24 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=130.133.4.66
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1781566464;
	cv=none; b=AUIAO95zVMGDZhq4Q1ICOKmbEwiSnvTvoehoMHwz4Zp7PrXmGVAI6BIUb+aiPegwLLJ1ojAMf516+T/JHn6MzHL1sswYRSamYFaVJxR3T70BxZX8HBrr9OPTcxkc82e9e2ygqE3C/5emkAxZmbkVcBr0kqyTg8mj3PGJezTAR5P13nIXD2g3FCp1Re7VNIROt0vLnSnplFbxpSK9kSYvy97zRJeATCwvvzWpyLC3JL02RMGqEC3lOZn0wSbV85IZ8e1/8c+xXu7rW28dhF0XpH0d8FOcjwdHNUwvB3yk3Y57g3Dq6ooVj6udNtVUGlY8VerFp97qHW5TvPR90ELk8A==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1781566464; c=relaxed/relaxed;
	bh=UcyzNe2kkvCr0tmZScGHxnkfzSMWsq/75HfrZoct7a8=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=iwKoHu+iqsRqOtAaQVzRUXjS9cbFM+J3aS7UVf9j1KtbUclU5grohuCl/UdiWuNfacTR8sUizDq54K2KfTOj0auxotQCYNe/DHMH/708tjjA10JF8atTuUXwXtv2mmbDhqSgDtELclFymHwZH5+hryUIrTnkHHVLvaDYzncdT3O8upTyha8J/TuPAWcBi5ZPB4e5d1qtBZyz10zqRCvavUsyWT5KOuYkfTmIaSKQ2WWFJkiEZYZwMOimfFztDm6f2AXbAMMK/iCSa5loOgsIyrYC6iGhsT+nAIWKuMToV19IyZt7aeBR464nv6mjAyuHAyW/igRhlFlJmBNBIwzrKw==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=physik.fu-berlin.de; dkim=pass (2048-bit key; unprotected) header.d=fu-berlin.de header.i=@fu-berlin.de header.a=rsa-sha256 header.s=fub01 header.b=HIhpFWAT; dkim-atps=neutral; spf=pass (client-ip=130.133.4.66; helo=outpost1.zedat.fu-berlin.de; envelope-from=glaubitz@zedat.fu-berlin.de; receiver=lists.ozlabs.org) smtp.mailfrom=zedat.fu-berlin.de
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=physik.fu-berlin.de
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=fu-berlin.de header.i=@fu-berlin.de header.a=rsa-sha256 header.s=fub01 header.b=HIhpFWAT;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=zedat.fu-berlin.de (client-ip=130.133.4.66; helo=outpost1.zedat.fu-berlin.de; envelope-from=glaubitz@zedat.fu-berlin.de; receiver=lists.ozlabs.org)
Received: from outpost1.zedat.fu-berlin.de (outpost1.zedat.fu-berlin.de [130.133.4.66])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4gfRKS4qffz2xnK
	for <linuxppc-dev@lists.ozlabs.org>; Tue, 16 Jun 2026 09:34:19 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=fu-berlin.de; s=fub01; h=MIME-Version:Content-Transfer-Encoding:
	Content-Type:References:In-Reply-To:Date:Cc:To:From:Subject:Message-ID:From:
	Reply-To:Subject:Date:Message-ID:To:Cc:MIME-Version:Content-Type:
	Content-Transfer-Encoding:Content-ID:Content-Description:In-Reply-To:
	References; bh=UcyzNe2kkvCr0tmZScGHxnkfzSMWsq/75HfrZoct7a8=; t=1781566460;
	x=1782171260; b=HIhpFWAT98G8IdY//G9+rrogMHf9tRrRx6T00JvzFSunW+ZN1ocftYrZ9o5S5
	T8cVG4wftxptE5XQfas725120Y7JICTeQcekieianZb+q1N0ao11wrpGlE4GxM+Lhw9P0XHMdfqf9
	GthfJ4r+O87RHqW09V/cv5FWZkvPRwTcOGFu0QjW5+6hiDSCdkI+kagN0wSM78t/cPmJvWusaZXSD
	DQX03IA78dHjTDF9gPAm6JC7ciNXnobAuIYbMVMwhYPvD1e3nxYTrOF3w/j9pVrd84gcKAEXvqHtc
	2tJdKBeczKZxNAk+13ghqVAU6im752vf9KbtnhGZSIiLhDs3CA==;
Received: from inpost2.zedat.fu-berlin.de ([130.133.4.69])
          by outpost.zedat.fu-berlin.de (Exim 4.99)
          with esmtps (TLS1.3)
          tls TLS_AES_256_GCM_SHA384
          (envelope-from <glaubitz@zedat.fu-berlin.de>)
          id 1wZGoh-00000000EPh-2I78; Tue, 16 Jun 2026 01:34:07 +0200
Received: from p57bd94c1.dip0.t-ipconnect.de ([87.189.148.193] helo=suse-laptop.fritz.box)
          by inpost2.zedat.fu-berlin.de (Exim 4.99)
          with esmtpsa (TLS1.3)
          tls TLS_AES_256_GCM_SHA384
          (envelope-from <glaubitz@physik.fu-berlin.de>)
          id 1wZGoh-00000000RxC-1Ebx; Tue, 16 Jun 2026 01:34:07 +0200
Message-ID: <c3789160609a10e232ba3e27c4b13adbb170956c.camel@physik.fu-berlin.de>
Subject: Re: [PATCH net-next 0/2] appletalk: move the protocol out of tree
From: John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>
To: Jakub Kicinski <kuba@kernel.org>, davem@davemloft.net
Cc: netdev@vger.kernel.org, edumazet@google.com, pabeni@redhat.com, 
	andrew+netdev@lunn.ch, horms@kernel.org, geert@linux-m68k.org,
 chleroy@kernel.org, 	npiggin@gmail.com, mpe@ellerman.id.au,
 maddy@linux.ibm.com, 	linux-mips@vger.kernel.org,
 linux-m68k@lists.linux-m68k.org, 	linuxppc-dev@lists.ozlabs.org
Date: Tue, 16 Jun 2026 01:34:06 +0200
In-Reply-To: <20260615222935.947233-1-kuba@kernel.org>
References: <20260615222935.947233-1-kuba@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.60.2 
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
X-Original-Sender: glaubitz@physik.fu-berlin.de
X-Originating-IP: 87.189.148.193
X-ZEDAT-Hint: PO

Hello Jakub,

On Mon, 2026-06-15 at 15:29 -0700, Jakub Kicinski wrote:
> This tiny series moves appletalk out of tree, to:
>=20
>   https://github.com/linux-netdev/mod-orphan
>=20
> Core maintainainers are unable to keep up with the rate of security
> bug reports and fixes. Nobody seems to care about appletalk enough
> to review the patches.

Why would fixing these vulnerabilities be relevant? No one is going to
expose an Apple Talk server to an untrusted network, are they? The same
applies to hamradio and AX.25, they are all used by hobbyists in DMZ
networks, so no one really cares about vulnerabilities in these protocols.

I find it sad that AI tools are basically used to shoot at the kernel
to kill off features as some people are apparently getting scared by
these AI reports and just nuke everything in a panic reaction as if it
wouldn't just be possible to disable these protocols at compile time
to reduce the attack surface.

> As Eric pointed out Mac OS dropped AppleTalk over a decade ago.

That's not the point though. No one is going to use AppleTalk to network
a Linux box to a modern macOS machine. The usefulness lies in hooking up
a Linux box to a vintage Mac or other retro computer.

So far, one of the huge advantages of open source operating systems has
always been that even niche use cases were supported and people could make
use of old hardware by using open source operating systems over commercial
offerings such as Windows or macOS.

With the advent of AI security reports, these niche use cases are more and
more being killed off with the argument that a vulnerability in the harmrad=
io
code could pose a threat to a large SAP database running on a Linux enterpr=
ise
distribution. However, if your enterprise distribution is enabling kernel
features their customers aren't using and therefore enlarging the attack su=
rface,
it's more a problem of said enterprise distribution and not of these old an=
d
obscure network protocols.

I am trying my best to save as many classic features in the kernel as possi=
ble
to enable retro computing but I am sometimes fearing that commercial intere=
st
in the kernel is taking over too much making my efforts harder every day.

Adrian

--=20
 .''`.  John Paul Adrian Glaubitz
: :' :  Debian Developer
`. `'   Physicist
  `-    GPG: 62FF 8A75 84E0 2956 9546  0006 7426 3B37 F5B5 F913

