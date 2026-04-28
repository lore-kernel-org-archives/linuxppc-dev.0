Return-Path: <linuxppc-dev+bounces-20230-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DE2E0FF8868
	for <linuxppc-dev@archiver.kernel.org>; Tue, 28 Apr 2026 09:31:05 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4g4Ztc1ctzz2ySf;
	Tue, 28 Apr 2026 19:31:04 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=209.85.208.47
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1777368664;
	cv=none; b=euKk+onZjKyCETW3C0Y6LUADBAMcLLPHF917Tph+Ie7hA/6eRoAmIO90+lqMR03tB3YOA5k+S2Aly9rI1KsrCa5dNMIra098Ss/l4Z+78y8qLRj6Ef6dsv0WpVCtxmcN12BC/2w8OXWBNxP/h3WnrDyWCAI0UBpj2RGfsiOjrjr5hyqsk9XmPOqUMd6EJrklhtghwpmM6KZaIrFYQUevtudq37rVuFo7nP9aD6752qjt4735glha3TmTgMUP3KQdRBVQ7W/NU38nkpRL0b2pMGJS3rGkVrfixRGpthoEEfuFe3oCWwReGU1cCEt682elqqll+4sxv2Dxw/mBMC7FjQ==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1777368664; c=relaxed/relaxed;
	bh=Al22kA6RCf7FSEzj29cZLSkjdM9EgXxihmBX7/SeSVI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=U7a+ApVelUKAJ4fsFqPscmAjTpQ50exeB+WcWpJlXkqP4060TqOf6SS1HwzmFPrQGWY1t2IvIYSkB489XXiWrBuaksOscYoqgQEEznjw/6h6oRes2pPRykUYpyxan3YQRRHeKG1zX6yP0JKl4tkQVlPRukujBu9lPLqkWYyKGFaXr4RblyRGINc1k5nMmabrlxZ+No8TS2dR1HLXusSpNLRUvcZAKCl++Ctq0PUczkQp6hPrVJO5vraQD4IrwwZvQbHhrraASseOyRdoiY5WvWOZU4y1epf34bdTJIS6/SIK+XMJB+qBwqaCMOgtH59rM/zAO1xhjw+FtybcF8qgxA==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org; spf=pass (client-ip=209.85.208.47; helo=mail-ed1-f47.google.com; envelope-from=geert.uytterhoeven@gmail.com; receiver=lists.ozlabs.org) smtp.mailfrom=gmail.com
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=gmail.com (client-ip=209.85.208.47; helo=mail-ed1-f47.google.com; envelope-from=geert.uytterhoeven@gmail.com; receiver=lists.ozlabs.org)
Received: from mail-ed1-f47.google.com (mail-ed1-f47.google.com [209.85.208.47])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4g4ZtY18Q3z2xcD
	for <linuxppc-dev@lists.ozlabs.org>; Tue, 28 Apr 2026 19:31:00 +1000 (AEST)
Received: by mail-ed1-f47.google.com with SMTP id 4fb4d7f45d1cf-678a526f374so7376733a12.0
        for <linuxppc-dev@lists.ozlabs.org>; Tue, 28 Apr 2026 02:30:59 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777368656; x=1777973456;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Al22kA6RCf7FSEzj29cZLSkjdM9EgXxihmBX7/SeSVI=;
        b=eKDr6krlhIuH4M+ih9fmC8GBTQUKXvqhlSF0b0pymshHOuHquxrp5CkMYBXanta5ya
         ThhUS3SuEho4A4HEKEx/e+IPI5HZaqAb6b35hjNBgABA2guICbxDCSqiF77saXPHN/QC
         Eug1ZVZ7AXEyXS15Ha6/iMEg9HleueXyAdZDCrVExHaRAavCUEKcSOPNxQgq3YCt+q/c
         YL6lDvMB1cm4q7l7bYEZ8teQ4kmvNzlBnASZyEZW9OC6YQ3i2Y87yhJXOTXjq64INch+
         iEgZPqgciRcMvV7CM5aDZzEjB+oFZB9IJar7MaSLNEkOCCjWGqlvUhawUxHxac6rvafx
         t1dQ==
X-Forwarded-Encrypted: i=1; AFNElJ/SJg5Wt8cvn4gZ1tWzpHuZkmH8gBXOI7P7ApXphsRhZ86bCvkT0QgUrSbQVy4JilWz4xfmwrb2p0bu73A=@lists.ozlabs.org
X-Gm-Message-State: AOJu0Yyc5ARcMylGD1HwLrBIS2U9AoNy5ew0NKE9Hg7jSi+6HHqIKWi2
	wfpjr8xRPE1SSrfBK0kqZPYsLVrbv16zdl8wCPtB83ttRkcnm6Ni5zyEYNNbykudccs=
X-Gm-Gg: AeBDietDQDFdjQKUIVb0y4qMGQdusSJHSiHVGJfbS0SvQHrQa08hYMCgmYOdBrBsROU
	JWoN/5kAVidRUWUYDEqRI07CwxBR4Ai4Tzq1aPAOMftOHUP8wNLtwfy4JsFzulXW0i0I8b+cirg
	bOCk0hUO/S6lm9IQqsLfeCbqXR1mf6WNYOA9GHEX0uHIxPBDSPm9KOsbvHm/8kBbfVzJsEiwuwY
	oGYD0sHM6Cg+Z8XUfjBqwwKbBaf+8Oaloyi4rMk2Werdu7BqaJahl3jwEwpQfR3FwRdp43AkLdr
	8QAB01CnWnBXdOLaRElsUuwdmnufLRfClRwTpSyMG4mQMCykotTY95kBw2fdSdOKMdU+G7fBhC1
	uFYbpXbfb0HUZU0EqhasrbgcT3lgrCv3IrbfCuDa2mJ9odMZg1dypHcVrizpl7ddbNwVl3iF+a1
	bZ2g3oLDE36JP60p+U1i9Bu5JWW1puUNV3XkXynQea0/1uMMIBbQk7J56f2IYA9WqUXiiytg0=
X-Received: by 2002:a17:907:3c84:b0:ba5:885d:3280 with SMTP id a640c23a62f3a-bb802da6a6cmr131479966b.17.1777368656192;
        Tue, 28 Apr 2026 02:30:56 -0700 (PDT)
Received: from mail-ed1-f41.google.com (mail-ed1-f41.google.com. [209.85.208.41])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-bb808632f35sm73709066b.11.2026.04.28.02.30.55
        for <linuxppc-dev@lists.ozlabs.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 28 Apr 2026 02:30:55 -0700 (PDT)
Received: by mail-ed1-f41.google.com with SMTP id 4fb4d7f45d1cf-67389cf78b0so19505019a12.2
        for <linuxppc-dev@lists.ozlabs.org>; Tue, 28 Apr 2026 02:30:55 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AFNElJ+HdUtN5pJVZm24fRbKQ6rDJl4+NfYgewC/qwAraeMrOtdOjgy+cOHQR4r7FAGkiapdDgrA/YarYxPKOP4=@lists.ozlabs.org
X-Received: by 2002:a05:6402:5056:b0:676:d8a1:7a04 with SMTP id
 4fb4d7f45d1cf-679bb09a4admr915149a12.23.1777368324094; Tue, 28 Apr 2026
 02:25:24 -0700 (PDT)
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
References: <cover.1777306795.git.chleroy@kernel.org> <c73b90236f2810edd47c84edd2a8d8e8e0c816da.1777306795.git.chleroy@kernel.org>
In-Reply-To: <c73b90236f2810edd47c84edd2a8d8e8e0c816da.1777306795.git.chleroy@kernel.org>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Tue, 28 Apr 2026 11:25:11 +0200
X-Gmail-Original-Message-ID: <CAMuHMdUvTBWoDN_wUo2n8-gkoheJ+-rbwew53OvoAwo8G5n1qg@mail.gmail.com>
X-Gm-Features: AVHnY4JEWBVPw4tSjHgbQTia8gZd2WGJ1sv6qLdKJbtvs4hms1blpvc35yb0VWw
Message-ID: <CAMuHMdUvTBWoDN_wUo2n8-gkoheJ+-rbwew53OvoAwo8G5n1qg@mail.gmail.com>
Subject: Re: [RFC PATCH v1 4/9] uaccess: Introduce copy_{to/from}_user_partial()
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
Content-Type: text/plain; charset="UTF-8"

Hi Christophe,

Thanks for your patch!

On Mon, 27 Apr 2026 at 19:18, Christophe Leroy (CS GROUP)
<chleroy@kernel.org> wrote:
> Today there are approximately 3000 calls for copy_to_user() and
> 3000 calls to copy_from_user().
>
> The majority of callers of copy_{to/from}_user() don't care about the
> return value, they only check whether it is 0 or not, and when it is
> not 0 they handle it as a -EACCES.

I think the "a" can be dropped.

> In order to allow better optimisation of copy_{to/from}_user() when
> the size of the copy is known at build time, create new fonctions

functions

> named copy_{to/from}_user_partial() to be used by the few callers
> that are interested in partial copies and need to now how many

know

> bytes remain at the end of the copy.
>
> For the time being it is just the same as copy_{to/from}_user().
>
> Signed-off-by: Christophe Leroy (CS GROUP) <chleroy@kernel.org>

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds

