Return-Path: <linuxppc-dev+bounces-18122-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 254D61067041
	for <linuxppc-dev@archiver.kernel.org>; Thu, 12 Mar 2026 15:03:44 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4fWrV716byz3cFN;
	Fri, 13 Mar 2026 02:03:43 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=202.12.124.139
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1773327823;
	cv=none; b=I+2WL4nbKDext1020J6afxyjwnQeDVEFQs9cZ5O3J2nXqj3f4K1SFPyueH4bOKn2qyZHSGEWglNFLAGti7X0dyDTQ2h+E/W6uJ1Uj9Zx2FFVdwMp79sysPWnNK65HBdb9fmWw5TOmR+btqc2Jyu3PlO9LWY64WgZx//4iHvwiGgrGqw+sryPszHk3vwUIRhfUQZmrqyBnvrZkQQ9nRjmqxuKQX/xAqJ8TFDAz3ov9q1L8h3MF+pCbdyQa+0VlQIivaoj4GWko2JyzMC/3Eu3t3sukmW/anQaywPB2cie/MCfWR4veeZ8LrIJJwMuzDeIOVEGXwKGdOTyc9t+cAJLDg==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1773327823; c=relaxed/relaxed;
	bh=SaJoBOWdSuPgCxv7hYpeAKeVFQyklTNNXObk3qvPfvI=;
	h=MIME-Version:Date:From:To:Cc:Message-Id:In-Reply-To:References:
	 Subject:Content-Type; b=QKLsMfpUGmExL1Qh0cOvHxDIykI5HJyrEurUWwPiotPRVwcoh9w68p2q0O0rdCRVTL2p63oqqNRXX0yqPVRX+V/ztLJKEaMY/2oZUXE9vo+b5lM/MwPWFCplMqnMnfmb3IY80nU2DsXSkpW2tGamjIaN9KgCR6mDxIfrTTs9hjELEcQOY5Cl5sbR9CiKKCB6zdHJkeHV89w08BJxxLz9P/UcnmQHSpxZxlzKJOVPoJKVRvBwSpglWcyZ5t7UO55zdQZNHyAmrBJykNfDDefV5oDPhCHHeHppxPYXQa/CI6GTupOprl5Pyrx5zSxbeT2RAzkLpqxti0dLdIQU48z6VQ==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=arndb.de; dkim=pass (2048-bit key; unprotected) header.d=arndb.de header.i=@arndb.de header.a=rsa-sha256 header.s=fm3 header.b=bGvJqXL+; dkim=pass (2048-bit key; unprotected) header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm1 header.b=o81mzw52; dkim-atps=neutral; spf=pass (client-ip=202.12.124.139; helo=flow-b4-smtp.messagingengine.com; envelope-from=arnd@arndb.de; receiver=lists.ozlabs.org) smtp.mailfrom=arndb.de
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=arndb.de
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=arndb.de header.i=@arndb.de header.a=rsa-sha256 header.s=fm3 header.b=bGvJqXL+;
	dkim=pass (2048-bit key; unprotected) header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm1 header.b=o81mzw52;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=arndb.de (client-ip=202.12.124.139; helo=flow-b4-smtp.messagingengine.com; envelope-from=arnd@arndb.de; receiver=lists.ozlabs.org)
Received: from flow-b4-smtp.messagingengine.com (flow-b4-smtp.messagingengine.com [202.12.124.139])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4fWrV31qk7z3cCJ
	for <linuxppc-dev@lists.ozlabs.org>; Fri, 13 Mar 2026 02:03:38 +1100 (AEDT)
Received: from phl-compute-04.internal (phl-compute-04.internal [10.202.2.44])
	by mailflow.stl.internal (Postfix) with ESMTP id 989381301A09;
	Thu, 12 Mar 2026 11:03:34 -0400 (EDT)
Received: from phl-imap-02 ([10.202.2.81])
  by phl-compute-04.internal (MEProxy); Thu, 12 Mar 2026 11:03:35 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arndb.de; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1773327814;
	 x=1773335014; bh=SaJoBOWdSuPgCxv7hYpeAKeVFQyklTNNXObk3qvPfvI=; b=
	bGvJqXL+CssgN9qcX6cryh57mVbGY/RIgqlwo0DFIBN1SUBMT453trmu9eYBrm37
	hVMySZEnXc1sCYAT9luPhCcccEYQp/GcoeeL5U11WztDI9Kos7lHLrpQ7DSbCIFb
	VLAX1fDkP4Nbox42DREjtOpPaVpQ2CaKlMC0wEOW6Ixb98oVCagr9dRR/BRbIaPl
	K/lb1IRzMjRLEPNHLPQSjcHtJQ1m20e4/ueYZYoaNXNdTsNxeu1Gejx5wqTYw3/Q
	RpyIxEQzLw3Ffvb7AgeIffzCQVwtg6Ehi2jf9DErhilCuB9EAgUUQolo0Ybod/MK
	AAKTvyOsypVX9Hsl7BV73A==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1773327814; x=
	1773335014; bh=SaJoBOWdSuPgCxv7hYpeAKeVFQyklTNNXObk3qvPfvI=; b=o
	81mzw52m7Y8g0esA44ovBldf2w1mCxrd2Nk9Hq8Q6NGnMoMh5sV1H75k6hYOWrkn
	/IqenwKMsv4+S+qDpNTCEa08jDAdQW4w94TEalRfExX+/5d9PfHjY+TEoW+X2+FE
	nFWMlydaHFMouUdZ/ynE6XSlGki1Iwh7MbfViMcd7rfUxiDrbaymgAmqcCF2/f1F
	cAQXtApjwSKqnLbWj14/DUBi6KTSwyGikFO7OdhTu2t8k4XPTUo85uY97bxS6W+o
	Sai+Jorj6mgUE1c18wQdKIG3yLYOGQ4rF1wH3nc5mWaOz/5kRWpuG+ckYl2Q0kTR
	2GoP9XsLVT3rcDlxDQxYw==
X-ME-Sender: <xms:xdWyaZDkEMiQgozqvnBiLyFjtP28g1ahKIBoyZrE_DaQA6uTpqgKTA>
    <xme:xdWyaSWF2czmKEqMg2Cvo9TuyFgPMGQGQ8na5IFTOatpC2gB6mVkngxTfEJgl3h66
    xHSsQTi-DP2fTzR5tNK-koMttWfQPwS9rU9OAGV2evxTVEPYx7rE-NE>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgddvkeejtdelucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhepofggfffhvfevkfgjfhfutgfgsehtjeertdertddtnecuhfhrohhmpedftehrnhgu
    uceuvghrghhmrghnnhdfuceorghrnhgusegrrhhnuggsrdguvgeqnecuggftrfgrthhtvg
    hrnhepfeeuudfgtdfhfeejjeetfeeutddufffgheejjeekudelkeekvddvvefftdejjefg
    necuffhomhgrihhnpehtvgigthdrshgvtghurhhithihnecuvehluhhsthgvrhfuihiivg
    eptdenucfrrghrrghmpehmrghilhhfrhhomheprghrnhgusegrrhhnuggsrdguvgdpnhgs
    pghrtghpthhtohepvdegpdhmohguvgepshhmthhpohhuthdprhgtphhtthhopehmphgvse
    gvlhhlvghrmhgrnhdrihgurdgruhdprhgtphhtthhopegumhhithhrhidrkhgrshgrthhk
    ihhnsehgmhgrihhlrdgtohhmpdhrtghpthhtohepnhhpihhgghhinhesghhmrghilhdrtg
    homhdprhgtphhtthhopehsvghrghgvsehhrghllhihnhdrtghomhdprhgtphhtthhopehr
    ohgsvghrthhordhsrghsshhusehhuhgrfigvihdrtghomhdprhgtphhtthhopegthhhlvg
    hrohihsehkvghrnhgvlhdrohhrghdprhgtphhtthhopehnrghthhgrnheskhgvrhhnvghl
    rdhorhhgpdhrtghpthhtoheprghgohhruggvvghvsehlihhnuhigrdhisghmrdgtohhmpd
    hrtghpthhtohepsghorhhnthhrrggvghgvrheslhhinhhugidrihgsmhdrtghomh
X-ME-Proxy: <xmx:xdWyaRetzDGkS5SKI9bnsPzbkpuMdRANOtnlcfTJPNlcWisTF1b1rQ>
    <xmx:xdWyadUGzj6XKM0U8A8TXpxoxcXoRD1syeMM2bNSJaTyZXuR_9okgQ>
    <xmx:xdWyaVGeL5I89cDQK5OzddGLqJwI522nV9L0TkeDyZinXQQiEKbXQw>
    <xmx:xdWyafdE08ACWNnAG8Xfy_DAQnVumhTLT3b6G07k1mGbHRJic4s2OQ>
    <xmx:xtWyaSNd2Rb7zlX_iGsR_SmDs79ks89ndHprjg7QyEwUf6Qyb8gfZZoH>
Feedback-ID: i56a14606:Fastmail
Received: by mailuser.phl.internal (Postfix, from userid 501)
	id A99AC700065; Thu, 12 Mar 2026 11:03:32 -0400 (EDT)
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
X-ThreadId: AHq5N6LSCfHR
Date: Thu, 12 Mar 2026 16:03:12 +0100
From: "Arnd Bergmann" <arnd@arndb.de>
To: "Nathan Chancellor" <nathan@kernel.org>,
 "Mimi Zohar" <zohar@linux.ibm.com>,
 "Roberto Sassu" <roberto.sassu@huawei.com>,
 "Dmitry Kasatkin" <dmitry.kasatkin@gmail.com>,
 "Eric Snowberg" <eric.snowberg@oracle.com>
Cc: "Madhavan Srinivasan" <maddy@linux.ibm.com>,
 "Michael Ellerman" <mpe@ellerman.id.au>,
 "Nicholas Piggin" <npiggin@gmail.com>,
 "Christophe Leroy" <chleroy@kernel.org>,
 "Heiko Carstens" <hca@linux.ibm.com>, "Vasily Gorbik" <gor@linux.ibm.com>,
 "Alexander Gordeev" <agordeev@linux.ibm.com>,
 "Christian Borntraeger" <borntraeger@linux.ibm.com>,
 "Sven Schnelle" <svens@linux.ibm.com>, "Paul Moore" <paul@paul-moore.com>,
 "James Morris" <jmorris@namei.org>, "Serge E. Hallyn" <serge@hallyn.com>,
 "Coiby Xu" <coxu@redhat.com>, linux-kernel@vger.kernel.org,
 linuxppc-dev@lists.ozlabs.org, linux-s390@vger.kernel.org,
 linux-integrity@vger.kernel.org, linux-security-module@vger.kernel.org,
 llvm@lists.linux.dev
Message-Id: <d2089740-16d8-4ca4-a61c-8c381f8e30a0@app.fastmail.com>
In-Reply-To: 
 <20260309-integrity-drop-weak-arch-get-secureboot-v1-1-6460d5c4bb89@kernel.org>
References: 
 <20260309-integrity-drop-weak-arch-get-secureboot-v1-1-6460d5c4bb89@kernel.org>
Subject: Re: [PATCH] integrity: Eliminate weak definition of arch_get_secureboot()
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

On Mon, Mar 9, 2026, at 21:37, Nathan Chancellor wrote:
> security/integrity/secure_boot.c contains a single __weak function,
> which breaks recordmcount when building with clang:
>
>   $ make -skj"$(nproc)" ARCH=powerpc LLVM=1 ppc64_defconfig 
> security/integrity/secure_boot.o
>   Cannot find symbol for section 2: .text.
>   security/integrity/secure_boot.o: failed
>
> Introduce a Kconfig symbol, CONFIG_HAVE_ARCH_GET_SECUREBOOT, to indicate
> that an architecture provides a definition of arch_get_secureboot().
> Provide a static inline stub when this symbol is not defined to achieve
> the same effect as the __weak function, allowing secure_boot.c to be
> removed altogether. Move the s390 definition of arch_get_secureboot()
> out of the CONFIG_KEXEC_FILE block to ensure it is always available, as
> it does not actually depend on KEXEC_FILE.
>
> Fixes: 31a6a07eefeb ("integrity: Make arch_ima_get_secureboot integrity-wide")
> Signed-off-by: Nathan Chancellor <nathan@kernel.org>

Acked-by: Arnd Bergmann <arnd@arndb.de>

