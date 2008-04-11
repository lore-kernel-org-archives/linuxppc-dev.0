Return-Path: <jwboyer@gmail.com>
Received: from py-out-1112.google.com (py-out-1112.google.com [64.233.166.177])
	by ozlabs.org (Postfix) with ESMTP id C653BDE18C
	for <linuxppc-dev@ozlabs.org>; Fri, 11 Apr 2008 11:02:30 +1000 (EST)
Received: by py-out-1112.google.com with SMTP id z59so283167pyg.27
	for <linuxppc-dev@ozlabs.org>; Thu, 10 Apr 2008 18:02:27 -0700 (PDT)
Subject: Re: [PATCH] [v5] Add idle wait support for 44x platforms
From: Josh Boyer <jwboyer@linux.vnet.ibm.com>
To: Arnd Bergmann <arnd@arndb.de>
In-Reply-To: <200804110218.23912.arnd@arndb.de>
References: <df0f79b7b4ab628887c2.1207673354@thinkpadL>
	<200804101544.44457.arnd@arndb.de> <1207858131.26428.4.camel@thinkpadL>
	<200804110218.23912.arnd@arndb.de>
Content-Type: text/plain
Date: Thu, 10 Apr 2008 20:02:16 -0500
Message-Id: <1207875736.3996.52.camel@vader.jdub.homelinux.org>
Mime-Version: 1.0
Sender: Josh Boyer <jwboyer@gmail.com>
Cc: kvm-ppc-devel@lists.sourceforge.net, linuxppc-dev@ozlabs.org
Reply-To: jwboyer@linux.vnet.ibm.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Fri, 2008-04-11 at 02:18 +0200, Arnd Bergmann wrote:
> > > static int __init idle_param(char *p)
> > > {
> > >       if (!strcmp(modes[i].name, "spin"))
> > >               ppc_md.power_save = NULL;
> > > }
> > > early_param("idle", idle_param);
> > > 
> > > if you statically initialize the ppc_md.power_save function to ppc44x_idle
> > > in the platform setup files?
> > 
> > The idea is to not statically initialize ppc_md.power_save to
> > ppc44x_idle in each platform setup file.
> > 
> 
> Why not? Unlike the platform_initcall, it wouldn't cost anything and your
> current code has the same effect in the end, but in a less obvious way.

This is likely something that has evolved from the original patch which
added a machine_late_initcall(<machine>, ppc44x_idle_init) to every
platform.c file.  It made the original patch overly complicated as
opposed to adding a single arch_initcall in a common file.  That was
also before we decided to make "wait" the default, which made things
much easier to deal with.

I'll take the blame for the way the minorly suboptimal state the patch
is, as Jerone had to jump through several hoops already at my request.
I agree it's cleaner to do as you suggest in the long run, and may well
make some changes along those lines myself.

josh
