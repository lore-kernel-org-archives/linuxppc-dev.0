Message-ID: <A33AEFDC2EC0D411851900D0B73EBEF7063EB6@NAPA>
From: Hua Ji <hji@netscreen.com>
To: linuxppc-embedded@lists.linuxppc.org
Subject: About eabi and stack
Date: Fri, 9 Feb 2001 15:08:05 -0800 
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


 I got confused by the EABI stack usage. Help needed. Thanks in advance.

What I did is:

* Wrote a dummy c function and got its asm codes like below with objdump
utility.
* From EABI convention, I can understand that testStack function first move
its stack pointer %r1
16 words down and meantime save the old stack position onto the lowest
address. However, I can't understand
where it puts the lr(link register). I can't understand the "stw r0, 20(r1)"
instruction. I THOUGHT, we **only**
moved the stack pointer **-16** down. How can we save the lr value with
"20(r1)"??

Hua

---------------------------------

 void testStack(){


	testFunction();
}

---------------------------------
 <testStack>:

 2b8:	94 21 ff f0 	stwu	r1,-16(r1)
 2bc:	7c 08 02 a6 	mflr	r0
 2c0:	93 e1 00 0c 	stw	r31,12(r1)
                        ***************
 2c4:	90 01 00 14 	stw	r0,20(r1)   ???? Where 20(r1) will point
to??
                        ***************
 2c8:	7c 3f 0b 78 	mr	r31,r1
 2cc:	48 00 00 01 	bl	2cc <testStack+0x14>

/* Below is to restrore stack and lr*/
 2d0:	81 61 00 00 	lwz	r11,0(r1)
 2d4:	80 0b 00 04 	lwz	r0,4(r11)
 2d8:	7c 08 03 a6 	mtlr	r0
 2dc:	83 eb ff fc 	lwz	r31,-4(r11)
 2e0:	7d 61 5b 78 	mr	r1,r11
 2e4:	4e 80 00 20 	blr

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
