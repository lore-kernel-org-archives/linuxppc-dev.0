Message-ID: <D1192D5D60069F449EAE4CAB0ED4BCE70D994A@stca202a.bus.sc.rolm.com>
From: "Guenther, Christian" <Christian.Guenther@icn.siemens.com>
To: "'linuxppc-embedded@lists.linuxppc.org'" <linuxppc-embedded@lists.linuxppc.org>
Subject: SIGSEGV while blocking in  nanosleep() system call 
Date: Thu, 7 Nov 2002 11:15:57 -0500 
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Hi,

I'm having a problem getting SIGSEGV in a multi (posix)-threaded process
(let me refer to that process with P1)
running on a TQM board (TQM855LDBBA3-T66.204) under a patched kernel
provided by DENX (linux-2.4.4-2002_03_21).
In addition to the patched kernel rtai-24.1.8-2002-03-21 (also provided by
DENX) is running.
The libraries I use are the ones indicated by LIB_LIST_HH-2.0 under
SELF-2002-03-21.
The MPC855 is running with data caches disabled.


Debugging of the generated core file (backtracing via gdb's "bt") shows that
the last thread running in process P1 was blocking
in a nanosleep() system call at that time.

To retrieve a little bit more information (PID, memory address) I patched
the kernel fault handler (fault.c) to see what memory reference causes the
SIGSEGV. It seems like the faulty address is deterministically the same
(0x5).


I currently assume (please correct me if my assumption might be wrong) that
this crash is not directly caused by one of the (posix-)threads running in
P1 for the following reasons:


- Substitution of the nanosleep() system call with a
select(0,0,0,0,&timeval) system call in the indicated thread also leads to
the very same problem with the very same address (0x5).

- After moving the code being executed by the indicated thread into a
dedicated different PROCESS P2 another thread of P1 crashes with the same
SISEGV (and the same memory address 0x5 also blocking in a select() system
call).


Is there anything else I can give a try in user space ?
Has anybody successfully run kdb on that platform ? If yes is there anything
special I have to consider in setting up kdb on a  TQM855 board?



I appreciate any hints.

Please forgive me in case I should be able to find answers to those
questions somewhere (in case those questions are standard questions).
I think I spent a reasonable amount of time crawling in KHG, this mailing
list' archive and the like, but I'm simply running out of time.

Thanks,
Christian


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
