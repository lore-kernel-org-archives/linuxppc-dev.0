Message-Id: <200112121928.fBCJSV809645@mailout6.nyroc.rr.com>
Content-Type: text/plain;
  charset="iso-8859-1"
From: Armando Di Cianno <armando@nycap.rr.com>
Reply-To: diciaa@rpi.edu
To: Jesse McCrosky <mccrosky@ualberta.ca>,
	LinuxPPC Dev List <linuxppc-dev@lists.linuxppc.org>
Subject: Re: link error with jdk-1.3
Date: Wed, 12 Dec 2001 14:23:59 -0500
References: <3C17A868.605B0BED@ualberta.ca>
In-Reply-To: <3C17A868.605B0BED@ualberta.ca>
MIME-Version: 1.0
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


> When I try to run java I get the following error.
> /usr/src/j2sdk1.3/jre/bin/ppc/native_threads/java: error while loading
> shared libraries: /usr/src/j2sdk1.3/jre/lib/ppc/classic/libjvm.so:
> symbol __register_frame_info, version GLIBC_2.0 not defined in file
> libc.so.6 with link time reference
> I am using glibc-2.2.4

I made my own distro, and encountered this problem.  I solved it by
downloading the YDL 2.0 Glibc 2.1.3 compatability libs, installing them, and
adding a line like this to the beginning of the .java_wrapper file:

export LD_PRELOAD=/usr/lib/libstdc++-3-libc6.1-2-2.10.0.so

The symbols were defined in that lib.  Note, that at one point I had
this environment variable exported from /etc/profile, and a handful of
programs ceased to work in mysterious ways; so I'd stick with only messing
with the .java_wrapper, and affecting only java.

__Armando Di Cianno
diciaa@rpi.edu

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
