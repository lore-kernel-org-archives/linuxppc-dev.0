Message-Id: <200004140219.WAA08338@hoover.gilbarco.com>
From: "Banks, Kelly" <kelly_banks@gilbarco.com>
To: "'linuxppc-embedded@lists.linuxppc.org'"
	 <linuxppc-embedded@lists.linuxppc.org>
Subject: gdb remote signal handling and multithreaded debugging (SIGPWR on
	 thread NEW() )
Date: Thu, 13 Apr 2000 22:19:51 -0400
Mime-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Using
ftp://ftp.mvista.com/pub/CDK/wip/ppc_8xx/RPMShhl-gdb-4_17_0_11-2_src.rpm
combined with a modified Makefile from
ftp://linuxppc.cs.nmt.edu/pub/linuxppc/embedded/gdbserver.tgz

I have built  GdB (mac host: powerpc-elf-linux-gnu) & GdBserver (homegrown
MPC860 target: powerpc-elf-linux-gnu).

I am having a difficulties with multithreaded debugging & step-over(next)
usage after a breakpoint.

First, I was receiving a SIGPWR (signal 0x20 at the host) upon thread
initialization.

I noticed that the kernel signals file has SIGRT32 = 0x20 whereas
gdb/target.h defines TARGET_SIGNAL_REALTIME_32 = 45 (0x2d).

I droped a couple of quik conversion routines { uchar sig_host2ppc(uchar
sig) & uchar sig_ppc2host(uchar sig) } into gdbserver/server.c.

I then used them in
gdbserver/server.c::main<case 'C'> and <case 'S' >
and in gdbserver/remote-utils.c::prepare_resume_reply(~) respectively.

The conversion simply added/subtracted (0x2d - 0x20) to/from the signal as
it was passed back & forth between host & target when the target sig>=0x20.

(Q: is this completely off base??)

I also set handling for SIG32 to nostop & noprint in gdb.

(Q: Is there a good source for documentation about these target linux
signals?)



Now, I can hit my breakpoints (I only tried in the parent thread main() so
far).

However, if I break at line 15 (for instance) and use repeated 'n' commands
The system shows me line
15, then 14!, then 15 again, and Fineally executes line 15 and goes on to
show line 16!

I fear that I am not handling that sig=0x20 properly but am not familiar
enough with the innerworkings as of yet.

Any guidance which you may be able to provide would be greatly appreciated.

Thanx,
Kelly Banks


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
