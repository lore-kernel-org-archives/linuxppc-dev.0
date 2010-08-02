Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 4F172B70CC
	for <linuxppc-dev@ozlabs.org>; Mon,  2 Aug 2010 13:54:53 +1000 (EST)
Subject: Re: [PATCH 02/11] powerpc/nvram: More flexible
	nvram_create_partition()
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: michael@ellerman.id.au
In-Reply-To: <1280720607.2491.175.camel@concordia>
References: <1280710522-6362-1-git-send-email-benh@kernel.crashing.org>
	<1280710522-6362-2-git-send-email-benh@kernel.crashing.org>
	<1280710522-6362-3-git-send-email-benh@kernel.crashing.org>
	<1280720607.2491.175.camel@concordia>
Content-Type: text/plain; charset="UTF-8"
Date: Mon, 02 Aug 2010 13:54:44 +1000
Message-ID: <1280721284.1902.52.camel@pasglop>
Mime-Version: 1.0
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Mon, 2010-08-02 at 13:43 +1000, Michael Ellerman wrote:

> >  	
> >  	/* try creating a partition with the free space we have */
> > -	rc = nvram_create_partition("ppc64,linux", );
> 
> That looks odd? Trailing comma.

Yeah, that and...

> > diff --git a/arch/powerpc/platforms/pseries/nvram.c b/arch/powerpc/platforms/pseries/nvram.c
> > index f4e4c06..2a1ef5c 100644
> > --- a/arch/powerpc/platforms/pseries/nvram.c
> > +++ b/arch/powerpc/platforms/pseries/nvram.c
> > @@ -22,14 +22,14 @@
> >  #include <asm/prom.h>
> >  #include <asm/machdep.h>
> >  
> > +/* Max bytes to read/write in one go */
> > +#define NVRW_CNT 0x20
> > +
> >  static unsigned int nvram_size;
> >  static int nvram_fetch, nvram_store;
> >  static char nvram_buf[NVRW_CNT];	/* assume this is in the first 4GB */
> >  static DEFINE_SPINLOCK(nvram_lock);
> >  
> > -/* Max bytes to read/write in one go */
> > -#define NVRW_CNT 0x20
> > -
> 
> Churn alert, you just moved that hunk there in the previous patch.

 ... that are local rebasing fu*kage.

I'll sort all that out in the next version.

Thanks,
Ben.
