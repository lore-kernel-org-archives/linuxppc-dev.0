Return-Path: <avorontsov@ru.mvista.com>
Received: from buildserver.ru.mvista.com (unknown [85.21.88.6])
	by ozlabs.org (Postfix) with ESMTP id CF271DE124
	for <linuxppc-dev@ozlabs.org>; Thu,  7 Aug 2008 21:11:59 +1000 (EST)
Date: Thu, 7 Aug 2008 15:11:56 +0400
From: Anton Vorontsov <avorontsov@ru.mvista.com>
To: Michael Ellerman <michael@ellerman.id.au>
Subject: Re: [PATCH 6/8] powerpc: set up OF properties for ppc32 kdump
Message-ID: <20080807111156.GA28825@polina.dev.rtsoft.ru>
References: <20080801141306.GA29127@polina.dev.rtsoft.ru>
	<20080801141425.GF1161@polina.dev.rtsoft.ru>
	<1218106051.7914.12.camel@localhost>
MIME-Version: 1.0
Content-Type: text/plain; charset=windows-1251
In-Reply-To: <1218106051.7914.12.camel@localhost>
Cc: linuxppc-dev@ozlabs.org, Paul Mackerras <paulus@samba.org>
Reply-To: avorontsov@ru.mvista.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Thu, Aug 07, 2008 at 08:47:31PM +1000, Michael Ellerman wrote:
> On Fri, 2008-08-01 at 18:14 +0400, Anton Vorontsov wrote:
> > From: Dale Farnsworth <dale@farnsworth.org>
> > 
> > Refactor the setting of kexec OF properties, moving the common code
> > from machine_kexec_64.c to machine_kexec.c where it can be used on
> > both ppc64 and ppc32.  This will be needed for kdump to work on ppc32
> > platforms.
> 
> Hi Anton,

Hi,

> > diff --git a/arch/powerpc/kernel/machine_kexec.c b/arch/powerpc/kernel/machine_kexec.c
> > index ac42cfb..bfef717 100644
> > --- a/arch/powerpc/kernel/machine_kexec.c
> > +++ b/arch/powerpc/kernel/machine_kexec.c
> > @@ -117,6 +117,7 @@ int overlaps_crashkernel(unsigned long start, unsigned long size)
> >  
> 
> >  static int __init kexec_setup(void)
> >  {
> >  	struct device_node *node;
> > @@ -135,6 +171,8 @@ static int __init kexec_setup(void)
> >  	kernel_end = __pa(_end);
> >  	prom_add_property(node, &kernel_end_prop);
> >  
> > +	export_crashk_values(node);
> > +
> >  	of_node_put(node);
> >  	return 0;
> >  }
> > diff --git a/arch/powerpc/kernel/machine_kexec_64.c b/arch/powerpc/kernel/machine_kexec_64.c
> > index c30678d..2aab296 100644
> > --- a/arch/powerpc/kernel/machine_kexec_64.c
> > +++ b/arch/powerpc/kernel/machine_kexec_64.c
> ...
> 
> > -
> >  static int __init kexec_setup(void)
> >  {
> >  	export_htab_values();
> > -	export_crashk_values();
> >  	return 0;
> >  }
> >  __initcall(kexec_setup);
> 
> This leaves us with two routines called kexec_setup(), do you mind
> getting rid of this one and making export_htab_values() an initcall
> directly.

Yup, good idea. Will do this, and will address your other comments,
too.

Thanks!

-- 
Anton Vorontsov
email: cbouatmailru@gmail.com
irc://irc.freenode.net/bd2
