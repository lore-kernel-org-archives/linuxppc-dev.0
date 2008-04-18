Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 5EA36DE09B
	for <linuxppc-dev@ozlabs.org>; Fri, 18 Apr 2008 18:19:17 +1000 (EST)
Subject: Re: [PATCH 3/3] Use __weak macro for smp_setup_processor_id
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Andrew Morton <akpm@linux-foundation.org>
In-Reply-To: <20080418000717.5a9c9758.akpm@linux-foundation.org>
References: <20080418065728.31AF4DE255@ozlabs.org>
	<20080418000717.5a9c9758.akpm@linux-foundation.org>
Content-Type: text/plain
Date: Fri, 18 Apr 2008 18:19:07 +1000
Message-Id: <1208506747.6958.402.camel@pasglop>
Mime-Version: 1.0
Cc: Linux-Arch <linux-arch@vger.kernel.org>, linuxppc-dev@ozlabs.org,
	Paul Mackerras <paulus@samba.org>, linux-kernel@vger.kernel.org
Reply-To: benh@kernel.crashing.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


On Fri, 2008-04-18 at 00:07 -0700, Andrew Morton wrote:
> On Fri, 18 Apr 2008 16:56:18 +1000 Benjamin Herrenschmidt <benh@kernel.crashing.org> wrote:
> 
> > Use the __weak macro instead of the longer __attribute__ ((weak)) form
> > 
> > Signed-off-by: Benjamin Herrenschmidt <benh@kernel.crashing.org>
> > --
> > 
> >  init/main.c |    2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> > 
> > --- linux-work.orig/init/main.c	2008-04-18 16:44:32.000000000 +1000
> > +++ linux-work/init/main.c	2008-04-18 16:44:37.000000000 +1000
> > @@ -500,7 +500,7 @@ static void __init boot_cpu_init(void)
> >  	cpu_set(cpu, cpu_possible_map);
> >  }
> >  
> > -void __init __attribute__((weak)) smp_setup_processor_id(void)
> > +void __init __weak smp_setup_processor_id(void)
> >  {
> >  }
> 
> ack on all three. Please fold #3 into #1 and add both to git-powerpc.

Damn ! I took 5mn to actually split it out in order to not do two
different things in one patch :-)

Will do.

Cheers,
Ben.
