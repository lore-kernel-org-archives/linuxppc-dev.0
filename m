Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 272DCDDF9A
	for <linuxppc-dev@ozlabs.org>; Fri, 30 Mar 2007 08:25:49 +1000 (EST)
Subject: Re: publishing OF platform devices
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Arnd Bergmann <arnd@arndb.de>
In-Reply-To: <200703300018.53809.arnd@arndb.de>
References: <4b73d43f0703291420v620b871fp97cb34941b1e7a85@mail.gmail.com>
	<200703292357.05205.arnd@arndb.de>
	<1175206052.5624.23.camel@localhost.localdomain>
	<200703300018.53809.arnd@arndb.de>
Content-Type: text/plain
Date: Fri, 30 Mar 2007 08:25:41 +1000
Message-Id: <1175207141.5624.27.camel@localhost.localdomain>
Mime-Version: 1.0
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Fri, 2007-03-30 at 00:18 +0200, Arnd Bergmann wrote:
> On Friday 30 March 2007, Benjamin Herrenschmidt wrote:
> > 
> > > The ppc_md->init() function is currently only present on 32 bit,
> > > if we decide that this is the way to go, we should make it common
> > > to both 32 and 64 bit platforms.
> > 
> > I still think we should do something like platform_xxx_initcall(); with
> > xxx being {core,subsys,device,...} ... I'll look into it. ppc_md.init()
> > is a bit gross.
> 
> Yes, that sounds like a good idea, but I'd much prefer adding these only
> if they actually simplify the existing code, rather than having them
> for completeness.

They will at first generate something like:

static int func(void)
{
	if (!machine_is(platform))
		return 0;
	return user_func();
}

xxx_initcall(func);

And thus will be equivalent in generated code to the open coded
versions, but that is already enough to avoid, I hope, quite a bit of
mistakes and simplify the source.

Later on, we can look into doing some smart ELF section tricks to also
reduce the generated code.

> We also might want to have something a lot simpler at first. Since
> many platforms just want to call
> 
> of_platform_bus_probe(NULL, foo_ids, NULL);
> 
> There could simply be an entry in ppc_md that gets set to foo_ids
> and we call of_platform_bus_probe() with that, and get rid of the
> unused root and parent arguments.

Might not be unused forever... oh well, we'll see.

Ben.
