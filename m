MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Subject: RE: tlbwe, rfci instructions and gcc cross assembler
Date: Thu, 11 Apr 2002 16:53:18 -0500
Message-ID: <45B36A38D959B44CB032DA427A6E10640167CFAE@cceexc18.americas.cpqcorp.net>
From: "Cameron, Steve" <Steve.Cameron@COMPAQ.com>
To: <linuxppc-embedded@lists.linuxppc.org>
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


I wrote about trouble compiling linuxppc_2_4
kernel on i686->powerpc cross compiler:
[...]
> /usr/local/ppc/bin/powerpc-linux-gcc -D__ASSEMBLY__
> -D__KERNEL__ -I/home/scameron/ppc/testdir/include   -c -o
> head_4xx.o head_4xx.S
> head_4xx.S: Assembler messages:
> head_4xx.S:111: Error: Unrecognized opcode: `tlbwe'
> head_4xx.S:112: Error: Unrecognized opcode: `tlbwe'
> head_4xx.S:420: Error: Unrecognized opcode: `rfci'
> make[1]: *** [head_4xx.o] Error 1
> make[1]: Leaving directory

I have a bit more info.  Looking through my binutils
(v. 2.12.90.0.4) I see some references to "tlbwe" so
I would think my binutils is recent enough...but
perhaps still broken?

So thinking maybe I wasn't running the assembler
I thought I was running, I did this:

cd /home/scameron/ppc/testdir/arch/ppc/kernel
strace /usr/local/ppc/bin/powerpc-linux-gcc -D__ASSEMBLY__ -D__KERNEL__ -I/home/scameron/ppc/testdir/include   -c -o head_4xx.o head_4xx.S
[...]
access("/usr/local/ppc/powerpc-linux/bin/as", X_OK) = 0
vfork()                                 = 16198
wait4(-1, head_4xx.S: Assembler messages:
head_4xx.S:111: Error: Unrecognized opcode: `tlbwe'
head_4xx.S:112: Error: Unrecognized opcode: `tlbwe'
head_4xx.S:420: Error: Unrecognized opcode: `rfci'
[WIFEXITED(s) && WEXITSTATUS(s) == 1], 0, NULL) = 16198
--- SIGCHLD (Child exited) ---
stat64("head_4xx.o", 0xbffff780)        = -1 ENOENT (No such file or directory)
stat64("/tmp/cc7egQ8n.s", {st_mode=S_IFREG|0600, st_size=49044, ...}) = 0
unlink("/tmp/cc7egQ8n.s")               = 0
_exit(1)                                = ?

So, I'm running /usr/local/ppc/powerpc-linux/bin/as
for my assembler, which seems right.  Let me try:

strings /usr/local/ppc/powerpc-linux/bin/as | grep tlbwe
tlbwe
tlbwelo
tlbwehi

So...looks like my assembler has at least _some_ kind
of knowledge of the tlbwe instruction.  Looking through
my binutils source, I see the "tlbwe" instruction in
a big table along with other instructions in
opcodes/ppc-opc.c

Hmmm, running out of ideas here.

-- steve

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
