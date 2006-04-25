Return-Path: <vwinstead@yahoo.com>
Received: from web52006.mail.yahoo.com (web52006.mail.yahoo.com
	[206.190.48.89]) by ozlabs.org (Postfix) with SMTP id 9505667A67
	for <linuxppc-embedded@ozlabs.org>;
	Wed, 26 Apr 2006 08:21:09 +1000 (EST)
Message-ID: <20060425222107.97443.qmail@web52006.mail.yahoo.com>
Date: Tue, 25 Apr 2006 15:21:06 -0700 (PDT)
From: Vincent Winstead <vwinstead@yahoo.com>
Subject: Re: Xilinx Virtex-2 PRO FPGA ppc 405 on ML310 board
To: Aidan Williams <aidan@nicta.com.au>
In-Reply-To: <444D5907.6010506@nicta.com.au>
MIME-Version: 1.0
Content-Type: multipart/alternative; boundary="0-2042123512-1146003666=:78167"
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

--0-2042123512-1146003666=:78167
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit

Ok, so all that worked - it WAS necessary to choose  "[*] Default all settings (lose changes)" in order for it to work though.  Without this option checked I needed to add information and variables and constants and definitions that were not added into necessary files after make menuconfig and make dep were completed.  
   But I still have nothing working with the ML310 board.  I did a "dow image.elf" at the XMD command prompt, then "con" and it showed up with a "RUNNING>" prompt, but nothing showed up on the hyperterminal window.  I compiled using 115200 baud and I changed my hyperterminal to match this, but nothing shows up ...at all.  Where do you think I would need to start looking to resolve this issue?  
 
 -Vincent

Aidan Williams <aidan@nicta.com.au> wrote: 
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



--0-2042123512-1146003666=:78167
Content-Type: text/html; charset=iso-8859-1
Content-Transfer-Encoding: 8bit

Ok, so all that worked - it WAS necessary to choose&nbsp; "[*] Default all settings (lose changes)" in order for it to work though.&nbsp; Without this option checked I needed to add information and variables and constants and definitions that were not added into necessary files after make menuconfig and make dep were completed.&nbsp; <br> &nbsp; But I still have nothing working with the ML310 board.&nbsp; I did a "dow image.elf" at the XMD command prompt, then "con" and it showed up with a "RUNNING&gt;" prompt, but nothing showed up on the hyperterminal window.&nbsp; I compiled using 115200 baud and I changed my hyperterminal to match this, but nothing shows up ...at all.&nbsp; Where do you think I would need to start looking to resolve this issue?&nbsp; <br> <br> -Vincent<br><br><b><i>Aidan Williams &lt;aidan@nicta.com.au&gt;</i></b> wrote:<blockquote class="replbq" style="border-left: 2px solid rgb(16, 16, 255); margin-left: 5px; padding-left: 5px;"> <br>After generating
 a new auto-config.in using the BSP,<br>you'll need to:<br><br>   0. put new auto-config.in into kernel directory<br>      linux-2.4.x/arch/ppc/platforms/xilinx_auto<br><br>   1. change to the top uClinux-dist directory<br>      (*NOT* the kernel directory)<br><br>   2. In "Vendor/Product Selection  ---&gt;"<br>      Choose "Xilinx"<br>      Choose "powerpc-auto"<br><br>   3. In "Kernel/Library/Defaults Selection  ---&gt;"<br>      Choose linux-2.4.x as your kernel, making sure that<br>      this is a symlink to or copy of the linuxppc-2.4<br>      tarball from UQ.<br><br>   4. In "Kernel/Library/Defaults Selection  ---&gt;"<br>      Choose "[*] Default all settings (lose changes)"<br><br>   5. Save and quit..<br><br>This process will pull in default Xilinx/powerpc config<br>files from vendors/Xilinx/powerpc-auto/config.*<br>for the kernel and for other uClinux components.<br><br>It will also generate a new linux-2.4.x/.config<br>based on your auto-config.in and the
 defaults<br>in vendors/Xilinx/powerpc-auto/config.linux-2.4.x.<br><br>btw, I don't have an ML310 board.  I have however gotten<br>the UQ kernel + uclinux to work on a v2pro FF1152 board<br>and a virtex-4 FX-12 minimodule.<br><br>another btw, the linuxppc-2.4 code has an auto-config.in<br>inside it which, if you follow the above steps (without<br>doing step 0), should compile.  The supplied auto-config.in<br>won't match your board, but it should at least compile.<br><br>- aidan<br><br><br>Vincent Winstead wrote:<br>&gt; guess what - I got the BSP to work!  But now I have a problem with the <br>&gt; make command.  I put the auto-config.in where it needs to be then I did <br>&gt; a make menuconfig to configure it, then I did a make dep, but when I did <br>&gt; a make is when  an error came up that I can't seem to figure out:<br>&gt; <br>&gt; In file included from <br>&gt; /home/ml310_linux/uClinux-dist/linuxppc-2.4/include/linux/pagemap.h:16,<br>&gt;                  from
 <br>&gt; /home/ml310_linux/uClinux-dist/linuxppc-2.4/include/linux/locks.h:8,<br>&gt;                  from <br>&gt; /home/ml310_linux/uClinux-dist/linuxppc-2.4/include/linux/blk.h:5,<br>&gt;                  from init/main.c:25:<br>&gt; /home/ml310_linux/uClinux-dist/linuxppc-2.4/include/linux/highmem.h: In <br>&gt; function `kmap':<br>&gt; /home/ml310_linux/uClinux-dist/linuxppc-2.4/include/linux/highmem.h:68: <br>&gt; error: `CONFIG_KERNEL_START' undeclared (first use in this function)<br>&gt; init/main.c: In function `start_kernel':<br>&gt; init/main.c:393: error: `CONFIG_KERNEL_START' undeclared (first use in <br>&gt; this function)<br>&gt; make[1]: *** [init/main.o] Error 1<br>&gt; make[1]: Leaving directory `/home/ml310_linux/uClinux-dist/linuxppc-2.4'<br>&gt; make: *** [linux] Error 1<br>&gt; <br>&gt; This CONFIG_KERNEL_START is the problem.  It doesn't seem to be defined <br>&gt; anywhere and I guess it needs to be.  Is this something I need to get <br>&gt; from
 somewhere?  Or is it maybe generated along with the BSP so I would <br>&gt; have to put a start number into the platform Studio configuration?<br>&gt; <br>&gt; -Vincent<br>&gt; <br>&gt; <br>&gt; */Aidan Williams /* wrote:<br>&gt; <br>&gt; <br>&gt;     Vincent Winstead wrote:<br>&gt;      &gt; Now, as far as step 5, am I supposed to have a symbolic link that is<br>&gt;      &gt; named linux-2.4.x placed into the uClinux-dist directory? Because<br>&gt;      &gt; there's already a folder named linux-2.4.x which was in there<br>&gt;     already<br>&gt;      &gt; when I untarred everything. At the command prompt in the<br>&gt;     uClinux-dist<br>&gt;      &gt; directory I entered the following line:<br>&gt;      &gt;<br>&gt;      &gt; ln -s ../linuxppc-2.4 linux-2.4.x<br>&gt;      &gt;<br>&gt;      &gt; and the result of this operation was to put a symbolic link into my<br>&gt;      &gt; linuxppc-2.4 directory with the name of linux-2.4.x - is this<br>&gt;     correct?<br>&gt;
      &gt;<br>&gt; <br>&gt;     First, you'll need to move the existing directory aside using<br>&gt;     a command like:<br>&gt; <br>&gt;     mv linux-2.4.x linux-2.4.x-dist<br>&gt; <br>&gt;     and then re-run the ln -s command above.<br>&gt; <br>&gt;      &gt; Now on to Step 6 problem.<br>&gt;      &gt; How am I supposed to make use uClinux EDK Board Support Package 1.0<br>&gt;      &gt; files? I'm not sure how to go about using them in the Xilinx<br>&gt;     Platform<br>&gt;      &gt; Studio in order to generate the necessary auto-config.in file.<br>&gt;      &gt;<br>&gt; <br>&gt;     See the document below for the general approach:<br>&gt; <br>&gt;      &gt; Even though it is about the microblaze rather than<br>&gt;      &gt; the PPC, a helpful "getting started" document is:<br>&gt;      &gt;<br>&gt;     http://www.itee.uq.edu.au/~wu/downloads/uClinux_ready_Microblaze_design.pdf<br>&gt;      &gt;<br>&gt; <br>&gt;     Look particularly at the section "Software Platform
 Settings"<br>&gt;     on page 29, steps 67,68.<br>&gt; <br>&gt;     If you are not overly familiar with the EDK, it would<br>&gt;     be best to find someone locally who can help walk you<br>&gt;     through the process of generating a system.<br>&gt; <br>&gt;     - aidan<br>&gt; <br>&gt; <br>&gt;     --------------------------------------------------------------------------<br>&gt;     This email and any attachments may be confidential. They may contain<br>&gt;     legally<br>&gt;     privileged information or copyright material. You should not read, copy,<br>&gt;     use or disclose them without authorisation. If you are not an intended<br>&gt;     recipient, please contact us at once by return email and then delete<br>&gt;     both<br>&gt;     messages. We do not accept liability in connection with computer virus,<br>&gt;     data corruption, delay, interruption, unauthorised access or<br>&gt;     unauthorised<br>&gt;     amendment. This notice should not be
 removed.<br>&gt; <br>&gt; <br><br></blockquote><br>
--0-2042123512-1146003666=:78167--
