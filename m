Message-ID: <20030430085853.57551.qmail@web12706.mail.yahoo.com>
Date: Wed, 30 Apr 2003 10:58:53 +0200 (CEST)
From: =?iso-8859-1?q?vincent=20poirson?= <poirsonv@yahoo.fr>
Subject: profiling kernel/head.S
To: linuxppc-embedded@lists.linuxppc.org
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Hi,

I am using a SBC8260 board. I want to profile code
from the interrupt signal to the interrupt handler
using Port C and a scope. One of my time measures is
in kernel/head.S right after the HardwareInterrupt at
0x500. My problem is that when I load the PDATC value,

the kernel crashes and I get a kernel stack overflow.
I have no idea why. Any help is appreciated.
Here is my modified head.S:

HardwareInterrupt:
 EXCEPTION_PROLOG
 addi r3,r1, STACK_FRAM_OVERHEAD
 li r20,MSR_KERNEL

 /* PDATC |= BIT_31 */
 lis 7,0xf0010d50@h     // PDATC addr : 0xf0010d50
 lwz 0,0xf0010d50@l(7)  // kernel crash here
 ori 0,0,1
 stw 0,0xf0010d50@l(7)


Thanks in advance.








___________________________________________________________
Do You Yahoo!? -- Une adresse @yahoo.fr gratuite et en français !
Yahoo! Mail : http://fr.mail.yahoo.com

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
