MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Subject: RE: tlbwe, rfci instructions and gcc cross assembler
Date: Fri, 12 Apr 2002 09:43:05 -0500
Message-ID: <45B36A38D959B44CB032DA427A6E10640167CFB1@cceexc18.americas.cpqcorp.net>
From: "Cameron, Steve" <Steve.Cameron@COMPAQ.com>
To: "Tom Rini" <trini@kernel.crashing.org>
Cc: <linuxppc-embedded@lists.linuxppc.org>
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Tom Rini [mailto:trini@kernel.crashing.org] wrote:

> On Thu, Apr 11, 2002 at 04:53:18PM -0500, Cameron, Steve wrote:
>
> [snip]
> > strace /usr/local/ppc/bin/powerpc-linux-gcc -D__ASSEMBLY__
> -D__KERNEL__ -I/home/scameron/ppc/testdir/include   -c -o
> head_4xx.o head_4xx.S
>
> -Wa,-m405 is missing here.

Where should it go?

I tried all possibilities I could think of with no luck:

[scameron@quandary kernel]$ cat x
/usr/local/ppc/bin/powerpc-linux-gcc -D__ASSEMBLY__ -D__KERNEL__ -I/home/scameron/ppc/testdir/include -c -o head_4xx.o head_4xx.S -Wa,m405
/usr/local/ppc/bin/powerpc-linux-gcc -D__ASSEMBLY__ -D__KERNEL__ -I/home/scameron/ppc/testdir/include -c -Wa,m405 -o head_4xx.o head_4xx.S
/usr/local/ppc/bin/powerpc-linux-gcc -D__ASSEMBLY__ -D__KERNEL__ -I/home/scameron/ppc/testdir/include -Wa,m405 -c  -o head_4xx.o head_4xx.S
/usr/local/ppc/bin/powerpc-linux-gcc -D__ASSEMBLY__ -D__KERNEL__ -Wa,m405 -I/home/scameron/ppc/testdir/include  -c  -o head_4xx.o head_4xx.S
/usr/local/ppc/bin/powerpc-linux-gcc -D__ASSEMBLY__ -Wa,m405 -D__KERNEL__ -I/home/scameron/ppc/testdir/include  -c  -o head_4xx.o head_4xx.S
/usr/local/ppc/bin/powerpc-linux-gcc -Wa,m405 -D__ASSEMBLY__  -D__KERNEL__ -I/home/scameron/ppc/testdir/include  -c  -o head_4xx.o head_4xx.S

[scameron@quandary kernel]$ sh x
Assembler messages:
Error: can't open m405 for reading
m405: No such file or directory
head_4xx.S:111: Error: Unrecognized opcode: `tlbwe'
head_4xx.S:112: Error: Unrecognized opcode: `tlbwe'
head_4xx.S:420: Error: Unrecognized opcode: `rfci'
Assembler messages:
Error: can't open m405 for reading
m405: No such file or directory
head_4xx.S:111: Error: Unrecognized opcode: `tlbwe'
head_4xx.S:112: Error: Unrecognized opcode: `tlbwe'
head_4xx.S:420: Error: Unrecognized opcode: `rfci'
Assembler messages:
Error: can't open m405 for reading
m405: No such file or directory
head_4xx.S:111: Error: Unrecognized opcode: `tlbwe'
head_4xx.S:112: Error: Unrecognized opcode: `tlbwe'
head_4xx.S:420: Error: Unrecognized opcode: `rfci'
Assembler messages:
Error: can't open m405 for reading
m405: No such file or directory
head_4xx.S:111: Error: Unrecognized opcode: `tlbwe'
head_4xx.S:112: Error: Unrecognized opcode: `tlbwe'
head_4xx.S:420: Error: Unrecognized opcode: `rfci'
Assembler messages:
Error: can't open m405 for reading
m405: No such file or directory
head_4xx.S:111: Error: Unrecognized opcode: `tlbwe'
head_4xx.S:112: Error: Unrecognized opcode: `tlbwe'
head_4xx.S:420: Error: Unrecognized opcode: `rfci'
Assembler messages:
Error: can't open m405 for reading
m405: No such file or directory
head_4xx.S:111: Error: Unrecognized opcode: `tlbwe'
head_4xx.S:112: Error: Unrecognized opcode: `tlbwe'
head_4xx.S:420: Error: Unrecognized opcode: `rfci'


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
