Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 279E1B6F09
	for <linuxppc-dev@ozlabs.org>; Sat, 19 Dec 2009 19:49:15 +1100 (EST)
Subject: Re: [PATCH 5/6 v5] CPU probe/release files
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Andreas Schwab <schwab@linux-m68k.org>
In-Reply-To: <m2oclw9wt4.fsf@igel.home>
References: <4AE8ADCF.6090104@austin.ibm.com>
	<4AE8B072.1070603@austin.ibm.com>  <m2oclw9wt4.fsf@igel.home>
Content-Type: text/plain; charset="UTF-8"
Date: Sat, 19 Dec 2009 19:46:55 +1100
Message-ID: <1261212415.2173.94.camel@pasglop>
Mime-Version: 1.0
Cc: linuxppc-dev@ozlabs.org, linux-kernel@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Fri, 2009-12-18 at 15:33 +0100, Andreas Schwab wrote:
> Nathan Fontenot <nfont@austin.ibm.com> writes:
> 
> > Index: powerpc/arch/powerpc/Kconfig
> > ===================================================================
> > --- powerpc.orig/arch/powerpc/Kconfig	2009-10-28 15:21:47.000000000 -0500
> > +++ powerpc/arch/powerpc/Kconfig	2009-10-28 15:21:53.000000000 -0500
> > @@ -320,6 +320,10 @@
> >  
> >  	  Say N if you are unsure.
> >  
> > +config ARCH_CPU_PROBE_RELEASE
> > +	def_bool y
> > +	depends on HOTPLUG_CPU
> > +
> 
> That does not work.
> 
> drivers/built-in.o: In function `.store_online':
> cpu.c:(.ref.text+0xf5c): undefined reference to `.cpu_hotplug_driver_lock'
> cpu.c:(.ref.text+0xfc8): undefined reference to `.cpu_hotplug_driver_unlock'
> make: *** [.tmp_vmlinux1] Error 1
> 
> cpu_hotplug_driver_lock is only defined on pseries, but HOTPLUG_CPU is
> also defined on pmac.

Well, the stuff was merged ... so we need to fix it.

Nathan, the problem is that the above wlil define ARCH_CPU_PROBE_RELEASE
for any powerpc platform that has HOTPLUG_CPU. So a kernel that doesn't
have pSeries support but has hotplug CPU will have a problem, though for
some reason none of my test configs triggered it (I'll have to check why
next week).

The right approach here is to have cpu_hotplug_driver_lock go through
ppc_md. I suppose, along with some of the other CPU hotplug platform
specific bits.

Cheers,
Ben.
