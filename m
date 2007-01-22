Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 71F18DDF36
	for <linuxppc-embedded@ozlabs.org>;
	Tue, 23 Jan 2007 08:05:42 +1100 (EST)
Subject: Re: Who's the maintainer for the freescale MPC8349ITX board?
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Timur Tabi <timur@freescale.com>
In-Reply-To: <45AFD24B.5070608@freescale.com>
References: <OF27AFB204.D453295B-ON88257267.0011100B-88257267.00158710@selinc.com>
	<45AFD24B.5070608@freescale.com>
Content-Type: text/plain
Date: Tue, 23 Jan 2007 08:05:34 +1100
Message-Id: <1169499934.1582.12.camel@localhost.localdomain>
Mime-Version: 1.0
Cc: Bruce_Leonard@selinc.com, linuxppc-embedded@ozlabs.org
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>


> > '/cpus/PowerPC,8349@0/timebase-frequency' as what it's searching for, but 
> > what ft_get_prop() finds is 
> > '///cpus//cpus/PowerPC,8349@0/timebase-frequency', which of course doesn't 
> > match, so it returns NULL to ft_setup() and the 'timebase-frequency' never 
> > gets updated before being passed to the kernel.
> 
> This sounds like a generic bug in the U-Boot OF code, but I'll check it out. 
> The DTS for the 8349ITX is defined just like the other DTSes.

Reminds me we should really look into writing, one of these days, both
for uboot, the zImage wrapper, and the kernel itself, a smarter OF path
parser that can

 - ignore spurrious /
 - handle relative path from a given node
 - handles getting passed the name without the unit address (the @ part)
   when non-ambiguous (when ambiguous, returns one of the nodes matching
   with no guarantee of which one)
 - handles getting passed the unit address without the name

That would make usage of path for "fixing up" properties or looking up
properties easier in many cases.

Any volunteer ? :-)

Ben.
