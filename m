Message-ID: <000501bfba40$0dd50200$efc5dba8@sec.samsung.co.kr>
From: "kim sook young" <icekim@sec.samsung.co.kr>
To: <linuxppc-embedded@lists.linuxppc.org>
Subject: Error: Unrecognized opcode
Date: Wed, 10 May 2000 14:24:40 +0900
MIME-Version: 1.0
Content-Type: text/plain;
	charset="ks_c_5601-1987"
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


hi,all

While compiling, Some weird messages occurred.
I  don't think rorw is available opcode on the ppc environment. do i?
I don't know why rorw opcodes are generated in assembly code.

----------------------------------------------------------------
Compiling smbd/oplock.c
/tmp/ccs9oFVa.s: Assembler messages:
/tmp/ccs9oFVa.s:190: Error: Unrecognized opcode: `rorw'
/tmp/ccs9oFVa.s:414: Error: Unrecognized opcode: `rorw'
/tmp/ccs9oFVa.s:417: Error: Unrecognized opcode: `rorw'
/tmp/ccs9oFVa.s:1171: Error: Unrecognized opcode: `rorw'
/tmp/ccs9oFVa.s:2629: Error: Unrecognized opcode: `rorw'
make: *** [smbd/oplock.o] Error 1

---------------------------------------------------------------
the following is a part of the assembly code.

.L199:
        lis 9,global_oplock_port@ha
        la 9,global_oplock_port@l(9)
        lhz 0,10(1)
        rorw $8, 0
        sth 0,0(9)
        bl setup_kernel_oplock_pipe
        cmpwi 0,3,0
        bc 4,2,.L203
        li 3,0
        b .L205
----------------------------------------------------------------

I hope somebody would tip me off to the solution(?)

Thanks
regards


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
