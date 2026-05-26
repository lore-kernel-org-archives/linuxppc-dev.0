Return-Path: <linuxppc-dev+bounces-21511-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3D565CD5BB1
	for <linuxppc-dev@archiver.kernel.org>; Tue, 26 May 2026 11:36:07 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4gPrKx4rcdz2y8t;
	Tue, 26 May 2026 21:36:05 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=159.69.126.157
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1779795365;
	cv=none; b=XYliZgqIjAbNyxJ/KSJs9i291da2iQthocKXshFs7ekBIbYEs/VI4vn/96SMKfdpi9bMUQD2P3Yopf0l+CiiDb3/42RJVgu5fm9KKKDKBbeWTWzpRSbU9xalfQ/iaKzAVBJionAeKGL+YHsNANu8ntPj5fX+VVM/9bFn/qcKCTyDaQfjWhmztMQ0c8BXz0Odx7vA8F2skALlA7YyihI/IWCNCH/gG90nSjj+60lFLtcj4v1iE3bIXhnyMIH08Nd97TcE1wjQHvWP64+XwsLOiws4bYxF6EY88tfaNMjkuvgwT4up1U+MnnxA3Uo0h+DOVeJcj2vnWqxS4JCz0vQbHw==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1779795365; c=relaxed/relaxed;
	bh=g38w4OKBOqAFsjF1AkUYkPUxwJDq+5E7jc9LO5rc008=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=QzdltKpjZeqmUp/uCWIv7vHMlVVw1vCdzK+r4xzMYqWOpkg8BoLaJF8RJdhJyfnUO0mFNBWzXtrmb3BP5RKwcM0TJKIVuQ/mq5j29iZf28JSbJLomtbM2p81MBrCnEzd06Fu2G7zeT3J2rKZAI9z9C1RcWan98u+tupOQ9ExNK4VWOPO0UaWANHI5eATwURuXl/MiPS4zMU+YJnLAMv+jzyDOIonxqsie1cljxv8rrdA1bQxgLFStSIzPipZifOCq392fW3kpXlyzMB/RJvArsaM8+PzmFjYm6rtloKN5pBdNBM8f3sEasT3k3QUTLDhy0rU9Fdp67xJ9V+onGEMxQ==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=weissschuh.net; dkim=pass (1024-bit key; unprotected) header.d=weissschuh.net header.i=@weissschuh.net header.a=rsa-sha256 header.s=mail header.b=aBKvmuQZ; dkim-atps=neutral; spf=pass (client-ip=159.69.126.157; helo=todd.t-8ch.de; envelope-from=linux@weissschuh.net; receiver=lists.ozlabs.org) smtp.mailfrom=weissschuh.net
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=weissschuh.net
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=weissschuh.net header.i=@weissschuh.net header.a=rsa-sha256 header.s=mail header.b=aBKvmuQZ;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=weissschuh.net (client-ip=159.69.126.157; helo=todd.t-8ch.de; envelope-from=linux@weissschuh.net; receiver=lists.ozlabs.org)
Received: from todd.t-8ch.de (todd.t-8ch.de [159.69.126.157])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4gPrKt6ckQz2xjQ
	for <linuxppc-dev@lists.ozlabs.org>; Tue, 26 May 2026 21:36:01 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=weissschuh.net;
	s=mail; t=1779795351;
	bh=HO2dMnPwk7LD1hzmaJr/Eo9RHeir7zm5koQqCs1AjVo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=aBKvmuQZTp6ZKtR7ynKixoXE7f2WMAle0qcJl9B/WSVwC3AiAFcf6xmu8VQ93nDVm
	 06ZJKxHeEK5WnQDXtpIecpLL231TRGxoWz8jum8/5wkSJPQPszeMFItOggbcmV30p5
	 izm/ufOZTR+xqoMmUXPxmtOuxymwa4WTfcoECq2I=
Date: Tue, 26 May 2026 13:35:51 +0200
From: Thomas =?utf-8?Q?Wei=C3=9Fschuh?= <linux@weissschuh.net>
To: Petr Pavlu <petr.pavlu@suse.com>
Cc: Alexei Starovoitov <ast@kernel.org>, 
	Daniel Borkmann <daniel@iogearbox.net>, Andrii Nakryiko <andrii@kernel.org>, 
	Eduard Zingerman <eddyz87@gmail.com>, Kumar Kartikeya Dwivedi <memxor@gmail.com>, 
	Nathan Chancellor <nathan@kernel.org>, Nicolas Schier <nsc@kernel.org>, Arnd Bergmann <arnd@arndb.de>, 
	Luis Chamberlain <mcgrof@kernel.org>, Sami Tolvanen <samitolvanen@google.com>, 
	Daniel Gomez <da.gomez@samsung.com>, Paul Moore <paul@paul-moore.com>, 
	James Morris <jmorris@namei.org>, "Serge E. Hallyn" <serge@hallyn.com>, 
	Jonathan Corbet <corbet@lwn.net>, Madhavan Srinivasan <maddy@linux.ibm.com>, 
	Michael Ellerman <mpe@ellerman.id.au>, Nicholas Piggin <npiggin@gmail.com>, 
	Naveen N Rao <naveen@kernel.org>, Mimi Zohar <zohar@linux.ibm.com>, 
	Roberto Sassu <roberto.sassu@huawei.com>, Dmitry Kasatkin <dmitry.kasatkin@gmail.com>, 
	Eric Snowberg <eric.snowberg@oracle.com>, Nicolas Schier <nicolas.schier@linux.dev>, 
	Daniel Gomez <da.gomez@kernel.org>, Aaron Tomlin <atomlin@atomlin.com>, 
	"Christophe Leroy (CS GROUP)" <chleroy@kernel.org>, Nicolas Bouchinet <nicolas.bouchinet@oss.cyber.gouv.fr>, 
	Xiu Jianfeng <xiujianfeng@huawei.com>, Martin KaFai Lau <martin.lau@linux.dev>, 
	Song Liu <song@kernel.org>, Yonghong Song <yonghong.song@linux.dev>, 
	Jiri Olsa <jolsa@kernel.org>, bpf@vger.kernel.org, 
	Fabian =?utf-8?Q?Gr=C3=BCnbichler?= <f.gruenbichler@proxmox.com>, Arnout Engelen <arnout@bzzt.net>, 
	Mattia Rizzolo <mattia@mapreri.org>, kpcyrd <kpcyrd@archlinux.org>, 
	Christian Heusel <christian@heusel.eu>, =?utf-8?B?Q8OianU=?= Mihai-Drosi <mcaju95@gmail.com>, 
	Eric Biggers <ebiggers@kernel.org>, Sebastian Andrzej Siewior <bigeasy@linutronix.de>, 
	linux-kbuild@vger.kernel.org, linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org, 
	linux-modules@vger.kernel.org, linux-security-module@vger.kernel.org, linux-doc@vger.kernel.org, 
	linuxppc-dev@lists.ozlabs.org, linux-integrity@vger.kernel.org, debian-kernel@lists.debian.org
Subject: Re: [PATCH v5 06/14] module: Switch load_info::len to size_t
Message-ID: <a1be99b5-997c-44d7-9516-5a53238034b7@t-8ch.de>
References: <20260505-module-hashes-v5-0-e174a5a49fce@weissschuh.net>
 <20260505-module-hashes-v5-6-e174a5a49fce@weissschuh.net>
 <8de0e6ad-987a-4729-bbd0-8399968dbb48@suse.com>
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
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <8de0e6ad-987a-4729-bbd0-8399968dbb48@suse.com>

On 2026-05-26 11:47:09+0200, Petr Pavlu wrote:
> On 5/5/26 11:05 AM, Thomas Weißschuh wrote:
> > Switching the types will make some later changes cleaner.
> 
> Since the updated version drops the patch "module: Deduplicate signature
> extraction", I believe this change is no longer necessary.

Ack.

(...)

Thomas

