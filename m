Message-ID: <381A4269.382A8779@263.net>
Date: Sat, 30 Oct 1999 08:57:13 +0800
From: Wang Yong <wung_y@263.net>
Reply-To: wung_y@263.net
MIME-Version: 1.0
To: Grant Erickson <grant@lcse.umn.edu>
CC: linuxppc-embedded@lists.linuxppc.org
Subject: Re: Kernel Math Emulation vs. -msoft-float and -nfp
References: <Pine.BSF.4.10.9910291051050.3718-100000@congo.borg.umn.edu>
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


how do you debug? kgdb or riscwatch? i met with the same problem when i
run a modified linux on i386. finally, i found the bug with kgdb that
the
problem is memory management. that is the handler of page fault. so i
guess if this is useful to you. i found that bug by adding some printk
in
the handlers and they gave me many useful information.

to the math-emu, i searched in the manual of 401d2 and found two
solutions
are provided. one is math library and the other is using the FPU
exception. the former is recommended for performance consideration. but 
i cannot find any math-emu lib for ppc. does linuxppc have one? there is 
a dir called math-emu in the arch/i386 and arch/sparc64 while arch/ppc
not.

anyway, i think the kernel should work without mathemu for there isn't 
any float point operation in kernel. right?

Grant Erickson wrote:
> 
> I finally got NFS root mounting working for the PowerPC 403GCX board port
> I'm playing with and figured out why /sbin/init wasn't getting very far
> (shared libraries, of course). However, that's about as far as things get.
> 
> I suspect that things are dying at this point because I'm using standard
> files from Linux/PPC 1999 and that really assumes a PPC machine based on
> the 6xx or 7xx processors.
> 
> So, I'm guessing that printf or one of the other routines that uses
> varargs is killing things. I even compiled a simple, static, hello program
> to replace /sbin/init and it too died.
>


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
