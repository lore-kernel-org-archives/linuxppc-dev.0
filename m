Mime-Version: 1.0 (Apple Message framework v613)
To: linuxppc-dev@lists.linuxppc.org
Message-Id: <20BB0EB5-841D-11D8-9FF0-000A95A07384@sands-edge.com>
Content-Type: multipart/mixed; boundary=Apple-Mail-30--534250508
From: John Whitney <jwhitney-linuxppc@sands-edge.com>
Subject: arch/ppc/Makefile wiping out /dev/null
Date: Thu, 1 Apr 2004 15:42:44 -0500
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


--Apple-Mail-30--534250508
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset=US-ASCII; format=flowed

In arch/ppc/Makefile, the line

NEW_AS := $(shell echo dssall | $(AS) -o /dev/null >/dev/null 2>&1 ;
echo $$?)

is causing my host's /dev/null file to be wiped out if I don't specify
CROSS_COMPILE, and the hosts' "as" is getting called instead of the
cross-compiler.  Apparently, "as" assumes that the file specified by
"-o file" belongs to it, and deletes it if an error occurs in the
compilation process.  I get this happening to me when I issue the
command:

sudo make ARCH=ppc INSTALL_MOD_PATH=<path> modules_install

In this case, I wasn't compiling anything so I didn't specify
CROSS_COMPILE, with the aforementioned result.  I've attached a patch
for this file which changes the offending line to:

NEW_AS := $(shell echo dssall | $(AS) -o /tmp/.as.$$$$ >/dev/null 2>&1
; echo $$?)

Which appears to work as intended (at least, my 2.14 binutils
ppc7xx-linux-as returns a value of 0 for this, and the failing x86 "as"
is returning 1, which I believe is the expected behavior), and doesn't
cause /dev/null to be deleted.

John

--Apple-Mail-30--534250508
Content-Transfer-Encoding: 7bit
Content-Type: application/octet-stream; x-unix-mode=0600; name="Makefile.patch"
Content-Disposition: attachment; filename=Makefile.patch

--- linuxppc-2.6.5-rc2.orig/arch/ppc/Makefile	2004-04-01 14:20:36.000000000 -0500
+++ linuxppc-2.6.5-rc2/arch/ppc/Makefile	2004-04-01 15:31:07.000000000 -0500
@@ -87,7 +87,7 @@

 ifdef CONFIG_6xx
 # Ensure this is binutils 2.12.1 (or 2.12.90.0.7) or later
-NEW_AS	:= $(shell echo dssall | $(AS) -o /dev/null >/dev/null 2>&1 ; echo $$?)
+NEW_AS	:= $(shell echo dssall | $(AS) -o /tmp/.as.$$$$ >/dev/null 2>&1 ; echo $$?)
 GOODVER	:= 2.12.1
 else
 NEW_AS	:= 0

--Apple-Mail-30--534250508--

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
