Message-ID: <40AE734D.1020609@g-house.de>
Date: Fri, 21 May 2004 23:23:25 +0200
From: Christian Kujau <evil@g-house.de>
MIME-Version: 1.0
To: linuxppc-dev list <linuxppc-dev@lists.linuxppc.org>
Subject: Error: Unrecognized opcode: `dssall'
Content-Type: text/plain; charset=us-ascii; format=flowed
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


hi,

i'm successfully using a crosstoolchain to compile gcc+binutils on i386
to make targets for powerpc-linux. upon "upgrading" the toolchain new
sources for gcc+binutils were fetched and now kernel-compilation fails
as follows:

-----------
   CHK     include/asm-ppc/offsets.h
*** 2.6 kernels no longer buildcorrectly with old versions of binutils.
*** Please upgrade your binutils to 2.12.1 or newer
make: *** [checkbin] Error 1
-----------

there is a check in arch/ppc/Makefile:

-----------
# Ensure this is binutils 2.12.1 (or 2.12.90.0.7) or later
NEW_AS  := $(shell echo dssall | $(AS) -o /dev/null >/dev/null 2>&1 ; \
echo $$?)
-----------

i don't really know what "dssall" is, but obviously it should be a valid
input for "as". now, please see the following:

-----------
/usr/local/opt/crosstool_new/bin/powerpc-linux-as --version
GNU assembler 2.14.92 20040507
This assembler was configured for a target of `powerpc-linux'.

/usr/local/opt/crosstool_old/bin/powerpc-linux-as --version
GNU assembler 2.14 20030612
This assembler was configured for a target of `powerpc-linux'.
-----------
(copyright notes removed), both versions of "as" seem to be in place.
but testing "dssall" gives indeed:

-----------
echo dssall | /usr/local/opt/crosstool_new/bin/powerpc-linux-as
{standard input}: Assembler messages:
{standard input}:1: Error: Unrecognized opcode: `dssall'

echo dssall | /usr/local/opt/crosstool_old/bin/powerpc-linux-as
[no message, so it's OK]
-----------


ok, i guess you get the picture. now, this "dssall" appears several
times under arch/ppc, so the real kernel compile fails. what i seek to
understand is: "as" comes with "binutils", but there was only a minor
upgrade in binutils, i somehow expected some brokenness from the new
gcc-3.4 (sorry gcc folks, really...).

perhaps you have some thoughts on it....
i'll go on with different binutils now...


Thanks,
Christian.
--
BOFH excuse #193:

Did you pay the new Support Fee?

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
