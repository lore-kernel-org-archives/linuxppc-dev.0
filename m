From: Paul Mackerras <paulus@samba.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Message-ID: <15366.8350.416601.229303@gargle.gargle.HOWL>
Date: Thu, 29 Nov 2001 22:48:46 +1100 (EST)
To: linuxppc-dev@lists.linuxppc.org
Cc: kaos@ocs.com.au
Subject: Re: include/asm-ppc/platforms/
In-Reply-To: <3C0482F6.1050307@embeddededge.com>
References: <15363.31192.101536.919771@gargle.gargle.HOWL>
	<3C2B376F.9070508@embeddededge.com>
	<15364.32906.728532.676746@gargle.gargle.HOWL>
	<3C0482F6.1050307@embeddededge.com>
Reply-To: paulus@samba.org
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


I have run the platform.h stuff past Keith Owens, the kbuild
maintainer.  He makes several points:

* He much prefers generated files (including symlinks) to be created
  in arch/$(ARCH) rather than include.  In particular he doesn't like
  mixing supplied and generated headers in the one directory.

* He prefers a copy rather than a symlink, particularly for
  kbuild-2.5, so that we have real pathnames and timestamps in the
  dependency tree.

* He wrote a new script that uses sed rather than awk, checks a few
  things (e.g. exactly one platform.h file is selected) and also
  creates empty files if e.g. no platform_serial.h file is selected.

The only reason for having include/asm-ppc/platforms under
include/asm-ppc is so that serial.h can include the right
blah_serial.h file.  We can get around that by using
early_serial_setup except that that doesn't work if the serial driver
is built as a module.  The boot stuff also needs to get at the first
serial port but we can manage that by requiring the platform.h file to
define e.g. BOOT_SERIAL_ADDRESS, BOOT_SERIAL_REG_SHIFT, etc., if it
wants to use a serial port in the boot wrapper.  The boot wrapper code
then just does #include <platform.h>.

Alternatively we can add a -Iarch/$(ARCH) flag for cc and put
platform.h in arch/ppc and the platform headers in
arch/ppc/platforms.  This is Keith's preferred solution and it feels
right to me too.

Platform maintainers can continue to statically initialize rs_table
for their serial ports if they wish.  I think I will move all those
crufty old fourport, accent, boca and hub6 declarations into
include/asm-ppc/isa_serial.h so that they are still available but not
getting in our faces all the time.

Comments?

Paul.

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
