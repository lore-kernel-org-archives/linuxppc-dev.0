Return-Path: <rpjday@mindspring.com>
Received: from mailhost.rdmcorp.com (world.rdmcorp.com [204.225.180.10])
	by ozlabs.org (Postfix) with ESMTP id D35932BD6A
	for <linuxppc-dev@ozlabs.org>; Sat, 18 Sep 2004 07:11:53 +1000 (EST)
Received: from [10.1.1.102] (10.1.2.1) by mailhost.rdmcorp.com (Worldmail
	1.3.167) for linuxppc-dev@ozlabs.org; 17 Sep 2004 16:48:44 -0400
Date: Fri, 17 Sep 2004 16:42:33 -0400 (EDT)
From: "Robert P. J. Day" <rpjday@mindspring.com>
To: Linuxppc-dev mailing list <linuxppc-dev@ozlabs.org>
Message-ID: <Pine.LNX.4.60.0409171634340.5645@localhost.localdomain>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Subject: where to find explanation of CP "RISC controller trap registers"?
List-Id: "Linux on PowerPC \(Including Embedded\) Developers Mail List"
	<linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


   i'm working with the latest "bk pull" of the kernel source tree from 
ppc.bkbits.net/linuxppc-2.5, and i'm reading 
arch/ppc/8xx_io/micropatch.c to understand the intricacies of how 
patches get applied.

   it all looks fairly straightforward, except in a couple cases where 
the CP RISC controller trap registers are set to, allegedly, enable 
the traps to get to [the patch].

   example from micropatch.c:

#ifdef USE_IIC_PATCH
         /* Enable the traps to get to it.
         */
         commproc->cp_cpmcr1 = 0x802a;
         commproc->cp_cpmcr2 = 0x8028;
         commproc->cp_cpmcr3 = 0x802e;
         commproc->cp_cpmcr4 = 0x802c;

         /* Enable uCode fetches from DPRAM.
         */
         commproc->cp_rccr = 1;

         printk("I2C uCode patch installed\n");
#endif


   i've looked in vain in my copy of the MPC850 Family User's Manual 
for the breakdown of these trap registers and their values.  chapter 
18 on the Comm Processor maddeningly just seems to jump over these 
registers, unless i'm totally missing something.

   hints?

rday
