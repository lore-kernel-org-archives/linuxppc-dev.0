Return-Path: <arnd@arndb.de>
Received: from moutng.kundenserver.de (moutng.kundenserver.de
	[212.227.126.177]) by ozlabs.org (Postfix) with ESMTP id 597CFDDECA
	for <linuxppc-dev@ozlabs.org>; Fri, 30 Mar 2007 08:19:01 +1000 (EST)
From: Arnd Bergmann <arnd@arndb.de>
To: linuxppc-dev@ozlabs.org
Subject: Re: publishing OF platform devices
Date: Fri, 30 Mar 2007 00:18:53 +0200
References: <4b73d43f0703291420v620b871fp97cb34941b1e7a85@mail.gmail.com>
	<200703292357.05205.arnd@arndb.de>
	<1175206052.5624.23.camel@localhost.localdomain>
In-Reply-To: <1175206052.5624.23.camel@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Message-Id: <200703300018.53809.arnd@arndb.de>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Friday 30 March 2007, Benjamin Herrenschmidt wrote:
> 
> > The ppc_md->init() function is currently only present on 32 bit,
> > if we decide that this is the way to go, we should make it common
> > to both 32 and 64 bit platforms.
> 
> I still think we should do something like platform_xxx_initcall(); with
> xxx being {core,subsys,device,...} ... I'll look into it. ppc_md.init()
> is a bit gross.

Yes, that sounds like a good idea, but I'd much prefer adding these only
if they actually simplify the existing code, rather than having them
for completeness.

We also might want to have something a lot simpler at first. Since
many platforms just want to call

of_platform_bus_probe(NULL, foo_ids, NULL);

There could simply be an entry in ppc_md that gets set to foo_ids
and we call of_platform_bus_probe() with that, and get rid of the
unused root and parent arguments.

	Arnd <><
