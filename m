Return-Path: <linuxppc-dev+bounces-23309-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ED71FC43458
	for <linuxppc-dev@archiver.kernel.org>; Wed,  1 Jul 2026 13:12:49 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4gr0mw4M6lz2xKh;
	Wed, 01 Jul 2026 23:12:48 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=202.12.124.152
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1782911568;
	cv=none; b=Xr5TZROjCPcZNf5A8u857lyh1JxPmWMcyiQ2zvDfLfJp+tU8jkTnxBaW7dFg6QQTx4ipLSk5lLwUgPY6XR4KXImW+OQ/S2wnHswJDdrQLkQ8QaAbE24H4i64q/oT2PmTcMc6jNw7GKwnUY0ImXc3YaJg/JOIn4yM/jy3fquAcSFMtKv8RdBWs90EcFP7ofypDk9Z6GkLnUFmlg2xXF4C8mPoXUcNmtbHuMITujb59gvxGYIYlsNbhe0gVyRSAa745MVcVxhg1buyhk6VHQvOamtgOVUxhKq9Gxj/yJnQFP762VOJkoXE0zBL6QJRvaW2u8j6noeggeOEhraQFgRkrQ==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1782911568; c=relaxed/relaxed;
	bh=XqEEA6N5CwGJ6IA3lZOQ+4Ik7bEoUp9hnbB4/W/Zwik=;
	h=MIME-Version:Date:From:To:Cc:Message-Id:In-Reply-To:References:
	 Subject:Content-Type; b=kIPDJJAUzqRZeemLa3Ws2xCuTPGsnZMIUevTHJJhZ2UJUr/8TkSaF7LPde+QoeO7lp6jfxU2WugapsZoFChxg/z6rhnWk5EC88SXhXMnVDs4vfPPdEmIn7shse8CAWjYWi3V7AnYikp2CAFw0A33rcSaFbe+sCBs33WzshczycJyHvl02zd44z90UsZ+QOfhfFG0ZIoL7z4jIe1GGqH33Mhtf3dwStHg7HJfcFTGWMrRmF0EW0QNaXqbU/62Ufc4tDf02e8sTt9ZCpEYwhumBR+Th8TYSMvcIIvk2uG0BaQpHFLhir61pATq1cZDWgp2NNsREixWPttqtcq1ybFnoQ==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=arndb.de; dkim=pass (2048-bit key; unprotected) header.d=arndb.de header.i=@arndb.de header.a=rsa-sha256 header.s=fm1 header.b=sQSfLOue; dkim=pass (2048-bit key; unprotected) header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm1 header.b=O8HXW5UO; dkim-atps=neutral; spf=pass (client-ip=202.12.124.152; helo=fhigh-b1-smtp.messagingengine.com; envelope-from=arnd@arndb.de; receiver=lists.ozlabs.org) smtp.mailfrom=arndb.de
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=arndb.de
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=arndb.de header.i=@arndb.de header.a=rsa-sha256 header.s=fm1 header.b=sQSfLOue;
	dkim=pass (2048-bit key; unprotected) header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm1 header.b=O8HXW5UO;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=arndb.de (client-ip=202.12.124.152; helo=fhigh-b1-smtp.messagingengine.com; envelope-from=arnd@arndb.de; receiver=lists.ozlabs.org)
Received: from fhigh-b1-smtp.messagingengine.com (fhigh-b1-smtp.messagingengine.com [202.12.124.152])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4gr0mr4ny7z2xJT
	for <linuxppc-dev@lists.ozlabs.org>; Wed, 01 Jul 2026 23:12:43 +1000 (AEST)
Received: from phl-compute-04.internal (phl-compute-04.internal [10.202.2.44])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 4658D7A009D;
	Wed,  1 Jul 2026 09:12:39 -0400 (EDT)
Received: from phl-imap-05 ([10.202.2.95])
  by phl-compute-04.internal (MEProxy); Wed, 01 Jul 2026 09:12:39 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arndb.de; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1782911559;
	 x=1782997959; bh=XqEEA6N5CwGJ6IA3lZOQ+4Ik7bEoUp9hnbB4/W/Zwik=; b=
	sQSfLOueyGINlkU+m6V2rhx9l6c7DSh4peFKT2GDZON3Z0C4LcbV4ctXku49JLkN
	g+HFYP+lati0duVqQNupgWCUMLIDFQb3u5OhrYunrii8zZnVegxb4bXG1TicAdTZ
	1J6fEVDY8WkbUy5NVTaQZHbsMQqul3Z67raQ5Nzixux9IEaGnMSqdnlolXzBfyzT
	1kpbhhyClY1m74WD8UisTPPxiNBiHUK1gsKQyOz/Cllu1TQyh5Cgyl797knGzYpL
	s7dHJXo95drQLrIeVLutdn2sJJ7bSvCI+vVMLkubPKL1jYBySDDrpEnCUKSb1FpA
	H1/6b8NJRdzlwIK1yB4dwQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1782911559; x=
	1782997959; bh=XqEEA6N5CwGJ6IA3lZOQ+4Ik7bEoUp9hnbB4/W/Zwik=; b=O
	8HXW5UO+aYHUGl4LikMybwFP5BR8Y0BseQRJoQ7MMtQtRJUW7dx0z8kecrkKp6vE
	f8gRSqm+yzPUDG4VjaFkAv1+JLHl6ByRd2Nf8FazoyogYQkRl1dvBfFjZTfQSKk8
	VyfIiwjLPmwpzhOpCtWlTevYqBX8eA9E4N4h3nnP5TwUxyn6oD0Ms4mAgBntjB+r
	wSTbF3lQ5DcPe5gBp/7W0cOrfSMl8r/ZhRyWoVzntnmXr6AlgZ8B9Ylr2+j0d2d+
	HKycxjwa4Nz/b+UGNnW2aCoD4/MAS5C6pCPkk0ZH4p5+k2Pd89IwyHTMevvk/7Ze
	tUOd+Xhn/Bgdmdpcb/8fw==
X-ME-Sender: <xms:RRJFajJNuY7Ea447a624_w6t7wruejv0IM83V3g7A6KL8oggeAQA2A>
    <xme:RRJFah-e56FYyd82CwMxPWeJjpQRTsQnlwKSbLFSNlao1NsAE5Wp-CdM4hyLbkXQE
    _DlzPAfMzoE-whGqeOAnblKj8Oai3gyJlPqRfIoY39qPxdSMlnPpfI>
X-ME-Proxy-Cause: dmFkZTGla2qQNlSZKlIqara0zN5koG4KqHg1bkjXpggyAWCLJNg2kfVgLI8lLCbuU2lk8S
    kRgH252hH9LXdkXzSDSjqALczLdLPKlEPR5SaACUkXhDXWZtx+GoScADM9yWf1unDYqP8Q
    2WSsB+yxUTjScO4bMrLoRiVJEsOVtHKynDYkTDSNlV/FlVOr++ZZbwgmEhkG986gVx8K+K
    aifgVAxvA4y5ZVbSgxsda+zcFEbK/18X5WWflJ/ywdGPJlyZMoKT8cNBLhbRk76vDXjwpw
    QLo2apXc7MtJeiGpsVVyKxyOA/SHS/M5eq8vxnr8WZeLKtuTYlVXwaw/JxEnplkTQrl3Pd
    B7NJkf2pxDtojfaBQtKKBZV/obBu6aw/ly8+Aq5oikyGZRbLPSYuUz30ITeiZegu7GL1IY
    BH+bpbU2FYzgYNvuW0kYqCdaBa94ExMmldk/xGt6dBhZaPieoYjNF9biNBBc3rgUbgmFbj
    62LsHEdx24hoFQqVnJ9a9mVEjsfGg3qOJ5+MN46JlrX9eUQauDWHHEy0Awb0Lne6WNgaUO
    4yVurEkxq/P/EbUXu4DrDTid9azOO9+oXTmhGP+PV4UklaisM4awcqFWxNagTgrY4T7xHu
    8B7GWHRFLuVtfbbi9R9DHc8ER2iJp174rEfUAKSD/WUZBfVxKq+AH24iHCTA
X-ME-Proxy: <xmx:RRJFalJN2aoA8kDFMua_h-i5Chn-r0wU-KwqgCI_zyQFyJxETPlNhw>
    <xmx:RRJFajzXivGAASdZ72Is3bie1NpvnftEdIUPxmclVvZbBh4i5pzhmg>
    <xmx:RRJFatM652J4WnFqkRON4WLzi44_c61ZybTn0ej-5qq9fbWYJQjNfA>
    <xmx:RRJFanuRV787OOoAY7DQlxvI-5sNjEiRW1y01nGxGmEYB1CpRRmLyA>
    <xmx:RxJFavp-QxIqJqyh2AhOILa9hNEeIKNUBd7uz-YJn9OT8avMOzD2XKsB>
Feedback-ID: i56a14606:Fastmail
Received: by mailuser.phl.internal (Postfix, from userid 501)
	id 537641820082; Wed,  1 Jul 2026 09:12:37 -0400 (EDT)
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
X-ThreadId: AE-5y0c3-Pto
Date: Wed, 01 Jul 2026 15:11:56 +0200
From: "Arnd Bergmann" <arnd@arndb.de>
To: =?UTF-8?Q?Thomas_Wei=C3=9Fschuh?= <thomas.weissschuh@linutronix.de>
Cc: "Andy Lutomirski" <luto@kernel.org>, "Thomas Gleixner" <tglx@kernel.org>,
 "Ingo Molnar" <mingo@redhat.com>, "Borislav Petkov" <bp@alien8.de>,
 "Dave Hansen" <dave.hansen@linux.intel.com>, x86@kernel.org,
 "H. Peter Anvin" <hpa@zytor.com>, "Russell King" <linux@armlinux.org.uk>,
 "Catalin Marinas" <catalin.marinas@arm.com>, "Will Deacon" <will@kernel.org>,
 "Madhavan Srinivasan" <maddy@linux.ibm.com>,
 "Michael Ellerman" <mpe@ellerman.id.au>,
 "Nicholas Piggin" <npiggin@gmail.com>,
 "Christophe Leroy" <chleroy@kernel.org>,
 "Thomas Bogendoerfer" <tsbogend@alpha.franken.de>,
 "Vincenzo Frascino" <vincenzo.frascino@arm.com>,
 "John Stultz" <jstultz@google.com>, "Stephen Boyd" <sboyd@kernel.org>,
 "David S . Miller" <davem@davemloft.net>,
 "Andreas Larsson" <andreas@gaisler.com>, linux-kernel@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linuxppc-dev@lists.ozlabs.org,
 linux-mips@vger.kernel.org, linux-api@vger.kernel.org,
 sparclinux@vger.kernel.org
Message-Id: <a512dc5f-0734-4bd0-838c-61c8820e5f6d@app.fastmail.com>
In-Reply-To: 
 <20260701102912-ea8f3291-7bba-407b-9a7d-7c367a4c9398@linutronix.de>
References: <20260630-vdso-compat_32bit_time-v2-0-520d194640dd@linutronix.de>
 <20260630-vdso-compat_32bit_time-v2-1-520d194640dd@linutronix.de>
 <0cda7366-2eb9-4ecb-b76a-b3b68ee10043@app.fastmail.com>
 <20260701102912-ea8f3291-7bba-407b-9a7d-7c367a4c9398@linutronix.de>
Subject: Re: [PATCH v2 1/9] time: Respect COMPAT_32BIT_TIME for old time type functions
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On Wed, Jul 1, 2026, at 10:40, Thomas Wei=C3=9Fschuh wrote:
> On Tue, Jun 30, 2026 at 03:00:37PM +0200, Arnd Bergmann wrote:
>> On Tue, Jun 30, 2026, at 09:38, Thomas Wei=C3=9Fschuh wrote:
>> > The "old" time types use 32-bit seconds which are not y2038-safe.
>> > Respect COMPAT_32BIT_TIME for functions using those types.
>> > time(), stime() and gettimeofday() are disabled completely.
>>=20
>> Looks good, yes
>
> Sashiko found an issue [0], which I think is valid. I'll change that f=
or v3.

Ok

>> > settimeofday() is kept as it is required to do the initial timewarp=
ing
>> > after boot. However the 'tv' argument will be rejected.
>>=20
>> Not sure about this part, did we already discuss this last time?
>
> This is my interpretation of [1].

Indeed, we did.

>> I can see how keeping the timewarping functionality is the easy way
>> out, but completely disabling the settimeofday syscall the same
>> way we do on new architectures seems so much more consistent.
>
> Shouldn't we then do this completely? Irrespective of COMPAT_32BIT_TIM=
E?
> And then remove all of the timewarping and kernel timezone bits.

I don't think we can simply kill the timewarping code since that
likely has users on architectures including on x86-64.

COMPAT_32BIT_TIME=3Dn is somewhat special because this is an
intentional (and optional) ABI break already and requires
updated userspace that avoids the time32 syscalls. Having the
timewarp still in settimeofday() or dropping it entirely is not
that different for userspace.

I was slightly worried about whether returning -EINVAL or -ENOSYS
is the better option here, but I think your choice is the correct
one after seeing that this is what glibc does other invalid
cases, and that in all of codesearch.debian.net, I could not
find a single caller that would care about the difference.

> It would be nice however if this series, and my other ones blocked beh=
ind it,
> are not blocked on that larger rework.

Sure.

I think you can go ahead with this version. I would prefer
to not have any settimeofday() for the COMPAT_32BIT_TIME=3Dn
case, but if nobody else has a strong opinion on the matter,
let's do it your way.

Reviewed-by: Arnd Bergmann <arnd@arndb.de>

