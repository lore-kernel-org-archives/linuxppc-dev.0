MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Subject: configure: error: unable to detect exception model
Date: Fri, 22 Aug 2003 13:38:44 -0400
Message-ID: <D556042D0579EA41896ABAB61A35A5827E9B6F@omnimail.corp.omnicluster.com>
From: "Carl Thomson" <cthomson@14south.com>
To: <linuxppc-dev@lists.linuxppc.org>
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


I am trying to build the PPC64 toolchain on an IBM ISERIES running the SuSe distribution Linux 2.14.19.

I have built, and installed the latest binutils from CVS,  I have gcc 3.2.3 patched to the 20030701 level to produce statically linked executables. I also have built a number of packages with statically linked those executables to complete pass1.

I then proceed to pass2. I create a root file system on another disk and copy all the statically linked executables to this disk and copy the /opt/ppc64 directory. I copied the kernel headers from the kernel source that came with the distribution to the /usr/include directory. I build and install GLIBC-2.3.2 , pointing to the kernel headers that I copied in the previous step, to produce the shared libraries on this root file system. I then build the binutils using those shared libraries and I am at the final stage of building c,c++, and f77 using the GLIBC dynamic libraries.

I can successfully build "c" and "f77" but my build fails when I attempt to build c++.

The make complains that I don't have a c++ compiler on my system yet!

The final output from the make is below:

mkdir libgcc
mkdir soft-float
mkdir libgcc/soft-float
../../gcc-3.2.3/gcc/crtstuff.c:195: warning: `__EH_FRAME_BEGIN__' defined but not used
../../gcc-3.2.3/gcc/crtstuff.c:195: warning: `__EH_FRAME_BEGIN__' defined but not used
../../gcc-3.2.3/gcc/crtstuff.c:195: warning: `__EH_FRAME_BEGIN__' defined but not used
../../gcc-3.2.3/gcc/crtstuff.c:195: warning: `__EH_FRAME_BEGIN__' defined but not used
/mnt/packagesrc/gcc-3.2.3/libstdc++-v3/configure: powerpc64-linux-c++: command not found
configure: error: unable to detect exception model
make: *** [configure-target-libstdc++-v3] Error

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
