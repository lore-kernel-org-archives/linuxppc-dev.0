Date: Thu, 29 Apr 1999 09:28:49 +0200 (METDST)
From: Gabriel Paubert <paubert@iram.es>
To: Geert Uytterhoeven <Geert.Uytterhoeven@cs.kuleuven.ac.be>
cc: lm78@stimpy.netroedge.com,
        Linux/PPC Development <linuxppc-dev@lists.linuxppc.org>
Subject: Re: Support for Hydra i2c
In-Reply-To: <Pine.LNX.4.10.9904281104050.12292-300000@mercator.cs.kuleuven.ac.be>
Message-ID: <Pine.HPP.3.96.990429091846.876E-100000@gra-ux1.iram.es>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>



	Hi Geert,


>   - prog/dump/isadump.c
> 
>       o glibc 2.1 doesn't have <sys/perm.h>
>       o make it compile on PPC (ISA I/O is memory mapped, but it doesn't work
> 	anyway because different types of PPC boxes have ISA I/O space at
> 	different addresses :-(

And why not add an mmap method to /dev/port ? This would be the most
elegant solution and would work on all architectures which use normal
memory accesses to ISA/PCI I/O space, in contrast to InHell which has an
extremely reduced set of instructions to access this space (you can't even
choose the registers you use). 

<rant>
I always thought that the distinction between I/O space and
non-prefetchable memory in PCI is extremely artificial, most PCI devices
have base registers in both spaces which have exactly the same
functionality (and Intel recommends using the MMIO method, which is much
faster on PPro/PII.../P\infinity).
</rant>

	Regards,
	Gabriel.


[[ This message was sent via the linuxppc-dev mailing list.  Replies are ]]
[[ not  forced  back  to the list, so be sure to Cc linuxppc-dev if your ]]
[[ reply is of general interest. Please check http://lists.linuxppc.org/ ]]
[[ and http://www.linuxppc.org/ for useful information before posting.   ]]
