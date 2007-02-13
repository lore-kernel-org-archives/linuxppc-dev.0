Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id DF213DDDCF
	for <linuxppc-dev@ozlabs.org>; Tue, 13 Feb 2007 11:20:32 +1100 (EST)
Subject: Re: [PATCH 02/10] powerpc: Add device tree fixups for the EFIKA
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Sylvain Munaut <tnt@246tNt.com>
In-Reply-To: <45D0F778.1080606@246tNt.com>
References: <11713184081457-git-send-email-tnt@246tNt.com>
	<11713184091057-git-send-email-tnt@246tNt.com>
	<11713184101239-git-send-email-tnt@246tNt.com>
	<1171321965.20192.37.camel@localhost.localdomain>
	<45D0F778.1080606@246tNt.com>
Content-Type: text/plain
Date: Tue, 13 Feb 2007 11:20:15 +1100
Message-Id: <1171326015.20192.44.camel@localhost.localdomain>
Mime-Version: 1.0
Cc: Linux PPC Dev ML <linuxppc-dev@ozlabs.org>,
	Paul Mackerras <paulus@samba.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


> The const might cause a warning because prop_set_prop takes a void
> *value and not
> a const void *value. I don't know if does need to modify the value or
> not though.

Ok, there's room for another patch to constify prom_set_prop and all
callers then :-)

> About static, that might achieve the same effect as const without the
> warning and since the function is called only once anyway ...
> 
> I would have hoped that being local to a __init function the memory for
> the initial values would be freed but I might me over optimistic.

Yeah, worth checking the ELF output but I think you are over
optimistic :-)
> 
> >> +
> >> +	rv = prom_getprop(node, "model", prop, sizeof(prop));
> >> +	if (rv == PROM_ERROR)
> >> +		return;
> >> +	if (strcmp(prop, "EFIKA5K2"))
> >> +		return;
> >>     
> >
> > Is there a version in their device-tree ? We might want to check in case
> > they ever fix it ...
> >   
> Yes there is a "revision" that's "2B3" for the moment. I'm not too sure
> if it's a firmware
> revision or a board revision though ...

Hrm... let's ignore it for now, we can always fixup the fixups if
necessary :-)

Ben.
