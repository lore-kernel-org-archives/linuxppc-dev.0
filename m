Message-ID: <3D914A93.E02456F4@mvista.com>
Date: Tue, 24 Sep 2002 22:33:07 -0700
From: Scott Anderson <scott_anderson@mvista.com>
MIME-Version: 1.0
To: jim <jduey@ccc-dcs.com>
Cc: linuxppc-embedded@lists.linuxppc.org
Subject: Re: Delay on starting init
References: <20020911175118.04A9E38E9D@server.weathercom.com> <20020912012457.GX13670@zax> <3D6E4A4A0000123A@charlotte.ccc-dcs.com> (added by charlotte.ccc-dcs.com)
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


jim wrote:
> If anyone finds the cause of the delay on starting init with NFS root file
> systems, please post to the list.

I don't know the cause of the delay, but as I was debugging another
kernel problem, I remembered this and hit ^C in gdb a few times to see what
was going on.  In both cases, it was handling mm faults.  I attached
the output from my gdb macros just in case it jogs anyone's brain cells.
To really figure out what is going on, we may have to compare old vs.
new.
  Scott

(gdb) ps
Address      PID State      User NIP  Kernel NIP device comm
0xC013DFD0     0<Running              0xC00060E4        swapper
0xC0344000     1 Disksleep 0x30003578 0xC0006FD8        init
0xC03DA000     2 Sleeping             0xC0006FD8        keventd
0xC03D6000     3 Sleeping             0xC0006FD8        ksoftirqd_CPU0
0xC03D4000     4 Sleeping             0xC0006FD8        kswapd
0xC03D2000     5 Sleeping             0xC0006FD8        bdflush
0xC03D0000     6 Sleeping             0xC0006FD8        kupdated
0xC7DD4000     7 Sleeping             0xC0006FD8        rpciod
(gdb) kbt 1
Task "init":
0xC0345D40: 0xc0006fd8 <_switch_to+96>: stw     r3,0(r30)
0xC0345D60: 0xc0010f30 <schedule+1368>: lwz     r9,8(r31)
0xC0345D90: 0xc0028cd4 <__lock_page+192>:       lwarx   r0,r0,r28
0xC0345DC0: 0xc0028d48 <lock_page+52>:  lwz     r0,20(r1)
0xC0345DD0: 0xc002a528 <filemap_nopage+376>:    lwz     r0,8(r31)
0xC0345E00: 0xc0025b08 <do_no_page+116>:        mr.     r31,r3
0xC0345E30: 0xc0025ce0 <handle_mm_fault+112>:
    b   0xc0025d58 <handle_mm_fault+232>
0xC0345E60: 0xc000ea74 <do_page_fault+652>:     cmpwi   r3,1
0xC0345F20: 0xc0004854 <ret_from_except>:       lwz     r3,148(r1)
(gdb) cont
Continuing.

Program received signal SIGSTOP, Stopped (signal).
idled () at idle.c:110
110                     if (current->need_resched) {
(gdb) ps
Address      PID State      User NIP  Kernel NIP device comm
0xC013DFD0     0<Running              0xC00060E4        swapper
0xC0344000     1 Disksleep 0x30003578 0xC0006FD8        init
0xC03DA000     2 Sleeping             0xC0006FD8        keventd
0xC03D6000     3 Sleeping             0xC0006FD8        ksoftirqd_CPU0
0xC03D4000     4 Sleeping             0xC0006FD8        kswapd
0xC03D2000     5 Sleeping             0xC0006FD8        bdflush
0xC03D0000     6 Sleeping             0xC0006FD8        kupdated
0xC7DD4000     7 Sleeping             0xC0006FD8        rpciod
(gdb) kbt 1
Task "init":
0xC0345D40: 0xc0006fd8 <_switch_to+96>: stw     r3,0(r30)
0xC0345D60: 0xc0010f30 <schedule+1368>: lwz     r9,8(r31)
0xC0345D90: 0xc0028cd4 <__lock_page+192>:       lwarx   r0,r0,r28
0xC0345DC0: 0xc0028d48 <lock_page+52>:  lwz     r0,20(r1)
0xC0345DD0: 0xc002a528 <filemap_nopage+376>:    lwz     r0,8(r31)
0xC0345E00: 0xc0025b08 <do_no_page+116>:        mr.     r31,r3
0xC0345E30: 0xc0025ce0 <handle_mm_fault+112>:
    b   0xc0025d58 <handle_mm_fault+232>
0xC0345E60: 0xc000ea74 <do_page_fault+652>:     cmpwi   r3,1
0xC0345F20: 0xc0004854 <ret_from_except>:       lwz     r3,148(r1)

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
