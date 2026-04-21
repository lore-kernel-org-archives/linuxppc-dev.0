Return-Path: <linuxppc-dev+bounces-19879-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1A41AF8FA65
	for <linuxppc-dev@archiver.kernel.org>; Tue, 21 Apr 2026 11:57:55 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4g0LTF34Jvz2ytx;
	Tue, 21 Apr 2026 21:57:53 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=209.85.221.180
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1776772673;
	cv=none; b=lmsLO20/esWdykEgkmZnIxeTLiKIIjJnLoFQZYk1mPKStVRJ1+0EJlevz53WuPYHDSqa181bfGIqMoMuxz1pJRhQiqGG4FbbrGXr+qfBkpmz+axkJMl0eTsx4HC14OEKYmSzjCp81ZRXOIlBTXnMArY1HQAC0hYRO/lCZIEs9cEGJc6ROXjn6ctn4X7i+qdmp8KidZuRF/waOSGajBieZgJHLEFud7/CPLPcbiIeM2cXH6dYzHxc87dsKanbclZB1MNLgrUFjDYRQ7/0STKGI7ccASo4uZMzSE4LtgLDiqYQwlIcNtNcRPclqIB/is1FWMih04jKixpFWGZSt/UBEg==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1776772673; c=relaxed/relaxed;
	bh=+Ji5jUeRQ9s6IdrcvkqpKzzaDEFKSxwSRUCTUPQc2w4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=coTHqKZpzvonTa2a/yRMW9RnBviO1juGODxOJLZOGM1bYGkazAzbynrWtaPzWsB75ahQqu+7y1Iw5r+SAn0bZqfvaPEAzpENLTWmKsC2jCxSAdbfK6Nu1PFlg+WWrBdmzuuYTBFC61wjkS55QZnNGb2lM3V2f8Hr/aH+RVXIGn3CEsGwUceVWjZ79iCtodzU/WYNychwAL+An7c9hjtFW+HNs6umaN7mXQqCuqn3+yBhCcLjrGr9Qzd4ilNR5kdR4MjJxkNAzMBeCRX7HeZhDsd7liEbePNK5LCxJcpSwl5U7Gc2zvvwp6WSUT+6bilAn1xQX1A0hrDrGHWWfvsJWw==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org; spf=pass (client-ip=209.85.221.180; helo=mail-vk1-f180.google.com; envelope-from=geert.uytterhoeven@gmail.com; receiver=lists.ozlabs.org) smtp.mailfrom=gmail.com
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=gmail.com (client-ip=209.85.221.180; helo=mail-vk1-f180.google.com; envelope-from=geert.uytterhoeven@gmail.com; receiver=lists.ozlabs.org)
Received: from mail-vk1-f180.google.com (mail-vk1-f180.google.com [209.85.221.180])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4g0LTD08VKz2ySW
	for <linuxppc-dev@lists.ozlabs.org>; Tue, 21 Apr 2026 21:57:50 +1000 (AEST)
Received: by mail-vk1-f180.google.com with SMTP id 71dfb90a1353d-56d8d479149so1409177e0c.2
        for <linuxppc-dev@lists.ozlabs.org>; Tue, 21 Apr 2026 04:57:50 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776772667; x=1777377467;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+Ji5jUeRQ9s6IdrcvkqpKzzaDEFKSxwSRUCTUPQc2w4=;
        b=jRmjOtsQj4TZQDaJS/gAyNt+11A8kj7aScHaWN/nQOgRVQ64BSLMvzJPS5H0BxwN+Z
         MXUJHo+qSWNv8GsJOAzwDWNDRb6Gv9KQkuIsKX/6qsbNytoLJKnB9gdqaK2JdYDqgzUY
         OSu8pLCpoAOCY+iKT4lz+z4NOhiq8a06FTKZKqlwCacj8kKbR86f8Bf+zcEwkKpoJiQt
         8FQ5GsN3W5z+R+PPVYSF3F3vjxo7ayIhtJpgoa08te3whbHmrdvbCaC4fMlnnbp5ixDd
         0Qtrt1ss/p8nvVlFy0CxZxVi5ZPd89aMeNIIO0Q+ycbk8L4FvgmOEKQ+njMPjIKlCvo0
         5LVg==
X-Forwarded-Encrypted: i=1; AFNElJ9sl9YD/beAfT/Ntu3HTj7CqGe0llEw12eOIvAT7ay3zid7GfK4I55YfL88+2aDUarf49UnXdkTiStvCv0=@lists.ozlabs.org
X-Gm-Message-State: AOJu0YzEhDZoKq71ZCR/Lu0lqnXr7xPg74597VCpvZNNHswqsWraFHIb
	fbLf9EtUFq+hMqIxIrFyxSUBnlBxiskG6SiU9MJr/UN087KE+yGA/0AhgL6oSmt2cRY=
X-Gm-Gg: AeBDieswM0rhPSqJeTtQYjuYYuP7OwOAVad1NnbWrAfouHkoH6X0Y+i9Ex/Oxpyfh5C
	PooU9le9JZRqtRxdDaNopHzskrYtQm6bF5YUFAiDCyk0FP01zzsZxVWcJ8l6r3TFAmjgK3BCG0s
	WNlBtdOhr0E1YDvVn0sLjYP1u9AydDNSRnzcwIaYkLecSL2uRP9+0ix+0rQc5pq/EOowPr2z4gO
	vYewqcQgt1k6wzcw9qQsBELsFLjKaL0nFT1dDGTfmIN0LET4CUI/xDVBFtvjsO0jD9rdnF0va2Q
	gRoaUJafBdxlC6hjSzI+RzV9IWeijNly9mhvyP4Xq0QKM5B4V7RZKQ9iSUgOh+QUu7kAfxXo+hJ
	Zw2TGDDfz6DW5j/+uQEKmRtUxhYqfUSQ0//kYKpsoqBFzNq4PjCDbkRX5czVRpX7sVFNIt9aiCW
	qPA9APUOmz+G0GnVxNga3LWGLKiAlGrBoBu03wV+gWleZlKQ6limsJtg3M6arRVPBuUsPjazQ=
X-Received: by 2002:a05:6122:83d3:b0:56f:2609:cd95 with SMTP id 71dfb90a1353d-56fa595340cmr7884241e0c.9.1776772666920;
        Tue, 21 Apr 2026 04:57:46 -0700 (PDT)
Received: from mail-ua1-f47.google.com (mail-ua1-f47.google.com. [209.85.222.47])
        by smtp.gmail.com with ESMTPSA id 71dfb90a1353d-56fa92f2207sm7600794e0c.10.2026.04.21.04.57.46
        for <linuxppc-dev@lists.ozlabs.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 21 Apr 2026 04:57:46 -0700 (PDT)
Received: by mail-ua1-f47.google.com with SMTP id a1e0cc1a2514c-9569825dc57so522897241.2
        for <linuxppc-dev@lists.ozlabs.org>; Tue, 21 Apr 2026 04:57:46 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AFNElJ8cYQ7DWvBAjeYu7XmfewCLmtj/BT07zoPAWTOdJIlDpt1TRVjgzn+MfXAGzT5/CeFhx+aL+5q7zKSnJAo=@lists.ozlabs.org
X-Received: by 2002:a05:6102:f8b:b0:601:f386:9ed2 with SMTP id
 ada2fe7eead31-616f4d67f72mr7641295137.7.1776772665998; Tue, 21 Apr 2026
 04:57:45 -0700 (PDT)
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
References: <20260421021943.1295109-1-kuba@kernel.org> <c7506c225ce22a71c03abc2673823cf84bbb5b0d.camel@infradead.org>
 <aedkZ5bizasuBPI8@gondor.apana.org.au>
In-Reply-To: <aedkZ5bizasuBPI8@gondor.apana.org.au>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Tue, 21 Apr 2026 13:57:34 +0200
X-Gmail-Original-Message-ID: <CAMuHMdU96F_42faeqNzDwaXks7mFrLrkPSJB_QTwxEn9HmVWpQ@mail.gmail.com>
X-Gm-Features: AQROBzAVi0Fh-UpifM1LaPGNEDH0ax6I6xOmcEB0yUP_KKo8UOyxGmDNb2nIMYw
Message-ID: <CAMuHMdU96F_42faeqNzDwaXks7mFrLrkPSJB_QTwxEn9HmVWpQ@mail.gmail.com>
Subject: Re: [PATCH net-deletions] net: remove unused ATM protocols and legacy
 ATM device drivers
To: Herbert Xu <herbert@gondor.apana.org.au>
Cc: David Woodhouse <dwmw2@infradead.org>, Jakub Kicinski <kuba@kernel.org>, davem@davemloft.net, 
	netdev@vger.kernel.org, edumazet@google.com, pabeni@redhat.com, 
	andrew+netdev@lunn.ch, horms@kernel.org, corbet@lwn.net, 
	skhan@linuxfoundation.org, linux@armlinux.org.uk, tsbogend@alpha.franken.de, 
	maddy@linux.ibm.com, mpe@ellerman.id.au, npiggin@gmail.com, 
	chleroy@kernel.org, 3chas3@gmail.com, razor@blackwall.org, idosch@nvidia.com, 
	jani.nikula@intel.com, mchehab+huawei@kernel.org, tytso@mit.edu, 
	ebiggers@kernel.org, johannes.berg@intel.com, jonathan.cameron@huawei.com, 
	kees@kernel.org, kuniyu@google.com, fourier.thomas@gmail.com, 
	andriy.shevchenko@intel.com, rdunlap@infradead.org, akpm@linux-foundation.org, 
	linux-doc@vger.kernel.org, linux-mips@vger.kernel.org, 
	linuxppc-dev@lists.ozlabs.org, bridge@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"

Hi Herbert,

On Tue, 21 Apr 2026 at 13:51, Herbert Xu <herbert@gondor.apana.org.au> wrote:
> On Tue, Apr 21, 2026 at 10:26:18AM +0100, David Woodhouse wrote:
> > I suspect they don't have a huge amount of interest in the Solos any
> > more, or the Geode-based SBC they sold with two of them on-board. But
> > OpenWrt does still support them, and I even have one here (although no
> > ADSL line to test it with). They were briefly popular as fully Linux-
> > supported ADSL routers.
>
> ADSL is history, it only ever made sense in rich countries where
> physical copper cables were pre-installed in homes.  While rich
> countries have moved to fibre, the rest of the world won't use
> ADSL either because there is no copper cable to begin with.  So
> it's actually cheaper to just lay a fibre cable for a new install.

I am afraid the move to fibre hasn't been completed yet.
ADSL (VDSL2?) is still being used.

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds

