Reply-To: <priyadk@future.futsoft.com>
From: "Priyadarshini K" <priyadk@future.futsoft.com>
To: <linuxppc-embedded@lists.linuxppc.org>
Subject: Memory Conflict between C and C++ programs
Date: Mon, 22 Apr 2002 17:07:27 +0530
Message-Id: <000301c1e9f2$1484f5e0$1106140a@future.futsoft.com>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Hi
   This is an overview of the problem we are facing with integrating C and
C++ object code to form an executable. The environment details are as
follows:

   OS : Hardhat Linux 2.0
   Compiler : ppc_8xx-gcc
   Linker : ppc_8xx-ld

   We had to integrate the modem software given to us (C++ object files as
an archive) with our protocol stack (C files).

   We faced the following problems during the integration and testing of the
same:

   1) The global memory area assigned to the C++ programs and the C programs
are clashing.
      We have compiled both the C++ programs and C programs with the -Ur
flags, so they are relocatable.

   2) The global constructors are called before the main() function (which
is in a C file) is called. So if we try to initialize the OS before the
global constructors try to use any OS services, the memory areas conflict
and the global constructors data members are getting corrupted (pointers
become NULL), consequently leading to a crash.

   3) Are there any options to define separate memory areas for the C++ and
C programs to use?

   4) Are there any options which have to be used when working with C and
C++ files, as we are doing?

   5) The global constructors are using member functions of other objects.
Some of the crashes may be due to the fact that the member functions called
may not belong to an already initialized object. Should the objects, as a
rule, be created on first access to any of their member functions?

   Can anyone help us resolve these issues?

   Thanks in advance for any help.
   Priya

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
