Return-Path: <owner-linuxppc-embedded@lists.linuxppc.org>
Message-ID: <002101c4311c$6ca7d440$0301a8c0@chuck2>
From: "Mark Chambers" <mwchambers@citlink.net>
To: "Gerrit Van de Velde" <gvd@denayer.wenk.be>
Cc: <linuxppc-embedded@lists.linuxppc.org>
References: <02f701c42f01$fcb464d0$0301a8c0@chuck2> <4095ED18.50605@denayer.wenk.be>
Subject: Re: Motorola 5200 MIPS
Date: Mon, 3 May 2004 10:39:20 -0400
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


> Don't know, but you're not comparing the right numbers anyway. Try
> running a Dhrystone benchmark. It reported something around 500 MIPS.

I suspect 500MIPS is probably pretty close, judging by some of the tests
I've run.

OK, I know I'm anal-retentive, but I can't just accept "it has 'bogo' in the
name, so therefore it means nothing."  We've run linux on several 8xx family
parts and the bogomips closely tracked the expected performance of 1
instruction/clock.  Now all of a sudden it doesn't mean anything?  So I
tracked it down, and the bogoMIPS calculation all boils down to a "bdnz"
instruction (on a PPC).  So on pipelined processors branches are the worst
case scenario.  I think it boils down to taking 2 processor cycles/bdnz
instruction.  So, it's a worst case scenario, but then again 760MIPS is a
best case scenario, assuming you can always feed two instructions into the
CPU every clock cycle (and never have to branch!).  Not going to happen, so
you've got to assume you can reasonably expect 1-point-something times the
processor clock.

Mark Chambers
Microfirst, Inc.

P.S. I'm a fan of Motorola processors, hope I didn't sound too ugly.  What
would the world be like if Bill had chosen the 68000???


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
