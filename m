Message-ID: <3CA9BF54.EAA3CEBD@lvl7.com>
Date: Tue, 02 Apr 2002 09:25:24 -0500
From: Neil Horman <nhorman@lvl7.com>
MIME-Version: 1.0
To: linuxppc-embedded@lists.linuxppc.org
Subject: question regarding a call stack from an oops message
Content-Type: multipart/mixed;
 boundary="------------B8D4C0DBABB3FDC3B568032B"
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


This is a multi-part message in MIME format.
--------------B8D4C0DBABB3FDC3B568032B
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit

Hello all!
	If anyone has a moment, I've got a question regarding the attached oops
message.  On the platform we are debugging we get this occasional oops message
(attached).  It doesn't start in any one point from the application code, but
the lower half of it (from sys_read down) is always identiacal. Specifically I'm
interested in the following snippet:
>Trace; c00202d4 <handle_mm_fault+6c/100>
>Trace; c0009e3c <Letext+190/3cc>
>Trace; c00029a8 <ret_from_except+0/34>
>Trace; c02e6e94 <END_OF_CODE+19a49c/???
>Trace; c002397c <do_generic_file_read+260/48c>

do_generic_file_read+260 in the image we are using is a jump to a function
pointer (named actor).  Our first thought was that actor was a corrupted pointer
(explaining the END_OF_CODE stack frame), but I no longer believe that.  I say
this because actor is assigned based on the file system type being read.  In the
current build we are using only nfs, so I replaced the call to the actor pointer
with a direct call to the function file_read_actor, which it is supposed to
point to.  The exact same oops message was observed with this change in place.
Then we thought that perhaps it was an uninitalized interrupt occuring, but
inspection of the SIMASK register shows that only interrupt 2 was enabled (the
service port PHY), which up until this oops had been working fine, as we are nfs
mounting our root filesystem over the service port.  We also thought that come
cache errata may be to blame for this but disabling the instruction and data
caches down in head_8xx.S made no difference.  Finally we thought it might have
been a kernel stack overflow, but that made no sense as after reading a few
things we fond that the GPR1 is larger than GPR2 by about 4k of space.  So
needless to say, we are running out of ideas.

Questions:
1) Can anyone think of any other theories that might cause this END_OF_CODE
stack frame behavior?
2) Regarding the Letext stack frame: I see this often as well, and I'm a little
puzzled.  Is its appearance to be expected.  I expected to see after a
ret_from_except stack frame a link to one of the memory management handler
routines (do_page_fault, etc), but I don't.  For my own education, what is that
Letext line?


Relevant information:
1) the board is a custom design, with 64 MB of SDRAM on board.
2) The CPU is an 860P.  The silicon revision is D4, which I understand to be
production quality, and the errata list shows no defects in the cache that I can
see.  however, we have tried this without caching (I or D) on and  with CPU6
errata enabled to be certain and the behavior perisists.
3) These oopses are seemingly random.  They happen at various times and places,
and there are others which occur in places other than an nfs file read, but this
is the most consistent (it occurs during the insmod of a large kernel module).
The final stack frame however, always ends in clear page, on the 1st iteration
of the loop defined in misc.S (GPR0 = 0x100).
4)The page on which it took the oops is marked as valid (I called print_8xx_pte
from die, and the pte v bit is 1), but the protection bits are marked as binary
00, which accoriding to the 8xx users guide indicates no access at all.

Thanks a bunch!
Neil :)
--------------B8D4C0DBABB3FDC3B568032B
Content-Type: text/plain; charset=us-ascii;
 name="oops1.txt"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="oops1.txt"

ksymoops 2.4.1 on i686 2.4.7-10.  Options used
     -V (default)
     -K (default)
     -L (default)
     -O (default)
     -m ./System.map (specified)

Oops: kernel access of bad area, sig: 11
NIP: C0004B3C XER: 00000000 LR: C0020088 SP: C3BB7C70 REGS: c3bb7bc0 TRAP: 0300    Not tainted
Using defaults from ksymoops -t elf32-little -a unknown
MSR: 00009032 EE: 1 PR: 0 FP: 0 ME: 1 IR/DR: 11
TASK = c3bb6000[84] 'insmod' Last syscall: 3
last math 00000000 last altivec 00000000
GPR00: 00000100 C3BB7C70 C3BB6000 C28F4000 00000000 C0116428 02000000 3090E000
GPR08: 000028F4 00000000 C0264040 000028F4 08070800 1001CD38 00000000 00000000
GPR16: 00000000 00000000 00000001 C0023BA8 00009032 03BB7DC0 00000000 C00029A8
GPR24: C0009CAC 00030002 C2B06438 C2B06438 C0125C70 C01271B0 00110889 C0207D00
Call backtrace:
C0020078 C0020160 C00202D4 C0009E3C C00029A8 C02E6E94 C002397C
C0023CB4 C005F028 C0031514 C000277C 1000BA28 100042FC 10004D78
0FED9DBC 00000000
Warning (Oops_read): Code line not seen, dumping what data is available

>>???; c0004b3c <clear_page+c/28>   <=====
Trace; c0020078 <do_anonymous_page+50/e4>
Trace; c0020160 <do_no_page+54/15c>
Trace; c00202d4 <handle_mm_fault+6c/100>
Trace; c0009e3c <Letext+190/3cc>
Trace; c00029a8 <ret_from_except+0/34>
Trace; c02e6e94 <END_OF_CODE+19a49c/???
Trace; c002397c <do_generic_file_read+260/48c>
Trace; c0023cb4 <generic_file_read+78/ac>
Trace; c005f028 <nfs_file_read+bc/d0>
Trace; c0031514 <sys_read+c8/114>
Trace; c000277c <ret_from_syscall_1+0/b4>
Trace; 1000ba28 Before first symbol
Trace; 100042fc Before first symbol
Trace; 10004d78 Before first symbol
Trace; 0fed9dbc Before first symbol
Trace; 00000000 Before first symbol


1 warning issued.  Results may not be reliable.

--------------B8D4C0DBABB3FDC3B568032B--


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
