From: Keith Owens <kaos@ocs.com.au>
To: Dan Malek <dan@netx4.com>
cc: linuxppc-dev@lists.linuxppc.org
Subject: Re: SGI XFS on ppc 
In-reply-to: Your message of "Sun, 30 Jul 2000 21:20:38 -0400."
             <3984D466.E3EAB9F0@embeddededge.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Mon, 31 Jul 2000 12:02:25 +1000
Message-ID: <13459.965008945@ocs3.ocs-net>
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On Sun, 30 Jul 2000 21:20:38 -0400,
Dan Malek <dan@netx4.com> wrote:
>Keith Owens wrote:
>
>> .....  It should only be
>> included if you select kdb but kdb has not been ported to ppc.  I
>> maintain modutils, kallsyms and kdb.
>
>
>Ummm...I use kgdb and xmon on ppc, at least the ones with serial
>ports.  Is there yet another debugger for the kernel?

kgdb uses the remote gdb interface to debug the kernel and is very
useful provided the kernel is actually running.  The problem with
remote gdb is that it needs some support from the remote kernel for
things like page I/O.  If the cpu gets into a spin loop when interrupts
are disabled then you cannot access gdb to debug it.  Also things like
single step do not work work when interrupts are disabled.  However gdb
is very useful for debugging the higher layers of the kernel.

kdb is a really low level debugger, it can be used in interrupts and
has hooks to detects runaway spin loops and drop into the debugger.  It
requires no kernel support, it accesses the I/O hardware itself.  The
downside of kdb is you do not get the nice symbol printing that gdb can
do.  kdb knows where all the symbols are and can convert addresses to
symbols and offsets, but it cannot do source line listing nor do pretty
prints of structures.


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
