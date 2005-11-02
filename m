Return-Path: <dhlii@comcast.net>
Received: from sccrmhc11.comcast.net (sccrmhc11.comcast.net [204.127.202.55])
	by ozlabs.org (Postfix) with ESMTP id CE22B68593
	for <linuxppc-embedded@ozlabs.org>;
	Wed,  2 Nov 2005 20:45:22 +1100 (EST)
Message-ID: <43688AAD.5050208@comcast.net>
Date: Wed, 02 Nov 2005 04:45:17 -0500
From: "David H. Lynch Jr" <dhlii@comcast.net>
MIME-Version: 1.0
To: linuxppc-embedded <linuxppc-embedded@ozlabs.org>
References: <20050906130029.74727.qmail@web8405.mail.in.yahoo.com>
In-Reply-To: <20050906130029.74727.qmail@web8405.mail.in.yahoo.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Subject: Board Bringup problem with 2.6.13.4
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

I am working through bringing up Linux 2.6.13.4 on a Xilinx V4 based ppc405.
with memory from 0x0 through 0x7fffffff



Right now I get:

 >Starting MonitorX.elf: V3.3.2.0.
 >
 >loaded at:     00400000 0047F13C
 >board data at: 0047D128 0047D13C
 >relocated to:  00405300 00405314
 >zimage at:     00405A95 0047CE71
 >avail ram:     00480000 08000000
 >
 >Linux/PPC load: console=ttyS0,9600 console=tty0 init=/linuxrc 
looptype=squashfs cdroot splash=silentttttt
 >Uncompressing Linux......done.
 >Now booting the kernel

I have been able to trace execution into head_4xx.S  to immediately 
before turn_on_mmu:
But immediately after this I lose the ability to trace.

I have been tracing things with a status port at 0x70000000 I can write 
to and read from the host side with code like

    lis   r14,0x7000      /* debugging port */
    li   r15,0x2305      /* value to output */
    stw   r15,4(r14)  
    eieio
 
after turn_on_mmu executes this does not seem to work.
looking at other code it appeared that I needed to add
tophy(r14,r14) prior to the stw
but that does not seem to help.

What do I need to do to be able to continue to use my debug port ?
