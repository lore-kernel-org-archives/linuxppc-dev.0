Return-Path: <glikely@secretlab.ca>
Received: from an-out-0708.google.com (an-out-0708.google.com [209.85.132.249])
	by ozlabs.org (Postfix) with ESMTP id C4A66DDEDA
	for <linuxppc-dev@ozlabs.org>; Thu, 20 Dec 2007 08:38:25 +1100 (EST)
Received: by an-out-0708.google.com with SMTP id c37so856720anc.78
	for <linuxppc-dev@ozlabs.org>; Wed, 19 Dec 2007 13:38:24 -0800 (PST)
Message-ID: <fa686aa40712191338x8c054c2qe0d0ce7aea70cd49@mail.gmail.com>
Date: Wed, 19 Dec 2007 14:38:23 -0700
From: "Grant Likely" <grant.likely@secretlab.ca>
Sender: glikely@secretlab.ca
To: avorontsov@ru.mvista.com
Subject: Re: [PATCH 4/4] [POWERPC] fsl_spi_init and users: stop using
	device_type = "spi"
In-Reply-To: <20071219211250.GA21416@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
References: <20071219203447.GA18285@localhost.localdomain>
	<20071219203817.GD20861@localhost.localdomain>
	<47698773.1010004@freescale.com>
	<20071219211250.GA21416@localhost.localdomain>
Cc: linuxppc-dev@ozlabs.org, Timur Tabi <timur@freescale.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On 12/19/07, Anton Vorontsov <avorontsov@ru.mvista.com> wrote:
> On Wed, Dec 19, 2007 at 03:04:51PM -0600, Timur Tabi wrote:
> > Anton Vorontsov wrote:
> >
> > >diff --git a/arch/powerpc/sysdev/fsl_soc.c b/arch/powerpc/sysdev/fsl_soc.c
> > >index 3cf84d0..91bac51 100644
> > >--- a/arch/powerpc/sysdev/fsl_soc.c
> > >+++ b/arch/powerpc/sysdev/fsl_soc.c
> > >@@ -1242,7 +1242,7 @@ int __init fsl_spi_init(struct spi_board_info
> > >*board_infos,
> > >     }
> > >
> > >     for (np = NULL, i = 1;
> > >-         (np = of_find_compatible_node(np, "spi", "fsl_spi")) != NULL;
> > >+         (np = of_find_compatible_node(np, NULL, "fsl,spi")) != NULL;
> >
> > Can you keep the original code around to look for older device trees that
> > are wrong?  Backwards compatibility is important.  I don't want to have to
> > update the device tree just because I update the kernel.
>
> I though about it. Is your device tree source out of tree? Otherwise
> it should be trivial to upgrade the dtb, instead of producing cruft in
> the kernel. I vote for less legacy code, but lets see what others will
> say. So far count is 1:1. ;-)

I agree with Timur.  Please keep the test for the older names.  Some
platforms have the dtb in the same sector as u-boot, making it more
dangerous to reflash.

g.

> --
> Anton Vorontsov
> email: cbou@mail.ru
> backup email: ya-cbou@yandex.ru
> irc://irc.freenode.net/bd2
> _______________________________________________
> Linuxppc-dev mailing list
> Linuxppc-dev@ozlabs.org
> https://ozlabs.org/mailman/listinfo/linuxppc-dev
>


-- 
Grant Likely, B.Sc., P.Eng.
Secret Lab Technologies Ltd.
grant.likely@secretlab.ca
(403) 399-0195
