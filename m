From: Paul Mackerras <paulus@samba.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Message-ID: <15389.55012.312836.197493@argo.ozlabs.ibm.com>
Date: Mon, 17 Dec 2001 22:28:36 +1100 (EST)
To: linuxppc-dev@lists.linuxppc.org
Subject: moving include/asm-ppc/platforms
Reply-To: paulus@samba.org
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


With the addition of -I$(TOPDIR)/arch/$(ARCH) to the compilation flags
for the kernel, we can now move the platform-specific header files
from include/asm-ppc/platforms to arch/ppc/platforms, which is where I
think they belong.  That does require changing <asm/platforms/blah.h>
to <platforms/blah.h>, but that is not a big job because these headers
tend to get included in only a few places.

For 2.4 we will keep the ugly lists of ifdefs in places like serial.h
and mpc8xx.h.  For 2.5 we should change over to using a mechanism to
copy an appropriate platform-dependent file to arch/ppc/platform.h.

Once we have moved include/asm-ppc/platforms/*.h to arch/ppc/platforms,
it will just about be time to do a big merge from devel into
linuxppc_2_4 and thence to Marcelo's tree.

Paul.

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
