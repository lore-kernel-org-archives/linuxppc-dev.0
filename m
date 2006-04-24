Return-Path: <aidan@nicta.com.au>
Received: from mail24.syd.optusnet.com.au (mail24.syd.optusnet.com.au
	[211.29.133.165])
	(using TLSv1 with cipher EDH-RSA-DES-CBC3-SHA (168/168 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 4D44E67A00
	for <linuxppc-embedded@ozlabs.org>;
	Tue, 25 Apr 2006 09:02:33 +1000 (EST)
Message-ID: <444D5907.6010506@nicta.com.au>
Date: Tue, 25 Apr 2006 09:02:31 +1000
From: Aidan Williams <aidan@nicta.com.au>
MIME-Version: 1.0
To: Vincent Winstead <vwinstead@yahoo.com>
Subject: Re: Xilinx Virtex-2 PRO FPGA ppc 405 on ML310 board
References: <20060424203047.86885.qmail@web52005.mail.yahoo.com>
In-Reply-To: <20060424203047.86885.qmail@web52005.mail.yahoo.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Cc: linuxppc-embedded list <linuxppc-embedded@ozlabs.org>
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>


After generating a new auto-config.in using the BSP,
you'll need to:

   0. put new auto-config.in into kernel directory
      linux-2.4.x/arch/ppc/platforms/xilinx_auto

   1. change to the top uClinux-dist directory
      (*NOT* the kernel directory)

   2. In "Vendor/Product Selection  --->"
      Choose "Xilinx"
      Choose "powerpc-auto"

   3. In "Kernel/Library/Defaults Selection  --->"
      Choose linux-2.4.x as your kernel, making sure that
      this is a symlink to or copy of the linuxppc-2.4
      tarball from UQ.

   4. In "Kernel/Library/Defaults Selection  --->"
      Choose "[*] Default all settings (lose changes)"

   5. Save and quit..

This process will pull in default Xilinx/powerpc config
files from vendors/Xilinx/powerpc-auto/config.*
for the kernel and for other uClinux components.

It will also generate a new linux-2.4.x/.config
based on your auto-config.in and the defaults
in vendors/Xilinx/powerpc-auto/config.linux-2.4.x.

btw, I don't have an ML310 board.  I have however gotten
the UQ kernel + uclinux to work on a v2pro FF1152 board
and a virtex-4 FX-12 minimodule.

another btw, the linuxppc-2.4 code has an auto-config.in
inside it which, if you follow the above steps (without
doing step 0), should compile.  The supplied auto-config.in
won't match your board, but it should at least compile.

- aidan


Vincent Winstead wrote:
> guess what - I got the BSP to work!  But now I have a problem with the 
> make command.  I put the auto-config.in where it needs to be then I did 
> a make menuconfig to configure it, then I did a make dep, but when I did 
> a make is when  an error came up that I can't seem to figure out:
> 
> In file included from 
> /home/ml310_linux/uClinux-dist/linuxppc-2.4/include/linux/pagemap.h:16,
>                  from 
> /home/ml310_linux/uClinux-dist/linuxppc-2.4/include/linux/locks.h:8,
>                  from 
> /home/ml310_linux/uClinux-dist/linuxppc-2.4/include/linux/blk.h:5,
>                  from init/main.c:25:
> /home/ml310_linux/uClinux-dist/linuxppc-2.4/include/linux/highmem.h: In 
> function `kmap':
> /home/ml310_linux/uClinux-dist/linuxppc-2.4/include/linux/highmem.h:68: 
> error: `CONFIG_KERNEL_START' undeclared (first use in this function)
> init/main.c: In function `start_kernel':
> init/main.c:393: error: `CONFIG_KERNEL_START' undeclared (first use in 
> this function)
> make[1]: *** [init/main.o] Error 1
> make[1]: Leaving directory `/home/ml310_linux/uClinux-dist/linuxppc-2.4'
> make: *** [linux] Error 1
> 
> This CONFIG_KERNEL_START is the problem.  It doesn't seem to be defined 
> anywhere and I guess it needs to be.  Is this something I need to get 
> from somewhere?  Or is it maybe generated along with the BSP so I would 
> have to put a start number into the platform Studio configuration?
> 
> -Vincent
> 
> 
> */Aidan Williams /* wrote:
> 
> 
>     Vincent Winstead wrote:
>      > Now, as far as step 5, am I supposed to have a symbolic link that is
>      > named linux-2.4.x placed into the uClinux-dist directory? Because
>      > there's already a folder named linux-2.4.x which was in there
>     already
>      > when I untarred everything. At the command prompt in the
>     uClinux-dist
>      > directory I entered the following line:
>      >
>      > ln -s ../linuxppc-2.4 linux-2.4.x
>      >
>      > and the result of this operation was to put a symbolic link into my
>      > linuxppc-2.4 directory with the name of linux-2.4.x - is this
>     correct?
>      >
> 
>     First, you'll need to move the existing directory aside using
>     a command like:
> 
>     mv linux-2.4.x linux-2.4.x-dist
> 
>     and then re-run the ln -s command above.
> 
>      > Now on to Step 6 problem.
>      > How am I supposed to make use uClinux EDK Board Support Package 1.0
>      > files? I'm not sure how to go about using them in the Xilinx
>     Platform
>      > Studio in order to generate the necessary auto-config.in file.
>      >
> 
>     See the document below for the general approach:
> 
>      > Even though it is about the microblaze rather than
>      > the PPC, a helpful "getting started" document is:
>      >
>     http://www.itee.uq.edu.au/~wu/downloads/uClinux_ready_Microblaze_design.pdf
>      >
> 
>     Look particularly at the section "Software Platform Settings"
>     on page 29, steps 67,68.
> 
>     If you are not overly familiar with the EDK, it would
>     be best to find someone locally who can help walk you
>     through the process of generating a system.
> 
>     - aidan
> 
> 
>     --------------------------------------------------------------------------
>     This email and any attachments may be confidential. They may contain
>     legally
>     privileged information or copyright material. You should not read, copy,
>     use or disclose them without authorisation. If you are not an intended
>     recipient, please contact us at once by return email and then delete
>     both
>     messages. We do not accept liability in connection with computer virus,
>     data corruption, delay, interruption, unauthorised access or
>     unauthorised
>     amendment. This notice should not be removed.
> 
> 
