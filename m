Return-Path: <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5CB2FC4332F
	for <linuxppc-dev@archiver.kernel.org>; Mon, 30 Oct 2023 16:56:55 +0000 (UTC)
Authentication-Results: lists.ozlabs.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=IIWebl7J;
	dkim-atps=neutral
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4SJzvV0BsGz3cWP
	for <linuxppc-dev@archiver.kernel.org>; Tue, 31 Oct 2023 03:56:54 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=IIWebl7J;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=145.40.68.75; helo=ams.source.kernel.org; envelope-from=kvalo@kernel.org; receiver=lists.ozlabs.org)
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4SJztX44srz3c82
	for <linuxppc-dev@lists.ozlabs.org>; Tue, 31 Oct 2023 03:56:04 +1100 (AEDT)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by ams.source.kernel.org (Postfix) with ESMTP id 001ABB80D84;
	Mon, 30 Oct 2023 16:56:00 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D4C1BC433C7;
	Mon, 30 Oct 2023 16:55:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1698684960;
	bh=7+7vRhXHb5QjQwut8OzZIttdLSOWtUI77jnd6XpGSc4=;
	h=From:To:Cc:Subject:References:Date:In-Reply-To:From;
	b=IIWebl7JgzJnu8OG5ttQkIo9V8/m9IvZLf/StWmZgBfxWD9jeT/YVvjLlXZfhgH5s
	 kcR75Po7P1yB1jcFGhWlpFs8RJPPacFX/rmewlstO3kP0siwx/qbB4jQOiFti4A1q9
	 mj5sFcZTYPJdkXJUR9RzanWW8/4aH1Fc89jjzSPAm5qL82K+88AKpP6KzuaKfvZF0p
	 LBDvpLeLTlGahSrdM2KKfAxUYXzDb7pveOMwWUA6aCOvlx/g0jv+JMIR1jXkjoiXF4
	 biqdLLSyukbxjK+7wnxw9qisV1bQJWTmHVyChAGrn3htbVw+xF9A9w2OD9yjg+4PBH
	 AtbosC34rrQWA==
From: Kalle Valo <kvalo@kernel.org>
To: John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>
Subject: Re: [PATCH 00/10] Remove obsolete and orphaned wifi drivers
References: <20231023131953.2876682-1-arnd@kernel.org>
	<20231030071922.233080-1-glaubitz@physik.fu-berlin.de>
Date: Mon, 30 Oct 2023 18:55:53 +0200
In-Reply-To: <20231030071922.233080-1-glaubitz@physik.fu-berlin.de> (John Paul
	Adrian Glaubitz's message of "Mon, 30 Oct 2023 08:19:22 +0100")
Message-ID: <87cywwvyli.fsf@kernel.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
MIME-Version: 1.0
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
Cc: arnd@kernel.org, alexandre.belloni@bootlin.com, quic_jjohnson@quicinc.com, arnd@arndb.de, stf_xl@wp.pl, geoff@infradead.org, gregkh@linuxfoundation.org, linux-staging@lists.linux.dev, linux-wireless@vger.kernel.org, claudiu.beznea@tuxon.dev, linux-kernel@vger.kernel.org, nicolas.ferre@microchip.com, geert@linux-m68k.org, pavel@ucw.cz, kuba@kernel.org, gregory.greenman@intel.com, johannes@sipsolutions.net, linuxppc-dev@lists.ozlabs.org, davem@davemloft.net, linux-arm-kernel@lists.infradead.org, Larry.Finger@lwfinger.net
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev" <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de> writes:

> There is some non-x86 hardware like the Amiga that still uses
> PCMCIA-style networking cards on machines like the A600 and A1200. So,
> unless these drivers are actually causing problems, I would rather not
> see them go yet.

There is a cost maintaining these drivers so I would like to see more
information in the report, at least:

* exact driver and hardware used

* last kernel version tested

* kernel log messages from a successful case

Here's a good example:

https://lore.kernel.org/linux-wireless/20231024014302.0a0b79b0@mir/

-- 
https://patchwork.kernel.org/project/linux-wireless/list/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches
