Return-Path: <owner-linuxppc-embedded@lists.linuxppc.org>
Message-ID: <20010508212135.87447.qmail@web9906.mail.yahoo.com>
Date: Tue, 8 May 2001 14:21:35 -0700 (PDT)
From: Freddy Lugo <wilflugo@yahoo.com>
Subject: Re: Uncompress Ok, but cannot run linux kernel... 
To: linuxppc-embedded@lists.linuxppc.org
In-Reply-To: <20010508152157.613E32814D@denx.denx.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


--- Wolfgang Denk <wd@denx.de> wrote:
> Single-stepping over an RFI instruction? I  don't
> think  you'll  get
> this working.

thanks, I discovered that the 'hard' way!.

However I found the problem but I don't have any clue
what is happenning.  On the start_here after
turn_on_mmu there are some memory access instructions:

start_here:
....
c000361c addi r11,r11,_endl@l
c0003620 lis r8, __bss_start@h
c0003624 addi r8,r8,__bss_start@l
c0003628 subf r11,r8,r11
....
c0003644 stwu r0,4(r8)

the problem is that for some reason the when the
c000361c instruction is executed the program counter
jumps to the c0003644 instruction.  R8 don't have the
value it should be and the current value is way out of
the 16MB declare initialy on initial_bats.
This cause an SIGSTOP signal cause the MMU can't
translate the address requested.  I think this should
be a debuging or compiler issue cause I don't have any
explanation about what is happenning.

I repeated the procedure several times and it is not
on the same instruction but is the same cause, and in
the same procedure (start_here).  Previous
instructions were not executed, and a memory access is
tried with anunexpected value on the register.

Any suggestions?

Debugging Environment:
BDI2000 -> gdb 5.0
MPC750 (6xx,7xx,7400) using a PReP Type

Thanks,

Freddy Lugo


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
