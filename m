Return-Path: <owner-linuxppc-embedded@lists.linuxppc.org>
From: nunninger@web.de
To: Linuxppc-Embedded <linuxppc-embedded@lists.linuxppc.org>
Date: Thu, 1 Mar 2001 16:15:47 +0100
MIME-Version: 1.0
Content-type: text/plain; charset=US-ASCII
Subject: Switching on virtual adresses -> TLB miss -> break
Reply-To: nunninger@web.de
Message-ID: <3A9E75B3.23216.ABFCB3D@localhost>
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Hello out there,

I got a problem running linux on a custom MPC860 board for which
I hope somebody knows a solution. I'm using linux 2.2.14 from
Montavista.

My code arrives at the point in /kernel/head.S where virtual address
translation is switched on.

turn_on_mmu:
mfmsr	r0
ori		r1,	r0,	MSR_DR|MSR_IR
mtspr	SRR1, 	r1
lis		r0,	start_here@h
ori		r0,	r0,	start_here@l
mtspr	SRR0,	r0
SYNC
rfi

start_here:
lis		r2,	init_task_union@h
ori		r2,	r2,	init_task_union@l
...


Direktly after the rfi instruction the code jumps into the
"DataStoreTLBMiss"-exception at position 0x1200. There it stops
at line 0x1214. Just to be sure the exception is not called from
some other place I placed a breakpoint direktly after rfi on the first
instruction of start_here. This breakpoint is never hit. The code
which is used in that exception for 8xx looks like this:

mtspr	M_TW, r20		/* save a couple of working registers */
mfcr	r20
stw		r20, 	0(r0)
stw		r21,	4(r0)
mfspr	r20,	M_TWB	/* Get level 1 tabel entry address */
lwz		r21,	0(r20)		/* Get the level 1 entry */	!!!!!!!!!!
rlwinm.	r20,	r21,	0,	0,	19	/* Extract page descriptor page
address */
beq		2f				/* If zero, don't try to find a pte */

I marked the line where the execution stops like this !!!!!!!!!!

So I got two questions:
First why does the code arrives here after all? T
Second how can I get it to continue?

I'm not sure if this is related to the above problem:
Some time ago I found that right at the begin of /kernel/head.S
there are two instructions which do not behave as I expect them to
do. This is in the code that initializes the TLBs. The instructions
are both:
	mtspr MD_TWC, 	r8
in both TLB initializations. When I check the value of MD_TWC it
did not change as I would expect it to do. However there is no sign
of an error. This seems strange to me. As it is related to the TLBs
might this cause the failure described above? If so what might be
the reason that these two instructions do not work?

I found this using the debugger of VisionClick. By now I switched to
BDM4GDB. However with GDB I can not verify wheter these
instruction work or not as I don't get propper symbol information in
the assembler files. However no matter which debugger I'm using
the code stops in the exception described above.

Many thanks for any comment
	Stefan

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
