Date: Thu, 22 Jun 2000 10:37:04 -0400
From: Josh Huber <huber@mclx.com>
To: Linux/PowerPC Devel List <linuxppc-dev@lists.linuxppc.org>
Subject: PPTP and mppe module
Message-ID: <20000622103704.A4900@mclx.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


In an effort to set up the pptp client on my powerbook, I downloaded the PPP
source, patched it with the required patch, installed the proper rc4* files
into the ppp source tree, and installed the new ppp files into the kernel.
the kernel I'm using is the latest BK tree in the 2.2 series.

Now, everything seemed to be working as planned, but when I went to build
and install the ppp drivers, I ran into a couple of problems.

First, the 2.3.10 ppp header for include/linux/if_ppp.h doesn't have defines
for PPP_MAGIC and PPP_VERSION which is used throughout the ppp.c driver. I
added the proper defines and the build continued.

The only issue I had left was the ppp_mppe.o module had unresolved
symbols...a couple of strange ones too:

# insmod ./ppp_mppe.o
./ppp_mppe.o: unresolved symbol __floatsidf
./ppp_mppe.o: unresolved symbol __adddf3

Which both appear to be in libgcc:
$ nm /usr/lib/gcc-lib/powerpc-linux/2.95.2/libgcc.a|grep floatsidf
0000128c T __floatsidf
$ nm /usr/lib/gcc-lib/powerpc-linux/2.95.2/libgcc.a|grep adddf3
0000069c T __adddf3

So, I tried linking libgcc with ld like so:
$ ld -r /usr/lib/gcc-lib/powerpc-linux/2.95.2/libgcc.a ppp_mppe.o -o tmp.o

This seems to allow the module to load, but I won't be able to test it until
I get home.

Anyone know what's going on here?  I looked at the code, and couldn't find
any reference to floating point math there...

Anyone tried getting a VPN client working on PPC?

Josh

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
