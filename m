Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client did not present a certificate)
 by ozlabs.org (Postfix) with ESMTPS id 9C75D2C013B
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 20 Aug 2013 06:56:51 +1000 (EST)
Message-ID: <1376945799.25016.77.camel@pasglop>
Subject: Re: Critical Interrupt Input
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: hbausley@deltatau.com
Date: Tue, 20 Aug 2013 06:56:39 +1000
In-Reply-To: <63d2635a$648939a4$b3aeac8$@deltatau.com>
References: <63d2635a$648939a4$b3aeac8$@deltatau.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Cc: linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Mon, 2013-08-19 at 12:00 -0700, Henry Bausley wrote:
> 
> Support does appear to be present but there is a problem returning
> back to user space I suspect.

Probably a problem with TLB misses vs. crit interrupts.

A critical interrupt can re-enter a TLB miss.

I can see two potential issues there:

 - A bug where we don't properly restore "something" (I thought we did
save and restore MMUCR though, but that's worth dbl checking if it works
properly) accross the crit entry/exit

 - Something in your crit code causing a TLB miss (the
kernel .text/.data/.bss should be bolted but anything else can). We
don't currently support re-entering the TLB miss that way.

If we were to support the latter, we'd need to detect on entering a crit
that the PC is within the TLB miss handler, and setup a return context
to the original instruction (replay the miss) rather than trying to
resume it..

Cheers,
Ben.

> What fails is it causes Linux user space programs to get Segmentation
> errors.
> Issuing a simple ls causes a segmentation fault sometimes.  The shell
> gets terminated 
> and you cannot log back in.  INIT: Id "T0" respawning too fast:
> disabled for 5 minutes pops up.
> 
> However, the critical interrupt handler keeps running.  I know this by
> adding the reading 
> of a physical I/O location in the handler and can see it is being read
> on the scope.
> 
> 
> The only code in the handler is below.
> 
> void critintr_handler(void *dev)
> {
>   critintrcount++;          // increment a variable
>   iodata = *piom;           // read an I/O location 
>   mtdcr(0x0c0, 0x00002000); // clear critical interrupt
> }
> 
> 
> Below is a log of the type of crashes that occur:
> 
> root@10.34.9.213:/opt/ppmac/ktest# ls
> Segmentation fault
> root@10.34.9.213:/opt/ppmac/ktest# ls
> Segmentation fault
> root@10.34.9.213:/opt/ppmac/ktest# ls
> Makefile        ktest.c    ktest.ko     ktest.mod.o  modules.order
> Module.symvers  ktest.cbp  ktest.mod.c  ktest.o
> root@10.34.9.213:/opt/ppmac/ktest# ls
> 
> Debian GNU/Linux 7 powerpmac ttyS0
> 
> powerpmac login: root
> 
> Debian GNU/Linux 7 powerpmac ttyS0
> 
> powerpmac login: root
> 
> Debian GNU/Linux 7 powerpmac ttyS0
> 
> powerpmac login: root
> 
> Debian GNU/Linux 7 powerpmac ttyS0
> 
> powerpmac login: root
> Password: 
> Last login: Thu Nov 30 20:42:16 UTC 1933 on ttyS0
> Linux powerpmac 3.2.21-aspen_2.01.09 #10 Mon Aug 19 08:49:12 PDT 2013
> ppc
> 
> The programs included with the Debian GNU/Linux system are free
> software;
> the exact distribution terms for each program are described in the
> individual files in /usr/share/doc/*/copyright.
> 
> Debian GNU/Linux comes with ABSOLUTELY NO WARRANTY, to the extent
> permitted by applicable law.
> INIT: Id "T0" respawning too fast: disabled for 5 minutes
> 
> 
> ______________________________________________________________________
> From: "Benjamin Herrenschmidt" <benh@kernel.crashing.org>
> Sent: Saturday, August 17, 2013 3:05 PM
> To: "Kumar Gala" <galak@kernel.crashing.org>
> Cc: linuxppc-dev@lists.ozlabs.org, hbausley@deltatau.com
> Subject: Re: Critical Interrupt Input
> 
> On Fri, 2013-08-16 at 06:04 -0500, Kumar Gala wrote:
> > The 44x low level code needs to handle exception stacks properly for
> > this to work. Since its possible to have a critical exception occur
> > while in a normal exception level, you have to have proper saving of
> > additional register state and a stack frame for the critical
> > exception, etc. I'm not sure if that was ever done for 44x.
> 
> Don't 44x and FSL BookE share the same macros ? I would think 44x does
> indeed implement the same crit support as e500...
> 
> What does the crash look like ?
> 
> Ben.
> 
> 
> _______________________________________________
> Linuxppc-dev mailing list
> Linuxppc-dev@lists.ozlabs.org
> https://lists.ozlabs.org/listinfo/linuxppc-dev
> 
> 
>   ­­  
