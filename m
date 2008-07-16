Return-Path: <miltonm@bga.com>
Received: from ruth.realtime.net (mercury.realtime.net [205.238.132.86])
	by ozlabs.org (Postfix) with ESMTP id E2008DDFA7
	for <linuxppc-dev@ozlabs.org>; Thu, 17 Jul 2008 02:19:19 +1000 (EST)
Mime-Version: 1.0 (Apple Message framework v624)
Content-Type: text/plain; charset=US-ASCII; format=flowed
Message-Id: <1dce2aab6509053e60f7a59a30974749@bga.com>
From: Milton Miller <miltonm@bga.com>
Subject: [HOW] binutils-2.17 breaks the 2.6.26 kernel
Date: Wed, 16 Jul 2008 11:21:17 -0500
To: ppcdev <linuxppc-dev@ozlabs.org>
Cc: Alan Modra <amodra@bigpond.net.au>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Hi.

I've been working with Debian bintuils 2.17-3 (which identifies
itself as 2.17) on my build box for some time.

When testing all-yes-config, I was getting warnings, but the
vmlinux was booting via kexec.

Since I was replicating the warnings from BFD about section lmas
overlapping in vmlinux.strip.$$, I was encouraged to actually try
booting the resulting stripped kernel.  After a false start (getting
the old binary) I ended up replicating the fail-to-boot some people
have reported on linuxppc-dev.

Digging into the failure, we were trying to copy *way* too much data
in copy_and_flush from after_prom.   I found the value loaded from
_klimit was something like 0x00002fea_00400000, not quite _end that
it was initialized.

I tracked this down to the .rodata and all sections following loosing
the inter-section alignment.


/DISCARD/ {
  ....
}
text: AT( .text - LOAD_OFFSET): {
  ....
}

. = ALIGN(0x1000)   /* this align directive aparently gets lost
                        when stripping the file */

.rodata: AT (.rodata - LOAD_OFFSET): {
   ...
}

the effects of that align were dropped during strip, shifting all
following sections up in memory and the resulting failure.

I don't know if the fault is ld or strip.

The behavior came between 2.6.24 and -next-20080710, but others
have suggested their kernels don't boot in the 2.6.25 to 2.6.26
transition, and a likely candidate is the addition of AT(x) to
set the lma, although we also switched form TEXT_TEXT macro in
include/asm-generic.h to a hand-rolled .text section.

Can we come up with a workaround?

thanks,
milton
