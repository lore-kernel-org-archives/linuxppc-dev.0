Return-Path: <hs@denx.de>
Received: from b.relay.invitel.net (b.relay.invitel.net [62.77.203.4])
	by ozlabs.org (Postfix) with ESMTP id 8F782B7CCD
	for <linuxppc-dev@ozlabs.org>; Mon,  8 Mar 2010 18:46:38 +1100 (EST)
Received: from mailgw3.invitel.net (mailgw3.invitel.net [91.82.208.36])
	by b.relay.invitel.net (Invitel Core SMTP Transmitter) with ESMTP id
	84D6F31A48B
	for <linuxppc-dev@ozlabs.org>; Mon,  8 Mar 2010 08:46:34 +0100 (CET)
Date: Mon, 08 Mar 2010 08:46:29 +0100
From: Heiko Schocher <hs@denx.de>
Subject: Re: [PATCH 0/4] 8xx: Optimize TLB Miss code.
In-reply-to: <OF342998FA.F0D2DAE1-ONC12576DD.003A3D7E-C12576DD.003AA365@transmode.se>
To: Joakim Tjernlund <joakim.tjernlund@transmode.se>
Message-id: <4B94AB55.3020308@denx.de>
MIME-version: 1.0
Content-type: text/plain; charset=ISO-8859-15
References: <4B8E17A7.10509@denx.de>
	<OF5AEF2DED.4E6AA5A2-ONC12576DB.002FD2D9-C12576DB.00305B81@transmode.se>
	<4B8E3582.8060003@denx.de>
	<OF1C3DEF4A.B7A4D572-ONC12576DB.003876E8-C12576DB.003A7EEF@transmode.se>
	<4B8F8BB4.6070201@denx.de> <20100304121656.6758A28BBC@gemini.denx.de>
	<OF22F52BE0.FB3F104E-ONC12576DC.00469DB5-C12576DC.004808C4@transmode.se>
	<4B8FE00F.4030405@denx.de>
	<OF342998FA.F0D2DAE1-ONC12576DD.003A3D7E-C12576DD.003AA365@transmode.se>
Cc: Scott Wood <scottwood@freescale.com>, linuxppc-dev@ozlabs.org,
	Wolfgang Denk <wd@denx.de>
Reply-To: hs@denx.de
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Hello Joakim,

Joakim Tjernlund wrote:
[...]
> What would be interesting is to skip patch 3 and turn off
> MODULES add PIN_TLB and compare that against your unpatched .33 but
> with MODULES off and PIN_TLB on

run     version

1-4	Linux2.6.33-rc without module support and PIN_TLB=on
5-8	Linux2.6.33-rc without module support and PIN_TLB=on + patches 1,2,4

                 L M B E N C H  3 . 0   S U M M A R Y
                 ------------------------------------
		 (Alpha software, do not distribute)

Basic system parameters
------------------------------------------------------------------------------
Host                 OS Description              Mhz  tlb  cache  mem   scal
                                                     pages line   par   load
                                                           bytes
--------- ------------- ----------------------- ---- ----- ----- ------ ----
tqm8xx    Linux 2.6.33-       powerpc-linux-gnu   66    28    16 1.0100    1
tqm8xx    Linux 2.6.33-       powerpc-linux-gnu   66    28    16 1.0400    1
tqm8xx    Linux 2.6.33-       powerpc-linux-gnu   66    28    16 1.0300    1
tqm8xx    Linux 2.6.33-       powerpc-linux-gnu   66    28    16 1.0100    1
tqm8xx    Linux 2.6.33-       powerpc-linux-gnu   66    28    16 1.0400    1
tqm8xx    Linux 2.6.33-       powerpc-linux-gnu   66    28    16 1.0400    1
tqm8xx    Linux 2.6.33-       powerpc-linux-gnu   66     7    16 1.0400    1
tqm8xx    Linux 2.6.33-       powerpc-linux-gnu   66    28    16 1.0100    1

Processor, Processes - times in microseconds - smaller is better
------------------------------------------------------------------------------
Host                 OS  Mhz null null      open slct sig  sig  fork exec sh
                             call  I/O stat clos TCP  inst hndl proc proc proc
--------- ------------- ---- ---- ---- ---- ---- ---- ---- ---- ---- ---- ----
tqm8xx    Linux 2.6.33-   66 2.97 8.91 127. 1238 270. 22.3 92.1 6386 27.K 83.K
tqm8xx    Linux 2.6.33-   66 3.05 8.99 129. 1208 261. 22.3 85.3 6418 27.K 83.K
tqm8xx    Linux 2.6.33-   66 3.05 8.81 128. 1205 270. 22.3 87.3 6342 27.K 82.K
tqm8xx    Linux 2.6.33-   66 3.05 8.82 132. 1215 270. 23.1 86.7 6357 27.K 82.K
tqm8xx    Linux 2.6.33-   66 3.28 9.29 128. 1257 260. 23.9 83.7 6511 28.K 84.K
tqm8xx    Linux 2.6.33-   66 3.34 9.35 126. 1264 271. 23.1 86.6 6437 27.K 84.K
tqm8xx    Linux 2.6.33-   66 3.19 8.97 130. 1212 271. 23.1 95.3 6480 27.K 84.K
tqm8xx    Linux 2.6.33-   66 3.28 8.76 127. 1229 269. 22.9 90.9 6293 27.K 82.K

Basic integer operations - times in nanoseconds - smaller is better
-------------------------------------------------------------------
Host                 OS  intgr intgr  intgr  intgr  intgr
                          bit   add    mul    div    mod
--------- ------------- ------ ------ ------ ------ ------
tqm8xx    Linux 2.6.33-   15.2   17.9 1.2500  124.1  202.4
tqm8xx    Linux 2.6.33-   15.6   18.0 1.1900  124.1  196.4
tqm8xx    Linux 2.6.33-   15.2   17.9 1.2400  124.9  202.5
tqm8xx    Linux 2.6.33-   15.2   17.9 1.2400  124.2  196.8
tqm8xx    Linux 2.6.33-   15.7   17.9 1.5500  124.2  203.6
tqm8xx    Linux 2.6.33-   15.7   17.9 1.5500  124.2  202.1
tqm8xx    Linux 2.6.33-   15.7   17.9 1.5700  125.0  202.2
tqm8xx    Linux 2.6.33-   15.7   17.9 1.5500  121.1  196.4

Basic uint64 operations - times in nanoseconds - smaller is better
------------------------------------------------------------------
Host                 OS int64  int64  int64  int64  int64
                         bit    add    mul    div    mod
--------- ------------- ------ ------ ------ ------ ------
tqm8xx    Linux 2.6.33-    15.          12.9 1944.1 1895.2
tqm8xx    Linux 2.6.33-    15.          12.9 1886.3 1894.4
tqm8xx    Linux 2.6.33-    15.          12.9 1944.1 1895.2
tqm8xx    Linux 2.6.33-    15.          12.9 1886.3 1894.8
tqm8xx    Linux 2.6.33-    15.          13.2 1944.1 1894.4
tqm8xx    Linux 2.6.33-    15.          13.2 1944.8 1896.3
tqm8xx    Linux 2.6.33-    15.          13.2 1945.2 1837.4
tqm8xx    Linux 2.6.33-    15.          13.2 1957.8 1907.4

Basic float operations - times in nanoseconds - smaller is better
-----------------------------------------------------------------
Host                 OS  float  float  float  float
                         add    mul    div    bogo
--------- ------------- ------ ------ ------ ------
tqm8xx    Linux 2.6.33- 1011.0 1620.2 5467.0 9868.0
tqm8xx    Linux 2.6.33- 1004.5 1630.1 5468.0 9852.0
tqm8xx    Linux 2.6.33- 1012.2 1620.5 5472.0 9855.0
tqm8xx    Linux 2.6.33- 1011.0 1620.2 5469.0 9866.0
tqm8xx    Linux 2.6.33- 1004.8 1617.3 5503.0 9856.0
tqm8xx    Linux 2.6.33- 1004.9 1577.1 5469.0 9859.0
tqm8xx    Linux 2.6.33- 1011.4 1618.5 5470.0 9859.0
tqm8xx    Linux 2.6.33- 1004.9 1620.5 5471.0 9904.0

Basic double operations - times in nanoseconds - smaller is better
------------------------------------------------------------------
Host                 OS  double double double double
                         add    mul    div    bogo
--------- ------------- ------  ------ ------ ------
tqm8xx    Linux 2.6.33- 1555.5 2789.5 3725.7  12.8K
tqm8xx    Linux 2.6.33- 1513.2 2772.0 3720.0  12.7K
tqm8xx    Linux 2.6.33- 1555.8 2772.1 3730.0  12.7K
tqm8xx    Linux 2.6.33- 1555.5 2699.0 3725.0  12.7K
tqm8xx    Linux 2.6.33- 1513.8 2699.5 3610.7  12.7K
tqm8xx    Linux 2.6.33- 1566.7 2771.6 3750.0  12.7K
tqm8xx    Linux 2.6.33- 1556.7 2789.2 3612.1  12.6K
tqm8xx    Linux 2.6.33- 1556.7 2698.5 3749.3  12.6K

Context switching - times in microseconds - smaller is better
-------------------------------------------------------------------------
Host                 OS  2p/0K 2p/16K 2p/64K 8p/16K 8p/64K 16p/16K 16p/64K
                         ctxsw  ctxsw  ctxsw ctxsw  ctxsw   ctxsw   ctxsw
--------- ------------- ------ ------ ------ ------ ------ ------- -------
tqm8xx    Linux 2.6.33-   64.4   74.9  130.2  111.1  180.4   123.2   211.1
tqm8xx    Linux 2.6.33-   67.4   81.0  125.0  117.0  183.7   127.7   208.4
tqm8xx    Linux 2.6.33-   67.5   80.5   92.7  115.3  156.9   128.0   183.8
tqm8xx    Linux 2.6.33-   67.0   80.2   90.5  114.6  159.4   126.8   185.8
tqm8xx    Linux 2.6.33-   82.0   87.8   88.0  116.1  149.3   125.5   182.2
tqm8xx    Linux 2.6.33-   81.7   98.5   97.6  123.8  158.1   135.3   188.0
tqm8xx    Linux 2.6.33-   67.9   87.7   90.7  114.9  151.1   127.3   177.9
tqm8xx    Linux 2.6.33-   67.5   80.3   84.6  113.6  145.7   124.8   170.9

*Local* Communication latencies in microseconds - smaller is better
---------------------------------------------------------------------
Host                 OS 2p/0K  Pipe AF     UDP  RPC/   TCP  RPC/ TCP
                        ctxsw       UNIX         UDP         TCP conn
--------- ------------- ----- ----- ---- ----- ----- ----- ----- ----
tqm8xx    Linux 2.6.33-  64.4 254.3 455. 648.0       941.8       2505
tqm8xx    Linux 2.6.33-  67.4 261.2 456. 645.8       909.1       2439
tqm8xx    Linux 2.6.33-  67.5 264.8 459. 638.5       932.0       2447
tqm8xx    Linux 2.6.33-  67.0 262.4 454. 643.9       909.9       2442
tqm8xx    Linux 2.6.33-  82.0 302.1 500. 651.4       937.2       2504
tqm8xx    Linux 2.6.33-  81.7 300.2 510. 643.2       909.7       2490
tqm8xx    Linux 2.6.33-  67.9 266.7 498. 645.5       923.4       2442
tqm8xx    Linux 2.6.33-  67.5 260.8 444. 640.3       917.7       2440

*Remote* Communication latencies in microseconds - smaller is better
---------------------------------------------------------------------
Host                 OS   UDP  RPC/  TCP   RPC/ TCP
                               UDP         TCP  conn
--------- ------------- ----- ----- ----- ----- ----
tqm8xx    Linux 2.6.33-
tqm8xx    Linux 2.6.33-
tqm8xx    Linux 2.6.33-
tqm8xx    Linux 2.6.33-
tqm8xx    Linux 2.6.33-
tqm8xx    Linux 2.6.33-
tqm8xx    Linux 2.6.33-
tqm8xx    Linux 2.6.33-

File & VM system latencies in microseconds - smaller is better
-------------------------------------------------------------------------------
Host                 OS   0K File      10K File     Mmap    Prot   Page   100fd
                        Create Delete Create Delete Latency Fault  Fault  selct
--------- ------------- ------ ------ ------ ------ ------- ----- ------- -----
tqm8xx    Linux 2.6.33- 6097.6 3731.3  30.3K 4000.0  4026.0  20.5    31.9 131.9
tqm8xx    Linux 2.6.33- 5747.1 3623.2  32.3K 3952.6  4030.0  16.6    31.0 132.7
tqm8xx    Linux 2.6.33- 5405.4 3610.1  32.3K 3921.6  4004.0  15.5    30.0 131.9
tqm8xx    Linux 2.6.33- 5681.8 3891.1  35.7K 4219.4  3966.0 6.038    30.4 128.7
tqm8xx    Linux 2.6.33-  12.7K 3649.6  34.5K 7092.2  4066.0 3.604    31.4 133.6
tqm8xx    Linux 2.6.33- 5405.4 4032.3  38.5K 5494.5  4036.0  18.1    31.0 128.6
tqm8xx    Linux 2.6.33- 5405.4 3610.1  37.0K 7142.9  4078.0  15.4    31.0 133.2
tqm8xx    Linux 2.6.33- 5714.3 3623.2  30.3K 7194.2  4054.0  12.7    29.9 133.0

*Local* Communication bandwidths in MB/s - bigger is better
-----------------------------------------------------------------------------
Host                OS  Pipe AF    TCP  File   Mmap  Bcopy  Bcopy  Mem   Mem
                             UNIX      reread reread (libc) (hand) read write
--------- ------------- ---- ---- ---- ------ ------ ------ ------ ---- -----
tqm8xx    Linux 2.6.33- 14.9 16.1 13.0   21.4   55.6   32.4   34.5 55.7  53.0
tqm8xx    Linux 2.6.33- 14.9 16.2 12.9   21.3   55.5   32.4   34.5 55.7  53.0
tqm8xx    Linux 2.6.33- 14.8 16.0 13.0   21.4   55.6   32.4   34.5 55.7  53.0
tqm8xx    Linux 2.6.33- 15.0 16.2 13.8   21.3   55.6   32.4   34.5 55.7  53.0
tqm8xx    Linux 2.6.33- 14.9 16.0 13.4   21.3   55.7   32.5   34.6 55.8  53.2
tqm8xx    Linux 2.6.33- 15.1 16.2 13.6   21.3   55.7   32.5   34.6 55.8  53.2
tqm8xx    Linux 2.6.33- 15.0 16.2 12.9   21.3   55.7   32.5   34.6 55.8  53.2
tqm8xx    Linux 2.6.33- 15.1 16.2 13.1   21.5   55.7   32.5   34.7 55.8  53.2

Memory latencies in nanoseconds - smaller is better
    (WARNING - may not be correct, check graphs)
------------------------------------------------------------------------------
Host                 OS   Mhz   L1 $   L2 $    Main mem    Rand mem    Guesses
--------- -------------   ---   ----   ----    --------    --------    -------
tqm8xx    Linux 2.6.33-    66   31.7  183.2       184.0      1163.0    No L2 cache?
tqm8xx    Linux 2.6.33-    66   31.7  183.2       184.0      1164.8    No L2 cache?
tqm8xx    Linux 2.6.33-    66   31.7  183.2       184.0      1163.2    No L2 cache?
tqm8xx    Linux 2.6.33-    66   31.7  183.2       183.8      1163.7    No L2 cache?
tqm8xx    Linux 2.6.33-    66   31.8  172.4       173.2      1147.3    No L2 cache?
tqm8xx    Linux 2.6.33-    66   31.8  172.5       173.2      1148.3    No L2 cache?
tqm8xx    Linux 2.6.33-    66   31.8  172.5       173.1      1146.9    No L2 cache?
tqm8xx    Linux 2.6.33-    66   31.8  172.5       173.2      1147.3    No L2 cache?

make[1]: Leaving directory `/home/hs/lmbench-3.0-a9/results'
-- 
DENX Software Engineering GmbH,     MD: Wolfgang Denk & Detlev Zundel
HRB 165235 Munich, Office: Kirchenstr.5, D-82194 Groebenzell, Germany
