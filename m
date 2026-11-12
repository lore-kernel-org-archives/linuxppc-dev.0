Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 20321606A321
	for <linuxppc-dev@archiver.kernel.org>; Thu, 12 Nov 2026 13:48:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=arndb.de header.i=@arndb.de header.a=rsa-sha256 header.s=fm2 header.b=ZFg7XYud;
	dkim=pass (2048-bit key, unprotected) header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm3 header.b=1uQLCPUh
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4jQMDF5q6Wz2ynW;
	Fri, 13 Nov 2026 00:48:29 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=202.12.124.144
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1794491309;
	cv=none; b=U/podO6KZJWFBflztSHS3eyZfUNkS+HSOLCS61a7qprW1x7DF8B5RrjrUNu0G9uZ7r9IIXyBrcGpyfNcieszoH/KFltUc1f3ecbCaCbfg44hKr9N9TqXOheXIG8eUfnD25/1rXSHY6G/Rv2Z9xSAQwQaUPYiDz1wsBlXWcvPXg4FyIAcOcVyyos/l7L4D1XNX80KlIA0+otqqafGiQqFHrHEO8e0TxZtsC6RdFjS8JVNQ8POKtuBgvIZcx+HlFM9h8v1ZGBj2NouaH88WwHYvzOkBngOcbmfWoAS8lYXlxWG04RJ6sbh+yzEfNYmSCiRbDfW58SITQ8m6r2bJ/StMA==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1794491309; c=relaxed/relaxed;
	bh=VRT7mJ1HJtli90asQUPZL0I86WWZMiU/wK7Ix1+t7eg=;
	h=MIME-Version:Date:From:To:Cc:Message-Id:In-Reply-To:References:
	 Subject:Content-Type; b=HZ3fki7eedTiXkIGnskeyPs31+sgLlP6wWFAAl565CWQVsgiirEEBxlxUIu9RZ0HodzXOEHvHSaLEEt8064A3Wff77j6y4nrTHHjLVWbyUXxXxng8TCWdDD55/XLUA1rhGTplQpmelyhnjuW162cesf9XO6THi2paK582olgAAfqXAL8DD2CKGFtFdq9DbDECqaSMMYbaXN8BJjCbFLNRcDJROGJFSH6FzNSJk2HYhhOaqQZuP9KRj/65ekCqRgK3pt7kQxnbpe/lvkk24WBm9iewRf32v1+PdF27Fpa6cQBBrODEYGI9O04gv+TjUZzYYbwIzJKOEISCVOwj5JMiA==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=arndb.de; dkim=pass (2048-bit key; unprotected) header.d=arndb.de header.i=@arndb.de header.a=rsa-sha256 header.s=fm2 header.b=ZFg7XYud; dkim=pass (2048-bit key; unprotected) header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm3 header.b=1uQLCPUh; dkim-atps=neutral; spf=pass (client-ip=202.12.124.144; helo=fout-b1-smtp.messagingengine.com; envelope-from=arnd@arndb.de; receiver=lists.ozlabs.org) smtp.mailfrom=arndb.de
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=arndb.de
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=arndb.de header.i=@arndb.de header.a=rsa-sha256 header.s=fm2 header.b=ZFg7XYud;
	dkim=pass (2048-bit key; unprotected) header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm3 header.b=1uQLCPUh;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=arndb.de (client-ip=202.12.124.144; helo=fout-b1-smtp.messagingengine.com; envelope-from=arnd@arndb.de; receiver=lists.ozlabs.org)
Received: from fout-b1-smtp.messagingengine.com (fout-b1-smtp.messagingengine.com [202.12.124.144])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4jQMDF0D0cz2y8F
	for <linuxppc-dev@lists.ozlabs.org>; Fri, 13 Nov 2026 00:48:28 +1100 (AEDT)
Received: from ams-compute-02.internal (ams-compute-02.internal [10.64.2.62])
	by mailfout.stl.internal (Postfix) with ESMTP id 287F01D0011E
	for <linuxppc-dev@lists.ozlabs.org>; Thu, 12 Nov 2026 08:48:26 -0500 (EST)
Received: from ams-imap-03 ([10.64.2.23])
  by ams-compute-02.internal (MEProxy); Thu, 12 Nov 2026 08:48:26 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arndb.de; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1794491296;
	 x=1794577696; bh=VRT7mJ1HJtli90asQUPZL0I86WWZMiU/wK7Ix1+t7eg=; b=
	ZFg7XYud8u3ZU3Vkr/1+eIliGEe+kQpH74nnhHWI7Eqc+HTavuuK9CUC1l9eKjDl
	jxu0OB8wXxkeLLbJv/9cSzU6GZc5Ct1v5d2nKsqHPbE2eB7l1wEap3sBTnrNH9fd
	tHE/oZj3+liNdFO1FR9C/XEbBMz1bm3QTqTsv9uWf9GEn4OB+UsPYx+LzAu+UJJO
	kRuyewpUP8qR94gZ5U+ZiVkd7Y8gPbDaB1GcbLOwO/p6es1saLOgeIvtTtKfXkxI
	VUfs+tVFBkTtn2Hro2xBsdP2fIs8DZ3ubGeDC4d+RPucAlx2znFsP1S5Gpq2O/wS
	nD0UZ6mz4iqcRJlx1HrjTQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1794491296; x=
	1794577696; bh=VRT7mJ1HJtli90asQUPZL0I86WWZMiU/wK7Ix1+t7eg=; b=1
	uQLCPUhfpBkq2Q22QgeuW9H5rrij5v+JMSy5FM2Wn+bVtVQBLeosNDVadLXZzukT
	3ouV7DnyvuyiCjMHoXchkZDUIAQ5TNEOLM8fzzVTzUmtwfczTeK2Z9KzWhjwH51f
	yDnw4gyc+K0fXZmrcuW80+VEyvEIDtNjgrjgvRYEjyryAv/MZzVXs4TEY03/oaGO
	0ZFAdG+NCCE6y9SCvV2bOMdPwpuvyjJJWHehPsHJjVpsttWDo2kiTwmWwwreEe5S
	85mDPA3PfONLF0QXnmwQletEi95k4tT3wPna+QS8PYV+oeL/9yPHQJP+K4xyjoxj
	ibh6+VdtoW1xNp2Vd7e3A==
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-09;
	repo=github.com/dkim2wg/interop; date=2026-11-03; sw=lmtpprox;
	action=sign d=arndb.de a=rsa-sha256;
DKIM2-Signature: i=1; m=1; t=1794491296; d=arndb.de;
	mf=PGFybmRAYXJuZGIuZGU+;
	rt=PGxpbnV4cHBjLWRldkBsaXN0cy5vemxhYnMub3JnPg==;
	s=fm2:rsa-sha256:JeD7iC2p8cQSylVlVtnMwnTzGHq0DI0xd/fpwdK/lZ12aEh
	zF4SgR/EMOgFZK/nA2FapDxtfXFsLvFPtO1rT/uTWfkMqjab9pOxq4VWSebysbc1
	0nNAKfaA7v9Qcxb0cbhBy4BhyHXJvmbeOzCrIRw697dLB/WcHl0JqTazMrQfN9W3
	tuUExwlc5z9GDuxDEYTmXGQEqDXkc0/stkX9/KEDsiVA+OfvHRW/4eG36GvG6ehP
	byRgAMk/5J35TTscMY3K4jUJkrCISGTMsYWiahJCergCtgk99dfKD6nHSX1oM9zv
	GgfJ5sScybE53alre13VprF3YtMaKI+sUHMBnVQ==;
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-09;
	repo=github.com/dkim2wg/interop; date=2026-11-03; sw=lmtpprox;
	action=mi-m=1; hc=12;
	hn=cc,content-transfer-encoding,content-type,date,feedback-id,
	from,in-reply-to,message-id,mime-version,references,subject,to;
Message-Instance: m=1; h=sha256:cDV/QukbB05DRWJQW1ny9Aplo0b9qlgUV7WG7RUjw10=:QpFJvCcS58Sd3l/liFWB5KOxe2KSj2H6oM6J00vPM5M=;
X-ME-Sender: <xms:mMP1aiXThfwsuTrckyvDNGaYKe-apvviZAyhg0Ae8AMVYARi_onkow>
    <xme:mMP1apb4WFgdoJcRw59RSXVmyyuJBI2enov0nwdM4Ezb_w-TOtmg7uEroPc3LUZ3H
    ayaSunT543I9lWRFx4LIM8LWal-iabylMdGB5cCQE1D66Elz8C01tE>
X-ME-Proxy-Cause: dmFkZTFSmrUQX6bVW+lydj2wLsCuvaSKIx7UJ4HZRXOwisKCAL64G7eTFeLIwxo2T5imjf
    E1T6qbM/BpAj3rqGX7z/WvswXxFcRdzeCXGFLaUKXMMCfRQjNd1u0uFGorpgeWiaCcwvut
    z3Yv2eiVJdW58Aeq1cotcHaZ52EAnYL87aE6+8qn7JtG48eGsTjG5u4OA3wp7Sfct0hPl6
    SJDUdXRl9Cp8oPKmtjGBmtHsBuFdoplTXhuvisAGQwC1Vl4MnT6XIgyth+NfI4Td55nldD
    Gyc31cN9GH9jT3czwpKGByIajJOn4jOEuqZDft6XCP0PJ1RDN5ohH/x11Qe4XbGdlpD9Bi
    D56KnFCMSvcirQwaOYWvKT3yEGTRCa2GXjvhrXOyUbOtNJhcYJmv/mZdKsc0omGFwtHoL1
    ZkKG/RRWMfHUFxSWX1ntYPunZlC++v21L/7td61gFdlBMiQIgffRJiD4V6POoDLDEgTFUQ
    qLkBCOWSAKbdoishupBjm/gVDsjPbYVtEFSRUCDHEOb1xpXvwmyd1YcBXdVJHQO5JfUhsl
    HbYFkwCvwU7fLtFehoAetiILiInkyZX35SSJZx3I+2ihzpc1jP5mRs09gVazpURvT131hO
    5MSiT4pcVHLXcLK6h8mKLFX/3Z8vTZd+SuwiYcvj5SIZIjvgFSDgssRisahw
X-ME-Proxy: <xmx:nMP1ak-egndCZ57bWUj3sKD_G9xgJaCR7wv7-Th42nK5bwH2bvZN8Q>
    <xmx:nMP1akoYo7PrCKZAkPmeWaoUQZXQtHTMUgGLRbP4QtbRmof8uDNWrQ>
    <xmx:nMP1ahPdIaqFM8xIN7rde2bXAYz3_nLjAgCk8jEliTPnIkGGn51udg>
    <xmx:nMP1aq6QcTmNrtWmoW4WwRUC7OR_XhZlbvh63W9H89hpDWjtKomLVg>
    <xmx:oMP1aiZgXBRRtMTvaCTvs1d8MGU9Z8LHyeZ9oDKxj_7O-wQc2k1st61T>
Feedback-ID: i56a14606:Fastmail
Received: by mailuser.ams.internal (Postfix, from userid 501)
	id 6C4DC32A0099; Thu, 12 Nov 2026 08:48:08 -0500 (EST)
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
Precedence: list
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-ThreadId: An903QizF2Ds
Date: Thu, 12 Nov 2026 14:47:28 +0100
From: "Arnd Bergmann" <arnd@arndb.de>
To: "Arnd Bergmann" <arnd@kernel.org>, linux-mm@kvack.org
Cc: "Andrew Morton" <akpm@linux-foundation.org>,
 "Andreas Larsson" <andreas@gaisler.com>,
 "Christophe Leroy" <chleroy@kernel.org>,
 "Dave Hansen" <dave.hansen@linux.intel.com>,
 "David Hildenbrand (Red Hat)" <david@kernel.org>,
 "Jason Gunthorpe" <jgg@nvidia.com>,
 "Linus Walleij" <linus.walleij@linaro.org>,
 "Lorenzo Stoakes" <ljs@kernel.org>, "Matthew Wilcox" <willy@infradead.org>,
 "Malin Jonsson" <malin.jonsson@est.tech>,
 "Richard Weinberger" <richard@nod.at>,
 "Russell King" <linux@armlinux.org.uk>, linux-arm-kernel@lists.infradead.org,
 linux-fsdevel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org, x86@kernel.org
Message-Id: <ae1a379b-89be-4284-b65e-4a6cf6aeaabe@app.fastmail.com>
In-Reply-To: <20261112112528.1116405-2-arnd@kernel.org>
References: <20261112112528.1116405-1-arnd@kernel.org>
 <20261112112528.1116405-2-arnd@kernel.org>
Subject: Re: [PATCH v2 1/6] ARM: remove support for highmem on VIVT
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-10.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_PASS,SPF_PASS autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Thu, Nov 12, 2026, at 12:25, Arnd Bergmann wrote:
> --- a/arch/arm/mach-omap2/Kconfig
> +++ b/arch/arm/mach-omap2/Kconfig
> @@ -135,7 +135,7 @@ config ARCH_OMAP2PLUS_TYPICAL
>  	bool "Typical OMAP configuration"
>  	default y
>  	select AEABI
> -	select HIGHMEM
> +	select HIGHMEM if !CPU_CACHE_VIVT
>  	select I2C
>  	select I2C_OMAP
>  	select MENELAUS if ARCH_OMAP2

I'm not sure where this comes from, it was probably a mistake during
rebasing. None of the V6/V7 CPUs can be built with CPU_CACHE_VIVT, so
I've dropped this part.

     Arnd

