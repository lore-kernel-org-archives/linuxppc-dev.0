Subject: make modules fails
From: Andy Fleming <afleming@motorola.com>
To: linuxppc-dev@lists.linuxppc.org
Content-Type: text/plain
Message-Id: <1049237813.990.9.camel@localhost.localdomain>
Mime-Version: 1.0
Date: 01 Apr 2003 16:56:54 -0600
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


I'm trying to compile 2.4.20-8a with Bryan Rittmeyer's perfmon patch
applied.  I can compile the kernel (which boots), but I can't "make
modules".  I get this error:

make[3]: Entering directory
`/home/afleming/linux-2.4.20-8a-perfmon/drivers/addon/cipe'
gcc -D__KERNEL__ -I/home/afleming/linux-2.4.20-8a-perfmon/include -Wall
-Wstrict-prototypes -Wno-trigraphs -O2 -fno-strict-aliasing -fno-common
-fomit-frame-pointer -I/home/afleming/linux-2.4.20-8a-perfmon/arch/ppc
-fsigned-char -msoft-float -pipe -ffixed-r2 -Wno-uninitialized
-mmultiple -mstring -DMODULE -DMODVERSIONS -include
/home/afleming/linux-2.4.20-8a-perfmon/include/linux/modversions.h
-nostdinc -iwithprefix include -DKBUILD_BASENAME=module  -c -o module.o
module.c
In file included from
/home/afleming/linux-2.4.20-8a-perfmon/include/linux/sched.h:24,
                 from
/home/afleming/linux-2.4.20-8a-perfmon/include/linux/skbuff.h:19,
                 from
/home/afleming/linux-2.4.20-8a-perfmon/include/linux/netdevice.h:147,
                 from cipe.h:62,
                 from module.c:15:
/home/afleming/linux-2.4.20-8a-perfmon/include/linux/tty.h:346: invalid
suffix on floating constant
/home/afleming/linux-2.4.20-8a-perfmon/include/linux/tty.h:346: parse
error before numeric constant
/home/afleming/linux-2.4.20-8a-perfmon/include/linux/tty.h:346: warning:
function declaration isn't a prototype
In file included from
/home/afleming/linux-2.4.20-8a-perfmon/include/linux/skbuff.h:227,
                 from
/home/afleming/linux-2.4.20-8a-perfmon/include/linux/netdevice.h:147,
                 from cipe.h:62,
                 from module.c:15:
/home/afleming/linux-2.4.20-8a-perfmon/include/linux/slab.h:74: warning:
parameter names (without types) in function declaration
In file included from
/home/afleming/linux-2.4.20-8a-perfmon/include/net/sock.h:74,
                 from cipe.h:69,
                 from module.c:15:
/home/afleming/linux-2.4.20-8a-perfmon/include/linux/if_pppox.h:124:
`unregister_pppox_proto_R_ver_str' declared as function returning a
function
/home/afleming/linux-2.4.20-8a-perfmon/include/linux/if_pppox.h:124:
warning: parameter names (without types) in function declaration
make[3]: *** [module.o] Error 1
make[3]: Leaving directory
`/home/afleming/linux-2.4.20-8a-perfmon/drivers/addon/cipe'
make[2]: *** [_modsubdir_cipe] Error 2
make[2]: Leaving directory
`/home/afleming/linux-2.4.20-8a-perfmon/drivers/addon'
make[1]: *** [_modsubdir_addon] Error 2
make[1]: Leaving directory
`/home/afleming/linux-2.4.20-8a-perfmon/drivers'
make: *** [_mod_drivers] Error 2

While I don't need the modules to test the work I'm doing, I'm wondering
if this is related to another problem I have.  When I startx, the screen
starts showing artifacts (a kind of doubling or tripling of the images
on the screen).  If I try to logout or switch virtual terminals, a wave
of white passes over the screen, leaving patches of bruise-like colors
all around the screen.

This is on my PowerBook G4 2002 with the Radeon 7500 and 1280x854
screen.  I suspect there's something wrong in the built in driver, which
would point to a configuration issue.  What can I do to fix this?

So, in summary, my questions are:

1) What causes the odd build errors in "make modules" when I try to
build.

2) What is wrong with my kernel config such that the video goes wrong
when I start X?  I think it happened once when I tried to switch
terminals without X started.

TIA,
Andy Fleming


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
