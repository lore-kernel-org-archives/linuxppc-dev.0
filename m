Return-Path: <g.liakhovetski@gmx.de>
Received: from mail.gmx.net (mail.gmx.de [213.165.64.20])
	by ozlabs.org (Postfix) with SMTP id CE0D067BDA
	for <linuxppc-embedded@ozlabs.org>;
	Mon,  4 Sep 2006 05:58:23 +1000 (EST)
Date: Sun, 3 Sep 2006 21:58:25 +0200 (CEST)
From: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
To: Zoltan HERPAI <wigyori@uid0.hu>
Subject: Re: Serial problem with MPC8241-based board
In-Reply-To: <44FAF68F.1080206@uid0.hu>
Message-ID: <Pine.LNX.4.60.0609032112260.3944@poirot.grange>
References: <44FAF68F.1080206@uid0.hu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: linuxppc-embedded <linuxppc-embedded@ozlabs.org>
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

On Sun, 3 Sep 2006, Zoltan HERPAI wrote:

> I've recently acquired an Allnet 6250 NAS, which has an MPC8241-based 
> board. Since its GPL tarball is not available fully, I began to build a 

that's where I'd start from - are at least kernel sources completely 
available? If not - would you consider politely asking the manufacturer 
for them?

> toolchain based on gcc-3.4.6 and binutils-2.16.1, and an up-to-date 
> kernel for it. PPCboot states that this is a Sandpoint 8241 Unity board, 
> so the platforms/sandpoint.* was chosen as a starting point, however, 
> after rewriting the irq and ioport values in sandpoint.h to the ones 
> (irq 137, ioport 0x80004500), no output came out of the serial port. 
> After a few days of tweaking around with variables is sandpoint.h, a 
> google session revealed that this board is 99% the same as the Buffalo 
> Linkstation's is, which has a 2.6.x port also, but those kernels are 
> also failing to display any output.

Well, on Linkstation (at least on KuroboxHG) serial port 0 (0x80004500) 
has irq 25 under 2.6. So, at least the irq assignment is different...

> Can anyone shed some light on what points should I check and what may I 
> have done wrong?

No light, sorry, but some info - Mark Greer (CC'ed) has ported sandpoint 
code recently from arch/ppc to arch/powerpc and to using the flattend 
device tree, which is a general trend now. He has send his patches to the 
list a couple of times. This work also depends on the boot-wrapper 
development for non Open-Firmware platforms. I'm trying to do the same for 
Kurobox(HG) / Linkstation, based on Mark's work. So, I think, it would be 
useful if you could do your port also directly under arch/powerpc too 
instead of arch/ppc.

Mark, may I use this opportunity to ask you for your current consistent 
snapshot of both powerpc/boot and powerpc/platforms and whatever others? I 
can compile a kernel with ARCH=powerpc for linkstation, now I have to find 
a way to boot it. My choices are kexec or u-boot. Neither will run 
out-of-the-box, so...

BTW, I would be greatful for any help with setting up kexec.

Thanks
Guennadi
---
Guennadi Liakhovetski
