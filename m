Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id AB6E467C1E
	for <linuxppc-dev@ozlabs.org>; Tue, 28 Nov 2006 10:17:07 +1100 (EST)
Subject: Re: powerpc.git build error
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: linuxppc-dev@tux.tmfweb.nl
In-Reply-To: <20061127231246.GA6192@nospam.com>
References: <20061125225807.GA10510@nospam.com>
	<1164523183.10222.1.camel@localhost.localdomain>
	<20061126190609.GA20291@nospam.com>
	<Pine.LNX.4.60.0611262144230.8431@poirot.grange>
	<20061126210535.GA5639@nospam.com>
	<1164597365.22055.2.camel@localhost.localdomain>
	<20061127231246.GA6192@nospam.com>
Content-Type: text/plain
Date: Tue, 28 Nov 2006 10:17:46 +1100
Message-Id: <1164669466.5350.48.camel@localhost.localdomain>
Mime-Version: 1.0
Cc: linuxppc-dev@ozlabs.org, paulus@samba.org,
	Guennadi Liakhovetski <g.liakhovetski@gmx.de>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


> I got this hang once in Linux and I seem to remember /proc/cpuinfo
> containing a line 'L2 cache: 1024Kb' or something like that. After
> that first hang, I cannot find the L2-cache line in /proc/cpuinfo any
> more _and_ I did not have a single hang (apart from during rebooting).
> 
> Actually I hoped to be able to play with the l2cr values (whatever
> valid values might be for this machine), but I cannot find the
> corresponding /proc/sys/kernel/l2cr which should exist according to
> Documentation/sysctl/kernel.txt . It might be that a smaller value
> (say, 512Kb) might still work. I don't know.
>
> Furthermore the machine feels sluggish. A kernel compile takes ~5.5
> hours, while the same compile on my P4 takes ~10 minutes. But it might
> be normal for a 400Mhz G3, I don't know...

Strange... it might indeed have a hw breakage.

> Goolging around for 'lombard bogomips' I got the impression the value
> should be 600 to 800, or at least of that order of magnitude. Since 33
> is far outside this range, I thought that to be the reason. Apparently
> not, then...

It used to be based on the cpu frequency but not any more.

> Ok, I got further with this one thanks to you :)
> 
> Suspend-to-RAM works like a charm! However, when it wakes up the
> screen is black (and I thought the suspend had crashed...). With fn-F2
> (increase brightness key) I can make the screen visible again.

Ah ok, so the brightness isn't properly restored. I suppose that can be
fixed ;-)

> How am I supposed to power down the machine? halt -p? With
> 'powerprefs' I can only select different suspend modes but not
> power-down modes...

halt or shutown -h now

> This leaves me to some OOPSes still:
>   - removing the PCMCIA wifi card (Orinoco) while the network is up
>   - booting the machine with the wifi card inserted
>   - bringing up the wifi card while no access point is found

Weird...

> (maybe-related:)
> And a warning in dmesg which reads (no OOPS):
> pcmcia: the driver needs updating to supported shared IRQ lines.
> ...which corresponds to /proc/interrupts :
>  22:    4912397   PMAC-PIC  Level     yenta, pcmcia0.0

Could be a driver issue

> The wifi-at-startup-OOPS:
> pccard: PCMCIA card inserted into slot 0
> cs: memory probe 0x0c0000-0x0fffff: excluding 0xc0000-0xfffff
> cs: memory probe 0x60000000-0x60ffffff: excluding 0x60000000-0x60ffffff
> cs: memory probe 0x80000000-0xfcffffff: excluding 0x80000000-0x81ffffff
> cs: memory probe 0xfd000000-0xfdffffff:Machine check in kernel mode.
> Caused by (from SRR1=49030): Transfer error ack signal
> Oops: Machine check, sig: 7 [#1]
> ...
> Call Trace:
> [D30ABD40] [D5044E90] pcmcia_read_cis_mem+0x15c/0x274 [pcmcia_core] (unreliable)
> [D30ABD70] [D5045110] read_cis_cache+0x168/0x16c [pcmcia_core]
> [D30ABD90] [D50452B8] pccard_get_next_tuple+0x100/0x454 [pcmcia_core]
> [D30ABDD0] [D50456A4] pccard_get_first_tuple+0x98/0x144 [pcmcia_core]
> ...
> 
> When I insert the PCMCIA card at a later stage, there are no 'cs: '
> lines in dmesg at all.
> 
> So still some riddles to be solved ;)

Yeah, some weird problems with the pcmcia controller, mgiht be incorrect
resource assignments...

Ben.
