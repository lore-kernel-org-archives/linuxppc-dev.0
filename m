Message-ID: <F1BED55F35F4D3118C0F00E0295CFF4D414C53@mail.mediatrix.com>
From: Jean-Denis Boyer <jdboyer@mediatrix.com>
To: "'Michael Habermann'" <MHabermann@gmx.de>
Cc: linuxppc-embedded@lists.linuxppc.org
Subject: RE: Reducing glibc with mklibs.sh
Date: Thu, 18 Oct 2001 09:07:04 -0400
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


A couple of things are missing in your configuration for mklibs.sh
to properly work. I spent many hours finding what was the exact
configuration to have mklibs.sh properly works.
I understood when I installed Debian Linux on a PC,
and looked how the boot-floppies package was installed.
That was a lot easier than understanding the script.

First, the map files should be present along with the pic files.
Next, to properly reduce libc, mklibs.sh needs two or three
(depending on the glibc version) objects files:
    soinit.o sofini.o interp.o
AFAIK, mklibs.sh needs extra object files only for libc.

As an example, I successfully cross-reduced glibc-2.2.4 for powerpc-linux,
on my ix86 Redhat.
The files were installed in the following hierarchy:
  /usr/local/powerpc-linux/lib/libc_pic.a
  /usr/local/powerpc-linux/lib/libc_pic.map
  /usr/local/powerpc-linux/lib/libc_pic/interp.o
  /usr/local/powerpc-linux/lib/libc_pic/soinit.o
  /usr/local/powerpc-linux/lib/libc_pic/sofini.o

The map file is generated along with the pic file, when building the libc
package.
It may have a different name, like 'libc.map', but mklibs.sh looks for
'libc_pic.map'.
The object files are found under the directory elf/ (also in glibc build)
with the extension .os.

Note: I successfully reduced libpthread.so, also.

Good luck.
--------------------------------------------
 Jean-Denis Boyer, B.Eng., Technical Leader
 Mediatrix Telecom Inc.
 4229 Garlock Street
 Sherbrooke (Québec)
 J1L 2C8  CANADA
 (819)829-8749 x241
--------------------------------------------

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
