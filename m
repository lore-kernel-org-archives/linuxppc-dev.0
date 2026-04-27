Return-Path: <linuxppc-dev+bounces-20196-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 56EBDFF8872
	for <linuxppc-dev@archiver.kernel.org>; Mon, 27 Apr 2026 21:39:45 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4g4H5q5wSZz2y2B;
	Tue, 28 Apr 2026 07:39:43 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2a00:1450:4864:20::62d"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1777325983;
	cv=none; b=Yb29HtNVQbjY1oeJBuP1dUdtfBTof+yn9rNx0VpQJnZSiykYIoQM7uFkRtE/KFiWv7XA0prnVOfYnn9HMWwb6jh0TmUsSwc1tpbiivu1IkFfQxdNd9AMI48+RFrwAIWEM0IuP69g/TJ5jZmKZXDHmJUc5ECJLyyUbSAlKDnT2m7eAXFFvC3lRGiJyUMRYSQ7FPfH79tDxSz3SQZEIFNNa16lQ0im8H/42FZ46KOVxc0t3CYvAi6O4aI3MidwN6itQKkrtTdf+lPrDvjy9khe6TBX1qrJ7vlG7j09llksq3AfkiqUUtrr5MENlO9qjhX8M68Xxly6F5ilYFXG/52lFw==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1777325983; c=relaxed/relaxed;
	bh=DjF1Jdn4Kp6xFyaBmAP2391GfFF2q7kuOVlruTChM90=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=fu1RsUKi/RQh5K1kmDxOvSSmx2Nm0rjAlW/KTRkowLooQ3+e3TXgnBQ5PEFicAY8rVxnk73ikxK1rJf7RdJeitBlvOCqyc/BgzJsBCrQ8Vvy5PHa4iUIyq33OsFLRlGrKoE+M+bssMlVeBrcc71JmqLq+95dheC+t/J3CMG5J+3H/lotlqjjMljjkR4HmvbLBp+vVSxV3rLOXKfBxaHu3S9IhdsODQp0hYdFJGXekESV0IICmewLQqW84wDQeT60DoBYzPSGE2uDsRRfzboQsxU26OwF9uQDqqGLmdBx3QJy3esAJpnpIsU8hv+T5MKzFDarfXeM5Qqamj95Xi6fFw==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; dkim=pass (1024-bit key; unprotected) header.d=linux-foundation.org header.i=@linux-foundation.org header.a=rsa-sha256 header.s=google header.b=TVN8EVT6; dkim-atps=neutral; spf=pass (client-ip=2a00:1450:4864:20::62d; helo=mail-ej1-x62d.google.com; envelope-from=torvalds@linuxfoundation.org; receiver=lists.ozlabs.org) smtp.mailfrom=linuxfoundation.org
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=linux-foundation.org header.i=@linux-foundation.org header.a=rsa-sha256 header.s=google header.b=TVN8EVT6;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linuxfoundation.org (client-ip=2a00:1450:4864:20::62d; helo=mail-ej1-x62d.google.com; envelope-from=torvalds@linuxfoundation.org; receiver=lists.ozlabs.org)
Received: from mail-ej1-x62d.google.com (mail-ej1-x62d.google.com [IPv6:2a00:1450:4864:20::62d])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4g4H5p1vryz2xC3
	for <linuxppc-dev@lists.ozlabs.org>; Tue, 28 Apr 2026 07:39:41 +1000 (AEST)
Received: by mail-ej1-x62d.google.com with SMTP id a640c23a62f3a-bb3c4d8cc29so236176466b.1
        for <linuxppc-dev@lists.ozlabs.org>; Mon, 27 Apr 2026 14:39:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1777325978; x=1777930778; darn=lists.ozlabs.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=DjF1Jdn4Kp6xFyaBmAP2391GfFF2q7kuOVlruTChM90=;
        b=TVN8EVT6Baa+HS+ZEXOxYgC8mbeEn3HP+IJlIn+UcNgWG7PRNNFxjCOwkZoPT7FnaV
         hgUwcnD50eJuTsUut0BH/j1GxWrTFzCxU48dGWobHMxJ+BM5JX3prqJg6v43kVAmVWvc
         ZENjajGF/YZHzQherd8doOGcppx9k9hMBr0jU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777325978; x=1777930778;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=DjF1Jdn4Kp6xFyaBmAP2391GfFF2q7kuOVlruTChM90=;
        b=GyrOjaPEQbxn4iItG3aKFbS4KrftT4J2GvSpoHgmV+Odrou8jhwVk3tGi+o5g2HemU
         vZdSK4XpApoMlbAZLbmE+QQPETC7vX2osGwNbMtzplwVg5Xs6Rl6hOA74atKY7+TRj3o
         07ML6fd238U9j72mZcnX83S5NUI7hb6O5i4ScAa3a+Trda0cnL53CZ4Cn1i7ag6l384l
         aN3N9JdobhnMSSGw1z7HAXse4as1O3lw93wtOXTBKPnW5mi5Kgwmty618+rZJ/vtq3ra
         DcyK/kkLzs14R0/pQO2lrOL9zu7CfC5KMidXf0Gg+E5O8rvELUpFyrnIsizoD1IHjjSG
         9scw==
X-Forwarded-Encrypted: i=1; AFNElJ/OLZyudA57KCdzkwvUXf/8Crr8Po9sfB7ZrSlFqPowyylwoXyAK8gAtCv6h0/O4ZUxH3wakZFE5mxi60A=@lists.ozlabs.org
X-Gm-Message-State: AOJu0Yw6hUMzEmI9W93HbOOV6b5O63xb7cZhspl5vKj70AnR1Ak/hja2
	qWeEIbM4hD2DvutyibF4lCFdBS3YACh4osQNory+KtA1dEpWia+GU+P6U13uQN688hqATeBhYRL
	z2tgb6lw3LQ==
X-Gm-Gg: AeBDieuk4Xjn4H+gxptGdvkqRIu+BGDLwN+WL2LI2KmZg5TgOQhj6rBEpXdBev2cI2Q
	OieigabHhgXlIJneZzrYHUMZD4C7fg4k1yozM4Z0ArXcEqAyJ/eENvRXqTpIC2TsFbGVRSRsMxH
	CeqlWBSbvduz5gwCpZDYt+9z6p+6fiNOX/WxY61Sotu9eaMd8OGI6cGiaFyyKMQ9bQQVAJHM96v
	GSTIDKFsF8k4b29gBHGsJIUn3bC533bYtDz4+2VN9RH5qYyNynO3ictZk4nJJo2vrk/HGoby0WX
	toVmoUghj8CEmNgiazYlGK5sCpv9WUcoa5hsiqMcCM/6209BJZeqLVZb72DkmwM6iIqjlpOPkv6
	tSk1aptEbYFf94I+JKtk+c6JEhZ0FpmU1gMfg7WjKdpVE/bV2MlM0whmFXULWPUDggpMq+Ktdlf
	+GpSqzP6L3pAoR2bGRUhMg9qx+rf5QiJ6fsbuPJuANA/rKsQZiTLFa+6wDIaE0z0ppb5dFwSwGw
	86TC+KleYo=
X-Received: by 2002:a17:907:3c84:b0:ba5:885d:3280 with SMTP id a640c23a62f3a-bb802da6a6cmr29138566b.17.1777325978196;
        Mon, 27 Apr 2026 14:39:38 -0700 (PDT)
Received: from mail-ed1-f53.google.com (mail-ed1-f53.google.com. [209.85.208.53])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-bb80b2aded9sm8979366b.41.2026.04.27.14.39.37
        for <linuxppc-dev@lists.ozlabs.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 27 Apr 2026 14:39:37 -0700 (PDT)
Received: by mail-ed1-f53.google.com with SMTP id 4fb4d7f45d1cf-678adefbd26so5624857a12.3
        for <linuxppc-dev@lists.ozlabs.org>; Mon, 27 Apr 2026 14:39:37 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AFNElJ/K4K5q7bDbhOrAmgvbPOhWoXY/hbNMnIFQ9ch0+nLBLdMu/U5Xj6trw/3K3Y7tlJvwvjaBbJKvLjZx8u8=@lists.ozlabs.org
X-Received: by 2002:a05:6402:5216:b0:679:1f4f:9d30 with SMTP id
 4fb4d7f45d1cf-679bb04c1a2mr179970a12.4.1777325976937; Mon, 27 Apr 2026
 14:39:36 -0700 (PDT)
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
References: <cover.1777306795.git.chleroy@kernel.org> <289b424e243ba2c4139ea04009cf8b9c448a87ff.1777306795.git.chleroy@kernel.org>
 <CAHk-=whC1DZojwdMB1=sJWG2=dsCdfyU8N6tDE1qx50HRZ-WJQ@mail.gmail.com> <20260427222914.1cb2dd3b@pumpkin>
In-Reply-To: <20260427222914.1cb2dd3b@pumpkin>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Mon, 27 Apr 2026 14:39:20 -0700
X-Gmail-Original-Message-ID: <CAHk-=wg0SGbRYhdZ1kvJUTv1HEvmRJyQauFtBGV_fMcZVF8UpQ@mail.gmail.com>
X-Gm-Features: AVHnY4I-AxqvQRk42MegvhKMp_z4sSEpEzhzpgw2GyV2bV8dezSPoI0JTlwB18Y
Message-ID: <CAHk-=wg0SGbRYhdZ1kvJUTv1HEvmRJyQauFtBGV_fMcZVF8UpQ@mail.gmail.com>
Subject: Re: [RFC PATCH v1 5/9] uaccess: Switch to copy_{to/from}_user_partial()
 when relevant
To: David Laight <david.laight.linux@gmail.com>
Cc: "Christophe Leroy (CS GROUP)" <chleroy@kernel.org>, Yury Norov <ynorov@nvidia.com>, 
	Andrew Morton <akpm@linux-foundation.org>, Thomas Gleixner <tglx@linutronix.de>, 
	linux-alpha@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-snps-arc@lists.infradead.org, linux-arm-kernel@lists.infradead.org, 
	linux-mips@vger.kernel.org, linuxppc-dev@lists.ozlabs.org, 
	kvm@vger.kernel.org, linux-riscv@lists.infradead.org, 
	linux-s390@vger.kernel.org, sparclinux@vger.kernel.org, 
	linux-um@lists.infradead.org, dmaengine@vger.kernel.org, 
	linux-efi@vger.kernel.org, linux-fsi@lists.ozlabs.org, 
	amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org, 
	intel-gfx@lists.freedesktop.org, linux-wpan@vger.kernel.org, 
	netdev@vger.kernel.org, linux-wireless@vger.kernel.org, 
	linux-spi@vger.kernel.org, linux-media@vger.kernel.org, 
	linux-staging@lists.linux.dev, linux-serial@vger.kernel.org, 
	linux-usb@vger.kernel.org, xen-devel@lists.xenproject.org, 
	linux-fsdevel@vger.kernel.org, ocfs2-devel@lists.linux.dev, 
	bpf@vger.kernel.org, kasan-dev@googlegroups.com, linux-mm@kvack.org, 
	linux-x25@vger.kernel.org, rust-for-linux@vger.kernel.org, 
	linux-sound@vger.kernel.org, sound-open-firmware@alsa-project.org, 
	linux-csky@vger.kernel.org, linux-hexagon@vger.kernel.org, 
	loongarch@lists.linux.dev, linux-m68k@lists.linux-m68k.org, 
	linux-openrisc@vger.kernel.org, linux-parisc@vger.kernel.org, 
	linux-sh@vger.kernel.org, linux-arch@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Mon, 27 Apr 2026 at 14:29, David Laight <david.laight.linux@gmail.com> wrote:
>
> I think there is a slight difference in that the normal copy_to_user()
> will determine the exact offset of the error by retrying with byte copies.

I have this dim memory that we decided that you can't reply on byte
exactness anyway, because not all architectures gave that guarantee
for the user copies.

But that thing came up many years ago, I might mis-remember.

            Linus

