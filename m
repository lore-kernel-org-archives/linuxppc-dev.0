Return-Path: <vijay_padiyar@hotmail.com>
Received: from hotmail.com (bay1-dav7.bay1.hotmail.com [65.54.244.111])
	by ozlabs.org (Postfix) with ESMTP id 7FE252BF0E
	for <linuxppc-embedded@ozlabs.org>;
	Wed, 12 Jan 2005 21:54:47 +1100 (EST)
Message-ID: <BAY1-DAV73031B6EE6F449E9ED3AD8B890@phx.gbl>
From: "Vijay Padiyar" <vijay_padiyar@hotmail.com>
To: "LinuxPPC Support" <linuxppc-embedded@ozlabs.org>
Date: Wed, 12 Jan 2005 16:07:09 +0530
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Subject: Some issues with kernel 2.6 for MPC8260 target
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

Hi all

I wish to discuss some strange issues that I faced with respect to the Linux
2.6.8 kernel (downloaded from kernel.org). Firstly, I wish to know whether
this has been known to work on an MPC8260 PowerPC target.

Secondly, when I tried to compile the Linux kernel with my toolchain (built
with Dan Kegel's crosstool for the PowerPC 603e core, which is what my
processor has), I got some errors which I found to rather queer after
investigation. Firstly, let me state the errors that I got:

------------------------------------------------------

  LD      init/built-in.o
  LD      .tmp_vmlinux1
arch/ppc/8260_io/built-in.o(.text+0x103c): In function `mii_queue_relink':
arch/ppc/8260_io/fcc_enet.c:1254: undefined reference to `schedule_task'
arch/ppc/8260_io/built-in.o(.text+0x1074): In function `mii_queue_config':
arch/ppc/8260_io/fcc_enet.c:1263: undefined reference to `schedule_task'

------------------------------------------------------

On further investigation, I find that 'schedule_task()' is simply not
defined anywhere in the 2.6.8 kernel sources. This is quite wierd! However,
it is defined in a file 'context.c' (linux-src/kernel) in the 2.4.27 kernel
sources, which we were using earlier. How is it that a function is being
called but its definition has been removed from the sources?

Another such example is with the structure 'tq_struct'. It is referred to in
the file 'fcc_enet.c' (linux-src/arch/ppc/8260_io) but it's not defined
anywhere! Again, after checking in the 2.4.27 sources, I find that it's
defined in the file 'tqueue.h' (linux-src/include/linux)!

A third thing is that the 2.4.27 kernel source file 'uart.c'
(linux-src/arch/ppc/cpm2_io) is not present in the corresponding folder in
the 2.6.8 source (linux-src/arch/ppc/8260_io). There is one 'uart.c' in the
folder '8xx_io', but it doesn't get compiled during the kernel build
process. Will my UART work correctly with this build?

Can someone please tell me if there's some explanation for this that I'm
unaware of? Which would be the proper forum to report this? Again I would
like to ask: Has the 2.6.8 kernel been tested successfully on the MPC8260
PowerPC platform?

Lastly, where can I get the latest stable Linux kernel source for the
PowerPC platform?

Regards

Vijay Padiyar
