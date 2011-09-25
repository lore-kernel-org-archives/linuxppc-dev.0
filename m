Return-Path: <B04825@freescale.com>
Received: from VA3EHSOBE009.bigfish.com (va3ehsobe006.messaging.microsoft.com
	[216.32.180.16]) (using TLSv1 with cipher AES128-SHA (128/128 bits))
	(Client CN "mail.global.frontbridge.com",
	Issuer "Microsoft Secure Server Authority" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id 46C45B6F68
	for <linuxppc-dev@lists.ozlabs.org>;
	Mon, 26 Sep 2011 03:06:36 +1000 (EST)
From: Tabi Timur-B04825 <B04825@freescale.com>
To: Anatolij Gustschin <agust@denx.de>
Subject: Re: [PATCH] powerpc/85xx: fix PHYS_64BIT selection for P1022DS
Date: Sun, 25 Sep 2011 17:06:20 +0000
Message-ID: <CAOZdJXXw-YMFG4vVbYQKOtDYHtriaXe-=sz6YBivFXbp=mH2PQ@mail.gmail.com>
References: <1316806370-21067-1-git-send-email-agust@denx.de>
In-Reply-To: <1316806370-21067-1-git-send-email-agust@denx.de>
Content-Type: text/plain; charset="iso-8859-1"
MIME-Version: 1.0
Cc: "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Fri, Sep 23, 2011 at 2:32 PM, Anatolij Gustschin <agust@denx.de> wrote:

> diff --git a/arch/powerpc/platforms/85xx/Kconfig b/arch/powerpc/platforms=
/85xx/Kconfig
> index 1b393f4..b29d4f2 100644
> --- a/arch/powerpc/platforms/85xx/Kconfig
> +++ b/arch/powerpc/platforms/85xx/Kconfig
> @@ -80,7 +80,7 @@ config P1010_RDB
> =A0config P1022_DS
> =A0 =A0 =A0 =A0bool "Freescale P1022 DS"
> =A0 =A0 =A0 =A0select DEFAULT_UIMAGE
> - =A0 =A0 =A0 select CONFIG_PHYS_64BIT =A0 =A0 =A0 =A0# The DTS has 36-bi=
t addresses
> + =A0 =A0 =A0 select PHYS_64BIT =A0 =A0 =A0 # The DTS has 36-bit addresse=
s

I have no idea how this happened, but I wonder if it's a good idea.
On the Freescale BSP, the default config for the P1022DS is 32-bit,
not 36-bit, so one day we might have a 32-bit config in the upstream
repository.

PHYS_64BIT is already covered by the defconfig.  I wonder if we should
just delete the bad line, and let the defconfig select the address
size.

--=20
Timur Tabi
Linux kernel developer at Freescale=
