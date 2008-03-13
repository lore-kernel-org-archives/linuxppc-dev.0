Return-Path: <roland@redhat.com>
Received: from QMTA03.emeryville.ca.mail.comcast.net
	(qmta03.emeryville.ca.mail.comcast.net [76.96.30.32])
	by ozlabs.org (Postfix) with ESMTP id 17745DDF4D
	for <linuxppc-dev@ozlabs.org>; Fri, 14 Mar 2008 09:42:41 +1100 (EST)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
From: Roland McGrath <roland@redhat.com>
To: Segher Boessenkool <segher@kernel.crashing.org>
Subject: Re: PPC upstream kernel ignored DABR bug
In-Reply-To: Segher Boessenkool's message of  Thursday,
	13 March 2008 23:20:47 +0100
	<2f8f82fe943fcd5103ec4cc39cc1bb26@kernel.crashing.org>
References: <20071126220224.GA5606@host0.dyn.jankratochvil.net>
	<200803101501.34439.jens@de.ibm.com>
	<1205344272.2272.45.camel@gargoyle>
	<200803122330.36905.jens@de.ibm.com>
	<20080313014745.DE97826F992@magilla.localdomain>
	<2f8f82fe943fcd5103ec4cc39cc1bb26@kernel.crashing.org>
Message-Id: <20080313224234.0A4FB26F993@magilla.localdomain>
Date: Thu, 13 Mar 2008 15:42:34 -0700 (PDT)
Cc: linuxppc-dev@ozlabs.org, Jan Kratochvil <jan.kratochvil@redhat.com>,
	Paul Mackerras <paulus@samba.org>, Arnd Bergmann <arnd@arndb.de>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

> Since the 970 kernel never sets DABRX currently, #8 cannot explain
> _intermittent_ problems: either it always works, or never does.

That's kind of what I thought, but I couldn't make enough sense of
the #8 text to be very sure.

> You could be happening upon #5, if the non-triggering data breakpoints
> are with vector loads/stores in strange code.

They are not.

> It would help if you could give us the disassembly of some code where the
> breakpoint did not trigger; say, that insn and the previous 20 or so insns.

The pointer to the test case was given here before.

http://sources.redhat.com/cgi-bin/cvsweb.cgi/~checkout~/tests/ptrace-tests/tests/ppc-dabr-race.c?cvsroot=systemtap

-m32	Dump of assembler code for function child_thread:
	0x10000950 <child_thread+0>:    stwu    r1,-32(r1)
	0x10000954 <child_thread+4>:    li      r3,207
	0x10000958 <child_thread+8>:    mflr    r0
	0x1000095c <child_thread+12>:   stw     r29,20(r1)
	0x10000960 <child_thread+16>:   stw     r0,36(r1)
	0x10000964 <child_thread+20>:   crclr   4*cr1+eq
	0x10000968 <child_thread+24>:   bl      0x10001680 <syscall>
	0x1000096c <child_thread+28>:   lis     r11,4097
	0x10000970 <child_thread+32>:   mr      r29,r3
	0x10000974 <child_thread+36>:   li      r3,1
	0x10000978 <child_thread+40>:   lwz     r9,7800(r11)
	0x1000097c <child_thread+44>:   addi    r9,r9,1
	0x10000980 <child_thread+48>:   stw     r9,7800(r11)
	0x10000984 <child_thread+52>:   bl      0x10001750 <sleep>
	0x10000988 <child_thread+56>:   lis     r9,4097
--->	0x1000098c <child_thread+60>:   stw     r29,7792(r9)
	0x10000990 <child_thread+64>:   bl      0x10001760 <pause>
	0x10000994 <child_thread+68>:   bl      0x10001760 <pause>
	0x10000998 <child_thread+72>:   b       0x10000990 <child_thread+64>
	End of assembler dump.

-m64	Dump of assembler code for function child_thread:
	0x0000000010000d10 <child_thread+0>:    mflr    r0
	0x0000000010000d14 <child_thread+4>:    std     r29,-24(r1)
	0x0000000010000d18 <child_thread+8>:    li      r3,207
	0x0000000010000d1c <child_thread+12>:   std     r0,16(r1)
	0x0000000010000d20 <child_thread+16>:   stdu    r1,-144(r1)
	0x0000000010000d24 <child_thread+20>:   bl      0x10000b68
	0x0000000010000d28 <child_thread+24>:   ld      r2,40(r1)
	0x0000000010000d2c <child_thread+28>:   ld      r11,-32696(r2)
	0x0000000010000d30 <child_thread+32>:   mr      r29,r3
	0x0000000010000d34 <child_thread+36>:   li      r3,1
	0x0000000010000d38 <child_thread+40>:   extsw   r29,r29
	0x0000000010000d3c <child_thread+44>:   lwz     r9,0(r11)
	0x0000000010000d40 <child_thread+48>:   addi    r9,r9,1
	0x0000000010000d44 <child_thread+52>:   clrldi  r9,r9,32
	0x0000000010000d48 <child_thread+56>:   stw     r9,0(r11)
	0x0000000010000d4c <child_thread+60>:   bl      0x10000a88
	0x0000000010000d50 <child_thread+64>:   ld      r2,40(r1)
	0x0000000010000d54 <child_thread+68>:   ld      r9,-32688(r2)
--->	0x0000000010000d58 <child_thread+72>:   std     r29,0(r9)
	0x0000000010000d5c <child_thread+76>:   nop
	0x0000000010000d60 <child_thread+80>:   bl      0x100009a8
	0x0000000010000d64 <child_thread+84>:   ld      r2,40(r1)
	0x0000000010000d68 <child_thread+88>:   b       0x10000d60 <child_thread+80>
	0x0000000010000d6c <child_thread+92>:   .long 0x0
	0x0000000010000d70 <child_thread+96>:   .long 0x1
	0x0000000010000d74 <child_thread+100>:  lwz     r0,0(r3)
	End of assembler dump.


Thanks,
Roland
