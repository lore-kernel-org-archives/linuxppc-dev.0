Return-Path: <SRS0+6d7f7bec91762bae7df7+730+infradead.org+dwmw2@pentafluge.srs.infradead.org>
Received: from pentafluge.infradead.org (pentafluge.infradead.org
	[213.146.154.40])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 6B5A568175
	for <linuxppc-dev@ozlabs.org>; Wed, 24 Aug 2005 03:00:47 +1000 (EST)
From: David Woodhouse <dwmw2@infradead.org>
To: Marcelo Tosatti <marcelo.tosatti@cyclades.com>
In-Reply-To: <20050823025645.GG9667@dmt.cnet>
References: <1124317852.24373.13.camel@localhost.localdomain>
	<8DC63AB4-C547-4023-BE7F-46176BC71535@freescale.com>
	<20050823025645.GG9667@dmt.cnet>
Content-Type: text/plain
Date: Tue, 23 Aug 2005 17:43:14 +0100
Message-Id: <1124815395.29448.26.camel@hades.cambridge.redhat.com>
Mime-Version: 1.0
Cc: linuxppc-dev list <linuxppc-dev@ozlabs.org>
Subject: Re: When are machine checks suppose to be recoverable?
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Mon, 2005-08-22 at 23:56 -0300, Marcelo Tosatti wrote:
> "My dual G4 PowerMac crashes sometimes when it probes for the (absent)
> serial ports. Theoretically it's supposed to take a machine check and
> recover -- but it doesn't always work like that."
> 
> Maybe you just need the proper entry in the exception table for IO
> inb/outb?
> 
> Is there a stacktrace, David?

No, just a silent death when probing for one of the serial ports;
usually not the first. It doesn't seem to even make it into the machine
check handler. Adding printks into serial_inb and serial_outb makes it
much less likely to happen -- could be something bizarre about alignment
of the instructions which cause the machine check, or time elapsed from
one machine check to the next.

-- 
dwmw2
