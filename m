Date: Wed, 29 May 2002 13:08:38 +1000
From: David Gibson <david@gibson.dropbear.id.au>
To: linuxppc-embedded@lists.linuxppc.org
Cc: Paul Mackerras <paulus@samba.org>
Subject: LMBench and CONFIG_PIN_TLB
Message-ID: <20020529030838.GZ16537@zax>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


I did some LMBench runs to observe the effect of CONFIG_PIN_TLB.  I've
run the tests in three cases:
	a) linuxppc_2_4_devel with the CONFIG_PIN_TLB option disabled
("nopintlb")
	b) linuxppc_2_4_devel with the CONFIG_PIN_TLB option enabled
("2pintlb")
	c) linuxppc_2_4_devel with the CONFIG_PIN_TLB option enabled,
but modified so that only 1 16MB page is pinned rather than 2
(i.e. only the fist 16MB rather than the first 32MB are mapped with
pinned entries) ("1pintlb")

These tests were done on an IBM Walnut board with 200MHz 405GP.  Root
filesystem was ext3 on an IDE disk attached to a Promise PCI IDE
controller.

Overall summary:
	Having pinned entries (1 or 2) performs as well or better than
not having them on virtually everything, the difference varies between
nothing (lost in the noise) to around 15% (fork proc).  The only
measurement where no pinned entries might be argued to win is
LMbench's main memory latency measurement.  The difference is < 0.1%
and may just be chance fluctation.
	The difference between 1 and 2 pinned entries is very small.
There are a few cases where 1 might be better (but it might just be
random noise) and a very few where 2 might be better than one.  On the
basis of that there seems little point in pinning 2 entries.

Using pinned TLB entries also means its easier to make sure the
exception exit path is safe, especially in 2.5 (we mustn't take a TLB
miss after SRR0 or SRR1 is loaded).

It's certainly possible to construct a workload that will work poorly
with pinned TLB entries compared to without (make it have an
instruction+data working set of precisely 64 pages), but similarly
it's possible to construct a workload that will work well with 65
available TLB entries and not 64.  Unless someone can come up with a
real life workload which works poorly with pinned TLBs, I see little
point in keeping the option - pinned TLBs should always be on (pinning
1 entry).

                 L M B E N C H  2 . 0   S U M M A R Y
                 ------------------------------------


Basic system parameters
----------------------------------------------------
Host                 OS Description              Mhz

--------- ------------- ----------------------- ----
1pintlb   Linux 2.4.19-       powerpc-linux-gnu  199
1pintlb   Linux 2.4.19-       powerpc-linux-gnu  199
1pintlb   Linux 2.4.19-       powerpc-linux-gnu  199
2pintlb   Linux 2.4.19-       powerpc-linux-gnu  199
2pintlb   Linux 2.4.19-       powerpc-linux-gnu  199
2pintlb   Linux 2.4.19-       powerpc-linux-gnu  199
nopintlb  Linux 2.4.19-       powerpc-linux-gnu  199
nopintlb  Linux 2.4.19-       powerpc-linux-gnu  199
nopintlb  Linux 2.4.19-       powerpc-linux-gnu  199

Processor, Processes - times in microseconds - smaller is better
----------------------------------------------------------------
Host                 OS  Mhz null null      open selct sig  sig  fork exec sh
                             call  I/O stat clos TCP   inst hndl proc proc proc
--------- ------------- ---- ---- ---- ---- ---- ----- ---- ---- ---- ---- ----
1pintlb   Linux 2.4.19-  199 1.44 3.21 16.0 24.1 152.2 5.60 16.5 1784 8231 30.K
1pintlb   Linux 2.4.19-  199 1.44 3.20 16.1 24.3 152.4 5.60 16.5 1768 8186 30.K
1pintlb   Linux 2.4.19-  199 1.44 3.20 16.1 24.8 152.4 5.60 16.5 1762 8199 30.K
2pintlb   Linux 2.4.19-  199 1.44 3.20 16.8 25.0 152.4 5.60 16.4 1773 8191 30.K
2pintlb   Linux 2.4.19-  199 1.44 3.21 17.0 25.2 151.9 5.58 17.1 1765 8241 30.K
2pintlb   Linux 2.4.19-  199 1.44 3.21 16.8 24.6 153.9 5.60 16.9 1731 8102 30.K
nopintlb  Linux 2.4.19-  199 1.46 3.34 17.2 24.6 156.1 5.66 16.5 2014 9012 33.K
nopintlb  Linux 2.4.19-  199 1.46 3.35 17.0 25.2 157.9 5.66 16.5 2070 9091 33.K
nopintlb  Linux 2.4.19-  199 1.46 3.35 17.2 25.1 154.7 5.65 16.5 2059 9044 33.K

Context switching - times in microseconds - smaller is better
-------------------------------------------------------------
Host                 OS 2p/0K 2p/16K 2p/64K 8p/16K 8p/64K 16p/16K 16p/64K
                        ctxsw  ctxsw  ctxsw ctxsw  ctxsw   ctxsw   ctxsw
--------- ------------- ----- ------ ------ ------ ------ ------- -------
1pintlb   Linux 2.4.19- 5.260   81.1  269.1   96.1  275.8    95.8   276.7
1pintlb   Linux 2.4.19- 3.460   81.7  272.0   95.9  276.5    96.1   276.4
1pintlb   Linux 2.4.19- 2.820   82.0  268.4   95.1  275.2    96.2   274.9
2pintlb   Linux 2.4.19- 3.930   80.6  280.7   95.3  276.8    95.5   275.1
2pintlb   Linux 2.4.19- 6.350   84.0  265.2   95.0  273.7    96.0   273.7
2pintlb   Linux 2.4.19- 2.780   82.5  257.8   93.5  272.8    95.6   273.4
nopintlb  Linux 2.4.19- 3.590   93.4  282.2  101.5  284.4   101.7   284.1
nopintlb  Linux 2.4.19- 0.780   83.1  284.3  100.0  283.1    99.7   282.7
nopintlb  Linux 2.4.19- 1.540   93.3  282.4   99.2  281.1    99.1   282.9

*Local* Communication latencies in microseconds - smaller is better
-------------------------------------------------------------------
Host                 OS 2p/0K  Pipe AF     UDP  RPC/   TCP  RPC/ TCP
                        ctxsw       UNIX         UDP         TCP conn
--------- ------------- ----- ----- ---- ----- ----- ----- ----- ----
1pintlb   Linux 2.4.19- 5.260  28.2 72.0             248.3       909.
1pintlb   Linux 2.4.19- 3.460  33.0 73.8             268.6       902.
1pintlb   Linux 2.4.19- 2.820  30.0 71.8             279.6       903.
2pintlb   Linux 2.4.19- 3.930  27.9 73.9             258.6       923.
2pintlb   Linux 2.4.19- 6.350  23.9 81.0             244.6       918.
2pintlb   Linux 2.4.19- 2.780  27.9 77.5             287.9       910.
nopintlb  Linux 2.4.19- 3.590  29.7 75.9             386.9       1194
nopintlb  Linux 2.4.19- 0.780  29.0 77.2             388.4       1208
nopintlb  Linux 2.4.19- 1.540  31.8 83.4             391.9       1190

File & VM system latencies in microseconds - smaller is better
--------------------------------------------------------------
Host                 OS   0K File      10K File      Mmap    Prot    Page
                        Create Delete Create Delete  Latency Fault   Fault
--------- ------------- ------ ------ ------ ------  ------- -----   -----
1pintlb   Linux 2.4.19-  579.4  160.5 1231.5  300.6   1448.0 3.358    18.0
1pintlb   Linux 2.4.19-  579.7  160.1 1231.5  315.7   1442.0 3.443    18.0
1pintlb   Linux 2.4.19-  579.7  160.6 1236.1  300.8   1456.0 3.405    18.0
2pintlb   Linux 2.4.19-  579.0  161.1 1231.5  304.7   1454.0 3.495    18.0
2pintlb   Linux 2.4.19-  580.0  159.1 1236.1  317.0   1446.0 2.816    18.0
2pintlb   Linux 2.4.19-  579.0  159.8 1228.5  317.7   1444.0 3.342    18.0
nopintlb  Linux 2.4.19-  643.5  213.9 1426.5  404.0   1810.0 3.540    21.0
nopintlb  Linux 2.4.19-  643.9  213.2 1418.4  394.9   1761.0 3.637    21.0
nopintlb  Linux 2.4.19-  645.6  217.2 1436.8  420.2   1776.0 4.233    21.0

*Local* Communication bandwidths in MB/s - bigger is better
-----------------------------------------------------------
Host                OS  Pipe AF    TCP  File   Mmap  Bcopy  Bcopy  Mem   Mem
                             UNIX      reread reread (libc) (hand) read write
--------- ------------- ---- ---- ---- ------ ------ ------ ------ ---- -----
1pintlb   Linux 2.4.19- 39.9 41.9 31.5   47.2  115.6   85.3   83.6 115. 128.0
1pintlb   Linux 2.4.19- 43.1 41.6 30.8   48.1  115.6   85.7   84.2 115. 128.9
1pintlb   Linux 2.4.19- 42.5 41.1 31.6   48.2  115.6   86.2   84.4 115. 130.6
2pintlb   Linux 2.4.19- 42.6 42.4 32.0   48.4  115.6   85.6   84.1 115. 128.7
2pintlb   Linux 2.4.19- 42.3 42.4 62.7   48.1  115.6   85.5   84.0 115. 129.4
2pintlb   Linux 2.4.19- 44.4 43.7 64.6   48.5  115.6   86.0   84.3 115. 129.4
nopintlb  Linux 2.4.19- 39.0 39.3 29.3   46.9  115.5   85.5   83.9 115. 127.8
nopintlb  Linux 2.4.19- 41.7 39.3 59.9   47.2  115.5   85.2   84.1 115. 130.1
nopintlb  Linux 2.4.19- 41.1 38.2 29.4   47.0  115.5   85.7   84.1 115. 130.5

Memory latencies in nanoseconds - smaller is better
    (WARNING - may not be correct, check graphs)
---------------------------------------------------
Host                 OS   Mhz  L1 $   L2 $    Main mem    Guesses
--------- -------------  ---- ----- ------    --------    -------
1pintlb   Linux 2.4.19-   199  15.0  134.0  149.2    No L2 cache?
1pintlb   Linux 2.4.19-   199  15.0  133.9  149.2    No L2 cache?
1pintlb   Linux 2.4.19-   199  15.0  133.8  149.2    No L2 cache?
2pintlb   Linux 2.4.19-   199  15.0  133.8  149.2    No L2 cache?
2pintlb   Linux 2.4.19-   199  15.0  133.8  149.2    No L2 cache?
2pintlb   Linux 2.4.19-   199  15.0  133.8  149.1    No L2 cache?
nopintlb  Linux 2.4.19-   199  15.0  134.0  149.1    No L2 cache?
nopintlb  Linux 2.4.19-   199  15.0  134.1  149.1    No L2 cache?
nopintlb  Linux 2.4.19-   199  15.0  133.9  149.0    No L2 cache?

--
David Gibson			| For every complex problem there is a
david@gibson.dropbear.id.au	| solution which is simple, neat and
				| wrong.  -- H.L. Mencken
http://www.ozlabs.org/people/dgibson

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
