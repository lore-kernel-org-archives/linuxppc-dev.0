Date: Thu, 13 Dec 2001 11:58:05 -0300
From: Ricardo Scop <scop@vanet.com.br>
Reply-To: scop@vanet.com.br
Message-ID: <8498.011213@vanet.com.br>
To: linuxppc-embedded@lists.linuxppc.org
Subject: Linux performance on a 8255 custom board
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Hi all,

We've run LmBench in our MPC8255 custom board running a recent
linuxppc_2_4 revision (2.4.16). CPU frequency is 132 MHz, bus @ 33 MHz
and we don't have L2 cache.

The results are presented bellow, for comparison. We are particularly
interesting in knowing how our memory latencies and related figures
(context switching, for example) are compared to other board's.

Thanks in advance,

Ricardo Scop                          mailto:scop@vanet.com.br
R SCOP Consult.

-------------------------------------------------------------
"Don't hate, it's too big a burden to bear."
~Martin Luther King Jr.
-------------------------------------------------------------

                 L M B E N C H  2 . 0   S U M M A R Y
                 ------------------------------------


Basic system parameters
----------------------------------------------------
Host                 OS Description              Mhz

--------- ------------- ----------------------- ----
nr2g       Linux 2.4.16                     ppc  132

Processor, Processes - times in microseconds - smaller is better
----------------------------------------------------------------
Host                 OS  Mhz null null      open selct sig  sig  fork exec sh
                             call  I/O stat clos TCP   inst hndl proc proc proc
--------- ------------- ---- ---- ---- ---- ---- ----- ---- ---- ---- ---- ----
nr2g       Linux 2.4.16  132 1.70 3.51 16.5 23.7 212.8 6.94 23.8 3888 28.K 65.K

Context switching - times in microseconds - smaller is better
-------------------------------------------------------------
Host                 OS 2p/0K 2p/16K 2p/64K 8p/16K 8p/64K 16p/16K 16p/64K
                        ctxsw  ctxsw  ctxsw ctxsw  ctxsw   ctxsw   ctxsw
--------- ------------- ----- ------ ------ ------ ------ ------- -------
nr2g       Linux 2.4.16 1.310  259.1  893.1  272.0  902.5   275.9   907.7

*Local* Communication latencies in microseconds - smaller is better
-------------------------------------------------------------------
Host                 OS 2p/0K  Pipe AF     UDP  RPC/   TCP  RPC/ TCP
                        ctxsw       UNIX         UDP         TCP conn
--------- ------------- ----- ----- ---- ----- ----- ----- ----- ----
nr2g       Linux 2.4.16 1.310  45.0 89.3 600.5       873.6       2706

File & VM system latencies in microseconds - smaller is better
--------------------------------------------------------------
Host                 OS   0K File      10K File      Mmap    Prot    Page
                        Create Delete Create Delete  Latency Fault   Fault
--------- ------------- ------ ------ ------ ------  ------- -----   -----
nr2g       Linux 2.4.16 3484.3 2325.6  18.2K 3571.4          1.334  1211.0

*Local* Communication bandwidths in MB/s - bigger is better
-----------------------------------------------------------
Host                OS  Pipe AF    TCP  File   Mmap  Bcopy  Bcopy  Mem   Mem
                             UNIX      reread reread (libc) (hand) read write
--------- ------------- ---- ---- ---- ------ ------ ------ ------ ---- -----
nr2g       Linux 2.4.16 28.2 16.1 8.72   24.7   65.2   33.4   33.4 65.2  57.7

Memory latencies in nanoseconds - smaller is better
    (WARNING - may not be correct, check graphs)
---------------------------------------------------
Host                 OS   Mhz  L1 $   L2 $    Main mem    Guesses
--------- -------------  ---- ----- ------    --------    -------
nr2g       Linux 2.4.16   132  15.2  397.1  409.8    No L2 cache?


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
