Date: Thu, 20 Jun 2002 19:35:05 +0900
From: Etsushi Kato <ekato@ees.hokudai.ac.jp>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: paulus@samba.org, linuxppc-dev@lists.linuxppc.org
Subject: Re: tlbia and PPC603
References: <20020620174254U.ekato@ees.hokudai.ac.jp> <20020620075355.30719@smtp.adsl.oleane.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20020620075355.30719@smtp.adsl.oleane.com>
Message-Id: <20020620193505D.ekato@ees.hokudai.ac.jp>
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On Thu, Jun 20, 2002 at 09:53:55AM +0200,
Benjamin Herrenschmidt <benh@kernel.crashing.org> wrote:

> Your xmon trace show something interesting: xmon itself crashes with a
> trap 300 while trying to access the hash table. The hash beeing mapped
> with a BAT, that shouldn't be an issue with the TLB handlers nor with
> a stale TLB entry. I currently fail to see what could be going on there,
> could you try to reproduce that crash ? In this case, once "h" fails
> within xmon, type
>
>  di %pc

>mon di %pc
c00c2ef4   7d7c002e	lwzx	r11,r28,r0
c00c2ef8   7e6a4b78	or	r10,r19,r9
c00c2efc   7c0b5000	cmpw	r11,r10
c00c2f00   3b280001	addi	r25,r8,1
c00c2f04   3bc00000	li	r30,0
c00c2f08   7ffc0214	add	r31,r28,r0
c00c2f0c   39200000	li	r9,0
c00c2f10   3b5d1000	addi	r26,r29,4096
c00c2f14   4800001c	b	0xc00c2f30
c00c2f18   39290001	addi	r9,r9,1
c00c2f1c   2c090007	cmpwi	r9,7
c00c2f20   3bff0008	addi	r31,r31,8
c00c2f24   41810014	bgt	0xc00c2f38
c00c2f28   801f0000	lwz	r0,0(r31)
c00c2f2c   7c005000	cmpw	r0,r10
c00c2f30   4082ffe8	bne	0xc00c2f18

>  r

>mon r
R00 = 00000000	R01 = c796db50	R02 = c796c000	R03 = 00000000
R04 = 00000000	R05 = 0ffff000	R06 = 00000000	R07 = 00000000
R08 = 00000000	R09 = 80000000	R10 = 0f0f0f0f	R11 = 00000000
R12 = 84282424	R13 = 1005c3bc	R14 = c796dee8	R15 = 240004e3
R16 = c02d62c0	R17 = c796c000	R18 = c02b0000	R19 = 00000000
R20 = 00009032	R21 = 0000ffff	R22 = 00000000	R23 = 00000000
R24 = ffffffff	R25 = c0512bc0	R26 = c02a0000	R27 = 00000000
R28 = 00000000	R29 = 00000000	R30 = c02a0000	R31 = 00000000
pc  = c00c2ef4	msr = 00001032	lr  = c00c3114	cr  = 84282424
ctr = 00000000	xer = 20000000	trap =  300


--
Etsushi Kato
ekato@ees.hokudai.ac.jp

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
