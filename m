Date: Thu, 15 Nov 2001 20:13:04 -0700
From: Okehee Goh <ogoh@asu.edu>
Subject: [Q]Tornado's GCC: compile assembly codes??
 "unresolved expression that must be .."
To: linuxppc-embedded@lists.linuxppc.org
Message-id: <CPEELCODKANPCLBCAGOFIEHECAAA.ogoh@asu.edu>
MIME-version: 1.0
Content-type: text/plain; charset=iso-8859-1
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


 Hello,
 This is Okehee Goh in ASU.
 This is not a question about Linux. I'm really sorry about that.

 I'd like to compile assembly codes for target machine, MBX860.
 This assembly codes will not be associated with VxWorks OS.
 As a compiler, I tried to use ccppc(gcc) compiler that comes with TornadoII
targeting MBX860.
 But it complained with "Error: unresolved expression that must be
resolved".
 I don't know how to solve this problem.

 The following is the command line to compile assembly code "ae3.s".
 The next one includes error message that ccppc generated.
 The third part is "ae3.s"

 I will appreciate your help. Thank you so much.

1. <the command line to compile assembly code "ae3.s".>

ccppc -g -mcpu=860 -ansi -nostdinc -fvolatile -fno-builtin -fno-for-scope -P
 -x assembler-with-cpp -I. -IC:/Tornado/target/h -DCPU=PPC860 -c ae3.s

2.<error message that ccppc generated>
C:\DOCUME~1\ogoh\LOCALS~1\Temp\cca02324.s: Assembler messages:
C:\DOCUME~1\ogoh\LOCALS~1\Temp\cca02324.s:9: Error: unresolved expression
that must be resolved
C:\DOCUME~1\ogoh\LOCALS~1\Temp\cca02324.s:10: Error: unresolved expression
that must be resolved
...

3. "ae3.s"
	.text

	.align		2
	.globl		main
main:
	.long		0
	.long		0
	.long		0
	lis		r7,0x0180
	addi		r7,r7,0x1000
	addi		r8,r0,0
	stw		r8,0(r7)
	stw		r8,0x1000(r7)
	stw		r8,0x2000(r7)

	lis		r5,0x0180
	li		r6,1
	stw		r6,0(r5)

.L4:
	lwz		r8,0(r7)
	addi		r8,r8,1
	stw		r8,0(r7)

	lwz		r8,0x1000(r7)
	addi		r8,r8,1
	stw		r8,0x1000(r7)

	lwz		r8,0x2000(r7)
	addi		r8,r8,1
	stw		r8,0x2000(r7)

	b		.L4
 ---------------------------------------
Real-Time System lab of CSE of ASU
Tel: 480-219-1346
 ---------------------------------------
Real-Time System lab of CSE of ASU
Tel: 480-219-1346


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
