Return-Path: <owner-linuxppc-embedded@lists.linuxppc.org>
Message-ID: <20010508135003.34130.qmail@web9906.mail.yahoo.com>
Date: Tue, 8 May 2001 06:50:03 -0700 (PDT)
From: Freddy Lugo <wilflugo@yahoo.com>
Subject: Re: Uncompress Ok, but cannot run linux kernel...
To: linuxppc-embedded@lists.linuxppc.org
In-Reply-To: <439B3F1E9095D41193DE00D0B74FF30601CE7900@xpr01.prd.hp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


> turn_on_mmu:
>     .....
>     SYNC
>     RFI


I am dealing with same problem.  After the rfi (on
turn_on_mmu) instruction an signal is generated and
the progam counter is lost.  When performing an rfi
most of the bits of the SRR1 registers become the MSR
bits and the SRR0 register become the next instruction
pointer (NIA).  I read the manual and if the new MSR
value enables some pending exceptions then this
exceptions are processed by exception priority.  The
bits modified after the rfi are MSR_IR & MSR_DR so I
think (I am not sure yet) this bits enables a waiting
exception of some kind and when the rfi is processed
the exception is executed.  gdb only said it recevies
a SIGSTOP signal.  I will be working with that today.
If I found anything I will let you know.

Thanks

Freddy Lugo


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
