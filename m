Date: Thu, 6 Jun 2002 14:29:39 +1000
From: David Gibson <david@gibson.dropbear.id.au>
To: linuxppc-embedded@lists.linuxppc.org
Subject: Re: LMbench results for large page patch
Message-ID: <20020606042939.GU2630@zax>
References: <20020605070832.GF2630@zax>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20020605070832.GF2630@zax>
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Ok, here are some more results, this time with 32M of RAM.

Hardware is the same: Walnut with 200MHz 405GP (PVR 401100c4), 128MB
RAM and IDE disk on a Promise PCI IDE controller.  The kernel is
booted with mem=32M, though, so only 32M of memory is in use.

Overall summary:
	As expected with only 32M of RAM (which is all pinned in the
2pintlb case), the gap between largepte and 2pintlb mostly
disappears.  There are a couple of things largepte still does better
on, main memory latency (expected) and exec proc (unexpected).  The
difference is small though.
	largepte still does as well or better than nopintlb in
essentially every case.

                 L M B E N C H  2 . 0   S U M M A R Y
                 ------------------------------------


Basic system parameters
----------------------------------------------------
Host                 OS Description              Mhz

--------- ------------- ----------------------- ----
2pintlb-3 Linux 2.4.19-       powerpc-linux-gnu  199
2pintlb-3 Linux 2.4.19-       powerpc-linux-gnu  199
2pintlb-3 Linux 2.4.19-       powerpc-linux-gnu  199
largepte- Linux 2.4.19-       powerpc-linux-gnu  199
largepte- Linux 2.4.19-       powerpc-linux-gnu  199
largepte- Linux 2.4.19-       powerpc-linux-gnu  199
nopintlb- Linux 2.4.19-       powerpc-linux-gnu  199
nopintlb- Linux 2.4.19-       powerpc-linux-gnu  199
nopintlb- Linux 2.4.19-       powerpc-linux-gnu  199

Processor, Processes - times in microseconds - smaller is better
----------------------------------------------------------------
Host                 OS  Mhz null null      open selct sig  sig  fork exec sh
                             call  I/O stat clos TCP   inst hndl proc proc proc
--------- ------------- ---- ---- ---- ---- ---- ----- ---- ---- ---- ---- ----
2pintlb-3 Linux 2.4.19-  199 1.40 2.48 15.7 23.7 138.2 5.54 19.9 1713 8063 30.K
2pintlb-3 Linux 2.4.19-  199 1.41 2.47 15.8 23.6 138.6 5.57 20.1 1699 8070 30.K
2pintlb-3 Linux 2.4.19-  199 1.41 2.48 15.8 23.6 138.3 5.57 20.0 1706 8091 30.K
largepte- Linux 2.4.19-  199 1.41 2.47 15.8 23.9 137.9 5.58 19.5 1684 7985 30.K
largepte- Linux 2.4.19-  199 1.41 2.47 17.3 23.7 137.8 5.58 19.5 1690 7990 30.K
largepte- Linux 2.4.19-  199 1.41 2.47 16.2 24.0 137.7 5.55 19.4 1687 7992 29.K
nopintlb- Linux 2.4.19-  199 1.46 2.85 17.7 26.2 156.8 6.03 19.4 2060 9060 34.K
nopintlb- Linux 2.4.19-  199 1.46 2.72 17.7 25.6 188.2 6.03 19.2 2075 9109 34.K
nopintlb- Linux 2.4.19-  199 1.46 2.72 17.0 25.3 157.3 6.11 20.2 2094 9120 34.K

Context switching - times in microseconds - smaller is better
-------------------------------------------------------------
Host                 OS 2p/0K 2p/16K 2p/64K 8p/16K 8p/64K 16p/16K 16p/64K
                        ctxsw  ctxsw  ctxsw ctxsw  ctxsw   ctxsw   ctxsw
--------- ------------- ----- ------ ------ ------ ------ ------- -------
2pintlb-3 Linux 2.4.19- 3.060   80.3  253.1   87.5  264.7    87.8   266.2
2pintlb-3 Linux 2.4.19- 3.210   80.1  252.8   88.6  266.9    88.2   267.9
2pintlb-3 Linux 2.4.19- 4.210   77.2  251.0   88.0  265.7    88.2   265.7
largepte- Linux 2.4.19- 3.760   78.2  250.2   86.0  265.3    86.5   263.9
largepte- Linux 2.4.19- 2.610   75.8  251.7   86.5  264.6    87.4   265.0
largepte- Linux 2.4.19- 2.320   76.2  250.9   86.1  264.3    86.7   263.7
nopintlb- Linux 2.4.19- 3.130   79.3  278.1   95.8  276.7    96.3   277.1
nopintlb- Linux 2.4.19- 4.000   96.1  277.1   96.5  275.2    97.2   277.3
nopintlb- Linux 2.4.19- 3.530   77.8  276.3   94.9  278.7    95.7   277.1

*Local* Communication latencies in microseconds - smaller is better
-------------------------------------------------------------------
Host                 OS 2p/0K  Pipe AF     UDP  RPC/   TCP  RPC/ TCP
                        ctxsw       UNIX         UDP         TCP conn
--------- ------------- ----- ----- ---- ----- ----- ----- ----- ----
2pintlb-3 Linux 2.4.19- 3.060  33.7 55.5             251.4       917.
2pintlb-3 Linux 2.4.19- 3.210  32.6 63.6             278.7       904.
2pintlb-3 Linux 2.4.19- 4.210  34.0 65.8             278.4       906.
largepte- Linux 2.4.19- 3.760  30.0 63.4             277.8       910.
largepte- Linux 2.4.19- 2.610  29.7 62.1             280.2       910.
largepte- Linux 2.4.19- 2.320  26.0 64.4             270.2       914.
nopintlb- Linux 2.4.19- 3.130  35.8 67.7             322.7       1172
nopintlb- Linux 2.4.19- 4.000  36.4 70.8             327.5       1156
nopintlb- Linux 2.4.19- 3.530  29.5 68.5             369.8       1188

File & VM system latencies in microseconds - smaller is better
--------------------------------------------------------------
Host                 OS   0K File      10K File      Mmap    Prot    Page
                        Create Delete Create Delete  Latency Fault   Fault
--------- ------------- ------ ------ ------ ------  ------- -----   -----
2pintlb-3 Linux 2.4.19-  580.0  160.8 1261.0  306.1    412.0 1.499    20.0
2pintlb-3 Linux 2.4.19-  582.4  160.9 1270.6  319.3    414.0 2.012    19.0
2pintlb-3 Linux 2.4.19-  581.1  159.5 1267.4  328.3    408.0 2.006    20.0
largepte- Linux 2.4.19-  581.4  159.7 1248.4  302.3    410.0 2.277    20.0
largepte- Linux 2.4.19-  581.7  163.1 1240.7  309.7    408.0 2.546    20.0
largepte- Linux 2.4.19-  581.1  158.4 1242.2  303.1    410.0 2.638    20.0
nopintlb- Linux 2.4.19-  649.8  215.9 1468.4  403.1    515.0 2.341    24.0
nopintlb- Linux 2.4.19-  651.9  218.2 1492.5  413.2    519.0 2.393    25.0
nopintlb- Linux 2.4.19-  653.6  219.5 1515.2  423.7    530.0 2.016    24.0

*Local* Communication bandwidths in MB/s - bigger is better
-----------------------------------------------------------
Host                OS  Pipe AF    TCP  File   Mmap  Bcopy  Bcopy  Mem   Mem
                             UNIX      reread reread (libc) (hand) read write
--------- ------------- ---- ---- ---- ------ ------ ------ ------ ---- -----
2pintlb-3 Linux 2.4.19- 42.8 43.6 65.5   48.3  115.6   86.0   83.8 115. 132.3
2pintlb-3 Linux 2.4.19- 42.2 42.0 65.6   48.3  115.7   87.2   83.8 115. 135.7
2pintlb-3 Linux 2.4.19- 43.0 43.0 65.9   48.4  115.6   87.2   83.7 115. 139.2
largepte- Linux 2.4.19- 42.0 43.9 32.9   48.5  115.7   86.0   84.0 115. 131.2
largepte- Linux 2.4.19- 41.7 38.6 33.1   48.5  115.7   86.9   83.9 115. 136.6
largepte- Linux 2.4.19- 42.6 42.8 65.9   48.4  115.7   87.2   83.6 115. 138.9
nopintlb- Linux 2.4.19- 39.7 39.3 28.7   47.1  115.5   85.6   83.7 115. 130.6
nopintlb- Linux 2.4.19- 40.9 39.3 59.9   46.7  115.5   86.6   83.7 115. 135.4
nopintlb- Linux 2.4.19- 41.5 39.3 29.4   47.0  115.5   87.3   83.6 115. 138.9

Memory latencies in nanoseconds - smaller is better
    (WARNING - may not be correct, check graphs)
---------------------------------------------------
Host                 OS   Mhz  L1 $   L2 $    Main mem    Guesses
--------- -------------  ---- ----- ------    --------    -------
2pintlb-3 Linux 2.4.19-   199  15.0  134.0  147.7    No L2 cache?
2pintlb-3 Linux 2.4.19-   199  15.0  134.0  147.8    No L2 cache?
2pintlb-3 Linux 2.4.19-   199  15.0  133.9  147.7    No L2 cache?
largepte- Linux 2.4.19-   199  15.0  134.0  147.3    No L2 cache?
largepte- Linux 2.4.19-   199  15.0  133.9  147.3    No L2 cache?
largepte- Linux 2.4.19-   199  15.0  134.0  147.2    No L2 cache?
nopintlb- Linux 2.4.19-   199  15.0  134.1  147.8    No L2 cache?
nopintlb- Linux 2.4.19-   199  15.0  134.0  147.7    No L2 cache?
nopintlb- Linux 2.4.19-   199  15.0  134.1  147.7    No L2 cache?

--
David Gibson			| For every complex problem there is a
david@gibson.dropbear.id.au	| solution which is simple, neat and
				| wrong.  -- H.L. Mencken
http://www.ozlabs.org/people/dgibson

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
