Return-Path: <B08782@freescale.com>
Received: from DB3EHSOBE002.bigfish.com (db3ehsobe006.messaging.microsoft.com
 [213.199.154.144])
 (using TLSv1 with cipher AES128-SHA (128/128 bits))
 (Client CN "mail.global.frontbridge.com",
 Issuer "Microsoft Secure Server Authority" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 697A9B6EEE
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  1 Feb 2012 22:23:44 +1100 (EST)
Received: from mail87-db3 (localhost [127.0.0.1])	by mail87-db3-R.bigfish.com
 (Postfix) with ESMTP id BF0DF4600C5	for
 <linuxppc-dev@lists.ozlabs.org>; Wed, 1 Feb 2012 11:23:30 +0000 (UTC)
Received: from DB3EHSMHS006.bigfish.com (unknown [10.3.81.252])	by
 mail87-db3.bigfish.com (Postfix) with ESMTP id 6FA512004A	for
 <linuxppc-dev@lists.ozlabs.org>; Wed,  1 Feb 2012 11:23:28 +0000 (UTC)
From: Manoil Claudiu-B08782 <B08782@freescale.com>
To: Wood Scott-B07421 <B07421@freescale.com>
Subject: RE: [PATCH] powerpc/85xx: Fix compiler error with THIS_MODULE and
 related
Date: Wed, 1 Feb 2012 11:23:25 +0000
Message-ID: <3EF2EF85608A7A40B711DE9808A61C9C173FBD@039-SN1MPN1-002.039d.mgd.msft.net>
References: <1328004939-29766-1-git-send-email-claudiu.manoil@freescale.com>
 <4F283D11.4080004@freescale.com>
In-Reply-To: <4F283D11.4080004@freescale.com>
Content-Type: text/plain; charset="us-ascii"
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

Hi,

You're right, <linux/export.h> is better for arch/powerpc/sysdev/fsl_85xx_c=
ache_sram.c.
However, it is not enough for arch/powerpc/sysdev/fsl_85xx_l2ctlr.c, as thi=
s one is defined as a module.
I'll resend the patch (with <linux/export.h> for fsl_85xx_cache_sram.c), if=
 that's fine with you.

Thanks,
Claudiu

> -----Original Message-----
> From: Wood Scott-B07421
> Sent: Tuesday, January 31, 2012 9:12 PM
> To: Manoil Claudiu-B08782
> Cc: linuxppc-dev@lists.ozlabs.org
> Subject: Re: [PATCH] powerpc/85xx: Fix compiler error with THIS_MODULE
> and related
>=20
> On 01/31/2012 04:15 AM, Claudiu Manoil wrote:
> >    CC      arch/powerpc/sysdev/fsl_85xx_l2ctlr.o
> > arch/powerpc/sysdev/fsl_85xx_l2ctlr.c:209:13: error: 'THIS_MODULE'
> > undeclared here (not in a function)
> > arch/powerpc/sysdev/fsl_85xx_l2ctlr.c:229:20: error: expected
> > declaration specifiers or '...' before string constant
> > cc1: warnings being treated as errors
> > arch/powerpc/sysdev/fsl_85xx_l2ctlr.c:229:1: error: data definition
> > has no type or storage class
> > arch/powerpc/sysdev/fsl_85xx_l2ctlr.c:229:1: error: type defaults to
> 'int' in declaration of 'MODULE_DESCRIPTION'
> > arch/powerpc/sysdev/fsl_85xx_l2ctlr.c:229:20: error: function
> > declaration isn't a prototype
> > arch/powerpc/sysdev/fsl_85xx_l2ctlr.c:230:16: error: expected
> > declaration specifiers or '...' before string constant
> > arch/powerpc/sysdev/fsl_85xx_l2ctlr.c:230:1: error: data definition
> > has no type or storage class
> > arch/powerpc/sysdev/fsl_85xx_l2ctlr.c:230:1: error: type defaults to
> 'int' in declaration of 'MODULE_LICENSE'
> > arch/powerpc/sysdev/fsl_85xx_l2ctlr.c:230:16: error: function
> > declaration isn't a prototype
> > make[1]: *** [arch/powerpc/sysdev/fsl_85xx_l2ctlr.o] Error 1
> >
> > ...
> >
> >   CC      arch/powerpc/sysdev/fsl_85xx_cache_sram.o
> > cc1: warnings being treated as errors
> > arch/powerpc/sysdev/fsl_85xx_cache_sram.c:69:1: error: data definition
> > has no type or storage class
> > arch/powerpc/sysdev/fsl_85xx_cache_sram.c:69:1: error: type defaults to
> 'int' in declaration of 'EXPORT_SYMBOL'
> > arch/powerpc/sysdev/fsl_85xx_cache_sram.c:69:1: error: parameter names
> > (without types) in function declaration
> > arch/powerpc/sysdev/fsl_85xx_cache_sram.c:80:1: error: data definition
> > has no type or storage class
> > arch/powerpc/sysdev/fsl_85xx_cache_sram.c:80:1: error: type defaults to
> 'int' in declaration of 'EXPORT_SYMBOL'
> > arch/powerpc/sysdev/fsl_85xx_cache_sram.c:80:1: error: parameter names
> > (without types) in function declaration
> > make[1]: *** [arch/powerpc/sysdev/fsl_85xx_cache_sram.o] Error 1
> >
> > Signed-off-by: Claudiu Manoil <claudiu.manoil@freescale.com>
> > ---
> >  arch/powerpc/sysdev/fsl_85xx_cache_sram.c |    1 +
> >  arch/powerpc/sysdev/fsl_85xx_l2ctlr.c     |    1 +
> >  2 files changed, 2 insertions(+), 0 deletions(-)
> >
> > diff --git a/arch/powerpc/sysdev/fsl_85xx_cache_sram.c
> > b/arch/powerpc/sysdev/fsl_85xx_cache_sram.c
> > index 1164158..92cce8d 100644
> > --- a/arch/powerpc/sysdev/fsl_85xx_cache_sram.c
> > +++ b/arch/powerpc/sysdev/fsl_85xx_cache_sram.c
> > @@ -24,6 +24,7 @@
> >   */
> >
> >  #include <linux/kernel.h>
> > +#include <linux/module.h>
> >  #include <linux/slab.h>
> >  #include <linux/err.h>
> >  #include <linux/of_platform.h>
> > diff --git a/arch/powerpc/sysdev/fsl_85xx_l2ctlr.c
> > b/arch/powerpc/sysdev/fsl_85xx_l2ctlr.c
> > index 5f88797..1957e53 100644
> > --- a/arch/powerpc/sysdev/fsl_85xx_l2ctlr.c
> > +++ b/arch/powerpc/sysdev/fsl_85xx_l2ctlr.c
> > @@ -21,6 +21,7 @@
> >   */
> >
> >  #include <linux/kernel.h>
> > +#include <linux/module.h>
> >  #include <linux/of_platform.h>
> >  #include <asm/io.h>
> >
>=20
> I believe <linux/export.h> is what you're supposed to include for this
> these days.
>=20
> -Scott
