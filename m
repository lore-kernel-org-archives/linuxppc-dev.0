Return-Path: <linuxppc-dev+bounces-18737-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 58097F54ADF
	for <linuxppc-dev@archiver.kernel.org>; Tue, 24 Mar 2026 17:12:40 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4fgGnL6xmSz2yng;
	Wed, 25 Mar 2026 04:12:38 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=209.85.214.174
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1774372358;
	cv=none; b=IeWzuew+LY+I77rxXl2oXPlx+itEk/YzP5i3TZipTrxYhfzWqdWi46NaW6WLn7zEDUU3Q9Yp77jIWPmN8UTTxnvEApMlLM6RqTrVni/lg+wumBLMt9o3N2j2E877z2+6g7D9eoi9/CK2WIN5QaKJccj1mJYQ+lkq28AynHeRgvaH4lilWSWWhtAelvTRdyz0eh7NNm1B3apOwE//smjx25yj3h0boZT9ErM17fF/xEEKvdHUCvqSffar5pfDewfuLCx66FUx+GiS2GM33MiwuIgCasskRWBMz4f0h5stGo+Ler1ZYSzbdT8VS5UHykh46X9Rm/SYqtkV2FqIdoyplQ==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1774372358; c=relaxed/relaxed;
	bh=imA4hBFgRxEV6K6PxesH3aFI8Gk9es7sFYCGiASF9lc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=PM/XmBfLF11XBWbmjYO6ty/MDZY3N1SoKGkN9fuIyg3mwo8rqbUUMH79ASXkUFNIq897s8LT/Jw8MzYC2PpomECpbYEEmlTCxSyRtc7hX8mdtSHH8DGi+KlQT7tGhdwcysVXwC3N7CinIu/KXXYNkukbc/VV/jvGkuxq5mW15TKz9upRxufQi+YSf8u+/9s0ux3Bwdb1miPwlTCkNjUb/e7f5ty/jBdlY6B+W5M6bmS4cdgYOPJsMNuffoJaJhi86+lSmPYdRrzilV4zULx/c2UKBMorzHn0WaeuCdFykFZGPeJwAb/AjfnEaam88/vE3LLXZ4fQj1lY7gfgX7s6Gg==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org; spf=pass (client-ip=209.85.214.174; helo=mail-pl1-f174.google.com; envelope-from=geert.uytterhoeven@gmail.com; receiver=lists.ozlabs.org) smtp.mailfrom=gmail.com
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=gmail.com (client-ip=209.85.214.174; helo=mail-pl1-f174.google.com; envelope-from=geert.uytterhoeven@gmail.com; receiver=lists.ozlabs.org)
Received: from mail-pl1-f174.google.com (mail-pl1-f174.google.com [209.85.214.174])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4fgGnK35gJz2yhZ
	for <linuxppc-dev@lists.ozlabs.org>; Wed, 25 Mar 2026 04:12:36 +1100 (AEDT)
Received: by mail-pl1-f174.google.com with SMTP id d9443c01a7336-2a8fba3f769so26268155ad.2
        for <linuxppc-dev@lists.ozlabs.org>; Tue, 24 Mar 2026 10:12:36 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774372354; x=1774977154;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=imA4hBFgRxEV6K6PxesH3aFI8Gk9es7sFYCGiASF9lc=;
        b=FlJTkpIcPSJbBV8y1QYC01ADYJ/FDuH78lfC2aDfJs3pP7PiekbX5N9Br05oimOyxh
         JLQq/YRyEz5uop9ex2aEFT2HGpGdwrcvUXQ1Dlm+JVFFlHEecQ857GsL9ymzmp8ccGt6
         SLpjk8YD6Ebk8ei49ZnDsa9LecRNIph6y7IZ7Q5skNZDaGzEwtOx7CVsGWFkXFqbyIog
         Aou0sZKbR1wOsw9QmlA8fK0CVAVe/TsG817HrqlZrrFKseYBJDvaux8yAaPyeLQ77J7r
         wR0Nl78UTcSiuGhDTGWoVkOiwLPmAe4X7OcGOU0otIybjq71NmUJizvCNaZcFtpUmwZG
         OO7w==
X-Forwarded-Encrypted: i=1; AJvYcCU2HO0ugN7CzFfVc6GkCQ/IliBsdJ+kBwU9CTMqoFJqtQj8SKe8yJ8SqyFwiKsrm+aHmSfkQQzvwTjz/pw=@lists.ozlabs.org
X-Gm-Message-State: AOJu0YxEpUfgkBJGtp3Va7ROW6YrhEJEZp4WrRHOdngsG+6H4K+wBgNS
	792SJ3P/B72kaeuKfFzm/3ZEzIk8snMGk8aLYpXD4JGbM87qDC9DiFs5wGZwpDiXFAg=
X-Gm-Gg: ATEYQzzPjQUZMeXdLky3HAjGpQNJgULZzPdzat6CAQa2AIJGTGnUXbpVTOPt390EIG5
	pVBm5WRRCN3w4PBYRmv1c8qBEiX5rplIckyUrW5Irqu4grjwGWOOlXL5s7ZB8Aqjl+KR+Ybwg2x
	c5+j+hUb5XQOHfXu30Y8n+13uDtRfBO+dakaihMS93xjLmiiY68PNk+tG/3RMoB8GinlQQTRHet
	lxRbEg7P+vWg9tU88ByA15Jb/3EJMLvgLsX2WhbviwDchTJfQinb8vwh9dYuPbxGnp301tQsDCC
	ZEAj3nMvSVjZ6E0bVtqWTWWvb3vxD3zQFFUIeLRw2g2niPm9I2MmpFIMdsGnRspjh+Xs0g4H6Pp
	A4JA9DK8vdfZ6EoDhfmmP4y9L2NXh773OjLVpeCSKmN4q7Em/hKda599zRR4oh/e5+KpnUqJ1vQ
	8o2azDWY2yIhVC5YMcNQ4H/EB/VvxSoxP9xsN0EDfq0CucmIqdOJAnqm9tbFI=
X-Received: by 2002:a17:902:ef11:b0:2b0:7225:d2c0 with SMTP id d9443c01a7336-2b0b0af56ccmr3921315ad.30.1774372353585;
        Tue, 24 Mar 2026 10:12:33 -0700 (PDT)
Received: from mail-dl1-f42.google.com (mail-dl1-f42.google.com. [74.125.82.42])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2b083516eacsm189097645ad.15.2026.03.24.10.12.33
        for <linuxppc-dev@lists.ozlabs.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 24 Mar 2026 10:12:33 -0700 (PDT)
Received: by mail-dl1-f42.google.com with SMTP id a92af1059eb24-128ebee22caso4566271c88.0
        for <linuxppc-dev@lists.ozlabs.org>; Tue, 24 Mar 2026 10:12:33 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCVQ81y9Dv0RM3fQVeDaPcSndf/37dPvP8eMIGrCDMz3dT/V7+d7q2U/oatI0UNKA3RgtMl0vhafxFO7KYY=@lists.ozlabs.org
X-Received: by 2002:a05:6122:1da4:b0:56b:5978:22f5 with SMTP id
 71dfb90a1353d-56d220a8b85mr416671e0c.12.1774371994638; Tue, 24 Mar 2026
 10:06:34 -0700 (PDT)
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
References: <20260324165633.4583-1-ilpo.jarvinen@linux.intel.com> <20260324165633.4583-6-ilpo.jarvinen@linux.intel.com>
In-Reply-To: <20260324165633.4583-6-ilpo.jarvinen@linux.intel.com>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Tue, 24 Mar 2026 18:06:22 +0100
X-Gmail-Original-Message-ID: <CAMuHMdXX16=pih34yehj=3bJkg2H3ivGUj_34JDg31ABheLE5Q@mail.gmail.com>
X-Gm-Features: AQROBzA3vydAXwvxX7mNaSzU55R-3eBg9lznDuFtNbFYtRdYd66gsLQKONTytjo
Message-ID: <CAMuHMdXX16=pih34yehj=3bJkg2H3ivGUj_34JDg31ABheLE5Q@mail.gmail.com>
Subject: Re: [PATCH 05/10] am68k/PCI: Remove unnecessary second application of align
To: =?UTF-8?Q?Ilpo_J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Cc: linux-pci@vger.kernel.org, Bjorn Helgaas <bhelgaas@google.com>, 
	Guenter Roeck <linux@roeck-us.net>, linux-alpha@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, linux-m68k@lists.linux-m68k.org, 
	linux-mips@vger.kernel.org, linux-parisc@vger.kernel.org, 
	linuxppc-dev@lists.ozlabs.org, linux-s390@vger.kernel.org, 
	linux-sh@vger.kernel.org, Russell King <linux@armlinux.org.uk>, 
	Thomas Bogendoerfer <tsbogend@alpha.franken.de>, 
	"James E.J. Bottomley" <James.Bottomley@hansenpartnership.com>, Helge Deller <deller@gmx.de>, 
	Michael Ellerman <mpe@ellerman.id.au>, Thomas Gleixner <tglx@kernel.org>, Ingo Molnar <mingo@redhat.com>, 
	Borislav Petkov <bp@alien8.de>, Dave Hansen <dave.hansen@linux.intel.com>, 
	"H. Peter Anvin" <hpa@zytor.com>, Chris Zankel <chris@zankel.net>, Max Filippov <jcmvbkbc@gmail.com>, 
	Madhavan Srinivasan <maddy@linux.ibm.com>, Yoshinori Sato <ysato@users.sourceforge.jp>, 
	Rich Felker <dalias@libc.org>, John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>, 
	linux-kernel@vger.kernel.org, Greg Ungerer <gerg@linux-m68k.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

CC gerg

On Tue, 24 Mar 2026 at 17:59, Ilpo J=C3=A4rvinen
<ilpo.jarvinen@linux.intel.com> wrote:
>
> Aligning res->start by align inside pcibios_align_resource() is
> unnecessary because caller of pcibios_align_resource() is
> __find_resource_space() that aligns res->start with align before
> calling pcibios_align_resource().
>
> Aligning by align in case of IORESOURCE_IO && start & 0x300 cannot ever
> result in changing start either because 0x300 bits would have not
> survived the earlier alignment if align was large enough to have an
> impact.
>
> Thus, remove the duplicated aligning from pcibios_align_resource().
>
> Signed-off-by: Ilpo J=C3=A4rvinen <ilpo.jarvinen@linux.intel.com>
> ---
>  arch/m68k/kernel/pcibios.c | 2 --
>  1 file changed, 2 deletions(-)
>
> diff --git a/arch/m68k/kernel/pcibios.c b/arch/m68k/kernel/pcibios.c
> index 1415f6e4e5ce..7e286ee1976b 100644
> --- a/arch/m68k/kernel/pcibios.c
> +++ b/arch/m68k/kernel/pcibios.c
> @@ -36,8 +36,6 @@ resource_size_t pcibios_align_resource(void *data, cons=
t struct resource *res,
>         if ((res->flags & IORESOURCE_IO) && (start & 0x300))
>                 start =3D (start + 0x3ff) & ~0x3ff;
>
> -       start =3D (start + align - 1) & ~(align - 1);
> -
>         return start;
>  }
>
> --
> 2.39.5

