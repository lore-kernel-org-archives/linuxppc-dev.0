Date: Tue, 17 Apr 2001 04:03:46 -0300
To: linuxppc-dev@lists.linuxppc.org
Subject: Re: Quad SMP on G4
Message-ID: <20010417040346.C15047@llama.nslug.ns.ca>
References: <200104170459.XAA21609@lists.linuxppc.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <200104170459.XAA21609@lists.linuxppc.org>; from owner-linuxppc-dev-digest@lists.linuxppc.org on Mon, Apr 16, 2001 at 11:59:09PM -0500
From: Peter Cordes <peter@llama.nslug.ns.ca>
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


> Date: Mon, 16 Apr 2001 10:48:42 -0500
> From: "Eddy Raineri" <eraineri@axiom-tx.com>
> Subject: Quad SMP on G4
>
> Hello,
>
> If this is not the correct forum for these questions; I apologize and could
> someone please direct me to the correct one forum for me to post this.
>
> 1)  I am currently working on a quad G4 custom processor board.  I have been
> trying to keep up with the linuxppc_2_4 tree on bitkeeper.fsmlabs.com.  I
> have successfully brought the board up with all 4 processors however at
> times I get various lock ups in the spin locks.  These spinlock debugs
> follow.
>
> 	spin_unlock(c0157384): no lock cpu 0 curr PC c0040500 mke2fs/22
> 	_spin_unlock(c0157384): cpu 0 trying clear of cpu 2 pc c00404f0 val
> ffffffff
> 	_spin_unlock(c0157384): cpu 2 trying clear of cpu 0 pc 28/680bc val
> ffffffff
> 	29/68_spin_unlock(c0157384): cpu 2 trying clear of cpu 0 pc c00400bc
>
> This spin_lock is lru_list_lock.
>
> I've also seen common instances where everything locks up inside of the
> hash_table_lock.  I have gotten this by running Bonnie on my SCSI harddrive.

 I've had similar instability problems with my quad PPC604 (Daystar Genesis
MP).  I bought the computer used from some random guy (who bought it from
somebody else), so I figured there was a good chance I had some bogus
hardware.  Since I'm not the only one to see this, I guess it's not my
hardware.   I've got another computer next to my ppc machine, so it's pretty
good for debugging.  I took notes, though, so here's what I've got:

 I was running 2.4.3-pre2 from the bk tree.  I started up the
distributed.net client, dnetc, and left the computer while I ate supper.
(dnetc starts a cruncher thread for every CPU.  Each thread runs in a tight
loop doing a known-plaintext attack against 64bit RC5 (the inner loop
basically doesn't use RAM, just registers).  see the web page for more
details.  There's a decent chance of two threads finishing their block at
the same time, since the amount of work per block is constant and there is
no memory access to make it dependent on stalls due to other processors.
When a thread finishes it's block, it saves the result (usually, that the
key was not in that block of keyspace :( ) and loads a new block to work on.
(a block is of course just a start/length, since keys are tested
sequentially.)

 When I came back from supper, these were lots of these messages, in random
order, on the screen.  A new one showed up every ~10 seconds, but not at
regular intervals:

_spin_lock(c0151484) CPU#0 NIP c002c358 holder: cpu 0 pc C002CD30
 "         c0151484     #1 NIP c002ce1c holder: cpu 0 pc C002CD30
 "         c014f740     #2 NIP c0080130 holder: cpu 0 pc C0043E8C
 "         c014f740     #3 NIP c9855800 holder: cpu 0 pc C0043E8C

 When these came up, the keyboard was half functional.  I could switch
consoles, scroll back, and use the magic sysrq key.  Regular typing doesn't
produce any characters on screen, so of course I couldn't log in.  I could
ping and make TCP connections, but user space sshd doesn't answer, so the
connection hangs.


System.map tells me that c0151484 is pagecache_lock and c014f740 is
kernel_flag.
CPU 0:
c002c358 is in filemap_fdatasync.  C002CD30 is inside __find_get_page.
CPU 1:
c002ce1c is in __find_lock_page.  C002CD30 same as above
CPU 2:
c0080130 is in tty_write.  C0043E8C is in sync_old_buffers.
CPU 3:
c9855800 is past the end of the kernel?!?  Maybe I copied it wrong.

 BTW, I left dnetc running on a console, instead of in its daemon-like mode,
which makes it plausible for tty_write to show up here.

 I typed in some magic-sysrq register dumps:

NIP: C00137A8 XER: 20000000 LR: C00137DC SP: c05bfe80 REGS: c05bfdd0 TRAP: 0500
MSR: 00009032 EE: 1 PR: 0 RP: 0 ME: 1 IR/DR: 11
TASK = c05be000[6] 'kupdate' Last syscall: -1
last math 00000000 last altivec 00000000 CPU: 0
GPR00: c00137d0 c05bfe80 c05be000 ffffffff c0151484 ffffffff ffffffff 00000000
GRP08: c6a75220 00000000 00000000 c05bfdc0 24882044 059a44a1 00000000 00000000
GPR16: 00000000 00000000 00000000 00000000 003ff000 c0160000 c016629c c0150000
GPR24: 00000000 c0068cd8 c0150000 c0160000 c0110000 00000000 c0151484 09b36540

(repeated, with same NIP.  _only_ change is GPR31 = 09452A6F.)

NIP: C00137A4 XER: 20000000 LR: C00137DC SP: c05bfe80 REGS: c05bfdd0 TRAP: 0500
(only change is in GPRs, where GRP31 = 087389cf.)

 holding down alt+sysrq+p (to produce a whole lot of dumps, for comparison
purposes) NIP can be:
c0006a08, c00137dc, or c00137a4

(usually c00137a8.  sometime trap is 0900).

 When NIP is c0006a08, GRP3 = c0151484.  Other times, it's ffffffff.
NIP: c05bfb60 XER: C0093e54 LR: c05bfb60 SP: 0000001e regs: c05bfa90 trap: \
c0113b0c
MSR: c0150000 EE: 0 PR: 0 FP: 0 ME: 0 IR/DR: 00
TASK = (same kupdate)
last math (same)
GPR00: c05bfad0 c00b7690 00000000 00000000 c05bfb10 c0150000 30303030 30333033
GPR08: c05bfad0 00000006 c01e2198 c01e2198 c05bfae0 c6a75276 00000009 ffffffff
GPR16: c05bfad0 c01e2198 00000018 00000006 c05bfaf0 c01b6889 00000001 c05bfaf0
GPR24: c05bfad0 c00148b8 00009032 c01e2198 c05bfb40 c0093e54 c05bfbb0 00000000

 As I said, I've got the System.map, so if anybody wants, I can decode it or
post it or something.  I've also got the vmlinux and the .config.

 I also had a crash with 2.4.4pre1 (bk tree), again with dnetc.  This time,
it dropped me into xmon.  I was able to move the mouse, and X redrew its
background window under the mouse, which was odd.  After I pressed 's' in
xmon, the system totally locked.  (I don't know xmon, so I don't even know
what that did.)

 I did get a backtrace and a register dump.  I'm not going to decode it all
right now, but I've got vmlinux, System.map, and the .config I compiled it
from.  If anyone wants to debug, I'll send the info.

 I'll have more time to work on this in a couple weeks after I graduate from
university.  :)

> 4)  One more simple question.  I'm unclear as to which 2_4 version I should
> pull from I have been using the linuxppc_2_4 kernel and not linus' is this
> correct?  I'm trying to stay current on the PPC fixes for the 2_4 kernel.  I
> am assuming that any fixes Linus makes to the kernel will be put into the
> linuxppc_2_4 version however any fixes made in general by the PPC group
> might not make it into the Linus version.

 Yup, that's the deal. see http://penguinppc.org/dev/kernel.shtml.  They've
got an rsync mirror of the bk tree (and others, like paulus and benh,
AFAIK).  e.g. rync --delete -avz rsync://penguinppc.org/linux-2.4-bk .
adjust as necessary.

 I point this out mainly because I found that I had to export the bk tree to
another directory to compile it, since all the filenames were wrong.

> I apologize if this is repeated.  I'm trying desperately to find the
> resources necessary for me to stay informed but may have not found it yet.

 AFAIK, this is _the_ mailing list for the Linux kernel on PowerPC.

 I'll have to give Michael Wortman's patch a try, if I still get the crash
with 2.4.4pre3.  (which compiled cleanly right off the bat.  Thanks Ben :)


--
#define X(x,y) x##y
Peter Cordes ;  e-mail: X(peter@llama.nslug. , ns.ca)

"The gods confound the man who first found out how to distinguish the hours!
 Confound him, too, who in this place set up a sundial, to cut and hack
 my day so wretchedly into small pieces!" -- Plautus, 200 BCE

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
