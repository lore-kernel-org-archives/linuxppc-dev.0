Return-Path: <schivers@csc.com.au>
Received: from mail1.bemta12.messagelabs.com (mail1.bemta12.messagelabs.com
 [216.82.251.7])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id C26902C0096
 for <linuxppc-dev@lists.ozlabs.org>; Thu,  6 Feb 2014 13:16:19 +1100 (EST)
Received: from amer-gw15.amer.csc.com (amer-gw15.amer.csc.com [20.137.2.189])
 by amer-mta111.csc.com (Sentrion-MTA-4.3.1/Sentrion-MTA-4.3.1) with
 ESMTP id s16292hb010848
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 5 Feb 2014 21:09:02 -0500
To: linuxppc-dev@lists.ozlabs.org
MIME-Version: 1.0
Subject: arch/powerpc/math-emu/mtfsf.c - incorrect mask?
From: Stephen N Chivers <schivers@csc.com.au>
Message-ID: <OF784BA598.ACFE9DA4-ONCA257C76.00827472-CA257C77.000BCFAD@csc.com>
Date: Thu, 6 Feb 2014 12:09:00 +1000
Content-Type: text/plain; charset="US-ASCII"
Cc: Chris Proctor <cproctor@csc.com.au>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

I have a MPC8548e based board and an application that makes
extensive use of floating point including numerous calls to cos.
In the same program there is the use of an sqlite database.

The kernel is derived from 2.6.31 and is compiled with math emulation.

At some point after the reading of the SQLITE database, the
return result from cos goes from an in range value to an out
of range value.

This is as a result of the FP rounding mode mutating from "round to 
nearest"
to "round toward zero".

The cos in the glibc version being used is known to be sensitive to 
rounding
direction and Joseph Myers has previously fixed glibc.

The failure does not occur on a machine that has a hardware floating
point unit (a MPC7410 processor).

I have traced the mutation to the following series of instructions:

        mffs            f0
        mtfsb1          4*cr7+so
        mtfsb0          4*cr7+eq
        fadd            f13,f1,f2
        mtfsf           1, f0

The instructions are part of the stream emitted by gcc for the conversion
of a 128 bit floating point value into an integer in the sqlite database 
read.

Immediately before the execution of the mffs instruction the "rounding
mode" is "round to nearest".

On the MPC8548 board, the execution of the mtfsf instruction does not
restore the rounding mode to "round to nearest".

I believe that the mask computation in mtfsf.c is incorrect and is 
reversed.

In the latest version of the file (linux-3.14-rc1), the mask is computed 
by:

                 mask = 0;
                 if (FM & (1 << 0))
                        mask |= 0x90000000;
                 if (FM & (1 << 1))
                        mask |= 0x0f000000;
                 if (FM & (1 << 2))
                        mask |= 0x00f00000;
                 if (FM & (1 << 3))
                        mask |= 0x000f0000;
                 if (FM & (1 << 4))
                        mask |= 0x0000f000;
                 if (FM & (1 << 5))
                        mask |= 0x00000f00;
                 if (FM & (1 << 6))
                        mask |= 0x000000f0;
                 if (FM & (1 << 7))
                        mask |= 0x0000000f;

I think it should be:

                mask = 0;
                if (FM & (1 << 0))
                        mask |= 0x0000000f;
                if (FM & (1 << 1))
                        mask |= 0x000000f0;
                if (FM & (1 << 2))
                        mask |= 0x00000f00;
                if (FM & (1 << 3))
                        mask |= 0x0000f000;
                if (FM & (1 << 4))
                        mask |= 0x000f0000;
                if (FM & (1 << 5))
                        mask |= 0x00f00000;
                if (FM & (1 << 6))
                        mask |= 0x0f000000;
                if (FM & (1 << 7))
                        mask |= 0x90000000;

With the above mask computation I get consistent results for both the 
MPC8548
and MPC7410 boards.

Am I missing something subtle?

Stephen Chivers,
CSC Australia Pty. Ltd.
