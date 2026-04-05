Return-Path: <linuxppc-dev+bounces-19382-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 95EDEE9D827
	for <linuxppc-dev@archiver.kernel.org>; Sun,  5 Apr 2026 22:50:42 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4fpnjr6tHZz2xQB;
	Mon, 06 Apr 2026 08:50:40 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2a00:1450:4864:20::630"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1775429440;
	cv=none; b=JvxNRDliz9S17jbnw3OPmDJZqtGCdrvFT93WMaeKvvDyRKPXIrixrBpa0ulN+rN3zjXu7xB5CkB62b331dcgiPLDDDT4Prknsq0BOZXQj3c17EDcFUkM1AHFnWFPWm9gJCQJjnnKungCy36tn2t6irSLTFf6xSaJPGxb/GfbGgCFe3q6/MT5bLr8Ax3R7i7PsTCI/UKrXK8U7zMyIfWXvtGTpDcCZkFVo3fIV2FZ6kYeIdfTwSjnzzlCzLtAp2UGZ4+3REqwA7YZUTy/YhBskcENF90CtNyqRmqAHZr5jyLfRwjtnKuHud35B+6XDmJdI9zM9IayOyh/YGuVgyOB0g==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1775429440; c=relaxed/relaxed;
	bh=jzjlDiAhhtCwD9FkXK7yFaosCzkOtMCSogVYlSJljQY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=UeyEJA9XC9+lfEJyQiV1kbnlwyN5/W8f1Kt36c9io5k9weVhJZ/pIDizgq7MFZascb4cFnzB+9RRT9RUlRoVoXBzgKzX6A2Zyk6RfJfZdDgKSB5VqBGuw1zQOdNRTVGPy684ObR0AB5wNtLj0qj8Gwl6ieorqqwGX51WB88cRhuCz40CcKsQV8mUXmkemw5tiw5Ng3hD0z1hj/OjMFohKUFj4KI2Q1gOv6RXfRkBY/4fc/1Z0INBxFHc9As/pj9WRz7L5oF3qfwD8T5jJGT9rgtrr0vpX9LeC117n9zpP5BrE3UtbE40UUuMF+GT25I8HL2ELPjzQRfOZkbmwT1+bg==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=chromium.org; dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.a=rsa-sha256 header.s=google header.b=ZmUaySGT; dkim-atps=neutral; spf=pass (client-ip=2a00:1450:4864:20::630; helo=mail-ej1-x630.google.com; envelope-from=dianders@chromium.org; receiver=lists.ozlabs.org) smtp.mailfrom=chromium.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.a=rsa-sha256 header.s=google header.b=ZmUaySGT;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=chromium.org (client-ip=2a00:1450:4864:20::630; helo=mail-ej1-x630.google.com; envelope-from=dianders@chromium.org; receiver=lists.ozlabs.org)
Received: from mail-ej1-x630.google.com (mail-ej1-x630.google.com [IPv6:2a00:1450:4864:20::630])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4fpnjr0Xhxz2xMY
	for <linuxppc-dev@lists.ozlabs.org>; Mon, 06 Apr 2026 08:50:39 +1000 (AEST)
Received: by mail-ej1-x630.google.com with SMTP id a640c23a62f3a-b9c3e2cf3c0so544442766b.1
        for <linuxppc-dev@lists.ozlabs.org>; Sun, 05 Apr 2026 15:50:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1775429436; x=1776034236; darn=lists.ozlabs.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jzjlDiAhhtCwD9FkXK7yFaosCzkOtMCSogVYlSJljQY=;
        b=ZmUaySGTGP0tunTa+BAVi53x9aBMav4RvpCjXflBRBXw9gbNWK45FpdT1X+4B9Ao/B
         QOg+LlcaiQ+VUeBlnBs5YVU3C5sIsl14a8AsNiWNiKExdp1Aj0uiqWe8cOFUpJIsqrm5
         FKU14pffbvYih/xQtyQTejYxRnX6arbj4j4+I=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775429436; x=1776034236;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=jzjlDiAhhtCwD9FkXK7yFaosCzkOtMCSogVYlSJljQY=;
        b=hvTmwnrCiZ4H3nteE7nflDvoTCEzYNaIOlsbelSYQQ8oPvuGwL1FFBwHHLKnuWJjI1
         kKfrH5PuTwMEh5Ui/IMjR8/2uDsvN+zGs7lwhE7z1oUjZTk/M2LxABKgJpKFGLLX2ILi
         OTw8aGho4VeQcQBHx2jXG77nu4KXpEpQjStTMYPN/EijZhDpoPlRZnHi6EhPJ+eZV63S
         Immt4MAckDihWffSWkzCHraAgGazqb0gpJRSjNAUXE1M3+AmyCN2kCcs022LolG5DLV/
         r6LjL95rCHCiPzP9pie+PHzvECOqUIHFBz92LMdENMakLR4h/ys2AOMQ/z09qLcYTsFR
         xnDw==
X-Forwarded-Encrypted: i=1; AJvYcCU5s5UJ0D+nBN1gR11HhiX3GXDsizqboxR++N4blnXdLB7S12eo4BZbucxrFkrVGeXQpMRaMSGqdxhlOXE=@lists.ozlabs.org
X-Gm-Message-State: AOJu0YzfeZ7vVvaB/eqa6vePTOIrnMGMTnFHRlQHTL8Y3+XhGBt3MxqM
	0o1pnkDrWTBtH3rB9hLWhoAsoo0v01tcD3oFHgGMY0IFBo5aS2/3/m3+Qy5J4y8SCjNRX+kZ01W
	/dBhA8A9i
X-Gm-Gg: AeBDieupkxOaPNRyQbnQMj/8PkkLj5g4oFDwJn3XAzwG8B+1r1QPgSLukStuEPi73Vf
	smANzGT2DaRL6y674QCUD1itOK6eu0MpaFnH7Gbu5lNXnzE+V77Cnzv5Ik2YIy1hizMS0YzyOOy
	mKQopWPdsEBRz7jTmryGXvZgUpcgCAsZZHzoWGYEq+lfgFYtYNM8h1c7wnjyFD//CuPZu+GwPbr
	9TZxDwLufj9pagKlb7HdwPhGHgMm2E+jQgUguyXJOkIC5OWKeprWCFrYbdTpl+KzQ2+C9ZNF2y9
	JJorHMJN4kVOmk0IahaIakzHUsVlapKHYFx0FH5Sns825Vzs9bm6lA5eHR+FnZtmxC3K9A0QamI
	YP/1Irb9unnl7sVfH4dusNRuktGqkfB2wwPKgsGdKVeqPWpFj0ytkrWmC7ijZ0kqUDmuRQ9fYoL
	Jx01Z6q7rULnTrjRYtwbBwbnYaNbef969UIJB7sDYFtkaU/13UdBAukbqTJI059A==
X-Received: by 2002:a17:906:5999:b0:b9c:4fc9:87db with SMTP id a640c23a62f3a-b9c679add8cmr339133966b.30.1775429436461;
        Sun, 05 Apr 2026 15:50:36 -0700 (PDT)
Received: from mail-ed1-f48.google.com (mail-ed1-f48.google.com. [209.85.208.48])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b9c3cec6f38sm425627766b.31.2026.04.05.15.50.36
        for <linuxppc-dev@lists.ozlabs.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 05 Apr 2026 15:50:36 -0700 (PDT)
Received: by mail-ed1-f48.google.com with SMTP id 4fb4d7f45d1cf-66c17372965so6321319a12.1
        for <linuxppc-dev@lists.ozlabs.org>; Sun, 05 Apr 2026 15:50:36 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCXVZH/MkOwalUlZtuLbyeSIY/fYeYNo96n10LBYPtFCNY/4Sk4uhP97/ezbDB1ZNtRClXZMcy6kcf5sx80=@lists.ozlabs.org
X-Received: by 2002:a5d:5889:0:b0:43b:47ee:4586 with SMTP id
 ffacd0b85a97d-43d292d34e1mr14051064f8f.29.1775429026066; Sun, 05 Apr 2026
 15:43:46 -0700 (PDT)
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
References: <20260404000644.522677-1-dianders@chromium.org> <2026040539-sponge-publisher-2b42@gregkh>
In-Reply-To: <2026040539-sponge-publisher-2b42@gregkh>
From: Doug Anderson <dianders@chromium.org>
Date: Sun, 5 Apr 2026 15:43:34 -0700
X-Gmail-Original-Message-ID: <CAD=FV=X6DRHV6k7G=p5Mno22na75G-69F-EzMkisSxMoxuvJcQ@mail.gmail.com>
X-Gm-Features: AQROBzBHjVedWun0AWH98b5RajBbraAAaRvLQSenEhaNEY8p1Czch8mAczvPiQQ
Message-ID: <CAD=FV=X6DRHV6k7G=p5Mno22na75G-69F-EzMkisSxMoxuvJcQ@mail.gmail.com>
Subject: Re: [PATCH v4 0/9] driver core: Fix some race conditions
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: "Rafael J . Wysocki" <rafael@kernel.org>, Danilo Krummrich <dakr@kernel.org>, 
	Alan Stern <stern@rowland.harvard.edu>, Saravana Kannan <saravanak@kernel.org>, 
	Christoph Hellwig <hch@lst.de>, Eric Dumazet <edumazet@google.com>, Johan Hovold <johan@kernel.org>, 
	Leon Romanovsky <leon@kernel.org>, Alexander Lobakin <aleksander.lobakin@intel.com>, 
	Alexey Kardashevskiy <aik@ozlabs.ru>, Robin Murphy <robin.murphy@arm.com>, 
	Andrew Morton <akpm@linux-foundation.org>, Frank.Li@kernel.org, 
	Jason Gunthorpe <jgg@ziepe.ca>, alex@ghiti.fr, alexander.stein@ew.tq-group.com, 
	andre.przywara@arm.com, andrew@codeconstruct.com.au, andrew@lunn.ch, 
	andriy.shevchenko@linux.intel.com, aou@eecs.berkeley.edu, ardb@kernel.org, 
	bhelgaas@google.com, brgl@kernel.org, broonie@kernel.org, 
	catalin.marinas@arm.com, chleroy@kernel.org, davem@davemloft.net, 
	david@kernel.org, devicetree@vger.kernel.org, dmaengine@vger.kernel.org, 
	driver-core@lists.linux.dev, gbatra@linux.ibm.com, 
	gregory.clement@bootlin.com, hkallweit1@gmail.com, iommu@lists.linux.dev, 
	jirislaby@kernel.org, joel@jms.id.au, joro@8bytes.org, kees@kernel.org, 
	kevin.brodsky@arm.com, kuba@kernel.org, lenb@kernel.org, lgirdwood@gmail.com, 
	linux-acpi@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
	linux-aspeed@lists.ozlabs.org, linux-cxl@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-mips@vger.kernel.org, linux-mm@kvack.org, 
	linux-pci@vger.kernel.org, linux-riscv@lists.infradead.org, 
	linux-serial@vger.kernel.org, linux-snps-arc@lists.infradead.org, 
	linux-usb@vger.kernel.org, linux@armlinux.org.uk, 
	linuxppc-dev@lists.ozlabs.org, m.szyprowski@samsung.com, maddy@linux.ibm.com, 
	mani@kernel.org, maz@kernel.org, miko.lenczewski@arm.com, mpe@ellerman.id.au, 
	netdev@vger.kernel.org, npiggin@gmail.com, osalvador@suse.de, 
	oupton@kernel.org, pabeni@redhat.com, palmer@dabbelt.com, 
	peter.ujfalusi@gmail.com, peterz@infradead.org, pjw@kernel.org, 
	robh@kernel.org, sebastian.hesselbarth@gmail.com, tglx@kernel.org, 
	tsbogend@alpha.franken.de, vgupta@kernel.org, vkoul@kernel.org, 
	will@kernel.org, willy@infradead.org, yangyicong@hisilicon.com, 
	yeoreum.yun@arm.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi,

On Sat, Apr 4, 2026 at 10:28=E2=80=AFPM Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
>
> On Fri, Apr 03, 2026 at 05:04:54PM -0700, Douglas Anderson wrote:
> > NOTE: one potentially "controversial" choice I made in some patches
> > was to always reserve a flag ID even if a flag is only used under
> > certain CONFIG_ settings. This is a change from how things were
> > before. Keeping the numbering consistent and allowing easy
> > compile-testing of both CONFIG settings seemed worth it, especially
> > since it won't take up any extra space until we've added a lot more
> > flags.
>
> Nah, this is fine, I don't see any problems with this as the original
> code kind of was doing the same thing with the "hole" in the structure
> if those options were not enabled.
>
> > I only marked the first patch as a "Fix" since it is the only one
> > fixing observed problems. Other patches could be considered fixes too
> > if folks want.
> >
> > I tested the first patch in the series backported to kernel 6.6 on the
> > Pixel phone that was experiencing the race. I added extra printouts to
> > make sure that the problem was hitting / addressed. The rest of the
> > patches are tested with allmodconfig with arm32, arm64, ppc, and
> > x86. I boot tested on an arm64 Chromebook running mainline.
>
> I'm guessing your tests passed?  :)

Yup, all the tests that I've run have passed. I also threw in an
"allnoconfig" compile test just for good measure.


> Anyway, this looks great, unless there are any objections, other than
> the "needs to be undefined", which a follow-on patch can handle, I'll
> queue them up next week for 7.1-rc1.

Thanks. As per the other thread, I'm happy if you or Danilo want to
apply it, and I'm happy if you want to make minor fixups when
applying.

When I see the patches applied, I'll send a followup patch to address
the "needs to be undefined" comment, unless Danilo makes that change
himself when applying.

-Doug

