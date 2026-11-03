Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C8DA6606A332
	for <linuxppc-dev@archiver.kernel.org>; Tue,  3 Nov 2026 08:36:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=yv0ia8QR
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4jJhk71XFwz2xKQ;
	Tue, 03 Nov 2026 19:36:15 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=pass smtp.remote-ip="2a00:1450:4864:20::535" arc.chain=google.com
ARC-Seal: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1793694975;
	cv=pass; b=NqAeoQ+X7uFTUbweg0TnXWBm+yEZPUg9MePKhA8lHGPVtHydm1x9E/8YiRc1LwaymHzTJjR+8FT3IghhJqfWGl8reAzvErIH7R9QkvYTvMnsB2Nb+b6P5QgB3ocXJiCYVix6EqEZrO3gblP4JGgro0i6iyJgD9S4J+BZd63wvjnQnJz2QJ0Q5j6yfZmIUFT3g7D/FetQa+eZcTmvO9gO9ra2Y519NCzKe+RSG2XTq2qzLCWpT26Cd7wWkY9XOlHZtjDsXQ1qnfE81v26QqeXlkxyGo89zuIqlJV/GP25nqpOOvjXEWtHCyzwGaZZq5VWiIjsysSjh8sqCeFP7JIY5g==
ARC-Message-Signature: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1793694975; c=relaxed/relaxed;
	bh=Yv23yaMyqpRiF4P9WlsztaedGDeR3XhsI7PBr228qS8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Content-Type; b=Yniqr0rxwd9RLcQ7QKpzeAOpVncz4LCzQKxz9b+AkwR0kaE7lsezulqmiih4PLW/Xn0BRI3XDnU9IM/Fn9ux25EuTQwJcbERRTNnpjep2Oz7dwR5yJfziVgs+yHougw2TgQDmB+Q7zNOVfLKOSIvra+JmfEOQAD2fNejQzjysMJL9rEhRfw4QKZVTsAPUZmn6Nogribv9CNjEktfnoQ3oR15+vB4Iv0jGEMmE+4ix09W17XTgeHopl6hcaMe7ymwxQnZT7VjB3Ue76dEOR3YZXTQtRiLOpsGOvndErlKDqs9GHJBZC7Qw8NPowTOyJR2P5rkhWXYl7TUqrz4g152Ig==
ARC-Authentication-Results: i=2; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com; dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=yv0ia8QR; dkim-atps=neutral; spf=pass (client-ip=2a00:1450:4864:20::535; helo=mail-ed1-x535.google.com; envelope-from=kaylovefoss@gmail.com; receiver=lists.ozlabs.org) smtp.mailfrom=gmail.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=yv0ia8QR;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=gmail.com (client-ip=2a00:1450:4864:20::535; helo=mail-ed1-x535.google.com; envelope-from=kaylovefoss@gmail.com; receiver=lists.ozlabs.org)
Received: from mail-ed1-x535.google.com (mail-ed1-x535.google.com [IPv6:2a00:1450:4864:20::535])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4jJhk50PPzz2xHP
	for <linuxppc-dev@lists.ozlabs.org>; Tue, 03 Nov 2026 19:36:12 +1100 (AEDT)
Received: by mail-ed1-x535.google.com with SMTP id 4fb4d7f45d1cf-6b1b13e09ffso5289837a12.3
        for <linuxppc-dev@lists.ozlabs.org>; Tue, 03 Nov 2026 00:36:12 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1793694967; cv=none;
        d=google.com; s=arc-20260327;
        b=OLQT05vXLSjkKIROEyE0G6wWk4cLyf0aQH73yZRgxsylMqmETqcTuAcLMNZ2mrBazE
         jXePg/ZHEc97jjzgyIM3O7D9R5x0QW6vh0LZTlVAWpzy7DuPcH9n/ddD1ctlefU4V90x
         9xmCnPOtPbf5ErjKxOqu5tjxIpRMbIU+OfoWBE5COPpANtZkLw3/mrrueRy0LNmg1+XT
         WicJfaDaOc6p4lQxw0zEKlBosl94/07GzsfZnBpeAVYDlbED4gVz0b55excy0mVqF+KY
         ybNLUurh7PLPAEld1vUv7MT+dCSCZ7UFRpK5SOX2nF0j/Nd0nwk3uRGUccHNfDP3D/to
         iIrg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=to:subject:message-id:date:from:in-reply-to:references:mime-version
         :dkim-signature;
        bh=Yv23yaMyqpRiF4P9WlsztaedGDeR3XhsI7PBr228qS8=;
        fh=1yUgcW/WJkBKu7j68UptqTJxr17CwW+Jd/xTap6TLsU=;
        b=LxuuoGCKWAYR/3NfEWPszs7fRiTOHUCYwEjHtTBB2Al1xgRVYJ5lgrYkIF6EjxYkDl
         E1nzQ8hhmG4VNAKpGv7meyvFFi6RmE7F5larhpVZKXKJSLBk0G6LSmn53wh1pMKAfPAB
         uxDVmgz7IyIPc2nmn3K5psRSB2LVRBVK2vgAqCxkLpCwi2aIPm3e6VBBKlBnaWn6ApEl
         gZwD0e4uLudMF2wznaznNJDXtaTUWe4A5llIrkRS/XqsgJtR1iyOXj9DbkI2QuuACwu4
         ZqLCEpBHDrGbw3eV0c7w7hKypTUE/iFO1tbgGBoC8SMQ/B0YdVSiZjLVhHtEiLlXLdjc
         GfHg==;
        darn=lists.ozlabs.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793694967; x=1794299767; darn=lists.ozlabs.org;
        h=content-type:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=Yv23yaMyqpRiF4P9WlsztaedGDeR3XhsI7PBr228qS8=;
        b=yv0ia8QRWTL7IRH57D5Ugd+cB/NxseG3UP6Udnw0b9v5rDS4+VhwnaMv8b5k0NeDMl
         nzHsBHiaprS4mgeh26X5FQNZZXNQK2ahkEv3z8eNzlLm5XV2Ev1c5KFJ+USM0bRgnVQw
         2ZqJ7gtT9wrg3iRQEhBL4nc7HS5bP7kGaDH/4dpaSgR6YFTi3bgjCKM1A8wCsS0BEIZG
         Aq72SRJGiUi11Ogm2sO1jN0Q4ESleH8gpmrf8RQ1IrVakiGo9+v6bHHkmCt5Kej1UgRp
         5Jw6G5Ur67HqRZ53KKMknbCwRawoIQlJKyl0L2YfKl7lV51CxLNDtRzgWCO4Rm6JhuEx
         9V/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793694967; x=1794299767;
        h=content-type:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=Yv23yaMyqpRiF4P9WlsztaedGDeR3XhsI7PBr228qS8=;
        b=KGmPxVkBZhTCW3ZFRcvptdLWmA0zsaXxk+21PzmGifxc8ABPoers+X1At6Y54HxgVV
         j8auDkx3xphwN34Wenqc1xD2XTCzYMcX+1g+EWdrRBbBD4kBumo2ciFd2+NE+KG8QDar
         GFQ3Yk65m4MUi4hcXXR7EWpOAmmVl77wKy9Qhg5AUpCcJvqYgdiGPXBAjcruE8/S54fh
         2nlRoqWCIjeg5bTczYQCKNZDVYg9txS4Jpst+kahQTHoCJXo31fjw4Y4sghz4CBJFZXH
         mSFYLNcXfVHSq5PQy5jscZO+LuSOPLGt+DeKa1/3WRFILCqk20YaeX38AVBfsfSNm7X4
         gCZQ==
X-Gm-Message-State: APuU4Z90U0StQFEllcI2cs650rWS6rKp18GJml9SUzP6zim0cDj+m9s0
	zaiyC9fyct7ZUiDwNdQK6uaJUvzpb5CYqV4WxjtDIbNktaFWJ/BypBH+8fpVImBCzpW8vfSUffB
	BQYglhSSGucp2Sb3v0FGg8JvR1WsN9l99WZAwXom8Ag==
X-Gm-Gg: AYBFou1ZCdtWp0vmqk0NH/vnT0zuZXcfs0YwLk6CyUCeeMGBmgIZj1Wpu4WUrGCYNDv
	E5Vc9AjGqWDQ3ZhD6GQ2VqOVn+uCXJalllMmxmKnhpXxsbxTJnGP3eqonpqRjlc8RengVOpMeF1
	4Yo/SBpBfwSkW7mdgJCQdNhgN3lBV8RgCHG/hQTuDWih2eu5mXL2+FdVJA4oLwbk9rOKOb8Q8qs
	od9eqipMgLZNRUG2TlVelOSQf+EUWuI9QfA126ONVrJkHBz+7cdJ5T/1w1FukGyBBJb0Y9OxdNk
	iQkCV7o+XFXm/d2SiGRImDKLQxy/IHokcdz8iQfIVlcVy9SmTzMka/g9a5y+ER/aNOPY1VRLo79
	rO93PeSQyc4/YV56Gl376bmLXY8j080wPojUdjsJcczrUjd6TGLAaGtCqeYlXSktJMEoR3j/xHv
	Dtr2RCNz4ugB+V1Eo2PjtjEcRuRUZ7KNj2Zq0S6c8=
X-Received: by 2002:a05:6402:2042:b0:6b1:82e4:b2df with SMTP id
 4fb4d7f45d1cf-6b4d4d6f5demr5950124a12.29.1793694967210; Tue, 03 Nov 2026
 00:36:07 -0800 (PST)
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
References: <20261101144716.119289-1-kaylovefoss@gmail.com>
In-Reply-To: <20261101144716.119289-1-kaylovefoss@gmail.com>
From: Kay <kaylovefoss@gmail.com>
Date: Tue, 3 Nov 2026 08:35:54 +0000
X-Gm-Features: AclHuK-3Fl-Npzmqjdn94YO2ZE-Dy5ImthzJxz01de9c8ISOFkA4OlMMEZJDFn8
Message-ID: <CADb9fe66VWdLCsB1c7FL=AuQmA3yvrppLjimSW0w8drPxmmuTw@mail.gmail.com>
Subject: Re: [QUESTION] Does PowerVM populate the rtas-sensors device-tree property?
To: linuxppc-dev@lists.ozlabs.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_PASS,
	SPF_PASS autolearn=no autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Hi,

I asked a while back whether PowerVM populates rtas-sensors. The
answer is yes. Michael Bringmann posted a live pHyp device-tree dump
in June 2017 that contains:

    rtas-sensors     00000001 00000000 00000005 00000000
                     00000009 00000000 0000232d 00000000

That's four (token, maxindex) pairs, 32 bytes on an IBM 8408-E8E running pHyp.

I looked at LoPAPR 1.1 section 7.2.6.1.2 and couldn't find a stated
maximum. Linux uses MAX_SENSORS = 17 with the comment "I only know of
17 sensors", which reads to me like an implementation choice rather
than a documented firmware limit. Bringmann's dump has 4. Can PowerVM
ever emit more than 17?

In case you might wonder why I ask: ppc_rtas_find_all_sensors()
computes sensors.quant = len / 8 and copies that many entries into
sensors.sensor[17] without checking. I reproduced this in QEMU with an
18-descriptor (144-byte) property against unmodified upstream
cbbddb6b08cc with CONFIG_KASAN=y. Reading /proc/powerpc/rtas/sensors
as uid 65534 gives me:

    BUG: KASAN: global-out-of-bounds in ppc_rtas_sensors_show
    Write of size 4 at ... by task cat/66
    ... sensors+0x8c/0xc0

I then applied Pengpeng Hou's April bounds check
(<20260401160317.88585-1-pengpeng@iscas.ac.cn>, never merged,
https://lore.kernel.org/linuxppc-dev/20260401160317.88585-1-pengpeng@iscas.ac.cn/)
on the same kernel and property:

    too many sensors reported: 18
    No sensors are available

No KASAN report at all. So the overrun is demonstrable from an
unprivileged read once a >17-descriptor property exists. What I can't
determine is reachability: does any shipped firmware emit one? If 17
is a firmware cap, the fix is defensive only, if not, I think
Pengpeng's check is worth reviving.

Thanks.

