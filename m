Return-Path: <owner-linuxppc-embedded@lists.linuxppc.org>
Message-ID: <6B546A602AD2D211BFF00008C7A42889041D6C6B@hrtades2.atea.be>
From: Goddeeris Frederic <Frederic.Goddeeris@siemens.atea.be>
To: "'linuxppc-embedded@lists.linuxppc.org'" <linuxppc-embedded@lists.linuxppc.org>
Subject: gdb problems / BDM PPCBoot
Date: Thu, 11 Oct 2001 12:05:25 +0200
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Hi.

I am doing exactly the same thing as Joakim Tjernlund a few months ago:

> I am trying to debug ppclinux 2.4 and ppcboot on RPX CLLF board
> connected to an Abatron emulator.
> When I print variables in gdb I get an <error type> message
> instead of the variable value. Breakpoints and stack trace etc. works
> fine. I have enabled -g switch to gcc.
> I am using Montavistas CDK 1.2 on RH7.1

After I enabled the -ggdb switch and removed -mrelocatable,  I am able to
look at variables, but it is all rubbish. Also the source code ddd points to
is completely wrong. When it should jump to board_init_f (PPCBoot, board.c),
it thinks it jumps to eth_rx+12. This corresponds with what I see in the
ppcboot.map-file. The offset between these two is 0xa9b0. When I reload the
symbol file, "add-symbol-file ppcboot 0xff00a960" instead of
"add-symbol-file ppcboot 0xff000000", I start seeing the correct source-code
lines, but the variables are still completely wrong.

Any ideas? Could it be a problem with the compiler and debugger version that
MontaVista ships with CDK1.2? That the -ggdb switch is needed is a hack in
the first place, right?

Thanks,
Frederic


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
