Message-ID: <392E81B4.1C03F89@agelectronics.co.uk>
Date: Fri, 26 May 2000 14:52:52 +0100
From: Adrian Cox <apc@agelectronics.co.uk>
MIME-Version: 1.0
To: linuxppc-embedded@lists.linuxppc.org
Subject: Re: Floating Point problems with Linux on the EST SBC8260
References: <Pine.BSF.4.21.0005261410410.16108-100000@invalid.ed.ntnu.no>
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Geir Frode Raanes wrote:
> Yes, one can always use the "-mlongcall" flag to GCC.
> Or boot the kernel with only 32 MBytes in sysLib.c, load
> the application (defaults to top of memory, while the kernel
> sits in low memory) and then "memAddToPool(sysMemTop(),0x2000000)"
> This is a FAQ issue. I have not verified the existence of the
> problem myself.
> [...]
I've just performed a test, and what happens is that VxWorks dynamic
loading now starts in low memory rather than high memory. You may still
need to specify longcall in development, but as deployed applications
don't use dynamic loading, the problem has pretty well gone away.

> Actually, I have obviousely a blind-spot in my understanding
> of how API calls work on Linux. User space is 4 GBytes linear.
> At the bottom is the enviroment tables copied prom the parent
> process. If I remember correctly, then the stack is at the
> lowest addresses above this, then comes the ELF text segment,
> then BSS, then data and the rest goes into the memory heap.

The user space on PowerPC is only 3GB at the moment. This means that
only 1GB of RAM is supported, as all RAM must be mapped into the
remaining address space (0xc0000000 to 0xffffffff). This image of all
physical RAM is only accessible in supervisor mode. We'll soon need
somebody to come up with a trick comparable to the way large memory x86
systems work, so that we can have 2GB PPC systems.

(In a perfect world, a follow up message would tell me that I've not
been paying attention, and this has already happened.)

> API calls results in violation exceptions which the OS will
> service. But to provoce an violation exception the user
> application must be able to address supervisor owned space
> in the first place. Meaning that some part of of the User
> space must be shared with the kernel and that this space
> must contain the API functions entrypoints. Correct?

>From a brief examination of head.S, system calls work by an application
performing the sc instruction, which starts execution from physical
address 0xc00 in supervisor mode. Once address translation is turned
back on the kernel sees kernel address space starting at virtual address
0xc0000000, and user space starting at virtual address 0x0.

- Adrian Cox, AG Electronics

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
