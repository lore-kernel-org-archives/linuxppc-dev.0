Return-Path: <owner-linuxppc-embedded@lists.linuxppc.org>
Date: Mon, 7 Jul 2003 12:05:23 -0400
From: Kent Borg <kentborg@borg.org>
To: linuxppc-embedded@lists.linuxppc.org
Subject: gdbserver, find_extend_vma(), and VM_GROWSDOWN
Message-ID: <20030707120523.B4527@borg.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


I am having gdbserver problems.  I can run gdbserver and attach to it
with gdb, but the peeks into the application space are failing.

For example, in debugging the peek for the first instruction of my
application, there is a call to find_extend_vma() (in mm/mmap.c).  The
test for:

  vma->vm_start <= addr

fails, and as this vms is VM_GROWSUP (and not VM_GROWSDOWN), the next
if-statement returns a NULL.  That percolates up until ptrace returns
zero.

This application code runs pretty well without gdbserver, what should
I look for next?  Is it indeed perverse for the addr to be below the
start?  Who is likely to blame for that?  Where should I look next?
Do I start grepping for every instance of PT_PTRACED in arch/ppc?


Thanks,

-kb, the Kent whose gdbserver Makefile says it is 4.12.3, and whose
kernel is quite close to 2.4.21.rc1.

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
