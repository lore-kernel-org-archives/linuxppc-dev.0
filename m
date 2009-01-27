Return-Path: <nvbolhuis@aimvalley.nl>
Received: from smtp-vbr8.xs4all.nl (smtp-vbr8.xs4all.nl [194.109.24.28])
	by ozlabs.org (Postfix) with ESMTP id C1847DE0D9
	for <linuxppc-dev@ozlabs.org>; Wed, 28 Jan 2009 00:34:02 +1100 (EST)
Message-ID: <497F0D42.7030503@aimvalley.nl>
Date: Tue, 27 Jan 2009 14:33:54 +0100
From: Norbert van Bolhuis <nvbolhuis@aimvalley.nl>
MIME-Version: 1.0
To: u-boot@lists.denx.de, LinuxPPC-Embedded <linuxppc-embedded@ozlabs.org>,
	linuxppc-dev@ozlabs.org
Subject: Nasty gunzip problem on MPC8313E-RDB
References: <49746A3B.5070706@aimvalley.nl>
	<20090119130757.BEB33832E425@gemini.denx.de>
	<4974875B.6060700@aimvalley.nl> <497EDC59.3080405@aimvalley.nl>
In-Reply-To: <497EDC59.3080405@aimvalley.nl>
Content-Type: multipart/mixed; boundary="------------060206090309040309040402"
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

This is a multi-part message in MIME format.
--------------060206090309040309040402
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit


We have 2 MPC8313E-RDB REVA4 boards.

u-boot always fails to uncompress certain compressed files.
Either the board will hang or a checkstop occurs.
The problem occurs on both our MPC8313E-RDB REVA4 boards.
Probably memory is overwritten at the end of RAM (where
u-boot is relocated to). When using a jtag debugger no
problem occurs.

The stock u-boot (shipped by Freescale) has the problem,
any custom built u-boot (v2008.10 or v2009-rc3) also
has the problem.

I tested with u-boot.v2009-rc3 on another board (a PQ2FADS
board). The problem doesn't occur on this board.

I would like to find this problem and I could use all the
help I can get. I'm a bit stuck at the moment.

It's not the watchdog, nor the compiler toolchain. The
watchdog is completely disabled anyway and other compiler
toolchains (including the ones from Freescale) make no
difference.
I already tried to raise the u-boot malloc() area, it makes no
difference either.

when compressing using bzip2 (either --best or --fast) no problem
occurs.
The problem occurs only for gzip compressed files which have
one or more dynamic codes blocks and a final fixed codes block.
I made a very small one, it's attached. It's only 5802 bytes and
md5sum = d5e5a4c95451d256520f1b2a7ace8fa5
Btw. mostly gzip compressed files have dynamic codes blocks only.

This file is in fact a collection of random bytes compressed
with "gzip -9" and a u-boot header in front. If I load this
file into RAM (with tftp) and try to uncompress it (by trying to
bootm it) the problem always occurs.

If anybody is willing to try this file on a MPC8313E-RDB
and/or help me with this problem please reply.


--------------060206090309040309040402
Content-Type: application/octet-stream;
 name="uImage"
Content-Transfer-Encoding: base64
Content-Disposition: attachment;
 filename="uImage"

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
ogwI4KiPIeJyDLD71vEAAG7FrZHonwAA
--------------060206090309040309040402--
