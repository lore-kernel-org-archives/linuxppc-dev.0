Date: Wed, 14 Jul 1999 14:04:03 -0400
From: Daniel Jacobowitz <drow@false.org>
To: Grant Carter <gcarter@eng.uct.ac.za>
Cc: linuxppc-dev@lists.linuxppc.org
Subject: Re: Some Cross Compiling Questions
Message-ID: <19990714140403.A24588@drow.res.cmu.edu>
References: <378CAFAD.32A1660D@eng.uct.ac.za>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <378CAFAD.32A1660D@eng.uct.ac.za>; from Grant Carter on Wed, Jul 14, 1999 at 05:41:33PM +0200
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On Wed, Jul 14, 1999 at 05:41:33PM +0200, Grant Carter wrote:
> 
> Hi all
> 
> I am very new at using the GNU tools and cross compilers etc and am
> wanting to compile Linux for the RPXLite Board running a PowerPC 823. I
> have gone throught the CrossGCC FAQ as well as a document on Cross
> Development for Linux/PPC but I still have a few questions/problems
> which I hope someone can help me with please.
> 
> I am running an i386-FreeBSD system and, as I said before, am wanting to
> build a PowerPC-linux system. I have built binutils-2.9.1.0.25 and
> egcs-1.1.2 successfully and have used that to build the LinuxPPC kernel
> (2.2.5). Everything compiled fine but I want to know 2 things: I have
> read about libgcc.o and was wondering if I had to provide my own one or
> if gcc knew enough about the 823 to build its own. Secondly, how do I
> get floating point emulation running as the 823 doesn't provide hardware
> floating point. I saw a --nfp in the configuration options - should I
> enable this?

You want -msoft-float.  Most likely when you build egcs it will build a
bunch of files in subdirectories named nof.  These are used when you
specify -msoft-float on the command line.

> Next I tried to compile both glibc which failed. The error message was
> as follows:
> 
> ../sysdeps/powerpc/s_isnan.c: In function `__isnan':
> ../sysdeps/powerpc/s_isnan.c:32: fixed or forbidden register 32 (0) was
> spilled for class FLOAT_REGS. This may be due to a compiler bug or to
> impossible asm statements or clauses.
> 
> Is this related to my needing the correct libgcc.o file so that the
> assembler knows how to implement these functions or what?

Bad version of gcc.  Try the latest 2.95 snapshots.

> I also tried newlib 1.8.1 and newlib 1.7.1. They were complaining about
> crt1.0 and crt1.s respectively. I believe that I need one of these files
> built for my target platform. Can someone provide me with one or do I
> have to write my own? If so, can someone please point me in the
> direction of some documentation about the contents of these files? 

crt*.o come partly with glibc and partly with egcs; crt1.o is from
glibc.  I would expect newlib to have it.

Dan

/--------------------------------\  /--------------------------------\
|       Daniel Jacobowitz        |__|        SCS Class of 2002       |
|   Debian GNU/Linux Developer    __    Carnegie Mellon University   |
|         dan@debian.org         |  |       dmj+@andrew.cmu.edu      |
\--------------------------------/  \--------------------------------/

[[ This message was sent via the linuxppc-dev mailing list.  Replies are ]]
[[ not  forced  back  to the list, so be sure to Cc linuxppc-dev if your ]]
[[ reply is of general interest. Please check http://lists.linuxppc.org/ ]]
[[ and http://www.linuxppc.org/ for useful information before posting.   ]]
