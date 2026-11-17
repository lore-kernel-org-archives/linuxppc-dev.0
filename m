Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EDF29606A89C
	for <linuxppc-dev@archiver.kernel.org>; Tue, 17 Nov 2026 17:42:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=S80DLh/l
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4jTX9X1DbBz2xl0;
	Wed, 18 Nov 2026 04:42:08 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=pass smtp.remote-ip="2a00:1450:4864:20::235" arc.chain=google.com
ARC-Seal: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1794937328;
	cv=pass; b=CA/wZXoQeYYk4TUNZVDqpWtCdaXVXubN2vuSSq0WRJBH7nht9VyNM2B/Wrc48R/Rn2NJkJgFnsqA803CeIBn827Xo2ZXOE9Zo46PPXnYvhACvC1SHgh2v2hsVXroYHI5IYbBjd6E7Hd92P71HGEwhSDmAQF8x9sDa1T9jvYJVlq8BxM7cr38+V/Nbovda7SlownAao/DK8bgB3CeL6E4z2YdjIviHyl8ptD72A2XitP17iK4OiVBJp7tqk9vvNyRpVA3W7eyJ/8UmViG3Mz5IPyd6r0f3auyHFgkPT35o/g5+3ebPCkY7PZ/zwc2DgJ2egv8+wDGw0ZnEesatbaniQ==
ARC-Message-Signature: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1794937328; c=relaxed/relaxed;
	bh=w/O1llxQjJQ6flYIT42pXL7et85J3uKpR2Je+X6X8uA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=exoYlzT8BOJP85hFGJ6cTaFfqOq3myu7/+roDoViqC70447IVhmiHXd6aM6MSt2beIQwEHfKBiukZyM9GxIIerisg11r1wXuPA0yHtymsftKq4ZE8fy6oek9neUuNW5AAWL1iCaBa+/q6ms7dhDyQnR32KSByRkv0MKxVrIkvibqOtytdI9H8BxaUpLUa9GS40KtKBJylNz86oizBeDayDzWyddJ9E1p9RtEPP1z5AcX5AgewcAnuvI5B9fWQ02iXr77UudN0PidOr2DrFPGgmqTHeqyj7M+4Q7FfT6KWEXQZQQnOanUfHZdX+YNCJ5CPMBiS8K2mp0K9B++3UGXdg==
ARC-Authentication-Results: i=2; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com; dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=S80DLh/l; dkim-atps=neutral; spf=pass (client-ip=2a00:1450:4864:20::235; helo=mail-lj1-x235.google.com; envelope-from=mattst88@gmail.com; receiver=lists.ozlabs.org) smtp.mailfrom=gmail.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=S80DLh/l;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=gmail.com (client-ip=2a00:1450:4864:20::235; helo=mail-lj1-x235.google.com; envelope-from=mattst88@gmail.com; receiver=lists.ozlabs.org)
Received: from mail-lj1-x235.google.com (mail-lj1-x235.google.com [IPv6:2a00:1450:4864:20::235])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4jTX9W04CBz2xL4
	for <linuxppc-dev@lists.ozlabs.org>; Wed, 18 Nov 2026 04:42:06 +1100 (AEDT)
Received: by mail-lj1-x235.google.com with SMTP id 38308e7fff4ca-3ae417eb235so1189071fa.3
        for <linuxppc-dev@lists.ozlabs.org>; Tue, 17 Nov 2026 09:42:06 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1794937322; cv=none;
        d=google.com; s=arc-20260327;
        b=iMsaXkSE7ZV+oYHKdZ5GssCTb22F3L05TDZH/9by7Yd2gEdubO9VHO8GCjc2iCaXlE
         VohzxOBKdPW7bPVhpcFFNv4MS9RMsfYqTLM6EcIInhixRW1ImF1pOK5ZCKWPvviTP2TI
         tVqlsr7WoXfcmpjCWhL2MDFG+el/52O+4lrUvz3B9rhKdFlFuP9U1dPLYeADXVywoWyN
         xDuVM/67VI2FW7uPX3cFJHBZCOIOVCWKnDJHfq+jmwcMA0FLz97k93GtrZEFUpDkFsbG
         O+Lh85ILFbOEk1FmvCU85TMfoP6wrz2fom6Ibv7bTrwU+EYchs8s/nIriLbh2fyfoSdY
         LtFA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=w/O1llxQjJQ6flYIT42pXL7et85J3uKpR2Je+X6X8uA=;
        fh=xe3IuvtX7Ly7OsQZgLSZMSZfQ/GJTw93SJGBhqjGGZc=;
        b=Wah8UXkgPvkWPCaoNAKFlp8nbrdneKngQd9fm4gWkxPg4pn3CWrdOEAgw1kcTm1trC
         flPlAkrDya3Epg9rfjfSbxAnGep4IXBwVmauIMAg9nNk6B9mZwmQsUrP9a82Cd4F3/t5
         w7EKAhHYDyXc3t/rrdI8T05NP/JeHKnQHc4E+zI4x4olml/6jvR8oV5jqEXMw+f3TJcF
         9sUe6+3yJBjD9Cf8eEa9+4NLwOS8th+MGAofhRRd7HkIdFXvykKP+Um9f7WM72aKYoCu
         Q7q0YyfP2safCAjrUE8QWestx/Amf9tPIJcT7MZnMnno66LmdfG0LiNV7H92ivEte8i7
         mTrg==;
        darn=lists.ozlabs.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794937322; x=1795542122; darn=lists.ozlabs.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=w/O1llxQjJQ6flYIT42pXL7et85J3uKpR2Je+X6X8uA=;
        b=S80DLh/leZQrXGtrlbCJbvyF3Dt8q7LYoOFqANhTo8Ih3gtHeZuy5kaRfOz2BBwtx8
         G6rX7gBZmNk1w2XC85gwOfvujN49me1wM7/4KdRZPUWltgE23swc6B1lPj7X8WbPT0JL
         K6vNizMyxvP6IBkniGOgQ1Nb29AihaZSEeP4EmnbFPRHaHFsTH1PJ+JVRFvyNIoHjv/6
         7n+h7uO41Q443esKvFjjXa1wDcqoBP5Wl2WimHnD+w2IRqOiHbVQ9MJYUJrgnM1VvVop
         Nv9CkB1BIky0BaCC93VwvBAlkf8SZqK6/NwlNeJmXejDIaW7XzUt3btdg4t0ff1k1lEf
         ODDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794937322; x=1795542122;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=w/O1llxQjJQ6flYIT42pXL7et85J3uKpR2Je+X6X8uA=;
        b=qAE7fogd7gM0pmuvDMX1BDVmOxJOyEF15kXnMeuCwbsc23LTYwZf3To9tqRnHjLEYv
         cJz7urfHa5DNYS0f/KlUXZEhBsS8nPW6JnhttKrvwJ3MPC6IE/Nx6LbCHT9LjBRC46K3
         pI4uheHcrgi+cktTDh+8TMtbK6PSBALteXHO9rqjef8trAOcio5pTg06/c7mKsVMhClH
         oZd+t5w3btCwUUf/i1udCc1SqJ6ZUC9CY0ly+iaulvLFkyOBAthfNFRyq4b+ff85TdL8
         xRmipA/ZX/t2nRVbSFyewOEnmLvzxPOy47KUQre8YKOc+7Bb3aEWsf34qY4uEsxKSHQu
         DU3Q==
X-Forwarded-Encrypted: i=1; AL+hErEybvO2C7LLaRDBMoObEaWZ9Q76fl1tpUPRvYxIL+b5CwwnB2TMUX1uZ1XvJNnAVMekjrZ29BfsZOYEOlU=@lists.ozlabs.org
X-Gm-Message-State: APuU4Z/c9j7MxGB2VGHeLN/8uIEHytGJdQb7Pn8mdj3Toi11nXajAeoA
	8hl7aKnkAWzVRRgYoUvfaBwawu/PFwH27bIbNxmbLc+7gkCg6Fn/3qZDOv3hlGeEH6LXl6agaRA
	zWnQ1gTgCmJlJdY+lLlVa4T5rxOxSRw4=
X-Gm-Gg: AYBFou0+sm5M/2Xugerdckq2+HYer9sUT61Jl0fx1pW8dvuSq09QQFGi0dzZ7LAgo/N
	DucqrH9HaHmUjiyy83nvjkh7z0DiCkZd57dQ+x8WXmA1GPnMudzLanzGMlfB4d/4MoLlLwXZ2qM
	tc2pmpAmYT6I991NV0vf2FL07FOJYO/y3j10xkCMue55f7CuNn7c3gteCsV6XITRFFNrRa5ZfKu
	0QWQXINtv47DadCEgEEMyCnf3fi8w1mGJr9P0cZa8LvpNaCUECGMNS92tElhJZE2VNzD1hn+5w9
	pI4x6fffT0ID7UliEn4msqMID37fA6PMt7iO+MqZXa7x47Es7rmE2bv7bQXwmDhBckfII82WLeN
	2NijGjz6+08tvCXbiT57a2AYplCfimz7VZvXR4ji1BktF9am1XaOoBjz/S2UdUYOKQKX+bZFt/7
	IDFwVjmI3H7MhcLb6F+/RiQ3PGMb14D24WLrMkOsatNJoDOjdM
X-Received: by 2002:a05:651c:41cf:b0:3a7:6d4a:1c9f with SMTP id
 38308e7fff4ca-3ae2b4f54f0mr39588581fa.15.1794937321825; Tue, 17 Nov 2026
 09:42:01 -0800 (PST)
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
References: <20261109-ppc32-perf-v1-0-a6e8a55b3b48@gmail.com>
 <20261109-ppc32-perf-v1-4-a6e8a55b3b48@gmail.com> <6d067199-3077-48a2-80cc-e21352f5c837@linux.ibm.com>
In-Reply-To: <6d067199-3077-48a2-80cc-e21352f5c837@linux.ibm.com>
From: Matt Turner <mattst88@gmail.com>
Date: Tue, 17 Nov 2026 12:41:47 -0500
X-Gm-Features: AclHuK9NyOHwdZhzY_0H8BI34W0hiUQkqAtn_flXFnIyln3e7UfXyG1O1B9kp28
Message-ID: <CAEdQ38E0prYYXVMFSBeZFUjYaSAP6gej_4aTMfL=R4ANrp7y=A@mail.gmail.com>
Subject: Re: [PATCH 4/8] powerpc/perf: mpc7450: Fill in the L1 data cache events
To: Tanushree Shah <tshah@linux.ibm.com>
Cc: Madhavan Srinivasan <maddy@linux.ibm.com>, Michael Ellerman <mpe@ellerman.id.au>, 
	Nicholas Piggin <npiggin@gmail.com>, "Christophe Leroy (CS GROUP)" <chleroy@kernel.org>, 
	"Ritesh Harjani (IBM)" <ritesh.list@gmail.com>, Shrikanth Hegde <sshegde@linux.ibm.com>, 
	Paul Mackerras <paulus@ozlabs.org>, linuxppc-dev@lists.ozlabs.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_PASS,
	SPF_PASS autolearn=no autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Tue, Nov 17, 2026 at 10:36=E2=80=AFAM Tanushree Shah <tshah@linux.ibm.co=
m> wrote:
> If you have a quick load-only run for 0x21a,
> it would be nice to see the numbers, but that's not a blocker.

Sure. This is a loop of 8 lwz and a bdnz, run 10M times on the 7448,
counted user-only with perf_event_open() and one event at a time. The
store loop is the same with stw.

  event                none       load      store
  raw 0x21a               9   80000012         12
  raw 0x014               8         11   80000011
  L1-dcache-loads         9   80000012         12
  instructions     10000062   90000086   90000092

The few extra counts come from the code around the loop. I got the
same numbers on three runs.

