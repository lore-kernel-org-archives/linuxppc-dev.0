Message-ID: <3FFEDA13.5050509@gcctech.com>
Date: Fri, 09 Jan 2004 11:42:59 -0500
From: "Christopher R. Johnson" <cjohnson@gcctech.com>
Reply-To: cjohnson@gcctech.com
MIME-Version: 1.0
To: kotaeji@secui.com
Cc: linuxppc-embedded@lists.linuxppc.org
Subject: Re: [Q] question about using x86 gdb to debug the remote ppc target
 (kgdb)
References: <006701c3d673$30cb7890$2c373737@hwteam6549>
Content-Type: text/plain; charset=us-ascii; format=flowed
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


You need to do a special "target" build of the gdb host side support.
 When you get the gdb sources, run the configure script something like this:

./configure --target=powerpc-405-linux-gnu --prefix=<locatin of cross
compile tools> --program-prefix=powerpc-405-linux-gnu-

This is what I do (obviously for the 405 processor).  --target tells gdb
that your target is embedded Linux on a 405.  --prefix is used to figure
out where the cross compilation tools are installed (like gcc, ld, etc.)
 --program-prefix creates the executables with a special prefix on the
filenames, which is quite important since you probably don't want to
replace your normal intel gdb program.  That way I end up running
something called powerpc-405-linux-gnu-gdb.

If you want gdbserver on the target machine, there's even more fun to
get that built right.

Hope this helps...

cj

kotaeji wrote:

>Hi, I have a question about using kgdb on PowerPC (8245)
>
>Is it possible that the host is x86, and the remote target
>is powerpc as following picture ?
>
>    HOST(x86)  ----------------------------- TARGET(ppc)
>      gdb              serial line           kgdb patch
>
>When I connect to target by gdb on x86 and do "info registers"
>to show target registers, it shows x86 registers.
>
>(gdb) info registers
>eax            0x2000   8192
>ecx            0xc3c6dd00       -1010377472
>edx            0xc3c6c000       -1010384896
>ebx            0xc0341540       -1070328512
>esp            0xc0341400       0xc0341400
>ebp            0xc3c6dd80       0xc3c6dd80
>esi            0xc3c6de4c       -1010377140
>edi            0x280008e8       671090920
>eip            0x0      0x0
>eflags         0x2      2
>cs             0x0      0
>ss             0xc5000000       -989855744
>ds             0xfed2a80        267201152
>es             0x10020300       268567296
>fs             0x0      0
>gs             0x0      0
>
>
>Is there any way that I can use x86 gdb to debug remote ppc target?
>Should I use powerpc gdb (like YellowDog) in order to debug
>ppc target?
>
>Any comments appreciated.
>
>
>

--
Christopher R. Johnson
Principal Software Engineer
GCC Printers


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
