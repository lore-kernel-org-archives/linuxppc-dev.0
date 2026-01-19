Return-Path: <linuxppc-dev+bounces-16008-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DD79CD29C58
	for <linuxppc-dev@archiver.kernel.org>; Mon, 19 Jan 2026 18:23:09 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4dvzND0wKsz2xJ6;
	Tue, 20 Jan 2026 05:23:08 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2600:3c0a:e001:78e:0:1991:8:25"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1768828837;
	cv=none; b=ZPUFXZZqCu8502JXp3u+euKeOrjU3mFu+YN/DvSjffgsVI9gFKsHIudJR3i6RmweQPzneqzunYxMqbk2jyV/M3a8n7fZFvBQySl0S/eesVeCCt+mdHfzSrPYWOz8zu0at1E5MuVvkk9LcrIdD6Zlz/blJMnYu+ObmEoFqxnw4tAp6pzyCFgZonB9UofZUph2m5eUJQpTSw+oId+5+h4ln46rIEDkACUpk10UyYxYoGPzjUjDG+UqrsfVJ3FzUUNKHIdwkDJO0wmmHobMnkAawAKiaB97kNJzvYot5izuU5iN56xM8c6Q9IWy0BuHE5YPeIi78ZZfX23VOP+DjJwThw==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1768828837; c=relaxed/relaxed;
	bh=Jljzdrq4r/rY5hYR5tbzegDR66TZ8LKmWCEKANj2q0M=;
	h=Mime-Version:Content-Type:Date:Message-Id:To:From:Subject:Cc:
	 References:In-Reply-To; b=SUUeUgoKeoGOjUxJFobo9dlvZF9HChg7bHBCxdSnz382WfmHbAVINhJ3YNq0ECsvpJdq/UQYHaDnqt1Y39gUX/rN0gPF9gD3B7xRfugReYNjqj0MJv+AuH22msHvdmOh2xViVjxTrSyK3wqw634hPf+a629PTVkqV1RyVdRUPbDwPl0TNXcZ/OcgINjbe5w23tDZ0BIXZKtn3hGA3eakmVlf0qrOVnfUFHGz3vdsS9KHRUkU7XEhcMdstrnl2qGW6204H0IPJzRpg/HRN94+FKQqPOLyEpxw2zPc6vlnmzBC3HUwkse7PU+trCJJ3b3XWTiRorO3cmtPXClT0+GuxA==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org; dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=LYqOMNv6; dkim-atps=neutral; spf=pass (client-ip=2600:3c0a:e001:78e:0:1991:8:25; helo=sea.source.kernel.org; envelope-from=dakr@kernel.org; receiver=lists.ozlabs.org) smtp.mailfrom=kernel.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=LYqOMNv6;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=2600:3c0a:e001:78e:0:1991:8:25; helo=sea.source.kernel.org; envelope-from=dakr@kernel.org; receiver=lists.ozlabs.org)
X-Greylist: delayed 6844 seconds by postgrey-1.37 at boromir; Tue, 20 Jan 2026 00:20:36 AEDT
Received: from sea.source.kernel.org (sea.source.kernel.org [IPv6:2600:3c0a:e001:78e:0:1991:8:25])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4dvrg82gzKz3bjN
	for <linuxppc-dev@lists.ozlabs.org>; Tue, 20 Jan 2026 00:20:36 +1100 (AEDT)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by sea.source.kernel.org (Postfix) with ESMTP id 5B90043724;
	Mon, 19 Jan 2026 13:20:34 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E5023C116C6;
	Mon, 19 Jan 2026 13:20:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1768828834;
	bh=Jljzdrq4r/rY5hYR5tbzegDR66TZ8LKmWCEKANj2q0M=;
	h=Date:To:From:Subject:Cc:References:In-Reply-To:From;
	b=LYqOMNv6K//ghc3wg6xqGAnjEk9y7lgkxB77d8PfRJZ0NgwDf4IdMzIiF2CM+pZTr
	 tp+dNB2zzIvG6F85ubonr1U8Z9HLFwm2La8nG088JaBLNRCnd+oN7MYgTCL/FvpB4z
	 8ZSc4pYJvGyoRhwQsYZYC6fPhbHnH6OFx2mLiCVzliYTY0U5V/z8j4R7oviRAvL35g
	 4dRcVJIVx7nxlu7YPz2cwPbUO1vCu4+J7IpIt+Q6Q8KAqOXPB14fi0nUDP7Eu3bLYg
	 oxfXosJm8l1f6KyAoM0Ufa3ANpnn246RhC+8beVyM1R39hIWt3Ivm926qthW+w2Iz2
	 RDepxu4iYp6Qw==
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
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Mon, 19 Jan 2026 14:20:28 +0100
Message-Id: <DFSLHM2ZBRE8.1JDMK08LNYYKT@kernel.org>
To: "Bartosz Golaszewski" <brgl@kernel.org>
From: "Danilo Krummrich" <dakr@kernel.org>
Subject: Re: [PATCH 1/8] of: provide of_machine_get_compatible()
Cc: "Bartosz Golaszewski" <bartosz.golaszewski@oss.qualcomm.com>, "Rob
 Herring" <robh@kernel.org>, "Saravana Kannan" <saravanak@kernel.org>, "Greg
 Kroah-Hartman" <gregkh@linuxfoundation.org>, "Rafael J. Wysocki"
 <rafael@kernel.org>, "Christophe Leroy (CS GROUP)" <chleroy@kernel.org>,
 "Shawn Guo" <shawnguo@kernel.org>, "Sascha Hauer" <s.hauer@pengutronix.de>,
 "Pengutronix Kernel Team" <kernel@pengutronix.de>, "Fabio Estevam"
 <festevam@gmail.com>, "Geert Uytterhoeven" <geert+renesas@glider.be>,
 "Magnus Damm" <magnus.damm@gmail.com>, "Chen-Yu Tsai" <wens@kernel.org>,
 "Jernej Skrabec" <jernej.skrabec@gmail.com>, "Samuel Holland"
 <samuel@sholland.org>, <devicetree@vger.kernel.org>,
 <linux-kernel@vger.kernel.org>, <linuxppc-dev@lists.ozlabs.org>,
 <linux-arm-kernel@lists.infradead.org>, <imx@lists.linux.dev>,
 <linux-renesas-soc@vger.kernel.org>, <linux-sunxi@lists.linux.dev>
References: <20260119-soc-of-root-v1-0-32a0fa9a78b4@oss.qualcomm.com>
 <20260119-soc-of-root-v1-1-32a0fa9a78b4@oss.qualcomm.com>
 <DFSJ2AD562CP.1ZX1JO1F0Y1UU@kernel.org>
 <CAMRc=McTaTGPM6fMWb3b+S0+Gq_V-Vi7DF9JxDeOEfPAavgXaQ@mail.gmail.com>
In-Reply-To: <CAMRc=McTaTGPM6fMWb3b+S0+Gq_V-Vi7DF9JxDeOEfPAavgXaQ@mail.gmail.com>

On Mon Jan 19, 2026 at 2:00 PM CET, Bartosz Golaszewski wrote:
> How about of_machine_read_compatible()?

SGTM.

