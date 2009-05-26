Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 1C1F1DE041
	for <linuxppc-dev@ozlabs.org>; Wed, 27 May 2009 08:24:29 +1000 (EST)
Subject: Re: Wrong looking statement in cpm_common.c
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Scott Wood <scottwood@freescale.com>
In-Reply-To: <4A1C69F8.9090301@freescale.com>
References: <1243224033.24376.18.camel@pasglop>
	<20090526175613.GB9464@loki.buserror.net>
	<1243375671.17847.0.camel@pasglop>  <4A1C69F8.9090301@freescale.com>
Content-Type: text/plain
Date: Wed, 27 May 2009 08:22:17 +1000
Message-Id: <1243376537.17847.11.camel@pasglop>
Mime-Version: 1.0
Cc: linuxppc-dev list <linuxppc-dev@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Tue, 2009-05-26 at 17:15 -0500, Scott Wood wrote:
> Benjamin Herrenschmidt wrote:
> > On Tue, 2009-05-26 at 12:56 -0500, Scott Wood wrote:
> >> Any suggestions for how to do it properly?
> > 
> > ioremap ? :-)
> 
> Does ioremap work that early?

It works very early on ppc32 but maybe not -that- early... It works from
start_kernel on. You might be able to do the ioremaps in machine_init
(provided LMBs are up) but they won't be "effective" until MMU_init
returns, but then, neither will setbat anyway.

However, since that's the only user of setbat I can still find and we
want to replace that with something saner, I'd rather kill it.

Ben.
