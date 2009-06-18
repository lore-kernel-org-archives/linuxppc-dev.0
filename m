Return-Path: <benh@kernel.crashing.org>
Received: from ozlabs.org (ozlabs.org [203.10.76.45])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mx.ozlabs.org",
	Issuer "CA Cert Signing Authority" (verified OK))
	by bilbo.ozlabs.org (Postfix) with ESMTPS id 93CA2B7288
	for <linuxppc-dev@lists.ozlabs.org>;
	Fri, 19 Jun 2009 08:18:29 +1000 (EST)
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id E8369DDD1B
	for <linuxppc-dev@ozlabs.org>; Fri, 19 Jun 2009 08:18:28 +1000 (EST)
Subject: Re: killing use of ppc_md.init
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Kumar Gala <galak@kernel.crashing.org>
In-Reply-To: <C81AEED1-5CEC-42B8-A893-5E6BDDD4EC54@kernel.crashing.org>
References: <C81AEED1-5CEC-42B8-A893-5E6BDDD4EC54@kernel.crashing.org>
Content-Type: text/plain
Date: Fri, 19 Jun 2009 08:18:18 +1000
Message-Id: <1245363498.8693.3.camel@pasglop>
Mime-Version: 1.0
Cc: linuxppc-dev list <linuxppc-dev@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Thu, 2009-06-18 at 09:38 -0500, Kumar Gala wrote:
> ppc_md.init only exists on ppc32 and seems like its pretty useless  
> today.  The users seem to fall into two classes:
> 
> 1. called to do of_platform_bus_probe() - most platforms use  
> machine_device_initcall() for this
> 2. some platform init code which seems like it could move into  
> setup_arch().
> 
> The second one seems to only be on amigaone and chrp.  Anyone know if  
> there is any harm in moving the amigaone_init() into  
> amigaone_setup_arch() and similarly on chrp chrp_init2() into  
> chrp_setup_arch().

We might kill it ... and revive it differently :-) 

Yes, the current ppc_init() can probably just go.

However, we probably also want to add a call from init/main.c back to
the architectures and ppc_md. in our case that is right after mm_init().

Right now, we do way too many things at setup_arch() (or even before
that on ppc64) which induces all sorts of pain due to having to use
bootmem etc...

Now that slab is available much earlier, before init_IRQ() and
time_init(), we should consider moving a whole bunch of stuff somewhere
later in the boot process to simplify the code etc...

Cheers,
Ben.
