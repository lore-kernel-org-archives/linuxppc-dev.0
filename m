Return-Path: <schwab@suse.de>
Received: from mail.suse.de (ns.suse.de [195.135.220.2])
	(using TLSv1 with cipher EDH-RSA-DES-CBC3-SHA (168/168 bits))
	(Client CN "mail.suse.de",
	Issuer "SuSE Linux AG internal IMAP-Server CA" (not verified))
	by ozlabs.org (Postfix) with ESMTP id 22ADC67A90
	for <linuxppc-dev@ozlabs.org>; Tue, 22 Mar 2005 11:42:40 +1100 (EST)
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
References: <jed5tuqlp1.fsf@sykes.suse.de> <1111377588.3835.258.camel@gaston>
	<jey8che16m.fsf@sykes.suse.de> <1111407779.1236.272.camel@gaston>
	<je8y4g7m6h.fsf@sykes.suse.de> <1111447381.1236.295.camel@gaston>
From: Andreas Schwab <schwab@suse.de>
Date: Tue, 22 Mar 2005 01:42:29 +0100
In-Reply-To: <1111447381.1236.295.camel@gaston> (Benjamin Herrenschmidt's
	message of "Tue, 22 Mar 2005 10:23:01 +1100")
Message-ID: <je64zk5x56.fsf@sykes.suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
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

Benjamin Herrenschmidt <benh@kernel.crashing.org> writes:

> Have you tried with very latest bk which contains by workarounds for
> radeon erratas ? The M7 has smore bugs that might have been triggered by
> the moving of code around that I did in the latest readeonfb.

Correction: it's actually an M6.

> Also, in pmac_cache.S, try locating that bit:
>
> 	/* disp-flush L1 */
> 	li	r4,0x4000
> 	mtctr	r4
> 	lis	r4,0xfff0
> 1:	lwzx	r0,r0,r4
> 	addi	r4,r4,32
> 	bdnz	1b
> 	sync
> 	isync
>
> And turn the li r4,0x4000 into lis r4,2 and let me know if that makes
> any difference...

This did help.

> Same a little bit later, there is:
>
>
> 	lis	r4,2
> 	mtctr	r4
> 	lis	r4,0xfff0
> 1:	lwzx	r0,r0,r4
> 	addi	r4,r4,32
> 	bdnz	1b
> 	sync
> 	isync
>
> Here, try turning the lis r4,2 into lis r4,0x20

This didn't, got crash in __flush_dcache_icache when called from
update_mmu_cache.  (I tested both changes separately.)

> Finally, what happens if you boot without any framebuffer in the kernel
> (no fbdev at all, no fbcon, just no console), ssh into the box, and put
> it to sleep ?

I have no idea how to put it into sleep in this configuration.  The
pbbuttonsd says that sleep is not supported.

Andreas.

-- 
Andreas Schwab, SuSE Labs, schwab@suse.de
SuSE Linux Products GmbH, Maxfeldstraße 5, 90409 Nürnberg, Germany
Key fingerprint = 58CA 54C7 6D53 942B 1756  01D3 44D5 214B 8276 4ED5
"And now for something completely different."
