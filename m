Return-Path: <linuxppc-dev+bounces-21005-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 800D8CD37AC
	for <linuxppc-dev@archiver.kernel.org>; Sun, 17 May 2026 10:47:24 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4gJHgt6Zvnz2xdh;
	Sun, 17 May 2026 20:47:22 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=172.234.252.31
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1779014842;
	cv=none; b=PQTABMcyrwoVuRfukTkkH5SNv1aV/fD+uIRQeLwgeKkOhHte/3lOyY4yU2qrukepK+x0SKxMHn4oTXtM/i+XDWKDnT6+ojIWL6CjSKwezwN/EiyvnJUIU/jYE2+MycZdGYRp8pxBzuAWoWug1nJ9M9Q4lzwBXiJO8eFkpc6DPFzIg3kvo4j9pTuV8gAhmZ+pNhCUDHpzTYbj35QuSioNzYZX5eB5tvsq2KWUEaR6oAnt/M82AF346tCpM5rQYC1F/gspIekt73aUbtYgCeFlnJn7aO6BOXHjDSisbHhYxVj+Q9hnVuPsMosNBiiHFtwBV+11kXy6c8530ZgGXR9AhQ==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1779014842; c=relaxed/relaxed;
	bh=x5OthVxZR8h4YrenYpMX4q6wZfMFvGhjdqdMWQqbl0s=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=nllN/LzPoPue+kTP7E08EW1PAX0WncLq4VNB4bjsX62pdolMb/6nQ+zqTNAsvmGBWX7YsvLCgG+O3H1kpApA5qaTN56cJb5+rfaAU21BaLlOEn0/Vm+uUXwsbMbmr8WXE4OvmSdRNKBjEUmr9upp/UlXieREvfPyk7voV61kYU3lhmE71sFkQR2QPDvjY5aVDIDBIMyRCqrXJqlPE86hFdw5+NDP2hsDSwwt37q2Qe6mauB39N8PszYMbdMhTYu4WShATv2VDuTt48bj9OIn+1TNgSzeft7HrW+JoEkbgOax1Uks7Z8dOAz6SGcNbIymw1b+HyBrIXQO9H+5moV5Bw==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org; dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=uhoiNK1a; dkim-atps=neutral; spf=pass (client-ip=172.234.252.31; helo=sea.source.kernel.org; envelope-from=linusw@kernel.org; receiver=lists.ozlabs.org) smtp.mailfrom=kernel.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=uhoiNK1a;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=172.234.252.31; helo=sea.source.kernel.org; envelope-from=linusw@kernel.org; receiver=lists.ozlabs.org)
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4gJHgt0B8pz2xVK
	for <linuxppc-dev@lists.ozlabs.org>; Sun, 17 May 2026 20:47:21 +1000 (AEST)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by sea.source.kernel.org (Postfix) with ESMTP id C9CDB419B7
	for <linuxppc-dev@lists.ozlabs.org>; Sun, 17 May 2026 10:47:19 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A4ED1C2BCB0
	for <linuxppc-dev@lists.ozlabs.org>; Sun, 17 May 2026 10:47:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1779014839;
	bh=x5OthVxZR8h4YrenYpMX4q6wZfMFvGhjdqdMWQqbl0s=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=uhoiNK1a/7+3F2Fkboo3WqWxenULTJtYJlyHKIs7fGWtBVwkVKG7nzcw4pIB5r4gD
	 OPimIgJsY78P3hzKBrcFcHSeQTE0h0dYzcfR6ynRlRPwefj+M21Nxym0DSr+SXIB6K
	 bjIwTKBoxHw3Q17/f83fWysh0LIgmd29c9tC6bGwA+7T7cJlVGI0bzTISpsxsZpGmY
	 5kgNyPuq6uPA1mGTjvk7Vb3uzv3AFLGuj97wxE72hQVE7r4GTKJUbqQFl2gACyaQd8
	 +lMZbb8ncQ49RMj6oUtHJEOo9+/k3T9hjXIzSoyz9kGVoF8vF2xkTJ6M3vpcol9Rkf
	 k3nd0kz9flbhQ==
Received: by mail-lf1-f51.google.com with SMTP id 2adb3069b0e04-5a8f9841616so1203364e87.0
        for <linuxppc-dev@lists.ozlabs.org>; Sun, 17 May 2026 03:47:19 -0700 (PDT)
X-Gm-Message-State: AOJu0YzxHGLREslkDTSOGLqcYl6SCYb1HxzGTdW/rU+So19tygrsAZdS
	REMRIsOXw10NubybDb1dFH3MlpYTsIpKyjPe+girRKsbKFubS0m/8r7qiroergM7hlq4z6dWmSN
	gzBIcFp3n/vD6RpVEmEbcO3CR/Ikw+2w=
X-Received: by 2002:a05:6512:3f1a:b0:5a8:97d7:8c2e with SMTP id
 2adb3069b0e04-5aa0e73225fmr3222764e87.28.1779014838393; Sun, 17 May 2026
 03:47:18 -0700 (PDT)
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
References: <20260517063754.21819-1-rosenp@gmail.com>
In-Reply-To: <20260517063754.21819-1-rosenp@gmail.com>
From: Linus Walleij <linusw@kernel.org>
Date: Sun, 17 May 2026 12:47:05 +0200
X-Gmail-Original-Message-ID: <CAD++jLnnRSbZn+1Ho9DO10uu9SeoA4xmkGGMYdQskZbs2-7UrQ@mail.gmail.com>
X-Gm-Features: AVHnY4Jj2qGp8iCCV7uyyHmWGturxuG39Lg_p7cijFMBsFdk0piuRaPK0H9-3z4
Message-ID: <CAD++jLnnRSbZn+1Ho9DO10uu9SeoA4xmkGGMYdQskZbs2-7UrQ@mail.gmail.com>
Subject: Re: [PATCHv2] powerpc/44x: Set GPIO chip parent
To: Rosen Penev <rosenp@gmail.com>
Cc: linuxppc-dev@lists.ozlabs.org, Madhavan Srinivasan <maddy@linux.ibm.com>, 
	Michael Ellerman <mpe@ellerman.id.au>, Nicholas Piggin <npiggin@gmail.com>, 
	"Christophe Leroy (CS GROUP)" <chleroy@kernel.org>, open list <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, May 17, 2026 at 8:38=E2=80=AFAM Rosen Penev <rosenp@gmail.com> wrot=
e:

> The PPC4xx GPIO driver stopped assigning an explicit parent
> to the gpio_chip when it moved away from of_mm_gpiochip_add_data().
>
> Restore that association from the platform device so OF GPIO lookup
> can match phandles to the registered gpiochip.
>
> Tested on: Cisco MX60W. No more probe deferral.
>
> Assisted-by: Codex:GPT-5.5
> Fixes: 1044dbaf2a77 ("powerpc/44x: Change GPIO driver to a proper platfor=
m driver")
> Signed-off-by: Rosen Penev <rosenp@gmail.com>

Reviewed-by: Linus Walleij <linusw@kernel.org>

Yours,
Linus Walleij

