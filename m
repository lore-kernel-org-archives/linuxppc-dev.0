Message-ID: <40DFB360.3090801@opersys.com>
Date: Mon, 28 Jun 2004 01:57:52 -0400
From: Karim Yaghmour <karim@opersys.com>
Reply-To: karim@opersys.com
MIME-Version: 1.0
To: "linuxppc-embedded@lists.linuxppc.org" <linuxppc-embedded@lists.linuxppc.org>
Subject: brk() problem in glibc 2.3.2 on TQM860
Content-Type: text/plain; charset=us-ascii; format=flowed
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


I've been having problems with brk() calls (like ones made by malloc() to the
kernel) when using glibc 2.3.2 on a TQM860 (16MB RAM, 8MB of flash.) Take the
following snippet of code for example:
	for (i = 1, val = 10; i < 10; val = val * 10, i++) {
		printf("Allocating %lu \n", val);
		x = (void*) malloc(val);
		memset(x, '\0', val);
	}

This always succeeds in allocating 100,000 bytes, but it's always freezing when
trying to allocate 10^6. The kernel isn't dead. In fact I can start this in the
background, but the fact of the matter is that it's never coming back from that
10^6 malloc.

This wouldn't be so anoying if it weren't reflecting in the execution of some
key applications ... like insmod.

There are two patches that were applied to this glibc, both from Dan Kegel
(neither of which should really make any difference):
- without-fp
- sscanf

Here's the configuration line for glibc 2.3.2:
$ CC=powerpc-linux-gcc CFLAGS="-O2 -D_SOFT_FLOAT -mcpu=860" \
 > ../glibc-2.3.2/configure --host=$TARGET --build=i686-linux \
 > --prefix="/usr" --enable-add-ons \
 > --with-headers=${TARGET_PREFIX}/include --without-fp

Also using:
- binutils 2.14
- gcc 3.3.2
- Linux 2.4.25 (vanilla; non-vanilla or other versions make no difference.)

The same code works fine an IceCube, granted with a different glibc config line.

If anyone's seen this before and has a fix, please let me know.

Thanks,

Karim
--
Author, Speaker, Developer, Consultant
Pushing Embedded and Real-Time Linux Systems Beyond the Limits
http://www.opersys.com || karim@opersys.com || 1-866-677-4546


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
