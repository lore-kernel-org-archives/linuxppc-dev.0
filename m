Return-Path: <linuxppc-dev+bounces-20186-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3D3E1FF8868
	for <linuxppc-dev@archiver.kernel.org>; Mon, 27 Apr 2026 18:07:38 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4g4BP464sFz2xSX;
	Tue, 28 Apr 2026 04:07:36 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2a00:1450:4864:20::44a"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1777313256;
	cv=none; b=VkAQxp9SkGQTMCS/7hINnbeouB+OykkatMk2n6DTJzcotIDlzyOlAV/24xCJkcDe/+rO2nDWiSQIoA544wSvUuFPkNVEIkg/Re80x9/K5LZIxBT4YfQyocMwXg+OLXI/DKj0gyelt79drOVZGp8MJfnYk0P0SRK5fkuX6QUIHR2mniXbXmG2/8O8Db6Y31iGkj/OWCm9RT2vWk6JVhxIym/XDu3P16SVEf3mDAuA3aXI3MDNTrzae118cnA5Tne1/wDoZt8sO3USEUHoYqatWV5TdrlgEc43imok0eqxx42cIaAZeDA4jfrTpx5H8XqaxIRO7LEJcaa208+okO+F9A==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1777313256; c=relaxed/relaxed;
	bh=HxkgeF4LNZGOlYkWj+Rbzgew6yzkspsu2lszfChr6II=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=fGf0hfGbt7Gza3OXCNvL8bihOA/MBK7Xwj22eU32YWMAFeBz00tbNB7LeNVvSoPofqDQMuPJwMab2Sqo5AbQUhBidwaesxY+MyOpmBXtgaP+JYuR5LDbqmA4+So23szRC/AuRtJZw3zeBqXkTa+hrDv0pQq1C36qKUx/GP4dnJAnWKmhEecBT3trICsYF5T2SUhOwQfb5DG4JRPatXN9Sm12182C3SSU7xNLRKMx3AWUHA8WGKfFIT0EtjqOiXvnjDkq5FfIRF6pljgVq3Hi9+eV3r8NG/cEDNlV3NR64MCnkseNOVNWg2DR2cGTxSRGFSoc5pplG6XNnS4oxK0HHA==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=reject dis=none) header.from=google.com; dkim=pass (2048-bit key; unprotected) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20251104 header.b=HrGlVm/c; dkim-atps=neutral; spf=pass (client-ip=2a00:1450:4864:20::44a; helo=mail-wr1-x44a.google.com; envelope-from=34axvaqkkdeiepmgiv2lpksskpi.gsqpmry1ttg-hizpmwxw.s3pefw.svk@flex--aliceryhl.bounces.google.com; receiver=lists.ozlabs.org) smtp.mailfrom=flex--aliceryhl.bounces.google.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20251104 header.b=HrGlVm/c;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=flex--aliceryhl.bounces.google.com (client-ip=2a00:1450:4864:20::44a; helo=mail-wr1-x44a.google.com; envelope-from=34axvaqkkdeiepmgiv2lpksskpi.gsqpmry1ttg-hizpmwxw.s3pefw.svk@flex--aliceryhl.bounces.google.com; receiver=lists.ozlabs.org)
Received: from mail-wr1-x44a.google.com (mail-wr1-x44a.google.com [IPv6:2a00:1450:4864:20::44a])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4g4BP22J42z2yN8
	for <linuxppc-dev@lists.ozlabs.org>; Tue, 28 Apr 2026 04:07:33 +1000 (AEST)
Received: by mail-wr1-x44a.google.com with SMTP id ffacd0b85a97d-43d7757463eso7008212f8f.0
        for <linuxppc-dev@lists.ozlabs.org>; Mon, 27 Apr 2026 11:07:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1777313250; x=1777918050; darn=lists.ozlabs.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=HxkgeF4LNZGOlYkWj+Rbzgew6yzkspsu2lszfChr6II=;
        b=HrGlVm/cq9lPWVUmGDyBHFo2YOHvl6lnPt1pqwdB3qg/ETZqoTQ4fLYVcbIbkzc6t4
         KpEpiPWyW05wyJ4GGkn9aClb2j3OWLg3EPawHF7Hu7K1CrwOfXg8egLBq8HjTL/hOj/d
         Mnh6aS+2E8VqDdmshjZGPGH3KrruPgWKmhCWooMSV+u7TOtAgJm83EE6NsjYQoYQ3gLY
         uLPIyD3kCykfRszS4ifdfDBCP5R5bPTDCr8Yesk/xEL1ikALD/bLptdaOmO+2zXJdpYD
         EpXoDsAeyLFoUtVubTWbtVOsFKBJVWvc35bwrvf+eYyOiaRC6quKLWW7Ta4HTkkl1+P9
         +iFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777313250; x=1777918050;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=HxkgeF4LNZGOlYkWj+Rbzgew6yzkspsu2lszfChr6II=;
        b=AzEj846FVXPKygsyaHNvKvhZV82zES68qZMrGl/f6NBvdsG45r/aBuiFGzP0JdwO7m
         dBsVapkw2r5q8B9dL2znEWLXFvgryg7QiWYQn7WgNI4zy0r1GXz7K/Lyhqd4PQSj7Jiv
         U6N9NfAQsDFKkLt5mM6Q5YO7Mx5KgP6foK0ASoMtCclcor/OZPVYDGfa5oPkZX4JO8c4
         8YDPLcNaOdZIdV/qRsHTw1DOmYoYFoSa8iMH3l+6Z8vPcU81IiX8Xh41JPBz11QLLuEa
         VCpNGiUiQS4z0KpWhOb+1V9KTHPLiqOiCMsqtga23zUkisjGKsV07V3ZlUhRDClb1zU7
         AjFg==
X-Forwarded-Encrypted: i=1; AFNElJ9A/DUCQnwRNoWBZVIQaJ97SEi42JNFb7bmKaf7uL11hEHgLaLA4g2X36hNud6tDl9zgF4gXtE+8wrUJW4=@lists.ozlabs.org
X-Gm-Message-State: AOJu0Yx+Ala6j1yHOrscbQDq6lCsl5kA9ELkaVN92Kegtx0Yle6Mnzi+
	tAO19ZWlowARjSl0l4mxKH/gn2pymHmJqeuvx/FWBL/cwxhLesPdeQrglLOIJfMmbSY7afrheZi
	pge7rXd/Vchca94qq2w==
X-Received: from wrmd3.prod.google.com ([2002:adf:e883:0:b0:43d:7940:a11b])
 (user=aliceryhl job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:6000:41c7:b0:43d:799c:b2cb with SMTP id ffacd0b85a97d-44636a393e7mr256856f8f.24.1777313249648;
 Mon, 27 Apr 2026 11:07:29 -0700 (PDT)
Date: Mon, 27 Apr 2026 18:07:28 +0000
In-Reply-To: <289b424e243ba2c4139ea04009cf8b9c448a87ff.1777306795.git.chleroy@kernel.org>
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
References: <cover.1777306795.git.chleroy@kernel.org> <289b424e243ba2c4139ea04009cf8b9c448a87ff.1777306795.git.chleroy@kernel.org>
Message-ID: <ae-l4FGDPLwBuDXM@google.com>
Subject: Re: [RFC PATCH v1 5/9] uaccess: Switch to copy_{to/from}_user_partial()
 when relevant
From: Alice Ryhl <aliceryhl@google.com>
To: "Christophe Leroy (CS GROUP)" <chleroy@kernel.org>
Cc: Yury Norov <ynorov@nvidia.com>, Andrew Morton <akpm@linux-foundation.org>, 
	Linus Torvalds <torvalds@linux-foundation.org>, David Laight <david.laight.linux@gmail.com>, 
	Thomas Gleixner <tglx@linutronix.de>, linux-alpha@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-snps-arc@lists.infradead.org, 
	linux-arm-kernel@lists.infradead.org, linux-mips@vger.kernel.org, 
	linuxppc-dev@lists.ozlabs.org, kvm@vger.kernel.org, 
	linux-riscv@lists.infradead.org, linux-s390@vger.kernel.org, 
	sparclinux@vger.kernel.org, linux-um@lists.infradead.org, 
	dmaengine@vger.kernel.org, linux-efi@vger.kernel.org, 
	linux-fsi@lists.ozlabs.org, amd-gfx@lists.freedesktop.org, 
	dri-devel@lists.freedesktop.org, intel-gfx@lists.freedesktop.org, 
	linux-wpan@vger.kernel.org, netdev@vger.kernel.org, 
	linux-wireless@vger.kernel.org, linux-spi@vger.kernel.org, 
	linux-media@vger.kernel.org, linux-staging@lists.linux.dev, 
	linux-serial@vger.kernel.org, linux-usb@vger.kernel.org, 
	xen-devel@lists.xenproject.org, linux-fsdevel@vger.kernel.org, 
	ocfs2-devel@lists.linux.dev, bpf@vger.kernel.org, kasan-dev@googlegroups.com, 
	linux-mm@kvack.org, linux-x25@vger.kernel.org, rust-for-linux@vger.kernel.org, 
	linux-sound@vger.kernel.org, sound-open-firmware@alsa-project.org, 
	linux-csky@vger.kernel.org, linux-hexagon@vger.kernel.org, 
	loongarch@lists.linux.dev, linux-m68k@lists.linux-m68k.org, 
	linux-openrisc@vger.kernel.org, linux-parisc@vger.kernel.org, 
	linux-sh@vger.kernel.org, linux-arch@vger.kernel.org
Content-Type: text/plain; charset="utf-8"

On Mon, Apr 27, 2026 at 07:13:46PM +0200, Christophe Leroy (CS GROUP) wrote:
> diff --git a/rust/helpers/uaccess.c b/rust/helpers/uaccess.c
> index 01de4fbbcc84..710e07cd60ae 100644
> --- a/rust/helpers/uaccess.c
> +++ b/rust/helpers/uaccess.c
> @@ -5,13 +5,13 @@
>  __rust_helper unsigned long
>  rust_helper_copy_from_user(void *to, const void __user *from, unsigned long n)
>  {
> -	return copy_from_user(to, from, n);
> +	return copy_from_user_partial(to, from, n);
>  }
>  
>  __rust_helper unsigned long
>  rust_helper_copy_to_user(void __user *to, const void *from, unsigned long n)
>  {
> -	return copy_to_user(to, from, n);
> +	return copy_to_user_partial(to, from, n);
>  }

No Rust code uses the return value for anything other than comparing it
with zero, so you can keep these as copy_[from|to]_user() without
issues.

Thanks, Alice

