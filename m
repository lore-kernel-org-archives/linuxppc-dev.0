Message-ID: <37512D45.1088A55A@wanadoo.fr>
Date: Sun, 30 May 1999 14:21:25 +0200
From: Martin Costabel <costabel@wanadoo.fr>
MIME-Version: 1.0
To: linuxppc-user@lists.linuxppc.org
CC: linuxppc-dev@lists.linuxppc.org
Subject: Re: Problem compiling egcs
References: <374E4267.5BF46F98@wanadoo.fr>
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Just to set the record straight:

This problem is now solved. It came from a kernel header file
include/asm-ppc/ptrace.h which, in the vger version 2.3.3 of the last 2
weeks, contained the definition
   #define REG unsigned long
It has been fixed yesterday. Thanks, Cort.

Martin Costabel wrote on Fri, 28 May 1999:
> 
> When trying to compile egcs-1.1.2 from the src.rpm, I get the following
> error:
> 
>   gcc  -DIN_GCC    -g  -DHAVE_CONFIG_H -DHAIFA    -I.
> -I/usr/src/redhat/BUILD/egcs-1.1.2/gcc
> -I/usr/src/redhat/BUILD/egcs-1.1.2/gcc/config  \
>     -DTARGET_NAME=\"ppc-redhat-linux\" \
>     -c `echo /usr/src/redhat/BUILD/egcs-1.1.2/gcc/toplev.c | sed
> 's,^\./,,'`
>   In file included from /usr/src/redhat/BUILD/egcs-1.1.2/gcc/rtl.h:41,
>                  from /usr/src/redhat/BUILD/egcs-1.1.2/gcc/toplev.c:49:
>   /usr/src/redhat/BUILD/egcs-1.1.2/gcc/rtl.def:549: parse error before
> `unsigned'
>   make[2]: *** [toplev.o] Error 1
>   make[2]: Leaving directory `/mnt/root2/BUILD/obj-ppc-linux/gcc'
>   make[1]: *** [bootstrap-lean] Error 2
> 
> The same error occured when I tried to compile gcc-2.95 from the cvs
> tree. I am using egcs-1.1.2-1c on pre-R5 with
> binutils-2.9.1.0.990418-1c. Processor is 603ev (PMac 6400/200).
> 
> There is no `unsigned' in gcc/rtl.def anywhere. Line 549 reads
>   DEF_RTL_EXPR(REG, "reg", "i0", 'o')
> 
> Since no one else seems to have this problem, I am beginning to believe
> that it is 603 related. Is this possible?
> 
> Any help appreciated.
> 
> --
> Martin

[[ This message was sent via the linuxppc-dev mailing list.  Replies are ]]
[[ not  forced  back  to the list, so be sure to Cc linuxppc-dev if your ]]
[[ reply is of general interest. Please check http://lists.linuxppc.org/ ]]
[[ and http://www.linuxppc.org/ for useful information before posting.   ]]
