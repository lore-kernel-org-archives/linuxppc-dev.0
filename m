Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 43B3D67A8C
	for <linuxppc-dev@ozlabs.org>; Thu, 20 Jan 2005 12:02:20 +1100 (EST)
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Andreas Schwab <schwab@suse.de>
In-Reply-To: <jehdld7wx0.fsf@sykes.suse.de>
References: <1106011958.4533.25.camel@gaston> <je7jmaurl0.fsf@sykes.suse.de>
	<1106100264.4534.135.camel@gaston> <jemzv584yw.fsf@sykes.suse.de>
	<1106175427.5326.21.camel@gaston>  <jehdld7wx0.fsf@sykes.suse.de>
Content-Type: text/plain
Date: Thu, 20 Jan 2005 12:01:54 +1100
Message-Id: <1106182915.5294.57.camel@gaston>
Mime-Version: 1.0
Cc: Andrew Morton <akpm@osdl.org>, linuxppc-dev list <linuxppc-dev@ozlabs.org>,
	Linus Torvalds <torvalds@osdl.org>
Subject: Re: [PATCH] ppc32: pmac sleep support update
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Thu, 2005-01-20 at 01:43 +0100, Andreas Schwab wrote:
> Benjamin Herrenschmidt <benh@kernel.crashing.org> writes:
> 
> > Even when building xmon into the kernel ?
> 
> Doh!  I didn't think of that.  This is what I get from xmon:
> 
>     <2>kernel BUG in unlock_page at mm/filemap.c:430!
>     vector: 700 at pc = c003f098, lr = c0041654
>     msr = 29032, sp = e71b1c80 [e71b1bd0]
>     current = e7bbec70, pid = 2915, comm = syslogd
> 
> c0041654 = generic_file_buffered_write
> 
> Last kernel messages:
> 
>     radeonfb: switching to D0 state...
>     HID1, after: 70000044
>     cpufreq: resume failed to assert current frequency is what timing core thinks it is.

Weird ... Can you try without cpufreq built in the kernel ? Also what is
the exact CPU revision ? I think you are just experiencing memory
corruption...

Ben.
