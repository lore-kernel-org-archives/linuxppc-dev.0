Return-Path: <sebastian@breakpoint.cc>
Received: from ozlabs.org (ozlabs.org [203.10.76.45])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mx.ozlabs.org",
	Issuer "CA Cert Signing Authority" (verified OK))
	by bilbo.ozlabs.org (Postfix) with ESMTPS id DB126B6EDE
	for <linuxppc-dev@lists.ozlabs.org>;
	Wed,  5 Aug 2009 09:06:16 +1000 (EST)
Received: from Chamillionaire.breakpoint.cc (Chamillionaire.breakpoint.cc
	[85.10.199.196])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 2499DDDD04
	for <linuxppc-dev@ozlabs.org>; Wed,  5 Aug 2009 09:06:15 +1000 (EST)
Received: id: bigeasy by Chamillionaire.breakpoint.cc with local
	(easymta 1.00 BETA 1) id 1MYT54-0007hS-0x
	for linuxppc-dev@ozlabs.org; Wed, 05 Aug 2009 01:06:06 +0200
Date: Wed, 5 Aug 2009 01:06:06 +0200
From: Sebastian Andrzej Siewior <sebastian@breakpoint.cc>
To: linuxppc-dev@ozlabs.org
Subject: kexec on e300 core / mpc5121
Message-ID: <20090804230605.GA28753@Chamillionaire.breakpoint.cc>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

I've tried kexec on e300 core which should be easy since it is possible
to disable the MMU on that core. However it does not work.
Once I disable the MMU, I can't access my MBAR and print chars on the
serial port. Is this "normal" or do I have still some caches on?
After I've setup two BATs one for SDRAM and the other for MBAR and
enabled the MMU again, I could trace it and see that it jumped into the
new kernel. I got lost after the turn off mmu part. So the new kernel
does not boot but it gets there.

I noticed that if I boot from u-boot, my I & Dcache are switched off and
in kexec mode there are on. So I tried to disable them in my kernel
wrapper with the following sequence which I borrowed from u-boot:

|icache_disable:
|        mfspr   r3, HID0
|        lis     r4, 0
|        ori     r4, r4, HID0_ICE|HID0_ILOCK
|        andc    r3, r3, r4
|        ori     r4, r3, HID0_ICFI
|        isync
|        mtspr   HID0, r4     /* sets invalidate, clears enable and lock*/
|        isync
|        mtspr   HID0, r3        /* clears invalidate */
|        blr
|dcache_disable:
|        mfspr   r3, HID0
|        lis     r4, 0
|        ori     r4, r4, HID0_DCE|HID0_DLOCK
|        andc    r3, r3, r4
|        ori     r4, r3, HID0_DCI
|        sync
|        mtspr   HID0, r4        /* sets invalidate, clears enable and lock */
|        sync
|        mtspr   HID0, r3        /* clears invalidate */
|        blr

First icache, followed by dcache.
This has the side effect that my LR which was saved on stack suddenly
become 0x0 in the function where I disable the caches.
So it looks like the sequence above is not correct and it is probably a
cache thing why the kernel does not boot.

So I tried not to enable I & Dcache in first place. The kernel booted
uncached and then I tried to kexec into my kernel. This did not succeed,
I saw my last char printed in kernel code but nothing more. So it looks
like the same result like the cached attempt.

The HID0 register differs only in powermanagement, MSR differs in IR,DR
and PR. Is there another register which could be different? There should
be one, since I can't write anything on my serial line unless I setup
BATs and enable data address translation.
Does someone have an idea?

Sebastian
