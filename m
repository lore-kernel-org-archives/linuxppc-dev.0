Message-ID: <37E180D6.770194C3@ctam.com.au>
Date: Fri, 17 Sep 1999 09:44:23 +1000
From: Brendan Simon <bsimon@ctam.com.au>
Reply-To: bsimon@ctam.com.au
MIME-Version: 1.0
CC: "linuxppc-embedded@lists.linuxppc.org"
 <linuxppc-embedded@lists.linuxppc.org>
Subject: Re: Cross compilation for MPC860
References: <19990916125231.12806.rocketmail@web601.yahoomail.com> <37E13540.1A410F5C@broadlink.com>
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Scott Wood wrote:

> > During the make zImage I get the following errors:
> >
> > ppc_ksyms.c:71:'isa_io_base' undeclared here (not in a fonction)
> >
> > ppc_ksyms.c:71:'initializer element for '--ksymtab_isa_io_base.value'
> > is not constant,
> >
> > And the same thing with the variable pci_dram_offset.
> >
> > Perhaps is there a configuration problem or I didn't install correctly
> > the powerpc-linux environment for cross development?
>
> Your cross-compile environment is good for building kernels.  This is a kernel
> configuration issue.  I got the same isa_io_base error building on a PowerMac
> (which doesn't have ISA) until I enabled SCSI support (?!?!?).  For my MPC850 build
> I commented out EXPORT_SYMBOL(isa_io_base); and also isa_mem_base and pci_dram_offset
> in arch/ppc/kernel/ppc_ksyms.c and I was able to successfully build a kernel without SCSI.
> Note that the 2.2.5-embedded kernel compiles in ADB support whether you configured for
> it or not (correct me if I'm wrong, but that has been my experience so far), so I
> commented out L_OBJS and LX_OBJS in drivers/macintosh/Makefile and it builds without ADB.

I added #include "pci.h" after all the system includes.  This was an early hack but I am sure
it is a configuration problem.  The best way is to choose the minimum configuration items.
You will find if you include serial and serial-console support, then you will get the isa
variable problems.  Do not choose any serial settings.  The embedded stuff enables serial
console (genearally on SMC1) by default.


> > On top of that the /usr/local/powerpc_linux/include directory is empty
> > so that I can't make the ln -s with the include/linux and include/asm
> > directories(in my linux sources directory) before I want to build the
> > LibC.
>
> Mine is empty too, and I can build kernels fine, but I get lots of errors trying
> to build anything else.  Instead of fussing with it (I don't know _why_ the builds
> fail anyway) I got a PowerMac, loaded YellowDog Linux, and all is well :-)

I cross-compile from an x86-linux host to a powerpc-linux target.  In this environment I have
installed the compiler to /usr/local/gcc and the powerpc-linux specific stuff goes in
/usr/local/gcc/powerpc-linux.  I made symbolic links from
/usr/local/gcc/powerpc-linux/include/linux to <linux-src-path>/include/linux.  This worked
for me.

I have not used a Mac for development (yet).  If your compiler is /usr/bin, then you will
probably need to make a symbolic link from /usr/powerpc-linux/include/linux to
<linux-src-path>/include/linux.  Alternatively, you can use -I<linux-src-path>/include when
building your applications.

I assume that you have also built glibc for powrepc-linux if you are cross-compiling, and
installed them in $prefix/$target (eg. /usr/local/gcc/powerpc-linux/).

Brendan Simon.


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
