Message-ID: <20030526082722.86882.qmail@web9706.mail.yahoo.com>
Date: Mon, 26 May 2003 01:27:22 -0700 (PDT)
From: None Atall <linux_meis@yahoo.com>
Subject: Re: [MPC8260] accessing I/Os while MMU is off
To: vincent poirson <poirsonv@yahoo.fr>,
	linuxppc-embedded@lists.linuxppc.org
In-Reply-To: <20030526061601.60728.qmail@web12701.mail.yahoo.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


You missed a small shift... :)

-----------------------
li r16,r16,0x10
li r13, 0xf001
slw  r13,r13,r16
addis r13, 0x0d50
stw r14, 0(r13)
-----------------------

                   Dimitris.

--- vincent poirson <poirsonv@yahoo.fr> wrote:
>
> Hello,
>
> I want to change my PDATC value while in
> HardwareInterrupt code (in kernel/head.S) where MMU
> is
> off. So I simply do :
> li r13, 0x0d50
> addis r13, 0xf001
> stw r14, 0(r13)
> // where 0xf0010d50 is my PDATC adress and r14 the
> value I want to store
> I do not understand why my kernel crahes and goes in
> machine exception. Surprisingly, I can change PDATC
> with BDI2000 but not with assembler code. Is this an
> adress translation problem ?
> Am I missing something obvious ? Any help will be
> appreciated.
>
> Thanks in advance.
>
>
>


=====
------------------------------------------------------------
-Dhmhtrios Meidanis
-Degree in Mathematics, University of the Aegean.
-Master in Computer Architecture and Digital
 Systems, University of Crete.
 Greece.
------------------------------------------------------------


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
