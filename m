From: brian.auld@adic.com
Message-ID: <995FF289C9D69747A09E42992644595405B23635@penguin.adic.com>
To: porter@cox.net, linuxppc-embedded@lists.linuxppc.org
Subject: RE: Trying to use ELDK to build Ebony/440GP
Date: Thu, 30 Jan 2003 13:02:59 -0800
MIME-Version: 1.0
Content-Type: text/plain
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Matt,

Thanks for the response. I was pretty surprised myself and to say the least
am not having a very good day.

Regarding the linuxppc_2_4_devel build attempt, these were the steps I took:

In fact, I'm going to run it again on my linux box as I regurgitate the
steps I previuosly took:

Prerequisites:
==============
- running RH8.0
- ELDK 2.0.2 installed with ppc_4xx tool chain (check)
- linuxppc_2_4_devel obtained from monte vista mirror (check)
(1) top-level Makefile hacked to read:
    - ARCH := ppc
    - CROSS_COMPILE = ppc_4xx-
(1) make mrproper
(2) make ebony_config
(3) make oldconfig
    - I accept default(s) for about 10 options I'm prompted for.
(4) make dep
(5) make zImage

When I run make zImage, I get the following error message:



===== Start of Clip =====

make[2]: Entering directory `/opt/eldk/usr/src/linuxppc_2_4_devel/kernel'
ppc_4xx-gcc -D__KERNEL__ (bla bla bla bla) sched.c
In file included from
/opt/eldk/usr/src/linuxppc_2_4_devel/include/linux/wait.h:13,
                 from
/opt/eldk/usr/src/linuxppc_2_4_devel/include/linux/fs.h:12,
                 from
/opt/eldk/usr/src/linuxppc_2_4_devel/include/linux/capability.h:17,
                 from
/opt/eldk/usr/src/linuxppc_2_4_devel/include/linux/binfmts.h:5,
                 from
/opt/eldk/usr/src/linuxppc_2_4_devel/include/linux/sched.h:9,
                 from
/opt/eldk/usr/src/linuxppc_2_4_devel/include/linux/mm.h:4,
                 from sched.c:23:
/opt/eldk/usr/src/linuxppc_2_4_devel/include/linux/kernel.h:10: stdarg.h: No
such file or directory
In file included from
/opt/eldk/usr/src/linuxppc_2_4_devel/include/linux/wait.h:13,
                 from
/opt/eldk/usr/src/linuxppc_2_4_devel/include/linux/fs.h:12,
                 from
/opt/eldk/usr/src/linuxppc_2_4_devel/include/linux/capability.h:17,
                 from
/opt/eldk/usr/src/linuxppc_2_4_devel/include/linux/binfmts.h:5,
                 from
/opt/eldk/usr/src/linuxppc_2_4_devel/include/linux/sched.h:9,
                 from
/opt/eldk/usr/src/linuxppc_2_4_devel/include/linux/mm.h:4,
                 from sched.c:23:
/opt/eldk/usr/src/linuxppc_2_4_devel/include/linux/kernel.h:74: parse error
before `va_list'
/opt/eldk/usr/src/linuxppc_2_4_devel/include/linux/kernel.h:74: warning:
function declaration isn't a prototype
/opt/eldk/usr/src/linuxppc_2_4_devel/include/linux/kernel.h:77: parse error
before `va_list'
/opt/eldk/usr/src/linuxppc_2_4_devel/include/linux/kernel.h:77: warning:
function declaration isn't a prototype
/opt/eldk/usr/src/linuxppc_2_4_devel/include/linux/kernel.h:81: parse error
before `va_list'
/opt/eldk/usr/src/linuxppc_2_4_devel/include/linux/kernel.h:81: warning:
function declaration isn't a prototype
make[2]: *** [sched.o] Error 1
make[2]: Leaving directory `/opt/eldk/usr/src/linuxppc_2_4_devel/kernel'
make[1]: *** [first_rule] Error 2
make[1]: Leaving directory `/opt/eldk/usr/src/linuxppc_2_4_devel/kernel'
make: *** [_dir_kernel] Error 2
[bauld@ppc-dev linuxppc_2_4_devel]$

===== End of Clip =====

-- Brian

-----Original Message-----
From: Matt Porter [mailto:porter@cox.net]
Sent: Thursday, January 30, 2003 3:38 PM
To: brian.auld@adic.com
Cc: linuxppc-embedded@lists.linuxppc.org
Subject: Re: Trying to use ELDK to build Ebony/440GP

On Thu, Jan 30, 2003 at 11:06:12AM -0800, brian.auld@adic.com wrote:
> (2) What's the best method to successfully build a kernel for the ebony
> board using the ELDK tools:
>      - Port ebony support into e-new?
>      - Try and work out build issues with 2_4_d configured for 'ebony'.
>
> Wanted to solicit some feedback before I go into tangent land.

I can't imagine why any ppc4xx toolchain couldn't build a properly
configured linuxppc_2_4_devel ebony kernel.  It's working right now
for my toolchain (mvista)...I haven't used ELDK for a little while now.

I take you have done the following?:

	make ebony_config
	make oldconfig
	make dep zImage

Where you have hacked ARCH and CROSS_COMPILE in the top-level Makefile
or have a script which passes in the appropriate prefix for your
toolchain.  i.e. "make ARCH=ppc CROSS_COMPILE=ppc_405- <rule>"

Regards,
--
Matt Porter
porter@cox.net
This is Linux Country. On a quiet night, you can hear Windows reboot.

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
