Message-ID: <20040205155918.14748.qmail@kasko.it>
From: "Antonello Lombardinilo" <antonello@kasko.it>
To: linuxppc-embedded@lists.linuxppc.org
Subject: RE: Problem in Cross compiling Pwlib for LINUX
Date: Thu, 05 Feb 2004 16:59:18 +0100
Mime-Version: 1.0
Content-Type: text/plain; format=flowed; charset="iso-8859-1"
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Hi all,
I work on embedded system based on MPC860L. I cross compiled PWLIB 1.5.2 in
the
following way:
1) Edit file ~/pwlib/configure, commenting the sentences => "cannot check"
2) $ ./configure --host=ppc-linux --target=ppc-linux
3) Edit file ~/pwlib/include/ptbuildopts.h and undefine:
     #undefine P_LDAP
     #undefine P_EXPAT
     //#define P_SSL 1
     //#define USE_SYSTEM_SWAB 1
4) Edit file ~/pwlib/ptbuildopts.mak:
     CC=ppc-linux-gcc
     CPLUS=ppc-linux-g++
  change ENDLIBS flag in this way:
     ENDLIBS += -lpthread -lcrypto -lresolv
  and setting flag as following:
     HAS_OPENSSL =
     HAS_OPENLDAP =
     HAS_EXPAT =
     HAS_SDL =
     TRY_1394AVC =
     TRY_1394DC =
5) Alter ~/pwlib/src/ptlib/unix/Makefile this:
    repalce:
        VIDEO_CAPTURE_SOURCE = video4linux.cxx
    with:
        VIDEO_CAPTURE_SOURCE = dummyvideo.cxx
6) $ make optnoshared

I then compiled OpenH323 in the following way:
1) Edit file ~/pwlib/configure, commenting the sentences => "cannot check"
2) copy file for asnparser for x86 patform in PWLIB directory
3) add LDFLAGS	    += -L/opt/eldk/ppc_8xx/usr/lib/gcc-lib/ppc-linux/2.95.4/
  to file ~/opnh323/openh323u.mak
3) make optnoshared

The problem is that when I lanch example application
~/opnh323/samples/simple/obj_linux_ppc_r/simph323
a segnemtation fault verified.
Do we have any suggestion?
Do we have cross compiled in correct way? (I'am using eldk from denx)
Could anyone explain me how I have to cross compile?

Thanks

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
