Return-Path: <owner-linuxppc-embedded@lists.linuxppc.org>
Subject: Re: using cpm interrupts on 8xx
From: Nate Pletcher <pletch@po.cwru.edu>
To: Wolfgang Denk <wd@denx.de>
Cc: linuxppc-embedded@lists.linuxppc.org
In-Reply-To: <20020522162110.447DF1196F@denx.denx.de>
References: <20020522162110.447DF1196F@denx.denx.de>
Content-Type: text/plain
Date: 23 May 2002 15:01:26 -0400
Message-Id: <1022180488.1225.63.camel@soundgarden>
Mime-Version: 1.0
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


On Wed, 2002-05-22 at 12:21, Wolfgang Denk wrote:
> > interrupt for the CPM and then another handler for the individual IDMA
> > interrupt from the CPM?  Perhaps someone could point me to some
>
> No, the CPM has it's own interrupt already registered  with  the  SIU
> (because  things  like  the console UART or Ethernet need it anyway).
> You are right in principle, though: this registration was done  using
> request_8xxirq() - but it has to be done only once, and Linux already
> did  this  for you. So all you need is to call cpm_install_handler().
> to register your CPM interrupt handler.

Thanks for the explanation.  Now I understand how the CPM interrupts
work.

Ok, I tried using cpm_install_handler in my loadable module by including
arch/ppc/8xx_io/commproc.h and it compiles cleanly, but when I try to
insert the module I get:

# insmod fpga.o
fpga.o: unresolved symbol cpm_install_handler

I looked through the Linux 2.2.14 source we are using and the function
is there but it isn't exported in arch/ppc/kernel/ppc_ksyms.c.  I added
a line to export the symbol but still got the same error.  Any ideas?

> > We're using MontaVista's
> > Hard Hat Linux CDK 1.2 with the 2.2.14 kernel and included tools.
>
> This stuff is _awfully_ old. Why don't you use a more current kernel?

We're in the process of migrating to a new kernel, and this may solve
the problem.  Does anyone have recommendations for kernel sources that
are easy to get running on a CLLF/RPXlite board (i.e. kernel.org with
ppc patch or BitKeeper linux_2_4?)

Thanks,
Nate


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
