Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 00EC267A8D
	for <linuxppc-dev@ozlabs.org>; Tue, 22 Mar 2005 10:24:18 +1100 (EST)
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Andreas Schwab <schwab@suse.de>
In-Reply-To: <je8y4g7m6h.fsf@sykes.suse.de>
References: <jed5tuqlp1.fsf@sykes.suse.de>
	<1111377588.3835.258.camel@gaston> <jey8che16m.fsf@sykes.suse.de>
	<1111407779.1236.272.camel@gaston>  <je8y4g7m6h.fsf@sykes.suse.de>
Content-Type: text/plain
Date: Tue, 22 Mar 2005 10:23:01 +1100
Message-Id: <1111447381.1236.295.camel@gaston>
Mime-Version: 1.0
Cc: linuxppc-dev list <linuxppc-dev@ozlabs.org>
Subject: Re: Wakeup broken on iBook G3
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Mon, 2005-03-21 at 21:56 +0100, Andreas Schwab wrote:
> Benjamin Herrenschmidt <benh@kernel.crashing.org> writes:
> 
> > Can you try playing with pmac_sleep.S and pmac_cache.S, basically
> > reverting those including the calls to set_L2CR in via-pmu.c ?
> 
> That makes it even worse (it apparently crashes almost immediately after
> wakeup).

Hrm... Ok...

At this point, I don't know for sure what's up, there have been several
reports but nobody physically close to me has any of these machines for
me to test with.

Have you tried with very latest bk which contains by workarounds for
radeon erratas ? The M7 has smore bugs that might have been triggered by
the moving of code around that I did in the latest readeonfb.

Also, in pmac_cache.S, try locating that bit:

	/* disp-flush L1 */
	li	r4,0x4000
	mtctr	r4
	lis	r4,0xfff0
1:	lwzx	r0,r0,r4
	addi	r4,r4,32
	bdnz	1b
	sync
	isync

And turn the li r4,0x4000 into lis r4,2 and let me know if that makes
any difference... Same a little bit later, there is:


	lis	r4,2
	mtctr	r4
	lis	r4,0xfff0
1:	lwzx	r0,r0,r4
	addi	r4,r4,32
	bdnz	1b
	sync
	isync

Here, try turning the lis r4,2 into lis r4,0x20

And let me know if any of these help.

Finally, what happens if you boot without any framebuffer in the kernel
(no fbdev at all, no fbcon, just no console), ssh into the box, and put
it to sleep ? Does it wake up ?

Ben.
