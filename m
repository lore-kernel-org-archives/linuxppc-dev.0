Return-Path: <avorontsov@ru.mvista.com>
Received: from ozlabs.org (ozlabs.org [203.10.76.45])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mx.ozlabs.org",
	Issuer "CA Cert Signing Authority" (verified OK))
	by bilbo.ozlabs.org (Postfix) with ESMTPS id 14EA6B70F5
	for <linuxppc-dev@lists.ozlabs.org>;
	Thu,  2 Jul 2009 07:29:00 +1000 (EST)
Received: from buildserver.ru.mvista.com (unknown [213.79.90.228])
	by ozlabs.org (Postfix) with ESMTP id A48CCDDD0C
	for <linuxppc-dev@ozlabs.org>; Thu,  2 Jul 2009 07:28:59 +1000 (EST)
Date: Thu, 2 Jul 2009 01:28:58 +0400
From: Anton Vorontsov <avorontsov@ru.mvista.com>
To: Timur Tabi <timur@freescale.com>
Subject: Re: [PATCH] powerpc: Don't use alloc_bootmem() in init_IRQ() path
Message-ID: <20090701212858.GA28455@oksana.dev.rtsoft.ru>
References: <20090701230831.3828e0bf@power-debian>
	<20090701194819.GB20522@ovro.caltech.edu>
	<20090701205957.GA9583@oksana.dev.rtsoft.ru>
	<4A4BD187.8000605@freescale.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
In-Reply-To: <4A4BD187.8000605@freescale.com>
Cc: Arnd Bergmann <arnd@arndb.de>, Ira Snyder <iws@ovro.caltech.edu>,
	linuxppc-dev@ozlabs.org, Andrey Gusev <a.gusev1980@mail.ru>,
	Geert Uytterhoeven <Geert.Uytterhoeven@sonycom.com>
Reply-To: avorontsov@ru.mvista.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Wed, Jul 01, 2009 at 04:13:43PM -0500, Timur Tabi wrote:
> Anton Vorontsov wrote:
> 
> > diff --git a/arch/powerpc/sysdev/qe_lib/qe_ic.c b/arch/powerpc/sysdev/qe_lib/qe_ic.c
> > index 63cdf98..074905c 100644
> > --- a/arch/powerpc/sysdev/qe_lib/qe_ic.c
> > +++ b/arch/powerpc/sysdev/qe_lib/qe_ic.c
> > @@ -333,12 +333,10 @@ void __init qe_ic_init(struct device_node *node, unsigned int flags,
> >  	if (ret)
> >  		return;
> >  
> > -	qe_ic = alloc_bootmem(sizeof(struct qe_ic));
> > +	qe_ic = kzalloc(sizeof(*qe_ic), GFP_KERNEL);
> 
> This function is called during init_IRQ() in main.c.

That's the main point of this patch (as subject says). Nowadays
init_IRQ() is called with kernel allocator available, so we
shouldn't use alloc_bootmem() anymore.

> Looking at the code, I don't see any earlier calls to kzalloc().

You seem to be looking into an outdated kernel. ;-) IIRC, the
first caller of kzalloc() in init_IRQ() path appeared in

commit 85355bb272db31a3f2dd99d547eef794805e1319
Author: Kumar Gala <galak@kernel.crashing.org>
Date:   Thu Jun 18 22:01:20 2009 +0000

    powerpc: Fix mpic alloc warning

> Are you sure this is supposed
> to work?

This was boot-tested on real HW. :-)


Thanks,

-- 
Anton Vorontsov
email: cbouatmailru@gmail.com
irc://irc.freenode.net/bd2
