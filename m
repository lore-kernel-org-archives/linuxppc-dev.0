Return-Path: <pollmeier@gonicus.de>
Received: from mail-1.ar.gonicus.de (mail-1.ar.gonicus.de [212.8.1.3])
	by ozlabs.org (Postfix) with ESMTP id 8E2B81007D2
	for <linuxppc-dev@lists.ozlabs.org>;
	Thu,  4 Nov 2010 02:07:51 +1100 (EST)
Received: from localhost (localhost [127.0.0.1])
	by mail-1.ar.gonicus.de (Postfix) with ESMTP id 23AB7144622
	for <linuxppc-dev@lists.ozlabs.org>;
	Wed,  3 Nov 2010 16:01:11 +0100 (CET)
Subject: Debugging kernel on mpc7448
From: Cajus Pollmeier <pollmeier@gonicus.de>
To: Linuxppc-dev@lists.ozlabs.org
Content-Type: text/plain; charset="UTF-8"
Date: Wed, 03 Nov 2010 16:01:07 +0100
Message-ID: <1288796467.3609.46.camel@frost>
Mime-Version: 1.0
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Hello there,

I'm currently trying to get a kernel upgrade from 2.6.11 to 2.6.31
working with u-boot/cuImage.c2k on a custom marvell discovery 3 board.
In the moment, the following steps work:

* u-boot (1.1.4, not changeable in the moment) runs from flash and
offers a prompt
* loading cuImage.c2k
* running the code of wrapper.c until calling vmlinux.addr
* entering __start in head_32.S and running until early_init gets called

The systems then hangs until the watchdog resets the board. In this
early stage, I've no output to the serial console - which is the only
way to see what's going on without having a development board with
single step capabilities.

To track it until early_init, I tried to place a stupid "blr" in
head_32.S, in order to get back to wrapper.c - which writes out a
message to the serial console in case the kernel "accidently" gets back
to it.

>From now on, I'm not sure if early_init is properly called. The blr
after the call is either not reached or there's something going on which
is beyond my limited knowledge of ppc assembler. Maybe u-boot gets
overwritten, but the blr isn't even reached if I change early_init by
just returning 0U immediately. Hmm.

Any pointers to help debugging would be really appreciated ;-)

Cheers,
Cajus
