Return-Path: <vijay_padiyar@hotmail.com>
Received: from hotmail.com (bay1-dav16.bay1.hotmail.com [65.54.244.120])
	by ozlabs.org (Postfix) with ESMTP id 68C1467A6D
	for <linuxppc-embedded@ozlabs.org>;
	Tue,  8 Mar 2005 01:48:35 +1100 (EST)
Message-ID: <BAY1-DAV1661FC7797CF282A10A46F8B5F0@phx.gbl>
From: "Vijay Padiyar" <vijay_padiyar@hotmail.com>
To: "Ramsay, Jim" <jimr@artesyncp.com>,
	"LinuxPPC Support" <linuxppc-embedded@ozlabs.org>
References: <797470E884C6D611B7A500B0D0AA56D0025960D9@batistuta.spider.com>
Date: Mon, 7 Mar 2005 20:19:09 +0530
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Subject: Re: Linux 2.6 port for M8260 PPC
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

Hi there

Ya I found that the code related to the MDIO implementation (CONFIG_MDIO)
hasn't been completely ported yet for the 2.6 kernel. Therefore, disabling
the option CONFIG_MDIO in menuconfig should solve the problem.

In case you wish to retain the option, you can copy the appropriate header
files from the 2.4 kernel source into the 2.6 tree. I think the relevant
file is kernel/context.c. Also, in another file, they're referring to a
structure tq_struct, which is defined in linux/tqueue.h. You can copy this
file to your 2.6 source tree as well.

However, this is not recommended, since we're mixing code from two separate
kernels. The tqueue.h header file is related to task queues, which have been
replaced in 2.6 with work queues. It's just that the file calling tq_struct
hasn't been ported yet, apparently. Therefore, it's best to omit the
erroneous code by not selecting the appropriate option in menuconfig. In
this case, all you need to do is disable CONFIG_MDIO.

Regards

Vijay Padiyar

http://www.vijaypadiyar.eu.tf
----- Original Message ----- 
From: "Ramsay, Jim" <jimr@artesyncp.com>
To: <vijay_padiyar@hotmail.com>
Sent: Monday, March 07, 2005 7:56 PM
Subject: Linux 2.6 port for M8260 PPC


> Hi,
>
> I found this using google, going through EXACTLY the same problems trying
to
> port some 2.4 code we have to 2.6.
>
> Did you find out how to get around these problems?
>
> Thanks,
>
> Jim
>
>
>
> Hi all I wish to discuss some strange issues that I faced with respect to
> the Linux 2.6.8 kernel (downloaded from kernel.org). Firstly, I wish to
know
> whether this has been known to work on an MPC8260 PowerPC target.
Secondly,
> when I tried to compile the Linux kernel with my toolchain (built with Dan
> Kegel's crosstool for the PowerPC 603e core, which is what my processor
> has), I got some errors which I found to rather queer after investigation.
> Firstly, let me state the errors that I got:
> ------------------------------------------------------ LD init/built-in.o
LD
> .tmp_vmlinux1 arch/ppc/8260_io/built-in.o(.text+0x103c): In function
> `mii_queue_relink': arch/ppc/8260_io/fcc_enet.c:1254: undefined reference
to
> `schedule_task' arch/ppc/8260_io/built-in.o(.text+0x1074): In function
> `mii_queue_config': arch/ppc/8260_io/fcc_enet.c:1263: undefined reference
to
> `schedule_task' ------------------------------------------------------ On
> further investigation, I find that 'schedule_task()' is simply not defined
> anywhere in the 2.6.8 kernel sources. This is quite wierd! However, it is
> defined in a file 'context.c' (linux-src/kernel) in the 2.4.27 kernel
> sources, which we were using earlier. How is it that a function is being
> called but its definition has been removed from the sources? Another such
> example is with the structure 'tq_struct'. It is referred to in the file
> 'fcc_enet.c' (linux-src/arch/ppc/8260_io) but it's not defined anywhere!
> Again, after checking in the 2.4.27 sources, I find that it's defined in
the
> file 'tqueue.h' (linux-src/include/linux)! A third thing is that the
2.4.27
> kernel source file 'uart.c' (linux-src/arch/ppc/cpm2_io) is not present in
> the corresponding folder in the 2.6.8 source (linux-src/arch/ppc/8260_io).
> There is one 'uart.c' in the folder '8xx_io', but it doesn't get compiled
> during the kernel build process. Will my UART work correctly with this
> build? Can someone please tell me if there's some explanation for this
that
> I'm unaware of? Which would be the proper forum to report this? Again I
> would like to ask: Has the 2.6.8 kernel been tested successfully on the
> MPC8260 PowerPC platform? Regards Vijay Padiyar
>
>
>
>
>
