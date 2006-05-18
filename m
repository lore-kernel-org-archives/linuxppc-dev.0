Return-Path: <segher@kernel.crashing.org>
Received: from mail-in-01.arcor-online.net (mail-in-01.arcor-online.net
	[151.189.21.41])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mx.arcor.de",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id 182B267A65
	for <linuxppc-dev@ozlabs.org>; Fri, 19 May 2006 09:53:17 +1000 (EST)
In-Reply-To: <1147988040.2692.40.camel@basalt.austin.ibm.com>
References: <1147988040.2692.40.camel@basalt.austin.ibm.com>
Mime-Version: 1.0 (Apple Message framework v749.3)
Content-Type: text/plain; charset=US-ASCII; format=flowed
Message-Id: <1F39785F-7897-4820-9A67-07448CAD9DC6@kernel.crashing.org>
From: Segher Boessenkool <segher@kernel.crashing.org>
Subject: Re: [patch] fix RTC/NVRAM accesses on Maple
Date: Fri, 19 May 2006 01:53:05 +0200
To: Hollis Blanchard <hollisb@us.ibm.com>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

> +	isa_ranges[0] = 0x1;
> +	isa_ranges[1] = 0x0;
> +	isa_ranges[2] = 0x0;
> +	isa_ranges[3] = 0x0;
> +	isa_ranges[4] = 0x0;
> +	isa_ranges[5] = 0x00010000;
> +	prom_setprop(isa, "/ht@0/isa@4", "ranges",
> +		     isa_ranges, sizeof(isa_ranges));

isa_ranges[2] = 0x01002000;

isa_ranges[5] looks suspicious as well; the value you put in
means that *no* (16-bit, which is all that 8111 supports) legacy
I/O sits on any other than the LPC bus; so no 8111 ATA support,
for example.

Showing only I/O ranges in the "ranges" property means that no
devices below the "isa" node sit on memory space; is that true
for the Maple device tree?  (The node for the flash chip,
specifically, if it exists in their tree at all).  If not, I'll
dig out the proper "ranges" value for it tomorrow (it depends on
hardware settings on their SIO chip, I have no idea what they
set it to right now :-) ).

I'm sure this all works for your kernel right now, but if you're
fixing up, let's fix it properly :-)


Segher
