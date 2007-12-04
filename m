Return-Path: <arnd@arndb.de>
Received: from moutng.kundenserver.de (moutng.kundenserver.de
	[212.227.126.174]) by ozlabs.org (Postfix) with ESMTP id 989BEDDE11
	for <linuxppc-dev@ozlabs.org>; Wed,  5 Dec 2007 00:11:13 +1100 (EST)
From: Arnd Bergmann <arnd@arndb.de>
To: linuxppc-dev@ozlabs.org
Subject: Re: [PATCH 1/3] cell: fix undefined reference to mmio_nvram_init
Date: Tue, 4 Dec 2007 14:10:42 +0100
References: <20071204.173453.-1300514021.kouish@swc.toshiba.co.jp>
In-Reply-To: <20071204.173453.-1300514021.kouish@swc.toshiba.co.jp>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Message-Id: <200712041410.43736.arnd@arndb.de>
Cc: paulus@samba.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Tuesday 04 December 2007, Ishizaki Kou wrote:
>=20
> +#ifdef CONFIG_MMIO_NVRAM
> =A0=A0=A0=A0=A0=A0=A0=A0mmio_nvram_init();
> +#endif
> =A0}

The patch is technically correct, but the preferred way of doing this is
to define a conditional inline function in the header, like:

#ifdef CONFIG_MMIO_NVRAM
extern int mmio_nvram_init(void);
#else
static inline int mmio_nvram_init(void)
{
	return 0;
}
#endif

so that the caller does not need to know about it.

	Arnd <><
