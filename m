Return-Path: <avorontsov@ru.mvista.com>
Received: from buildserver.ru.mvista.com (unknown [85.21.88.6])
	by ozlabs.org (Postfix) with ESMTP id 7B0F8DDFE7
	for <linuxppc-dev@ozlabs.org>; Thu, 20 Dec 2007 08:10:39 +1100 (EST)
Date: Thu, 20 Dec 2007 00:12:50 +0300
From: Anton Vorontsov <avorontsov@ru.mvista.com>
To: Timur Tabi <timur@freescale.com>
Subject: Re: [PATCH 4/4] [POWERPC] fsl_spi_init and users: stop using
	device_type = "spi"
Message-ID: <20071219211250.GA21416@localhost.localdomain>
References: <20071219203447.GA18285@localhost.localdomain>
	<20071219203817.GD20861@localhost.localdomain>
	<47698773.1010004@freescale.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf8
In-Reply-To: <47698773.1010004@freescale.com>
Cc: linuxppc-dev@ozlabs.org
Reply-To: avorontsov@ru.mvista.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Wed, Dec 19, 2007 at 03:04:51PM -0600, Timur Tabi wrote:
> Anton Vorontsov wrote:
> 
> >diff --git a/arch/powerpc/sysdev/fsl_soc.c b/arch/powerpc/sysdev/fsl_soc.c
> >index 3cf84d0..91bac51 100644
> >--- a/arch/powerpc/sysdev/fsl_soc.c
> >+++ b/arch/powerpc/sysdev/fsl_soc.c
> >@@ -1242,7 +1242,7 @@ int __init fsl_spi_init(struct spi_board_info 
> >*board_infos,
> > 	}
> > 
> > 	for (np = NULL, i = 1;
> >-	     (np = of_find_compatible_node(np, "spi", "fsl_spi")) != NULL;
> >+	     (np = of_find_compatible_node(np, NULL, "fsl,spi")) != NULL;
> 
> Can you keep the original code around to look for older device trees that 
> are wrong?  Backwards compatibility is important.  I don't want to have to 
> update the device tree just because I update the kernel.

I though about it. Is your device tree source out of tree? Otherwise
it should be trivial to upgrade the dtb, instead of producing cruft in
the kernel. I vote for less legacy code, but lets see what others will
say. So far count is 1:1. ;-)

Thanks,

-- 
Anton Vorontsov
email: cbou@mail.ru
backup email: ya-cbou@yandex.ru
irc://irc.freenode.net/bd2
