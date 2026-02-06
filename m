Return-Path: <linuxppc-dev+bounces-16665-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F1F8AEB28FA
	for <linuxppc-dev@archiver.kernel.org>; Fri,  6 Feb 2026 09:09:31 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4f6pF63wcTz2xqk;
	Fri, 06 Feb 2026 20:09:30 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=172.105.4.254
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1770368970;
	cv=none; b=Fx22WhUPP/S2h5js6jLy6phGLoMFH+Hwt7tVnvkmpyHaJ+1iDx39U3hyvVu+RggC/yUJ7OkMqHnPXmtqKh/VUmHRvdNHr78Iq7XsI6oCT1F7gswMx8DxNj1klyhyFcb3ZmV5EagWrimIjpAH5M5X8gaxAKOZM+hbs41H41biwp0B0Q6Sh/h++DUW0QuGEWOEf7x0wP/uizlH8pQqJyNqz95gRoJw7GfuLI7LdDhfC83VLzZMczsg/wZo6AMSpiDwZvI5OIrp8dsGddsuKY5f9mRb2Hz2VHVKZeiHR+7Dsa9a114hln2NnIvuzb9KiugAcYZTzbky/Z0Nq+2Nf+PKAQ==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1770368970; c=relaxed/relaxed;
	bh=5jEw+NL8w7SPGBQomvX8i0ogOG6XIW6Sh/ESsQ7Mrbs=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=cLUXkcz6Ch2EjyZA3hooq1xwfq1oOAnuQl6J4qyfoZyNw/wUjhXa1wWHpMf0QUKaUKKhGtuaWl3RHE0+tAiOdli03CGcFmeVNkPB5nWDD1Vsn+pB3su3bE6j84JNLGQPJLFAt8cWIbCmU04Y9arLImW28PseNScBfIULL2gMCWSasiW3tAn8hX8vALoRBHu2glFb9MDqnCfRJGcMfA/iAFlCMmhBz8+pkc2YLd6XOj3NtvfScCOXotBPpQNxieDJbgDQaPk2K/JyedwL/ysMnq1yiT1Bb41eBMgPlWr1FjIPnTkFPoSlkpb9K7FI8O0G3Rrbpohd5pSIGvtjZLTjsA==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org; dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=A7b5R4g+; dkim-atps=neutral; spf=pass (client-ip=172.105.4.254; helo=tor.source.kernel.org; envelope-from=chleroy@kernel.org; receiver=lists.ozlabs.org) smtp.mailfrom=kernel.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=A7b5R4g+;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=172.105.4.254; helo=tor.source.kernel.org; envelope-from=chleroy@kernel.org; receiver=lists.ozlabs.org)
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4f6pF50Ly1z2xWJ
	for <linuxppc-dev@lists.ozlabs.org>; Fri, 06 Feb 2026 20:09:28 +1100 (AEDT)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by tor.source.kernel.org (Postfix) with ESMTP id EE464600AD;
	Fri,  6 Feb 2026 09:09:26 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1F419C19424;
	Fri,  6 Feb 2026 09:09:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1770368966;
	bh=bvTRKg2OrjlQepO6LzKrASGvcExrTa3Qk/kDeFWK0eo=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=A7b5R4g+TJRZZXAGk3SKg4fQ3mkmVtOPSQE3PlMgcjr8O7xXRq8Jpvzam3nXZDYkv
	 +Zt/AyrCiKCKpfi7gnSR9NFYDSVjEGCpWHk4FZP+WiFnQZfUXeM7cQTX4redKYkLxE
	 SkUEzKlZAB7RCls0Cup2EA5fL2Rkiau4oR11peZpB8UrzPue5/OwWqCIcfEKih2UTc
	 SHqqzHb5+r3Y/36OucldM9ggEkUtRbQnUpiSNaWQ/3WeggSRDyg4WZ0dxyoZZH2R8r
	 VeC3+V5ktY4F36b70LLeQRYzciPk4iK6jmsb98kDxftqNPhRqhC5jD3XrxSF+cmqrO
	 r0A1HSU1NbsQA==
Message-ID: <ffdafd21-fe7a-44a2-86ec-0e0c2ad4238c@kernel.org>
Date: Fri, 6 Feb 2026 10:09:12 +0100
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
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 05/17] module: Switch load_info::len to size_t
To: =?UTF-8?Q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>,
 Nathan Chancellor <nathan@kernel.org>, Arnd Bergmann <arnd@arndb.de>,
 Luis Chamberlain <mcgrof@kernel.org>, Petr Pavlu <petr.pavlu@suse.com>,
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
 Nicolas Schier <nsc@kernel.org>,
 Nicolas Bouchinet <nicolas.bouchinet@oss.cyber.gouv.fr>,
 Xiu Jianfeng <xiujianfeng@huawei.com>
Cc: =?UTF-8?Q?Fabian_Gr=C3=BCnbichler?= <f.gruenbichler@proxmox.com>,
 Arnout Engelen <arnout@bzzt.net>, Mattia Rizzolo <mattia@mapreri.org>,
 kpcyrd <kpcyrd@archlinux.org>, Christian Heusel <christian@heusel.eu>,
 =?UTF-8?Q?C=C3=A2ju_Mihai-Drosi?= <mcaju95@gmail.com>,
 Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
 linux-kbuild@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-arch@vger.kernel.org, linux-modules@vger.kernel.org,
 linux-security-module@vger.kernel.org, linux-doc@vger.kernel.org,
 linuxppc-dev@lists.ozlabs.org, linux-integrity@vger.kernel.org
References: <20260113-module-hashes-v4-0-0b932db9b56b@weissschuh.net>
 <20260113-module-hashes-v4-5-0b932db9b56b@weissschuh.net>
Content-Language: fr-FR
From: "Christophe Leroy (CS GROUP)" <chleroy@kernel.org>
In-Reply-To: <20260113-module-hashes-v4-5-0b932db9b56b@weissschuh.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



Le 13/01/2026 à 13:28, Thomas Weißschuh a écrit :
> Switching the types will make some later changes cleaner.
> size_t is also the semantically correct type for this field.
> 
> As both 'size_t' and 'unsigned int' are always the same size, this
> should be risk-free.

Are you sure ?

Some architectures have size_t as 'unsigned int', some have 'unsigned 
long', some have 'unsigned long long'

https://elixir.bootlin.com/linux/v6.19-rc5/source/arch/s390/include/uapi/asm/posix_types.h#L16
https://elixir.bootlin.com/linux/v6.19-rc5/source/arch/sparc/include/uapi/asm/posix_types.h#L35
https://elixir.bootlin.com/linux/v6.19-rc5/source/arch/xtensa/include/uapi/asm/posix_types.h#L26
https://elixir.bootlin.com/linux/v6.19-rc5/source/include/uapi/asm-generic/posix_types.h#L68
https://elixir.bootlin.com/linux/v6.19-rc5/source/include/uapi/asm-generic/posix_types.h#L72
https://elixir.bootlin.com/linux/v6.19-rc5/source/arch/sparc/include/uapi/asm/posix_types.h#L23
https://elixir.bootlin.com/linux/v6.19-rc5/source/arch/x86/include/uapi/asm/posix_types_x32.h#L15
https://elixir.bootlin.com/linux/v6.19-rc5/source/include/uapi/asm-generic/posix_types.h#L16

Christophe

