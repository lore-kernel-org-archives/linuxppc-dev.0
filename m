Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 6D48C474CD
	for <linuxppc-dev@ozlabs.org>; Fri, 16 Jan 2009 10:01:18 +1100 (EST)
Subject: Re: [PATCH 2/4] powerpc: Add ppc_progress() wrapper
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Paul Mackerras <paulus@samba.org>
In-Reply-To: <18799.7994.553829.470138@cargo.ozlabs.ibm.com>
References: <e3520e2f9806d4f6e4b30587b6d29176e583833d.1232001793.git.michael@ellerman.id.au>
	<3922453a668745466cb291f889d2c067932e4894.1232001793.git.michael@ellerman.id.au>
	<18799.7994.553829.470138@cargo.ozlabs.ibm.com>
Content-Type: text/plain
Date: Fri, 16 Jan 2009 10:01:01 +1100
Message-Id: <1232060461.22571.125.camel@pasglop>
Mime-Version: 1.0
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


> It certainly used to be the case on ppc32 (and may still be) that
> ppc_md.progress was called very very early, in some cases before the
> MMU was set up, so we don't want to call printk from it.  Falling back
> to udbg_printf would be more appropriate.
> 
> The idea of ppc_md.progress was that if you need to debug very early
> boot and you have something that you can poke with absolutely minimal
> setup and observe externally, you can hook that up to ppc_md.progress
> and get an idea where the system is dying.  Once you get to the point
> where printk works then you can just use printk.

Right, printk shouldn't be called before lockdep is initialized, though
I don't see a call to lockdep_init on ppc32 ..

Appart from that, printk is pretty safe as long as we have some kind
of translation from PAGE_OFFSET that covers the kernel text, data and
bss, which we do have fairly early.

I think the reasons we did that back then is that printk output will end
up nowhere. Nowadays however, we have udbg console which can possibly be
initialized very early too.

I'd say let's keep that patch on the back burner until we get a chance
to play a bit more with that stuff.

Among other things, I still want to change the early initialization
order of ppc32 to look more like ppc64 which would help in that are as
well so ...

Cheers,
Ben.
 
