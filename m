Return-Path: <mgreer@mvista.com>
Received: from gateway-1237.mvista.com (gateway-1237.mvista.com
	[63.81.120.158]) by ozlabs.org (Postfix) with ESMTP id 0DAD467B19
	for <linuxppc-embedded@ozlabs.org>;
	Thu,  4 May 2006 08:59:45 +1000 (EST)
Date: Wed, 3 May 2006 16:01:20 -0700
From: "Mark A. Greer" <mgreer@mvista.com>
To: Simon Smith <simon.v.smith@gmail.com>
Subject: Re: Sandpoint X3B and 7447 - boot problems
Message-ID: <20060503230120.GA6645@mag.az.mvista.com>
References: <c4b82dc40605031145h18145dcci520a8ee7ff4a7c8@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <c4b82dc40605031145h18145dcci520a8ee7ff4a7c8@mail.gmail.com>
Cc: linuxppc-embedded@ozlabs.org
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

On Wed, May 03, 2006 at 01:45:19PM -0500, Simon Smith wrote:
> Hi,
> 
> I'm a new member on this list.  I've been trying to get my Sandpoint
> X3B/mpmc7447 to boot a stock Linux kernel from kernel.org (tried 2.6.14 and
> 2.6.16). I'm running into a boot issue, I load zImage.elf (using DINK32
> v13.1.1) -  I get the "Linux/PPC load:" prompt  and then nothing (no more
> text, and no more serial port response).
> 
> I been searching through the archives - I did come across one email that
> mentioned that Motorola(Freescale) started to ship Sandpoint X3B's with
> serial #'s > 6000 with "different" switch settings (my board has a serial #
> greater than 6000).  I haven't changed any switch settings from the
> defaults, the comments in arch/ppc/platforms/sandpoint.c seem to make
> reference to switch settings for the X1/2 board - but nothing about the X3B.
> In all my searching I have yet to find any reference to what the switch
> settings for the X3B rev should be for Linux.
> 
> If anyone has any pointers regarding the switch settings for the X3B - or
> anything else that might help - I would appreciate any help I can get.

I just booted last night's kernel.org tree on a sandpoint 7447A X3B
with serial # > 6000.  I used the default config file, just like you.

The switches on the processor card are set as shown below.  The "on" and
"off" match the physical markings on the switches as you look at them.

SW1: on,off,off,off,off,off,off,on
SW2: on,off,on,off,off,on,on,on
SW3: on,off,off,off,on,on,on,off


FYI, this is the info printed by dink for you to compare with:

I/O system initialized...
Memory Enabled: [ 128MB at CL=2 ]
Caches Enabled: [ L1I(32K), L1D(32K) ]
Register Inits: [ 32 GPRs, 32 FPRs, 224 SPRs, 32 VPRs ]


                 ##  ##            ##
                 ##  ##            ##
                 ##                ##
            #######  ##  #######   ##    ##
           ##    ##  ##  ##    ##  ##   ##
           ##    ##  ##  ##    ##  ######
           ##    ##  ##  ##    ##  ##   ## 
            ######   ##  ##    ##  ##    ##

      (        (    (  ( (AltiVec) )  )    )        )

   Version : 13.1.1, Metaware Build
  Released : INTERIM( build 784 on Dec 16 2003 15:50:00 )
Written by : Motorola CPD/NCSG PowerPC Applications, Austin, TX
    System : Sandpoint X3 with Valis (MPMC7447A)
 Processor : MPC7447A V1.1 @ 1000 MHz, 100 MHz memory
    Memory : Map B (CHRP) 128MB at CL=2

Copyright 1993-2003, by Motorola Inc.


DINK32[MPC7447A] {1} >>
