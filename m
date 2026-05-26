Return-Path: <linuxppc-dev+bounces-21516-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3A64BCD5BC8
	for <linuxppc-dev@archiver.kernel.org>; Tue, 26 May 2026 12:34:45 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4gPsdb53N3z2yFK;
	Tue, 26 May 2026 22:34:43 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2a01:4f9:c010:3052::1"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1779798883;
	cv=none; b=Tsq3oIHOci2VdpHK18EK0guy2IlyJHsxJ606SndGe7xi/YRrQNIkyBR2UQC/yPWSQogMZgBdBckWkOxSlIdf9rjl/u3bTCdWUvA2YgvAaXpNHDkaopHHljrpeN34xRN+bYFDGerdRJz/W02osSi4Zk7kXq+KKuI1HFaQcloJfBRLnkmDwUGIu2nE4T3sDv73LySlLCwRq1cVsXqPTZMCTXXmuYElLSOJ9ZSWTHkJ2qZb1ABqKQew8iHVcy9I7wX8Yf4yBKs9fQlbPrRn3wosXedTYl3r0zSGFMimI9Aa8QHoMS/pGlSg4/ZY31FjwUFLLC9zXrALSTmJ+ImIeK22Zg==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1779798883; c=relaxed/relaxed;
	bh=DumjHkMnQiUKEXczcFzbHTJ12Og3qEh2uESbAgSH9Z0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=jIscoMbz54ldEih4L+KSA+Bgo394salx8SvuJZzutuOhIwpsf+hb4UGJcpzCLVAg+ecgt7edLnWvscBGNxOCSTiY01YBrp/JVXsMpF4ZiUaHwGPjrW0DDyZgTw/guqOoTXTmnnr17hNT139oAvDzVO+2P40aI6NaCxnVTiYnrTGj2EjKFGnuRjDQRWxWaET6MpI3p4M/0LXVGiMN8M689ej+jAApN3KWKG7iN0QnMSsE/2nR0w2TdZmRsSOCFQ2cNKvKqByF7OI4/y/UJGqs3dSJt7AvvXZQVR3e5a9BQGZ9FsyGcbOWeu8XMdi3Q4LoAQLtPw7ulooLVDPiVaZstQ==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=archlinux.org; dkim=pass (4096-bit key; unprotected) header.d=archlinux.org header.i=@archlinux.org header.a=rsa-sha256 header.s=dkim-rsa header.b=0PaXCVkX; dkim=pass header.d=archlinux.org header.i=@archlinux.org header.a=ed25519-sha256 header.s=dkim-ed25519 header.b=qAvsEodf; dkim-atps=neutral; spf=pass (client-ip=2a01:4f9:c010:3052::1; helo=mail.archlinux.org; envelope-from=kpcyrd@archlinux.org; receiver=lists.ozlabs.org) smtp.mailfrom=archlinux.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=archlinux.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (4096-bit key; unprotected) header.d=archlinux.org header.i=@archlinux.org header.a=rsa-sha256 header.s=dkim-rsa header.b=0PaXCVkX;
	dkim=pass header.d=archlinux.org header.i=@archlinux.org header.a=ed25519-sha256 header.s=dkim-ed25519 header.b=qAvsEodf;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=archlinux.org (client-ip=2a01:4f9:c010:3052::1; helo=mail.archlinux.org; envelope-from=kpcyrd@archlinux.org; receiver=lists.ozlabs.org)
X-Greylist: delayed 410 seconds by postgrey-1.37 at boromir; Tue, 26 May 2026 22:34:40 AEST
Received: from mail.archlinux.org (mail.archlinux.org [IPv6:2a01:4f9:c010:3052::1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4gPsdX0PVyz2xLs
	for <linuxppc-dev@lists.ozlabs.org>; Tue, 26 May 2026 22:34:39 +1000 (AEST)
Message-ID: <2d93a9e4-0c36-4bc7-8e94-b15f69ebda79@archlinux.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=archlinux.org;
	s=dkim-rsa; t=1779798460;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=DumjHkMnQiUKEXczcFzbHTJ12Og3qEh2uESbAgSH9Z0=;
	b=0PaXCVkXBjwxgV57Gtk9GND9h+M3olt9dDZsAZSMh69khuwz+7omoquMv7bxY+X2NwBvDs
	7cJghWP+kfKXxa/Mzj4ItNhRylLxtHEbXT2U/CdXfxlLvJjJ5rkSidgc2aBrQrTiI+CPaf
	ofc7Q62sZXcpwYR2fUFCbVV0KYA5RBkUnwqkS7dvPSc8p+xrEimxO3yvUJhT2LR8N394lG
	zKL5TDaB8eCxpGZRhxbfjUn9RFNKl2xluA2p7u5kkai+avEVgv9hwAOtKMW2EVgYqK2xAn
	EZYIc0WKVZAH1Nb4ZDiz1NIO/snRu/iHOKTOeHm8VeRYVTieMy8yWHVg8nfo1l/UbnU8Tv
	k5Yk3bdm2ZtFa0+WU70NGuYxJOHWvVeBaFwICiatUOh8gM6R/WS3IFlU9YbXwjVzymwuFc
	XKuulQ5BeoNzGUlr/QrMDgw1cdIvgtAwKofD4IsvIOGsRR1yNR3JjzQoMvKvrQPONqF6JZ
	OMMNLxAhP1LGiCUgH2GoiCYXngwwZmE2ZcjLiIEAmlhKl2r0JyV2gMJn4Uke4zTOViHDJQ
	/gJXPKLMTm5lh6Zjv6J183nbfZ/UIz4eehTUQeqX6uRy6jBru/K/rs1ICZHdgd/GSKMS+z
	nP5SILf6vZKcsnA0+D/43BN50nXByYlhjDbPB2kBPA+oekNoiga84=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=archlinux.org;
	s=dkim-ed25519; t=1779798460;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=DumjHkMnQiUKEXczcFzbHTJ12Og3qEh2uESbAgSH9Z0=;
	b=qAvsEodfYN9Au3PfLWPaXQEfyjbOcwD3RqWnSlsvTSJQ3NP8ZX9wWEW0wqValvrgMDgl0u
	ST8XcV+dvsfuSMCQ==
Authentication-Results: mail.archlinux.org;
	auth=pass smtp.auth=kpcyrd smtp.mailfrom=kpcyrd@archlinux.org
Date: Tue, 26 May 2026 14:27:36 +0200
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
Subject: Re: [PATCH v5 07/14] module: Make module authentication usable
 without MODULE_SIG
To: =?UTF-8?Q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>,
 Petr Pavlu <petr.pavlu@suse.com>
Cc: Alexei Starovoitov <ast@kernel.org>,
 Daniel Borkmann <daniel@iogearbox.net>, Andrii Nakryiko <andrii@kernel.org>,
 Eduard Zingerman <eddyz87@gmail.com>,
 Kumar Kartikeya Dwivedi <memxor@gmail.com>,
 Nathan Chancellor <nathan@kernel.org>, Nicolas Schier <nsc@kernel.org>,
 Arnd Bergmann <arnd@arndb.de>, Luis Chamberlain <mcgrof@kernel.org>,
 Sami Tolvanen <samitolvanen@google.com>, Daniel Gomez
 <da.gomez@samsung.com>, Paul Moore <paul@paul-moore.com>,
 James Morris <jmorris@namei.org>, "Serge E. Hallyn" <serge@hallyn.com>,
 Jonathan Corbet <corbet@lwn.net>, Madhavan Srinivasan <maddy@linux.ibm.com>,
 Michael Ellerman <mpe@ellerman.id.au>, Nicholas Piggin <npiggin@gmail.com>,
 Naveen N Rao <naveen@kernel.org>, Mimi Zohar <zohar@linux.ibm.com>,
 Roberto Sassu <roberto.sassu@huawei.com>,
 Dmitry Kasatkin <dmitry.kasatkin@gmail.com>,
 Eric Snowberg <eric.snowberg@oracle.com>,
 Nicolas Schier <nicolas.schier@linux.dev>, Daniel Gomez
 <da.gomez@kernel.org>, Aaron Tomlin <atomlin@atomlin.com>,
 "Christophe Leroy (CS GROUP)" <chleroy@kernel.org>,
 Nicolas Bouchinet <nicolas.bouchinet@oss.cyber.gouv.fr>,
 Xiu Jianfeng <xiujianfeng@huawei.com>,
 Martin KaFai Lau <martin.lau@linux.dev>, Song Liu <song@kernel.org>,
 Yonghong Song <yonghong.song@linux.dev>, Jiri Olsa <jolsa@kernel.org>,
 bpf@vger.kernel.org, =?UTF-8?Q?Fabian_Gr=C3=BCnbichler?=
 <f.gruenbichler@proxmox.com>, Arnout Engelen <arnout@bzzt.net>,
 Mattia Rizzolo <mattia@mapreri.org>, Christian Heusel <christian@heusel.eu>,
 =?UTF-8?Q?C=C3=A2ju_Mihai-Drosi?= <mcaju95@gmail.com>,
 Eric Biggers <ebiggers@kernel.org>,
 Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
 linux-kbuild@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-arch@vger.kernel.org, linux-modules@vger.kernel.org,
 linux-security-module@vger.kernel.org, linux-doc@vger.kernel.org,
 linuxppc-dev@lists.ozlabs.org, linux-integrity@vger.kernel.org,
 debian-kernel@lists.debian.org,
 Holger Levsen <holger@reproducible-builds.org>
References: <20260505-module-hashes-v5-0-e174a5a49fce@weissschuh.net>
 <20260505-module-hashes-v5-7-e174a5a49fce@weissschuh.net>
 <0a0736a4-2cdd-49f2-9062-e2f18d769fc0@suse.com>
 <4ee3c775-1fbf-45e1-8b77-5f9034f45125@t-8ch.de>
Content-Language: de-DE, en-US
From: kpcyrd <kpcyrd@archlinux.org>
In-Reply-To: <4ee3c775-1fbf-45e1-8b77-5f9034f45125@t-8ch.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 5/26/26 1:38 PM, Thomas Weißschuh wrote:
> On 2026-05-26 12:53:22+0200, Petr Pavlu wrote:
>> Should MODULE_SIG_FORCE be renamed to MODULE_AUTH_FORCE, along with
>> renaming the sig_enforce functionality in kernel/module/auth.c to
>> auth_enforce?
> 
> Given that it is a user-visible symbol we'll need to be a bit careful
> not to break existing configurations.
> I'll try to use the new "transitional" kconfig attribute.
A slightly softer worded alternative (yet semantically equivalent) name could be 
MODULE_AUTH_REQUIRE. No strong opinion though, I think MODULE_AUTH_* does make 
sense.

I initially shared the concern about renaming well established config options, 
but the transitional feature does seem to be a good fit for this.

Sincerely,
kpcyrd

