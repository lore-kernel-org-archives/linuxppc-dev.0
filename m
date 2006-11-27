Return-Path: <rutger@wingding.demon.nl>
Received: from post-23.mail.nl.demon.net (post-23.mail.nl.demon.net
	[194.159.73.193]) by ozlabs.org (Postfix) with ESMTP id 7BF2167C86
	for <linuxppc-dev@ozlabs.org>; Tue, 28 Nov 2006 10:12:50 +1100 (EST)
Date: Tue, 28 Nov 2006 00:12:46 +0100
From: Rutger Nijlunsing <rutger@nospam.com>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: Re: powerpc.git build error
Message-ID: <20061127231246.GA6192@nospam.com>
References: <20061125225807.GA10510@nospam.com>
	<1164523183.10222.1.camel@localhost.localdomain>
	<20061126190609.GA20291@nospam.com>
	<Pine.LNX.4.60.0611262144230.8431@poirot.grange>
	<20061126210535.GA5639@nospam.com>
	<1164597365.22055.2.camel@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1164597365.22055.2.camel@localhost.localdomain>
Cc: linuxppc-dev@ozlabs.org, paulus@samba.org,
	Guennadi Liakhovetski <g.liakhovetski@gmx.de>
Reply-To: linuxppc-dev@tux.tmfweb.nl
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Mon, Nov 27, 2006 at 02:16:04PM +1100, Benjamin Herrenschmidt wrote:
> 
> > Hold your horses, I'm just a simple user without too much
> > understanding of the hardware trying to get most out of his PowerBook
> > G3 Lombard (with broken L2 cache: 33bogomips) which I got a week ago :)
> 
> What makes you think it has a broken L2 cache ?

During the time Mac OS9 was on this machine, the machine would
occasionaly boot with a window displaying a message along the lines
'problem with memory'. I forgot the exact error message, but it
involved memory in general (so not L2 specific). When the message
would not display, the machine would hang randomly after some time
(say, 1 hour).

I was told the Apple Store owner suggested swapping the motherboard to
fix it, but I don't know the expertise of him either.

I got this hang once in Linux and I seem to remember /proc/cpuinfo
containing a line 'L2 cache: 1024Kb' or something like that. After
that first hang, I cannot find the L2-cache line in /proc/cpuinfo any
more _and_ I did not have a single hang (apart from during rebooting).

Actually I hoped to be able to play with the l2cr values (whatever
valid values might be for this machine), but I cannot find the
corresponding /proc/sys/kernel/l2cr which should exist according to
Documentation/sysctl/kernel.txt . It might be that a smaller value
(say, 512Kb) might still work. I don't know.

Furthermore the machine feels sluggish. A kernel compile takes ~5.5
hours, while the same compile on my P4 takes ~10 minutes. But it might
be normal for a 400Mhz G3, I don't know...

> The 33 bogomips are
> totally unrelated, it's the timebase frequency. Bogomips are NOT a
> benchmark and on the powerpc architecture, and not even related to the
> processor speed at all (but to the frequency of the timebase input).

Goolging around for 'lombard bogomips' I got the impression the value
should be 600 to 800, or at least of that order of magnitude. Since 33
is far outside this range, I thought that to be the reason. Apparently
not, then...

> > It seems suspend-to-ram is working to some extend, or at least
> > 'should' work out-of-the-box. When I close the lid and reopen it, it
> > resumes 'a little': PCMCIA cards seem to power up again (TX/RX WiFi
> > led starts to flash again), but the screen stays dark. I haven't tried
> > to debug this yet, since getting WiFi to work
> 
> Does it work better without the PCMCIA card ? Is it properly going to
> sleep (snoozing LED) ? Also make sure you are using the proper video
> driver (atyfb on the lombard) and not booting with "novideo" or
> "video=ofonly".

Ok, I got further with this one thanks to you :)

Suspend-to-RAM works like a charm! However, when it wakes up the
screen is black (and I thought the suspend had crashed...). With fn-F2
(increase brightness key) I can make the screen visible again.

> > Furthermore I'm not interested in kexec if 'all is working'. But since
> > 'rebooting' already hangs after the powerdown, I'm more focused on
> > getting the normal 'reboot' working.
> 
> That is the strange thing... does it reboot fine in MacOS ?

Uhm, I got this second-hand machine 1.5 weeks ago, and I wiped MacOS
in day one. So I cannot remember. It also looses track of date/time
once in a while (not always!) after pressing the reset-button on the
back (which I need to bring it back to life).

How am I supposed to power down the machine? halt -p? With
'powerprefs' I can only select different suspend modes but not
power-down modes...

This leaves me to some OOPSes still:
  - removing the PCMCIA wifi card (Orinoco) while the network is up
  - booting the machine with the wifi card inserted
  - bringing up the wifi card while no access point is found

(maybe-related:)
And a warning in dmesg which reads (no OOPS):
pcmcia: the driver needs updating to supported shared IRQ lines.
...which corresponds to /proc/interrupts :
 22:    4912397   PMAC-PIC  Level     yenta, pcmcia0.0

The wifi-at-startup-OOPS:
pccard: PCMCIA card inserted into slot 0
cs: memory probe 0x0c0000-0x0fffff: excluding 0xc0000-0xfffff
cs: memory probe 0x60000000-0x60ffffff: excluding 0x60000000-0x60ffffff
cs: memory probe 0x80000000-0xfcffffff: excluding 0x80000000-0x81ffffff
cs: memory probe 0xfd000000-0xfdffffff:Machine check in kernel mode.
Caused by (from SRR1=49030): Transfer error ack signal
Oops: Machine check, sig: 7 [#1]
...
Call Trace:
[D30ABD40] [D5044E90] pcmcia_read_cis_mem+0x15c/0x274 [pcmcia_core] (unreliable)
[D30ABD70] [D5045110] read_cis_cache+0x168/0x16c [pcmcia_core]
[D30ABD90] [D50452B8] pccard_get_next_tuple+0x100/0x454 [pcmcia_core]
[D30ABDD0] [D50456A4] pccard_get_first_tuple+0x98/0x144 [pcmcia_core]
...

When I insert the PCMCIA card at a later stage, there are no 'cs: '
lines in dmesg at all.

So still some riddles to be solved ;)

-- 
Rutger Nijlunsing ---------------------------------- eludias ed dse.nl
never attribute to a conspiracy which can be explained by incompetence
----------------------------------------------------------------------
