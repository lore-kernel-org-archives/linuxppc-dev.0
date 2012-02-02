Return-Path: <paul.gortmaker@gmail.com>
Received: from mail-gy0-f179.google.com (mail-gy0-f179.google.com
 [209.85.160.179])
 (using TLSv1 with cipher ECDHE-RSA-RC4-SHA (128/128 bits))
 (Client CN "smtp.gmail.com", Issuer "Google Internet Authority" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 3F688104796
 for <linuxppc-dev@lists.ozlabs.org>; Fri,  3 Feb 2012 04:56:41 +1100 (EST)
Received: by ghbg19 with SMTP id g19so1346149ghb.38
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 02 Feb 2012 09:56:38 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <1327117828-27085-1-git-send-email-paul.gortmaker@windriver.com>
References: <1327117828-27085-1-git-send-email-paul.gortmaker@windriver.com>
Date: Thu, 2 Feb 2012 12:56:38 -0500
Message-ID: <CAP=VYLrPMwfEe09uW0=4NKNDPHkNEFcGjGBfDVa_rEFT3kMkZw@mail.gmail.com>
Subject: Re: [PATCH] powerpc: dont include 8250 pre-setup if 8250 driver isn't
 enabled.
From: Paul Gortmaker <paul.gortmaker@gmail.com>
To: benh@kernel.crashing.org, paulus@samba.org
Content-Type: text/plain; charset=ISO-8859-1
Cc: Paul Gortmaker <paul.gortmaker@windriver.com>,
 linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Fri, Jan 20, 2012 at 10:50 PM, Paul Gortmaker
<paul.gortmaker@windriver.com> wrote:
> The legacy_serial code was setting things up based on the assumption
> that the main 8250 driver would be loaded shortly after. =A0But some
> randconfigs exposed an issue where early debug (UDB) UART support was
> enabled, yet the core UART 8250 support was disabled.

Hi Ben,

Can you mark this in patchworks as Superseded?  It is at:

http://patchwork.ozlabs.org/patch/137142/

You fixed it independently with this:

http://git.kernel.org/?p=3Dlinux/kernel/git/benh/powerpc.git;a=3Dcommit;h=
=3D3493c85366ba09c9d0972c919e7123367a39982a

Thanks,
Paul.


>
> In theory a person could care about _really_ early UART output for
> early debug, but not care about generic console output via UART on
> embedded devices, so fix things so it is a valid combination.
>
> While this might seem like a pointless randconfig change, there are
> some existing default configs that actually reflect the above setup.
>
> Signed-off-by: Paul Gortmaker <paul.gortmaker@windriver.com>
>
> diff --git a/arch/powerpc/kernel/legacy_serial.c b/arch/powerpc/kernel/le=
gacy_serial.c
> index 3fea368..9a82a49 100644
> --- a/arch/powerpc/kernel/legacy_serial.c
> +++ b/arch/powerpc/kernel/legacy_serial.c
> @@ -413,6 +413,14 @@ void __init find_legacy_serial_ports(void)
> =A0 =A0 =A0 =A0DBG(" <- find_legacy_serial_port()\n");
> =A0}
>
> +/*
> + * In theory, one could have the early debugging enabled, but yet not ca=
re
> + * about 8250 after that, i.e. PPC_UDBG_16550=3Dy but "SERIAL_8250 is no=
t set".
> + * Mostly appears in randconfig builds, but some defconfigs have this.
> + */
> +
> +#ifdef CONFIG_SERIAL_8250
> +
> =A0static struct platform_device serial_device =3D {
> =A0 =A0 =A0 =A0.name =A0 =3D "serial8250",
> =A0 =A0 =A0 =A0.id =A0 =A0 =3D PLAT8250_DEV_PLATFORM,
> @@ -523,6 +531,7 @@ static int __init serial_dev_init(void)
> =A0}
> =A0device_initcall(serial_dev_init);
>
> +#endif /* CONFIG_SERIAL_8250 */
>
> =A0#ifdef CONFIG_SERIAL_8250_CONSOLE
> =A0/*
> --
> 1.7.7.2
>
> _______________________________________________
> Linuxppc-dev mailing list
> Linuxppc-dev@lists.ozlabs.org
> https://lists.ozlabs.org/listinfo/linuxppc-dev
