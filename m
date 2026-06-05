Return-Path: <linuxppc-dev+bounces-22108-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5FD6BCD6E74
	for <linuxppc-dev@archiver.kernel.org>; Fri,  5 Jun 2026 07:30:54 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4gWtQN5RZ8z2yR5;
	Fri, 05 Jun 2026 17:30:52 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=209.85.221.175
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1780644652;
	cv=none; b=ff8lQUTZpXg/xtced2+5Q9YgAtCLgSPkZ1lOKJHL5CuI9aE+g4Kut79jecwz3tq/A2xubydGVUqihp+k+e32wNr//Bu4UHEsMtcHz+ttiTLP5f7Cw/XUD5qPKR6fqElkwoPiPkBUm3XJP9ASl6IieGwzaTEJypVk5v9ofFwTZFnjb4MBi3N1gw9aqJScCzgwjEXfZ8PWLHssQ6FP/cZW/cmkKB7w2tUByJ0Om4MRLLTsqAoxX350sBC9ABPkArTse3N6+lUy1GIZobxtPvRc11VwHgmj5+EeQVVgPNkm03yKD5YacIbG0RROAk04vWudmy+Fg1vCrx7SsuB9w3J3ZA==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1780644652; c=relaxed/relaxed;
	bh=JJPTFXFfEVfaClOO5icEXfzsJcEhxZLVJwj7hX3l3SM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=oy0EwfmY/hashUW+IGHi7yiZv9ZOQnBvP8wAvpzyAK5b9eVorP5HT3NHUYPq2mJLM7Mgd0ByNcCgcXwW4wAMYJ+jQDDe7TWwGnYqwrEbZh6vYDjx5gkWJ/rmZOhQnY5+c1N/HdYEDUFnFZfcvAU2GioEC2wo+VbM1deh+qXbusTACHHvzJJ3ofrOaxrrFT7XEctHpgNHWpvWQGR7E/TXloxcKOF/QYyBzS00ZzvdaHyWIMvkJ9WXxf5EG/ZvH6QhHwzNdmQ52z6RGexmE/Y2WgY6yRqmS/Fh0xjCxvCrqNDaSomqgcPQNlq6AdSbNZm70BKcq3rb2WXc8XgGtmZxIQ==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org; spf=pass (client-ip=209.85.221.175; helo=mail-vk1-f175.google.com; envelope-from=geert.uytterhoeven@gmail.com; receiver=lists.ozlabs.org) smtp.mailfrom=gmail.com
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=gmail.com (client-ip=209.85.221.175; helo=mail-vk1-f175.google.com; envelope-from=geert.uytterhoeven@gmail.com; receiver=lists.ozlabs.org)
Received: from mail-vk1-f175.google.com (mail-vk1-f175.google.com [209.85.221.175])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4gWtQM1Yfyz2xnK
	for <linuxppc-dev@lists.ozlabs.org>; Fri, 05 Jun 2026 17:30:50 +1000 (AEST)
Received: by mail-vk1-f175.google.com with SMTP id 71dfb90a1353d-5873983d19eso1541599e0c.2
        for <linuxppc-dev@lists.ozlabs.org>; Fri, 05 Jun 2026 00:30:50 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780644647; x=1781249447;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=JJPTFXFfEVfaClOO5icEXfzsJcEhxZLVJwj7hX3l3SM=;
        b=ivJvCy4SFAPTitAxhIXVoCtMQKoc45jR68rjTOSG7pYNF4RkDK3HE2hUTCOlo/udOa
         GkRZ1oV6AFSC4MyDSY7BzABJekXiqt3m8nbhA2BGfDTJVuL6GhTFrOlueGkgmRMBGsbw
         j100mz3gQaDiyQGTC93r+TuoEqte+OVWatYf2yccWxL9LPby44Vp8+Hu9Tnyi278fXVG
         4sYHOblcpvJiLHZIrKKJPgl3Cbv95bGclsm7b6E+aupwzkEm/avBQMdkwA+myW64ted8
         aEdd6jXYvyk46lL0ontvRVD4glyxJBWQZGG7/SscqncIUuiunDxne03xOBSkaEUUtkGD
         tGjg==
X-Forwarded-Encrypted: i=1; AFNElJ8/rMl8WUMbu3LpQXYAKqCIu5VuFgIXmiiB25WNYxodG5HhbP0mTDV8ByOFA/ojuaSIqcSFyj59mQkfTvY=@lists.ozlabs.org
X-Gm-Message-State: AOJu0YzPb++vm4Z+luL9M2AJ/ilDNdZt3m87JlrAvnl/So4roXUJa1c7
	JQEsUAADvTs/05PP0lew8LZdxHXLNarye/yaNKbjeWk6QzdLwv5XB66ssIdIa4I0i0o=
X-Gm-Gg: Acq92OH9j54ilWnKFySc5ALN4Q4Zm1Oty+lWH4tsPRfC8x30y8hCL1OrWZvY2mY9oMf
	tfcFb6NaSOjlV4PhiuUS8jp+9L7a2IIRkYADvuVQ9X79XPOSbuEJgSNXY8jhhTOy8s0lA+9IMC5
	nDTGkPrVeExAk7sObOxfxQbblxETL+ZpQyc6T5VnW+HtC/rFpcK3zWpUav9D08236HCrFTU5NjI
	XGuKm35Z8u7xW4Q9O1BjrJ0u7IpyjtmJ5zhyUSMtnga9uK1yUDMXznVNfKXU2+bJlg3y1O01upK
	1SygkIfV7OjdLYnbfPIsvhyhKKSWfM1jxnZY1zeEMzwjBvIagb48QxnkXc0agsEr+GVWujRU254
	SayY7MGBJhEa1oIFqwCxBzcZTuUAdmbHalSt6lDAa/LA4N57lrBvatj3xqRXiOsGXTmxXcQgT8x
	Uau/8jKyzhfRWI5r7jAJ/uzSsSWYfzkI7CCcXOf4OVnN68rlsircgO3/gcOKPjGI6ijOp6Td0=
X-Received: by 2002:a05:6122:1d4d:b0:5a3:da51:daa3 with SMTP id 71dfb90a1353d-5ac4ea998f5mr1205203e0c.1.1780644647315;
        Fri, 05 Jun 2026 00:30:47 -0700 (PDT)
Received: from mail-ua1-f44.google.com (mail-ua1-f44.google.com. [209.85.222.44])
        by smtp.gmail.com with ESMTPSA id 71dfb90a1353d-5a6d6fb9ca0sm7959323e0c.6.2026.06.05.00.30.46
        for <linuxppc-dev@lists.ozlabs.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 05 Jun 2026 00:30:46 -0700 (PDT)
Received: by mail-ua1-f44.google.com with SMTP id a1e0cc1a2514c-963a7e48493so1199822241.1
        for <linuxppc-dev@lists.ozlabs.org>; Fri, 05 Jun 2026 00:30:46 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AFNElJ8UHqakIIHwYnlffb0dDrcSWdt9b3VeLlaZQXtnFR2htKLUAPndlXyzBITdyaNYHYJuogVRQdEYcEEY6gQ=@lists.ozlabs.org
X-Received: by 2002:a05:6102:cc8:b0:62f:3abe:907f with SMTP id
 ada2fe7eead31-6feed1adbffmr1189675137.4.1780644646130; Fri, 05 Jun 2026
 00:30:46 -0700 (PDT)
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
References: <20260604-remove-pktcdvd-references-v3-0-e2f06fb4eef4@gmail.com>
 <20260604-remove-pktcdvd-references-v3-1-e2f06fb4eef4@gmail.com> <88d9bb41-e51d-4b71-a6d9-f1b79eccd496@acm.org>
In-Reply-To: <88d9bb41-e51d-4b71-a6d9-f1b79eccd496@acm.org>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Fri, 5 Jun 2026 09:30:35 +0200
X-Gmail-Original-Message-ID: <CAMuHMdVhjYBhKUPzx-FAKWAAkUwcpYh0v2V5w64OMJtREZr4PQ@mail.gmail.com>
X-Gm-Features: AVVi8CdzPUN0PjO13sCwZaAxIjLcvwA5tXzyJ1zGjjn5YbgvhAb6LM_UbfPQhv4
Message-ID: <CAMuHMdVhjYBhKUPzx-FAKWAAkUwcpYh0v2V5w64OMJtREZr4PQ@mail.gmail.com>
Subject: Re: [PATCH v3 1/6] scsi: core: Remove remaining reference to the
 pktcdvd driver
To: Bart Van Assche <bvanassche@acm.org>
Cc: Catalin Iacob <iacobcatalin@gmail.com>, Thomas Bogendoerfer <tsbogend@alpha.franken.de>, 
	Madhavan Srinivasan <maddy@linux.ibm.com>, Michael Ellerman <mpe@ellerman.id.au>, 
	Nicholas Piggin <npiggin@gmail.com>, "Christophe Leroy (CS GROUP)" <chleroy@kernel.org>, Rich Felker <dalias@libc.org>, 
	John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>, "David S. Miller" <davem@davemloft.net>, 
	Andreas Larsson <andreas@gaisler.com>, 
	"James E.J. Bottomley" <James.Bottomley@hansenpartnership.com>, 
	"Martin K. Petersen" <martin.petersen@oracle.com>, Jens Axboe <axboe@kernel.dk>, 
	Yoshinori Sato <ysato@users.sourceforge.jp>, linux-mips@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org, 
	linux-sh@vger.kernel.org, sparclinux@vger.kernel.org, 
	linux-scsi@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Hoi Bart,

On Thu, 4 Jun 2026 at 18:01, Bart Van Assche <bvanassche@acm.org> wrote:
> On 6/4/26 6:20 AM, Catalin Iacob wrote:
> > Commit 1cea5180f2f8 ("block: remove pktcdvd driver") left behind an
> > export that is now dead code. Remove it.
> The subject should say something like "Unexport
> scsi_device_from_queue()".

<pedantic>
But that is not what it does: the symbol is never exported, as
CONFIG_CDROM_PKTCDVD_MODULE can never be set?
</pedantic>

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds

