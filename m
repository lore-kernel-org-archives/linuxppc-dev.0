Return-Path: <timur@freescale.com>
Received: from ozlabs.org (ozlabs.org [203.10.76.45])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mx.ozlabs.org",
	Issuer "CA Cert Signing Authority" (verified OK))
	by bilbo.ozlabs.org (Postfix) with ESMTPS id 76A51B7100
	for <linuxppc-dev@lists.ozlabs.org>;
	Thu,  2 Jul 2009 07:14:12 +1000 (EST)
Received: from az33egw02.freescale.net (az33egw02.freescale.net
	[192.88.158.103])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "az33egw02.freescale.net",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id 08357DDD1B
	for <linuxppc-dev@ozlabs.org>; Thu,  2 Jul 2009 07:14:10 +1000 (EST)
Message-ID: <4A4BD187.8000605@freescale.com>
Date: Wed, 01 Jul 2009 16:13:43 -0500
From: Timur Tabi <timur@freescale.com>
MIME-Version: 1.0
To: avorontsov@ru.mvista.com
Subject: Re: [PATCH] powerpc: Don't use alloc_bootmem() in init_IRQ() path
References: <20090701230831.3828e0bf@power-debian>
	<20090701194819.GB20522@ovro.caltech.edu>
	<20090701205957.GA9583@oksana.dev.rtsoft.ru>
In-Reply-To: <20090701205957.GA9583@oksana.dev.rtsoft.ru>
Content-Type: text/plain; charset=ISO-8859-1
Cc: Arnd Bergmann <arnd@arndb.de>, Ira Snyder <iws@ovro.caltech.edu>,
	linuxppc-dev@ozlabs.org, Andrey Gusev <a.gusev1980@mail.ru>,
	Geert Uytterhoeven <Geert.Uytterhoeven@sonycom.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Anton Vorontsov wrote:

> diff --git a/arch/powerpc/sysdev/qe_lib/qe_ic.c b/arch/powerpc/sysdev/qe_lib/qe_ic.c
> index 63cdf98..074905c 100644
> --- a/arch/powerpc/sysdev/qe_lib/qe_ic.c
> +++ b/arch/powerpc/sysdev/qe_lib/qe_ic.c
> @@ -333,12 +333,10 @@ void __init qe_ic_init(struct device_node *node, unsigned int flags,
>  	if (ret)
>  		return;
>  
> -	qe_ic = alloc_bootmem(sizeof(struct qe_ic));
> +	qe_ic = kzalloc(sizeof(*qe_ic), GFP_KERNEL);

This function is called during init_IRQ() in main.c.  Looking at the code, I don't see any earlier calls to kzalloc().  Are you sure this is supposed to work?

-- 
Timur Tabi
Linux kernel developer at Freescale
