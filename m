Return-Path: <matt@genesi-usa.com>
Received: from mail.genesippc.com (mithrandir.softwarenexus.net [66.98.186.96])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 6911D67B84
	for <linuxppc-dev@ozlabs.org>; Wed, 19 Jul 2006 01:11:09 +1000 (EST)
From: "Matt Sealey" <matt@genesi-usa.com>
To: "'Kumar Gala'" <galak@kernel.crashing.org>
Subject: RE: AltiVec in the kernel
Date: Tue, 18 Jul 2006 10:10:58 -0500
Message-ID: <005701c6aa7c$632a48e0$99dfdfdf@bakuhatsu.net>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="US-ASCII"
In-Reply-To: <E40C6B7A-F2E8-4DB8-97D3-2CFF88C1D90A@kernel.crashing.org>
Cc: 'linuxppc-dev list' <linuxppc-dev@ozlabs.org>,
	'Paul Mackerras' <paulus@samba.org>
Reply-To: matt@genesi-usa.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

 

> -----Original Message-----
> From: Kumar Gala [mailto:galak@kernel.crashing.org] 
> Sent: Tuesday, July 18, 2006 8:53 AM
> To: matt@genesi-usa.com
> Cc: linuxppc-dev list; Paul Mackerras
> Subject: Re: AltiVec in the kernel
> 
> 
> On Jul 18, 2006, at 7:48 AM, Matt Sealey wrote:
> 
> > for instance there is a RAID5/6 driver (for G5) which uses 
> > AltiVec in a kernel context.
> 
> Using Altivec generally in the kernel is still something that 
> is not recommended.  The key to using it is in disabling 
> preemption, this ensures that when the code is done the 
> Altivec register state is back to how the kernel found it.
> 
> 	preempt_disable();
> 	enable_kernel_altivec();
> 
> 	raid6_altivec$#_gen_syndrome_real(disks, bytes, ptrs);
> 
> 	preempt_enable();

Why isn't it recommended?

For instance on FreeBSD and other operating systems they have
designed the functionality in there as it would be a feature
people would want to use. QNX uses AltiVec to perform the
context switch and message passing and keep latency down.

Restricting AltiVec to userspace code (applications..) really
means you are barely ever using it. Kernel functions and
drivers are called every second of every day.. it's about
making AltiVec really used and not having the unit sit twiddling
it's thumbs until you REALLY NEED TO DECODE A JPEG VERY FAST.

There are thousands of things it could be doing. One example
could be.. in-kernel compression and encryption subroutines.

> > teach them what AltiVec is etc. we demonstrate application 
> > AND kernel  functionality and the quirks associated with it).
> 
> I'm pretty sure Paul looked into using AltiVec for memory 
> operations in the kernel and didn't see a significant benefit to it.

We had our own guy look at it and he presented some significant
performance improvements. One problem was, though, that the best
improvement in theory came from a function which needed to be
called very early in kernel boot, well before AltiVec was
enabled, and everything else is marginal at best (1.n times
improvement, but it is still 0.n more than 1.0). I am not clear
on this and cannot find my discussion on the subject in my logs
and email backups, so. I will leave it for now. 

There is also plenty of example code (libmotovec, Freescale
Application Notes) which improve things like TCP checksumming
and so on using AltiVec. These patches are even used in EEMBC
benchmarks to boost the scores.

There is also plenty of examples of userspace code (as before,
checksumming, encryption, compression/decompression) which has
been improved. libfreevec includes some changes to the zlib
window functions. For example the kernel includes an MD5, SHA,
zlib compression framework.. mostly ported userspace code and
standard libraries. Would these not be candidates? The development
and speed improvements are even capable of being tested in
userspace (and this is a GREAT teaching aid also; show how to
improve some userspace app. Then show the differences it needed
to go into the kernel. Benchmark both. Detail result.)

I think there are thousands of places where AltiVec could be
used - even sparingly - to provide good performance improvements.
>From your reply I suspect that these would be places which do
not rely on the effects preemption has on performance (i.e.
you trade preemption for AltiVec and gain).

I don't think people investigate it too much because the first
thing they hit is lack of documentation, and then "well we don't
really recommend it". I think this makes Linux the worst OS a
developer would want to run on a G4 and G5, then? :D

-- 
Matt Sealey <matt@genesi-usa.com>
Manager, Genesi, Developer Relations
