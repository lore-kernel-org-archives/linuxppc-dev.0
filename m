Return-Path: <vitalywool@gmail.com>
Received: from mail-ew0-f216.google.com (mail-ew0-f216.google.com
	[209.85.219.216]) by ozlabs.org (Postfix) with ESMTP id 3311EB7D92
	for <linuxppc-dev@lists.ozlabs.org>;
	Wed, 12 May 2010 02:02:24 +1000 (EST)
Received: by ewy8 with SMTP id 8so1366760ewy.8
	for <linuxppc-dev@lists.ozlabs.org>;
	Tue, 11 May 2010 09:02:22 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20100511154108.11546.12066.stgit@muvarov>
References: <20100511154108.11546.12066.stgit@muvarov>
Date: Tue, 11 May 2010 18:02:21 +0200
Message-ID: <AANLkTinTprEzXRIFeJfu6TEvPqj24UBjrrZN3MtZD6LH@mail.gmail.com>
Subject: Re: [PATCH] [POWEPC] crashdump: do not fail on null pointer
	dereferencing
From: Vitaly Wool <vitalywool@gmail.com>
To: Maxim Uvarov <muvarov@gmail.com>
Content-Type: text/plain; charset=ISO-8859-1
Cc: uvarov@dev.rtsoft.ru, linuxppc-dev@lists.ozlabs.org,
	linux-kernel@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Hi,

> diff --git a/arch/powerpc/kernel/crash.c b/arch/powerpc/kernel/crash.c
> index 6f4613d..341d8af 100644
> --- a/arch/powerpc/kernel/crash.c
> +++ b/arch/powerpc/kernel/crash.c
> @@ -375,6 +375,9 @@ void default_machine_crash_shutdown(struct pt_regs *r=
egs)
> =A0 =A0 =A0 =A0for_each_irq(i) {
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0struct irq_desc *desc =3D irq_to_desc(i);
>
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (!desc || !desc->chip || !desc->chip->eo=
i)
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 continue;
> +

Kinda unlikely that desc can be NULL here :)

~Vitaly
