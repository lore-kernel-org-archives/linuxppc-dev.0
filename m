Message-Id: <4.2.0.56.19990616191743.037404c0@mail.lauterbach.com>
Date: Wed, 16 Jun 1999 19:21:53 +0200
To: Eric Ding <ericding@applix.com>
From: Franz Sirl <Franz.Sirl@munich.netsurf.de>
Subject: Re: ld bug with -Bsymbolic --noinhibit-exec (2.9.1.0.990418-1c)
Cc: linuxppc-dev@lists.linuxppc.org
In-Reply-To: <199906161629.MAA09854@tuxedo.applix.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; format=flowed
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


At 18:29 16.06.99 , Eric Ding wrote:

>Hi,
>
>I'm developing on LinuxPPC R5, with egcs-1.1.2-12c and
>binutils-2.9.1.0.990418-1c installed.  I'm running into a problem with
>using the -Bsymbolic flag.  Building a shared library which references
>global symbols that are not found in it, we usually use the
>--noinhibit-exec flag so that shared library builds even without those
>symbols being bound.
>
>The build command looks like this:
>
>     gcc -shared -Wl,-v -Wl,-Bsymbolic -Wl,--noinhibit-exec -o \
>      /ax/axexec/axdata/axshlib/libaxel.so -L/ax/axexec/axdata/axshlib \
>      -L/ax/axobj/axdata/rts elimports.o elexports.o \
>      /ax/axobj/axdata/rts/axel.o
>
>Without the -Bsymbolic flag, the shared library builds fine.  With the
>flag, however, it spits out the following errors (which are expected):
>
>GNU ld version 2.9.4 (with BFD 990418)
>/ax/axobj/axdata/rts/axel.o: In function `ElfInstallLibModules':
>/ax/axobj/axdata/rts/axel.o(.text+0x38): undefined reference to 
>`ElfInstallModule'
>/ax/axobj/axdata/rts/axel.o(.text+0x48): undefined reference to 
>`ElfInstallModule'
>/ax/axobj/axdata/rts/axel.o(.text+0x58): undefined reference to 
>`ElfInstallModule'
>/ax/axobj/axdata/rts/axel.o: In function `ELElfMacroId':
>/ax/axobj/axdata/rts/axel.o(.text+0xc0): undefined reference to 
>`ElfGetModuleStartInd'
>
>On other platforms (i.e., Intel, Alpha), we also see these errors, but
>because of the --noinhibit-exec flag, the shared library is correctly
>built anyway.  But on PPC, ld returns with 1 exit status, and the shared
>library is not built.  Not using -Bsymbolic is not an option.

Hmm, what version of binutils are you using on Intel/Alpha? Does it work on 
Intel/Alpha with binutils-2.9.4.0.[3-5]?

In any case, you can try the RPM of binutils-2.9.4.0.5 on 
<ftp://dev.linuxppc.org/users/fsirl/R5/RPMS/ppc> and see if it helps.

Franz.


[[ This message was sent via the linuxppc-dev mailing list.  Replies are ]]
[[ not  forced  back  to the list, so be sure to Cc linuxppc-dev if your ]]
[[ reply is of general interest. Please check http://lists.linuxppc.org/ ]]
[[ and http://www.linuxppc.org/ for useful information before posting.   ]]
