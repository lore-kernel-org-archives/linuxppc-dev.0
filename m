Message-ID: <3B018266.49F9E6CB@mvista.com>
Date: Tue, 15 May 2001 12:24:22 -0700
From: Matthew Locke <mlocke@mvista.com>
MIME-Version: 1.0
To: Denton Gentry <denny@dominetsystems.com>
Cc: linuxppc-embedded@lists.linuxppc.org
Subject: Re: glibc 2.2.x?
References: <3B017F0B.B89B3A94@dominetsystems.com>
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


The problem we ran into with 2.2.2 was the optimized memset wasn't
aligned properly.  We reverted back to the generic memset and haven't
had any trouble on 8xx. I am not aware of any similar issues on the 405,
but...


Denton Gentry wrote:
>
>   About 6 weeks ago there were a couple messages on the list
> about glibc 2.2.x and embedded PowerPC. Has anyone made more
> progress?
>   I'm trying to use glibc2.2.3 on a Walnut board, and cannot
> start any processes. The MVista glibc-2.1.3 and ld.so.1 work
> fine on this platform. My problem with glibc 2.2.3 looks similar
> to the problems described a few weeks ago (fault when linking
> libraries).
>
>   Just for reference, heres what I did to glibc 2.2.3:
>
>   I had to move sysdeps/powerpc/fclrexcept.c to the fpu subdirectory,
> as it deals with the FPU (sysdeps/generic/fclrexcept.c will be used
> instead). I also had to remove the fenv_const and fe_nomask references
> from the Makefile.
>   So far as I can see __elf_machine_runtime_setup() in
> sysdeps/powerpc/dl-machine.c has been updated to know that
> not all PPCs have 32 byte cache lines, so I left it alone.
> memset.S does still have an assumption about cache line
> size ("subfic  rALIGN, rALIGN, 0x20"), so I moved it aside
> to let the generic version be used.
>

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
