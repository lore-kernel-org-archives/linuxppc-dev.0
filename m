Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 12A48606A33A
	for <linuxppc-dev@archiver.kernel.org>; Mon, 23 Nov 2026 14:17:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=arndb.de header.i=@arndb.de header.a=rsa-sha256 header.s=fm2 header.b=cPLj8Yt9;
	dkim=pass (2048-bit key, unprotected) header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm3 header.b=hC6LIkJb
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4jY7LY2bXJz2xyj;
	Tue, 24 Nov 2026 01:17:25 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=103.168.172.148
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1795443445;
	cv=none; b=as1lNdftNyALBuPC0RRzfH2tQsIjfp+E+KpGTWUOnL4Ka6VEM9HuBITnJXjbRNUkDf7c0pvC0YPGqirXIDi2Tufty3wkBsStJD4EnXq7+CJh1PSfxj6F137BiHAMgxxTEq/SZB2F/Ct2RsHbRobMmxlqgWLf5eJGNmjQolNdkgXbswOfXQUPmaWlak0vc5/sg3ruuFh5AsiqeV9cstYT2uT8mYL83C0fd9lPXUF75vE0RhiqnMERPmBVek6+N12I/qc4r5+7PgMVHlQcj5SOBpO0fEREAOOEe8nldxJVqjL9Se4MW6wr/n7u0eLDCp1gDRrBUgaRx4j7mlex1sl4vg==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1795443445; c=relaxed/relaxed;
	bh=BHJ91NJtNYQ6/J6+FaRGzznho5yPOY/r3tuo2Sshg1o=;
	h=MIME-Version:Date:From:To:Cc:Message-Id:In-Reply-To:References:
	 Subject:Content-Type; b=Q7t27T2NKh4JFrCaWtMdduBsqbvuBIP32jcMLtJDCvUKGW6MrtXC7EVxkJ8mxegbCXWHopcrV58YRqoNURmd+k/B1oNyQDZEO2Jxx7/Zsx+c+Na1mTdsTbcEsElKah0PmiMl5L3Z9mZVfGIuazUAOyDtEcFOhl47pnI/M8jfVYsa545m+qab/82S9fcdrHttCbcPo51jsCOTjkZgeu1hYZ+xckH694IxzgerNyVQY2KuWMHEYXlFkqTVgqEchMw+Xo6061q9pFjC4umA8+MerdHclmZDk4xfI0YUPmjIugHJICEVdgzr40zmBgVWWjP0/wpF9imFFAARj7RuSRX8MQ==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=arndb.de; dkim=pass (2048-bit key; unprotected) header.d=arndb.de header.i=@arndb.de header.a=rsa-sha256 header.s=fm2 header.b=cPLj8Yt9; dkim=pass (2048-bit key; unprotected) header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm3 header.b=hC6LIkJb; dkim-atps=neutral; spf=pass (client-ip=103.168.172.148; helo=fout-a5-smtp.messagingengine.com; envelope-from=arnd@arndb.de; receiver=lists.ozlabs.org) smtp.mailfrom=arndb.de
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=arndb.de
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=arndb.de header.i=@arndb.de header.a=rsa-sha256 header.s=fm2 header.b=cPLj8Yt9;
	dkim=pass (2048-bit key; unprotected) header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm3 header.b=hC6LIkJb;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=arndb.de (client-ip=103.168.172.148; helo=fout-a5-smtp.messagingengine.com; envelope-from=arnd@arndb.de; receiver=lists.ozlabs.org)
Received: from fout-a5-smtp.messagingengine.com (fout-a5-smtp.messagingengine.com [103.168.172.148])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4jY7LT6Qwyz2xQD
	for <linuxppc-dev@lists.ozlabs.org>; Tue, 24 Nov 2026 01:17:21 +1100 (AEDT)
Received: from ams-compute-02.internal (ams-compute-02.internal [10.64.2.62])
	by mailfout.phl.internal (Postfix) with ESMTP id BC607EC0B98
	for <linuxppc-dev@lists.ozlabs.org>; Mon, 23 Nov 2026 09:17:16 -0500 (EST)
Received: from ams-imap-03 ([10.64.2.23])
  by ams-compute-02.internal (MEProxy); Mon, 23 Nov 2026 09:17:16 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arndb.de; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1795443431;
	 x=1795529831; bh=BHJ91NJtNYQ6/J6+FaRGzznho5yPOY/r3tuo2Sshg1o=; b=
	cPLj8Yt9KDzFT9oOBUn+/GuSsf5mynsPFU3peaGSzzjdcM3xPq2nCeDkNchhwU0y
	agEnTSgyBbGQ/yirLqdAtbec6K/eMPAPx84L678ABrYcb+wpXySl2GHRp4LB9WLN
	CFo2ebu58MUl9iNZ9Ieq9B5w0n8KUsPK5DwUz9m8y9EZ7/GezgGomuFh9mdki4r/
	+BIiXtKtzOGG5D+kuw3mpodMWyr20zPfOAhpC9pxJqrf1XcU6K399GtXsEQMc/8R
	39qj2UCf7kgamdATa+Pl6YH54Dj6cd0VQx4T8GjJ0eSyaIyzVoR7OVUL9GzpK8m7
	+ruoO3v7zMRO6WezXgniMQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1795443431; x=
	1795529831; bh=BHJ91NJtNYQ6/J6+FaRGzznho5yPOY/r3tuo2Sshg1o=; b=h
	C6LIkJbKj92f5S7k/JXfyeaid1Af9ZzNDUOfhQPFxJP9BRVK8CoFu3txAUBGFSdE
	kDtEOIgPiZzvlCZbCv4YLx/KipUoHlpFtABBaFDzTO/Eo99zurKqUHK11ZRFH3nk
	zrK7lUHYw/5sxSK66fxI2EBGUdhZg116RSbILC1OuB62zbnw2sD4sW3+a4PBWhw+
	vIkMNp+LX1SFD5zMvRTmes4VjgpqWOOFse8Womzu4lb2d/5udJ8V95DWmA0O1EvJ
	RGzmtn81sr/9oZLy7H3BztHTIli/UeDdJz4S0o8+2QlJ2kzB0w3ffJ58MILv/tOp
	VBsPDLa1+OUIFoA4NwwtQ==
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-09;
	repo=github.com/dkim2wg/interop; date=2026-11-03; sw=lmtpprox;
	action=sign d=arndb.de a=rsa-sha256;
DKIM2-Signature: i=1; m=1; t=1795443431; d=arndb.de;
	mf=PGFybmRAYXJuZGIuZGU+;
	rt=PGxpbnV4cHBjLWRldkBsaXN0cy5vemxhYnMub3JnPg==;
	s=fm2:rsa-sha256:B0z5X0IgH8LJSg532GU6JnpsgaqAtxdEsfwEO6ZJcYN+ad3
	YlMytqj+EKyng/9mY2OC+CT7MvcoIyZ1UtWh1i3UqXc+7gkhEENH5lHpPJg4YZdM
	Tg35AGH0LVyn/Ek/7l2hZrDpIDRIGuUd8BnsB+6fkinSAkYClmIPUWYYouP6h5Y6
	ysvezS9Sc54fsQSJzxr4ufHMeaoKQsDXR4J0SdsCRmwxGHizb8JmHpTCu0odsh3i
	O7+E6tiS8kAkQWk+huGxf/aE1SexzTY+7Jnol3VvKAQqEoMPPxkarkqdh/3lNlTR
	Esw3JwFnMLeAKHz+n8o6dH6l8H7ySfW1l+ehNHQ==;
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-09;
	repo=github.com/dkim2wg/interop; date=2026-11-03; sw=lmtpprox;
	action=mi-m=1; hc=12;
	hn=cc,content-transfer-encoding,content-type,date,feedback-id,
	from,in-reply-to,message-id,mime-version,references,subject,to;
Message-Instance: m=1; h=sha256:Sap56MIkcyZT8r4cYNPG+lEt8q7zj6cm/hR6DX/YHXU=:rDsMBjpfa65jK66igtyHf1M93PmlfJObl6/94lUiVSI=;
X-ME-Sender: <xms:4koEa8b6jWHk9Km-gWsvkjXKBe9FOycLSAoQHdX1x28WgylltvrlXg>
    <xme:4koEayN-2NZ5tuVMTv_F6M4wNcDyjmgtjmjdAzvHywIA7KHMufFQZrYw4q170T5Th
    fPdBGfTNlodLlNUN9knmz7mxDJr9FP9Hc2uPOv3pg8T14AiyewMGhM>
X-ME-Proxy-Cause: dmFkZTGFrwq2MF5SSuOMe3naqs9tbtMAmc3XEG2p+PrgD+xfiVSS77ldCceRFMgHOXXvSL
    Ging+R6VT6K3yz4OUeCdmIETXjNj7XXI0r9Tg2543OHjiuaKhMh+yVJAoB6OkAWbwGP/U3
    JowxnSxhNhDyTsBNjiM7LlqkLGWpphbuTeJ0WjErvJ9KhK0fJtLolaHFC6Kw2talXF2YGF
    JN7yWyVcYnsY66wGn8uoBc1Op9fn/HtafFpC/Ha3Z7ng5ziTGTERGiQYQq5K4ZdS/5JuDE
    HH1gfdWjYiM0bW96wZfgClnWGF2XIAu99qwAHGam6Iwuv/kahBWnYmwWVFrVPNzzZ/ahP5
    U1UkBFU5ZxOctbFZFvYR87OCQ9D85IrFkHXF9AU7aFYWG6vLW8lI9uDg5E561v2/5hKHQA
    sjQFn5A8NcDFUKKIz/Gj2N6XcZVOTlbQkDMhl7pFKmJR0nTwtc/ea8J3ozLffLR/0wUUbB
    iamGkspUsbgem4niF9wBtKb8Aybdc10XaTbLUSATly8dgGeAoj4vWgf2FM9ltEDrHvDjNY
    51emBC5k6bV+SyYpJacMFkokFxMkxKPk9r+T99bzSjJsfdRVRAC/r+2KM3FJJSK6C1f8wW
    I+V82FhA+/RpOowStt3CO/53UAvaoCC1+Mr9HKqAkD73+MJL10fMk/SelFXQ
X-ME-Proxy: <xmx:5UoEa7zTEzd5mDVuAJ0khzXfAhl-NnyAwD2CijXl1cunNEN88JhvqQ>
    <xmx:5UoEa4LmzfnQ4K0KUaYuA7sCKQ4bXebQmmhpsTBdhtm50HSfa0pUZw>
    <xmx:5UoEa9456MjeyYgj744opH-waU6skY_xuQzxaCDvT7bwukaslpL8Pw>
    <xmx:5UoEa2xmieeiTKUZnDvuF-Yhydil8f6ZkK_qEXx5P2wofodg1yRZbQ>
    <xmx:50oEa5l_6AC-8c6ZgGJR10cedMu4FgnH1XmeVBS7jPfPPs2PoWN-CFom>
Feedback-ID: i56a14606:Fastmail
Received: by mailuser.ams.internal (Postfix, from userid 501)
	id 6EB4832A009C; Mon, 23 Nov 2026 09:17:06 -0500 (EST)
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
X-ThreadId: AMjdjL9dYp0J
Date: Mon, 23 Nov 2026 15:16:41 +0100
From: "Arnd Bergmann" <arnd@arndb.de>
To: =?UTF-8?Q?Thomas_Wei=C3=9Fschuh?= <thomas.weissschuh@linutronix.de>
Cc: "Kees Cook" <kees@kernel.org>, linux-mm@kvack.org,
 linux-kernel@vger.kernel.org, Linux-Arch <linux-arch@vger.kernel.org>,
 linux-arm-kernel@lists.infradead.org, linux-riscv@lists.infradead.org,
 loongarch@lists.linux.dev, linux-s390@vger.kernel.org,
 linuxppc-dev@lists.ozlabs.org, linux-mips@vger.kernel.org,
 sparclinux@vger.kernel.org, linux-sh@vger.kernel.org,
 linux-alpha@vger.kernel.org, "Paul Walmsley" <pjw@kernel.org>,
 "Andy Chiu" <andybnac@gmail.com>, "Magnus Lindholm" <linmag7@gmail.com>
Message-Id: <b7b8e8cd-d0ba-4e37-93f3-0fa209207124@app.fastmail.com>
In-Reply-To: 
 <20261123110111-6431e85f-39a4-427e-b545-2e7a590a6c19@linutronix.de>
References: <20261123-at-vector-size-arch-v3-0-d342dae9e843@linutronix.de>
 <ec5359c1-c16e-4177-8dfa-2ae5ab8a874f@app.fastmail.com>
 <20261123110111-6431e85f-39a4-427e-b545-2e7a590a6c19@linutronix.de>
Subject: Re: [PATCH v3 00/15] exec: Remove AT_VECTOR_SIZE_ARCH from UAPI
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-10.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,MAILING_LIST_MULTI,SPF_HELO_PASS,SPF_PASS
	autolearn=unavailable autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Mon, Nov 23, 2026, at 11:03, Thomas Wei=C3=9Fschuh wrote:
> On Mon, Nov 23, 2026 at 10:44:40AM +0100, Arnd Bergmann wrote:
>> On Mon, Nov 23, 2026, at 10:37, Thomas Wei=C3=9Fschuh wrote:
>> > There is nothing userspace can do with this value. In the kernel is
>> > always combined with AT_VECTOR_SIZE_BASE, which is not exposed to
>> > userspace and also changes from time to time.
>> >
>> > Move the symbol to kernel-internal headers.
>> >
>> > Meant to be applied through the asm-generic or execve tree.
>> > The default recipient list was huge. I trimmed it to only the
>> > architecture lists.
>> >
>> > Signed-off-by: Thomas Wei=C3=9Fschuh <thomas.weissschuh@linutronix.=
de>
>>=20
>> Hi Thomas,
>>=20
>> I'm happy to take this through the asm-generic tree. I've already
>> made sure it all applies and the patches look good to me. I'd
>> wait a few more days for additional Ack or any other replies,
>> let me know once you think I should apply this version.
>
> This v3 is functionally identical to v1 and v2 which have been on the
> list of a long time. I am not sure how much more feedback will come.
> IMO it can already be applied to gain more exposure in -next.

Fair enough, pushed out to the asm-generic tree now.

     Arnd

