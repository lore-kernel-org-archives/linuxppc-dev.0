Message-ID: <20040126132202.77293.qmail@web21401.mail.yahoo.com>
Date: Mon, 26 Jan 2004 05:22:02 -0800 (PST)
From: "Dave, Dave, Dave, Dave Johnson, Johnson, Johnson, Johnson" <davejohnson_hifi@yahoo.com>
Subject: Re: Linux Performance 
To: Wolfgang Denk <wd@denx.de>
Cc: linuxppc-embedded@lists.linuxppc.org
In-Reply-To: <20040123000415.E219AC10AF@atlas.denx.de>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="0-125327544-1075123322=:76524"
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


--0-125327544-1075123322=:76524
Content-Type: text/plain; charset=us-ascii
Content-Id: 
Content-Disposition: inline

Sorry, file is attached now.
Dave
--- Wolfgang Denk <wd@denx.de> wrote:
>
> In message
> <20040122204828.62134.qmail@web21405.mail.yahoo.com>
> you wrote:
> >
> > I am running MV3.1 Linux on a MPC8270 based custom
> > board. I ran LMbench2 on my board and got these
> > numbers (file attached). Also I have high
> interrupt
>
> Attachment missing.
>
> > Also these numbers dont look good either. Are
> there
> > any tricks which can be played to enhance kernel
> > performance??
>
> Turn on the caches?
>
>
> Wolfgang Denk
>
> --
> See us @ Embedded World, Nuremberg, Feb 17 - 19,
> Hall 12.0 Booth 440
> Phone: (+49)-8142-4596-87  Fax: (+49)-8142-4596-88
> Email: wd@denx.de
> "You know, after a woman's raised a family and so
> on,  she  wants  to
> start living her own life."   "Whose life she's
> _been_ living, then?"
>                                   - Terry Pratchett,
> _Witches Abroad_
>
>


--0-125327544-1075123322=:76524
Content-Type: text/plain; name="ppc_LMbench.txt"
Content-Description: ppc_LMbench.txt
Content-Disposition: inline; filename="ppc_LMbench.txt"

                 L M B E N C H  2 . 0   S U M M A R Y
                 ------------------------------------


Basic system parameters
----------------------------------------------------
Host                 OS Description              Mhz

--------- ------------- ----------------------- ----
dave--x86 Linux 2.4.18-       i686-pc-linux-gnu 2387
dave-ppc  Linux 2.4.18_       powerpc-linux-gnu  450

Processor, Processes - times in microseconds - smaller is better
----------------------------------------------------------------
Host                 OS  Mhz null null      open selct sig  sig  fork exec sh
                             call  I/O stat clos TCP   inst hndl proc proc proc
--------- ------------- ---- ---- ---- ---- ---- ----- ---- ---- ---- ---- ----
dave--x86 Linux 2.4.18- 2387 0.46 0.51 1.21 1.87 6.001 0.74 2.51 125. 348. 2349
dave-ppc  Linux 2.4.18_  450 0.49 1.19 7.32 24.1  68.9 1.98 6.21 1388 9126 36.K

Context switching - times in microseconds - smaller is better
-------------------------------------------------------------
Host                 OS 2p/0K 2p/16K 2p/64K 8p/16K 8p/64K 16p/16K 16p/64K
                        ctxsw  ctxsw  ctxsw ctxsw  ctxsw   ctxsw   ctxsw
--------- ------------- ----- ------ ------ ------ ------ ------- -------
dave--x86 Linux 2.4.18- 0.800 1.8600 5.4000 2.3500   32.4 5.74000    41.2
dave-ppc  Linux 2.4.18_ 1.730   82.9  277.1   85.0  282.3    85.0   282.4

*Local* Communication latencies in microseconds - smaller is better
-------------------------------------------------------------------
Host                 OS 2p/0K  Pipe AF     UDP  RPC/   TCP  RPC/ TCP
                        ctxsw       UNIX         UDP         TCP conn
--------- ------------- ----- ----- ---- ----- ----- ----- ----- ----
dave--x86 Linux 2.4.18- 0.800 4.085 7.55  11.1  17.2  13.7  23.3 32.5
dave-ppc  Linux 2.4.18_ 1.730  14.1 42.6 128.1 285.9 210.7 375.0 603.

File & VM system latencies in microseconds - smaller is better
--------------------------------------------------------------
Host                 OS   0K File      10K File      Mmap    Prot    Page
                        Create Delete Create Delete  Latency Fault   Fault
--------- ------------- ------ ------ ------ ------  ------- -----   -----
dave--x86 Linux 2.4.18-   29.6 6.0130   67.6   11.5   1125.0 1.083 1.00000
dave-ppc  Linux 2.4.18_ 1968.5 1483.7  19.6K 1841.6   8065.0 1.920    38.0

*Local* Communication bandwidths in MB/s - bigger is better
-----------------------------------------------------------
Host                OS  Pipe AF    TCP  File   Mmap  Bcopy  Bcopy  Mem   Mem
                             UNIX      reread reread (libc) (hand) read write
--------- ------------- ---- ---- ---- ------ ------ ------ ------ ---- -----
dave--x86 Linux 2.4.18- 1237 2080 580. 1508.6 1546.5  800.0  795.8 1582 1194.
dave-ppc  Linux 2.4.18_ 91.7 54.2 42.7   80.9  210.3  108.0  108.0 210. 166.6

Memory latencies in nanoseconds - smaller is better
    (WARNING - may not be correct, check graphs)
---------------------------------------------------
Host                 OS   Mhz  L1 $   L2 $    Main mem    Guesses
--------- -------------  ---- ----- ------    --------    -------
dave--x86 Linux 2.4.18-  2387 0.838 7.6960  143.3
dave-ppc  Linux 2.4.18_   450 4.447  121.1  125.5    No L2 cache?


Interrupt Latency Numbers (done from console, if done from telnet, I dont get the ones in 2k+)

root@dave-ppc:~# cat /proc/latencytimes
cpu 0 worst 20 latency times of 261 measured in this period.
  usec      cause     mask   start line/file      address   end line/file
  2862       uart        0   832/sched.c         c000ff24    71/tty_io.c
  2861       uart        1   832/sched.c         c000ff24   664/sched.c
  2838  spin_lock        0    60/tty_io.c        c00a9b90   664/sched.c
    87  spin_lock        0   392/memory.c        c0028c34   413/memory.c
    86  spin_lock        0    60/dir.c           c007d7c4   664/sched.c
    85  spin_lock        0    60/namei.c         c00539d0   664/sched.c
    56  spin_lock        0   163/memory.c        c0028830   169/memory.c
    55  spin_lock        0   205/fork.c          c0013d90   210/fork.c
    51  spin_lock        0  1477/memory.c        c002aad4   210/fork.c
    42  spin_lock        0    60/exit.c          c0019b9c   664/sched.c
    40    unknown        4    78/softirq.c       c001bc20   123/softirq.c
    28    unknown        0   832/sched.c         c000ff24    71/dir.c
    24    unknown        0   832/sched.c         c000ff24    71/namei.c
    20  spin_lock        0  1017/memory.c        c0029b80  1027/memory.c
    19  spin_lock        0  1245/memory.c        c002a57c  1262/memory.c
    19  spin_lock        1   582/irq.c           c00058cc   123/softirq.c
    18  spin_lock        0  1313/memory.c        c002a7d8  1342/memory.c
    17  spin_lock        0    86/mprotect.c      c0032ebc    92/mprotect.c
    16  spin_lock        0    60/namei.c         c00539d0    71/namei.c

--0-125327544-1075123322=:76524--

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
