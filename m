Return-Path: <hs@denx.de>
Received: from b.relay.invitel.net (b.relay.invitel.net [62.77.203.4])
	by ozlabs.org (Postfix) with ESMTP id 8692DB7E1A
	for <linuxppc-dev@ozlabs.org>; Thu,  4 Mar 2010 21:30:16 +1100 (EST)
Received: from mailgw1.invitel.net (mailgw1.invitel.net [91.82.208.34])
	by b.relay.invitel.net (Invitel Core SMTP Transmitter) with ESMTP id
	5D95B31AD1A
	for <linuxppc-dev@ozlabs.org>; Thu,  4 Mar 2010 11:30:14 +0100 (CET)
Date: Thu, 04 Mar 2010 11:30:12 +0100
From: Heiko Schocher <hs@denx.de>
Subject: Re: [PATCH 0/4] 8xx: Optimize TLB Miss code.
In-reply-to: <OF1C3DEF4A.B7A4D572-ONC12576DB.003876E8-C12576DB.003A7EEF@transmode.se>
To: Joakim Tjernlund <joakim.tjernlund@transmode.se>
Message-id: <4B8F8BB4.6070201@denx.de>
MIME-version: 1.0
Content-type: text/plain; charset=ISO-8859-1
References: <4B8E17A7.10509@denx.de>
	<OF5AEF2DED.4E6AA5A2-ONC12576DB.002FD2D9-C12576DB.00305B81@transmode.se>
	<4B8E3582.8060003@denx.de>
	<OF1C3DEF4A.B7A4D572-ONC12576DB.003876E8-C12576DB.003A7EEF@transmode.se>
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
> Could you try reverting patch:
>   8xx: Don't touch ACCESSED when no SWAP.
> and see if that makes a difference?
[...]
> Turning on pinned TLBs(you must turn on ADVANCED_OPTIONS first) could be an improvement,
> regardless of my patches.

here the results:

run	version

1-4	2.6.33-rc6 without your patches
5-8	2.6.33-rc6 with all your patches
9-12	2.6.33-rc6 with patches 1,2 and 4 (without 8xx: Don't touch ACCESSED when no SWAP)
13-16	2.6.33-rc6 with all your patches and CONFIG_PIN_TLB=y

> Turning on pinned TLBs(you must turn on ADVANCED_OPTIONS first) could be an improvement,
> regardless of my patches.

make[1]: Entering directory `/home/hs/lmbench-3.0-a9/results'

                 L M B E N C H  3 . 0   S U M M A R Y
                 ------------------------------------
		 (Alpha software, do not distribute)

Basic system parameters
------------------------------------------------------------------------------
Host                 OS Description              Mhz  tlb  cache  mem   scal
                                                     pages line   par   load
                                                           bytes
--------- ------------- ----------------------- ---- ----- ----- ------ ----
tqm8xx    Linux 2.6.33-       powerpc-linux-gnu   66    32    16 1.0400    1
tqm8xx    Linux 2.6.33-       powerpc-linux-gnu   66     7    16 1.0400    1
tqm8xx    Linux 2.6.33-       powerpc-linux-gnu   66     7    16 1.0400    1
tqm8xx    Linux 2.6.33-       powerpc-linux-gnu   66    32    16 1.0400    1
tqm8xx    Linux 2.6.33-       powerpc-linux-gnu   66    32    16 1.0400    1
tqm8xx    Linux 2.6.33-       powerpc-linux-gnu   66     7    16 1.0400    1
tqm8xx    Linux 2.6.33-       powerpc-linux-gnu   66     7    16 1.0400    1
tqm8xx    Linux 2.6.33-       powerpc-linux-gnu   66    32    16 1.0400    1
tqm8xx    Linux 2.6.33-       powerpc-linux-gnu   66    32    16 1.0400    1
tqm8xx    Linux 2.6.33-       powerpc-linux-gnu   66    32    16 1.0400    1
tqm8xx    Linux 2.6.33-       powerpc-linux-gnu   66    32    16 1.0100    1
tqm8xx    Linux 2.6.33-       powerpc-linux-gnu   66    32    16 1.0100    1
tqm8xx    Linux 2.6.33-       powerpc-linux-gnu   66    28    16 1.1700    1
tqm8xx    Linux 2.6.33-       powerpc-linux-gnu   66     7    16 1.0100    1
tqm8xx    Linux 2.6.33-       powerpc-linux-gnu   66    28    16 1.0400    1
tqm8xx    Linux 2.6.33-       powerpc-linux-gnu   66     7    16 1.0400    1


Processor, Processes - times in microseconds - smaller is better
------------------------------------------------------------------------------
Host                 OS  Mhz null null      open slct sig  sig  fork exec sh
                             call  I/O stat clos TCP  inst hndl proc proc proc
--------- ------------- ---- ---- ---- ---- ---- ---- ---- ---- ---- ---- ----
tqm8xx    Linux 2.6.33-   66 2.97 10.3 129. 1377 272. 21.8 91.3 6949 29.K 89.K
tqm8xx    Linux 2.6.33-   66 3.06 10.5 124. 1375 273. 21.8 91.3 7136 30.K 89.K
tqm8xx    Linux 2.6.33-   66 3.06 10.6 129. 1365 272. 21.2 96.6 6889 29.K 89.K
tqm8xx    Linux 2.6.33-   66 3.06 10.5 124. 1309 272. 21.8 101. 6896 29.K 89.K
tqm8xx    Linux 2.6.33-   66 2.97 8.86 126. 1336 273. 21.7 84.2 6785 29.K 88.K
tqm8xx    Linux 2.6.33-   66 3.06 8.90 130. 1343 263. 21.3 84.7 7080 29.K 88.K
tqm8xx    Linux 2.6.33-   66 3.52 8.97 129. 1339 270. 22.4 84.4 6823 29.K 88.K
tqm8xx    Linux 2.6.33-   66 2.97 8.99 127. 1333 261. 22.4 87.0 7037 29.K 87.K
tqm8xx    Linux 2.6.33-   66 3.06 8.83 128. 1355 269. 20.7 89.2 6927 29.K 87.K
tqm8xx    Linux 2.6.33-   66 3.05 8.84 127. 1344 271. 21.6 90.5 6868 29.K 88.K
tqm8xx    Linux 2.6.33-   66 3.06 8.84 131. 1376 260. 21.4 88.1 7119 29.K 87.K
tqm8xx    Linux 2.6.33-   66 3.05 8.90 122. 1342 272. 21.4 88.6 6847 29.K 88.K
tqm8xx    Linux 2.6.33-   66 3.19 9.10 122. 1205 265. 20.9 90.3 6358 27.K 83.K
tqm8xx    Linux 2.6.33-   66 3.28 9.10 124. 1208 270. 20.9 95.2 6217 27.K 82.K
tqm8xx    Linux 2.6.33-   66 3.19 8.98 125. 1210 270. 21.1 87.9 6364 27.K 83.K
tqm8xx    Linux 2.6.33-   66 3.19 8.86 124. 1237 262. 21.3 90.7 6311 27.K 84.K

Basic integer operations - times in nanoseconds - smaller is better
-------------------------------------------------------------------
Host                 OS  intgr intgr  intgr  intgr  intgr
                          bit   add    mul    div    mod
--------- ------------- ------ ------ ------ ------ ------
tqm8xx    Linux 2.6.33-   15.7   18.0 1.5600  124.2  203.1
tqm8xx    Linux 2.6.33-   15.7   17.4 1.5800  121.1  202.8
tqm8xx    Linux 2.6.33-   15.2   17.9 1.6200  124.2  202.7
tqm8xx    Linux 2.6.33-   15.2   17.9 1.6000  125.0  204.0
tqm8xx    Linux 2.6.33-   15.7   18.1 1.5600  124.7  204.4
tqm8xx    Linux 2.6.33-   15.7   18.1 1.5800  124.2  202.8
tqm8xx    Linux 2.6.33-   15.7   17.9 1.5500  124.2  203.2
tqm8xx    Linux 2.6.33-   15.7   18.1 1.5500  124.5  202.0
tqm8xx    Linux 2.6.33-   15.7   18.1 1.5500  124.5  202.6
tqm8xx    Linux 2.6.33-   15.7   18.1 1.5500  121.0  196.5
tqm8xx    Linux 2.6.33-   15.7   17.9 1.5500  121.0  202.5
tqm8xx    Linux 2.6.33-   15.7   18.1 1.5500  125.1  196.4
tqm8xx    Linux 2.6.33-   15.7   17.9 1.5500  124.2  202.1
tqm8xx    Linux 2.6.33-   15.7   17.9 1.5500  124.2  203.4
tqm8xx    Linux 2.6.33-   15.7   17.9 1.5500  124.2  196.4
tqm8xx    Linux 2.6.33-   15.7   17.9 1.5500  124.2  196.5

Basic uint64 operations - times in nanoseconds - smaller is better
------------------------------------------------------------------
Host                 OS int64  int64  int64  int64  int64
                         bit    add    mul    div    mod
--------- ------------- ------ ------ ------ ------ ------
tqm8xx    Linux 2.6.33-    15.          13.3 1952.2 1838.2
tqm8xx    Linux 2.6.33-    15.          13.2 1951.5 1837.8
tqm8xx    Linux 2.6.33-    15.          13.2 1886.7 1907.8
tqm8xx    Linux 2.6.33-    15.          13.2 1951.5 1838.2
tqm8xx    Linux 2.6.33-    15.          13.3 1887.0 1902.2
tqm8xx    Linux 2.6.33-    15.          13.3 1887.4 1901.5
tqm8xx    Linux 2.6.33-    15.          13.3 1886.7 1893.0
tqm8xx    Linux 2.6.33-    15.          13.3 1950.0 1900.4
tqm8xx    Linux 2.6.33-    15.          13.3 1955.2 1906.7
tqm8xx    Linux 2.6.33-    15.          13.2 1943.7 1900.7
tqm8xx    Linux 2.6.33-    15.          13.3 1958.2 1910.4
tqm8xx    Linux 2.6.33-    15.          13.3 1886.7 1900.7
tqm8xx    Linux 2.6.33-    15.          13.3 1943.7 1837.4
tqm8xx    Linux 2.6.33-    15.          13.2 1944.1 1837.4
tqm8xx    Linux 2.6.33-    15.          13.2 1944.4 1906.1
tqm8xx    Linux 2.6.33-    15.          13.2 1957.8 1894.8

Basic float operations - times in nanoseconds - smaller is better
-----------------------------------------------------------------
Host                 OS  float  float  float  float
                         add    mul    div    bogo
--------- ------------- ------ ------ ------ ------
tqm8xx    Linux 2.6.33- 1008.9 1629.2 5527.0 9895.0
tqm8xx    Linux 2.6.33- 1008.9 1628.9 5495.0 9892.0
tqm8xx    Linux 2.6.33- 1007.8 1622.0 5499.0 9886.0
tqm8xx    Linux 2.6.33- 1016.5 1628.6 5319.0 9940.0
tqm8xx    Linux 2.6.33- 1008.0 1628.3 5497.0 9879.0
tqm8xx    Linux 2.6.33- 1007.6 1577.4 5495.0 9881.0
tqm8xx    Linux 2.6.33- 1014.8 1627.1 5493.0 9889.0
tqm8xx    Linux 2.6.33- 1004.6 1627.7 5487.0 9881.0
tqm8xx    Linux 2.6.33- 1003.8 1627.1 5490.0 9875.0
tqm8xx    Linux 2.6.33-  977.2 1628.0 5318.0 9924.0
tqm8xx    Linux 2.6.33- 1007.4 1627.7 5490.0 9882.0
tqm8xx    Linux 2.6.33- 1004.7 1628.0 5495.0 9891.0
tqm8xx    Linux 2.6.33- 1011.6 1630.1 5484.0 9855.0
tqm8xx    Linux 2.6.33-  977.0 1621.4 5469.0 9856.0
tqm8xx    Linux 2.6.33- 1011.4 1621.4 5471.0 9856.0
tqm8xx    Linux 2.6.33- 1004.9 1577.1 5470.0 9866.0

Basic double operations - times in nanoseconds - smaller is better
------------------------------------------------------------------
Host                 OS  double double double double
                         add    mul    div    bogo
--------- ------------- ------  ------ ------ ------
tqm8xx    Linux 2.6.33- 1562.4 2782.8 3730.7  12.6K
tqm8xx    Linux 2.6.33- 1556.1 2781.5 3724.3  12.6K
tqm8xx    Linux 2.6.33- 1513.9 2801.0 3726.4  12.8K
tqm8xx    Linux 2.6.33- 1556.1 2780.9 3611.4  12.6K
tqm8xx    Linux 2.6.33- 1570.5 2772.6 3742.1  12.6K
tqm8xx    Linux 2.6.33- 1560.1 2703.0 3611.4  12.7K
tqm8xx    Linux 2.6.33- 1560.4 2779.5 3760.7  12.7K
tqm8xx    Linux 2.6.33- 1559.8 2773.0 3742.1  12.6K
tqm8xx    Linux 2.6.33- 1564.7 2699.0 3722.1  12.6K
tqm8xx    Linux 2.6.33- 1560.7 2790.0 3725.7  12.7K
tqm8xx    Linux 2.6.33- 1565.0 2780.0 3749.3  12.7K
tqm8xx    Linux 2.6.33- 1560.4 2700.0 3767.1  12.8K
tqm8xx    Linux 2.6.33- 1555.5 2772.1 3747.9  12.6K
tqm8xx    Linux 2.6.33- 1513.5 2772.5 3725.7  12.6K
tqm8xx    Linux 2.6.33- 1557.0 2772.5 3725.7  12.7K
tqm8xx    Linux 2.6.33- 1514.1 2773.5 3719.3  12.7K

Context switching - times in microseconds - smaller is better
-------------------------------------------------------------------------
Host                 OS  2p/0K 2p/16K 2p/64K 8p/16K 8p/64K 16p/16K 16p/64K
                         ctxsw  ctxsw  ctxsw ctxsw  ctxsw   ctxsw   ctxsw
--------- ------------- ------ ------ ------ ------ ------ ------- -------
tqm8xx    Linux 2.6.33-   92.6  109.6  110.9  137.5  173.8   151.8   199.3
tqm8xx    Linux 2.6.33-   95.8  108.5  104.7  137.1  172.7   150.9   194.7
tqm8xx    Linux 2.6.33-   95.8  118.8   97.5  146.4  162.0   160.8   190.1
tqm8xx    Linux 2.6.33-   92.9  111.9  101.0  138.1  166.6   152.3   192.0
tqm8xx    Linux 2.6.33-   90.8  108.5  116.2  134.3  171.8   147.1   210.0
tqm8xx    Linux 2.6.33-  100.1  111.4  105.0  136.4  173.1   148.3   200.8
tqm8xx    Linux 2.6.33-   98.7  111.3  111.8  135.7  172.5   147.9   200.9
tqm8xx    Linux 2.6.33-   92.0  117.9  109.9  141.6  170.4   154.9   196.4
tqm8xx    Linux 2.6.33-   96.9  112.4   95.4  138.3  165.1   152.2   196.4
tqm8xx    Linux 2.6.33-  100.6  115.8  109.3  138.5  173.3   150.9   199.2
tqm8xx    Linux 2.6.33-  102.2  114.3  109.4  140.9  175.5   153.2   202.0
tqm8xx    Linux 2.6.33-   99.1  114.5  106.5  138.2  174.7   151.7   199.9
tqm8xx    Linux 2.6.33-   69.5   80.5   88.9  119.6  147.3   130.4   178.7
tqm8xx    Linux 2.6.33-   85.8   97.6   79.1  122.3  154.1   132.6   180.1
tqm8xx    Linux 2.6.33-   89.4   93.8  125.7  120.8  178.4   129.5   206.1
tqm8xx    Linux 2.6.33-   88.1  101.8   91.2  121.4  162.8   131.6   191.4

*Local* Communication latencies in microseconds - smaller is better
---------------------------------------------------------------------
Host                 OS 2p/0K  Pipe AF     UDP  RPC/   TCP  RPC/ TCP
                        ctxsw       UNIX         UDP         TCP conn
--------- ------------- ----- ----- ---- ----- ----- ----- ----- ----
tqm8xx    Linux 2.6.33-  92.6 338.4 581. 720.1       1047.       2749
tqm8xx    Linux 2.6.33-  95.8 334.0 595. 725.0       1051.       2754
tqm8xx    Linux 2.6.33-  95.8 330.9 574. 720.1       1047.       2772
tqm8xx    Linux 2.6.33-  92.9 338.8 574. 714.3       1046.       2742
tqm8xx    Linux 2.6.33-  90.8 322.1 576. 734.9       1012.       2706
tqm8xx    Linux 2.6.33- 100.1 326.0 565. 719.5       1027.       2702
tqm8xx    Linux 2.6.33-  98.7 322.8 571. 713.8       1028.       2711
tqm8xx    Linux 2.6.33-  92.0 328.1 549. 714.1       1022.       2696
tqm8xx    Linux 2.6.33-  96.9 327.0 573. 722.3       1036.       2721
tqm8xx    Linux 2.6.33- 100.6 330.4 561. 723.8       1024.       2726
tqm8xx    Linux 2.6.33- 102.2 331.4 590. 728.6       1040.       2753
tqm8xx    Linux 2.6.33-  99.1 330.1 585. 723.5       1023.       2750
tqm8xx    Linux 2.6.33-  69.5 265.9 447. 632.6       909.0       2431
tqm8xx    Linux 2.6.33-  85.8 267.0 492. 650.6       909.4       2455
tqm8xx    Linux 2.6.33-  89.4 295.6 493. 643.0       908.8       2453
tqm8xx    Linux 2.6.33-  88.1 301.0 494. 645.1       907.9       2451

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
tqm8xx    Linux 2.6.33- 5917.2 3968.3  31.2K 4329.0  4147.0  18.8    34.1 135.2
tqm8xx    Linux 2.6.33- 5714.3 3937.0  32.3K 6060.6  4210.0  14.2    34.5 131.4
tqm8xx    Linux 2.6.33- 5747.1 4000.0  31.2K 4329.0  4114.0 7.692    34.0 133.1
tqm8xx    Linux 2.6.33- 5747.1 4081.6  30.3K 4273.5  4100.0  18.2    34.2 135.0
tqm8xx    Linux 2.6.33- 5714.3 3952.6  31.2K 4273.5  4130.0  33.5    35.1 136.1
tqm8xx    Linux 2.6.33- 5714.3 3906.2  31.2K 6060.6  4105.0  25.7    35.5 135.9
tqm8xx    Linux 2.6.33- 5681.8 3921.6  32.3K 4255.3  4144.0  23.5    35.0 134.9
tqm8xx    Linux 2.6.33- 5649.7 3937.0  30.3K 4237.3  4116.0  21.6    35.3 135.3
tqm8xx    Linux 2.6.33- 5747.1 3921.6  32.3K 4329.0  4107.0  17.7    35.6 131.2
tqm8xx    Linux 2.6.33- 5952.4 3937.0  31.2K 4273.5  4119.0  25.4    35.8 136.4
tqm8xx    Linux 2.6.33- 5848.0 3937.0  32.3K 4484.3  4223.0  14.3    35.4 135.1
tqm8xx    Linux 2.6.33- 6172.8 3984.1  35.7K 4291.8  4210.0  14.4    36.0 135.0
tqm8xx    Linux 2.6.33- 5291.0 3610.1  31.2K 4065.0  3836.0 1.389    30.0 135.7
tqm8xx    Linux 2.6.33- 5524.9 3649.6  29.4K 3906.2  3867.0  14.9    29.8 137.7
tqm8xx    Linux 2.6.33- 5319.1 3649.6  29.4K 4048.6  3873.0  13.3    30.3 135.9
tqm8xx    Linux 2.6.33- 5347.6 3623.2  32.3K 3921.6  3894.0  13.3    30.4 135.8

*Local* Communication bandwidths in MB/s - bigger is better
-----------------------------------------------------------------------------
Host                OS  Pipe AF    TCP  File   Mmap  Bcopy  Bcopy  Mem   Mem
                             UNIX      reread reread (libc) (hand) read write
--------- ------------- ---- ---- ---- ------ ------ ------ ------ ---- -----
tqm8xx    Linux 2.6.33- 14.8 15.6 10.1   21.0   55.5   32.3   34.5 55.6  53.0
tqm8xx    Linux 2.6.33- 14.8 15.6 10.7   21.0   55.5   32.3   34.5 55.6  53.0
tqm8xx    Linux 2.6.33- 14.8 15.7 12.7   21.0   55.5   32.3   34.5 55.6  53.0
tqm8xx    Linux 2.6.33- 14.8 15.6 13.9   21.0   55.5   32.3   34.5 55.6  53.0
tqm8xx    Linux 2.6.33- 14.8 15.8 12.9   21.0   55.7   32.5   34.6 55.8  53.1
tqm8xx    Linux 2.6.33- 14.8 15.7 14.0   21.0   55.7   32.4   34.6 55.8  53.1
tqm8xx    Linux 2.6.33- 14.8 15.8 12.9   21.0   55.7   32.5   34.6 55.8  53.1
tqm8xx    Linux 2.6.33- 14.8 15.8 13.0   21.0   55.7   32.5   34.6 55.8  53.1
tqm8xx    Linux 2.6.33- 14.8 15.7 14.0   21.0   55.6   32.4   34.6 55.8  53.1
tqm8xx    Linux 2.6.33- 14.7 15.7 12.8   21.0   55.6   32.4   34.6 55.7  53.1
tqm8xx    Linux 2.6.33- 14.6 15.7 12.8   21.0   55.6   32.4   34.6 55.8  53.1
tqm8xx    Linux 2.6.33- 14.8 15.7 12.8   21.0   55.6   32.4   34.6 55.8  53.1
tqm8xx    Linux 2.6.33- 15.0 16.0 13.2   21.3   55.8   32.5   34.7 55.9  53.2
tqm8xx    Linux 2.6.33- 15.0 16.0 13.4   21.3   55.8   32.5   34.7 55.8  53.2
tqm8xx    Linux 2.6.33- 15.0 16.0 13.9   21.3   55.8   32.5   34.7 55.9  53.2
tqm8xx    Linux 2.6.33- 15.0 16.0 13.2   21.2   55.8   32.5   34.6 55.9  53.2

Memory latencies in nanoseconds - smaller is better
    (WARNING - may not be correct, check graphs)
------------------------------------------------------------------------------
Host                 OS   Mhz   L1 $   L2 $    Main mem    Rand mem    Guesses
--------- -------------   ---   ----   ----    --------    --------    -------
tqm8xx    Linux 2.6.33-    66   31.8  141.0       184.0      1165.7
tqm8xx    Linux 2.6.33-    66   31.8  141.2       184.2      1165.3
tqm8xx    Linux 2.6.33-    66   31.8  141.3       184.3      1165.6
tqm8xx    Linux 2.6.33-    66   31.8  141.3       184.2      1166.2
tqm8xx    Linux 2.6.33-    66   31.8  141.0       171.8      1100.5    No L2 cache?
tqm8xx    Linux 2.6.33-    66   31.8  141.0       171.8      1102.5    No L2 cache?
tqm8xx    Linux 2.6.33-    66   31.8  141.0       171.8      1101.7    No L2 cache?
tqm8xx    Linux 2.6.33-    66   31.8  141.0       171.8      1101.6    No L2 cache?
tqm8xx    Linux 2.6.33-    66   31.8  141.1       173.4      1149.1    No L2 cache?
tqm8xx    Linux 2.6.33-    66   31.8  141.1       173.4      1149.0    No L2 cache?
tqm8xx    Linux 2.6.33-    66   31.7  141.1       173.4      1148.7    No L2 cache?
tqm8xx    Linux 2.6.33-    66   31.7  141.1       173.4      1148.2    No L2 cache?
tqm8xx    Linux 2.6.33-    66   31.8  171.1       171.7      1099.8    No L2 cache?
tqm8xx    Linux 2.6.33-    66   31.8  171.1       171.6      1100.5    No L2 cache?
tqm8xx    Linux 2.6.33-    66   31.7  171.0       171.7      1101.0    No L2 cache?
tqm8xx    Linux 2.6.33-    66   31.8  171.0       171.6      1101.3    No L2 cache?

make[1]: Leaving directory `/home/hs/lmbench-3.0-a9/results'
bye
Heiko
-- 
DENX Software Engineering GmbH,     MD: Wolfgang Denk & Detlev Zundel
HRB 165235 Munich, Office: Kirchenstr.5, D-82194 Groebenzell, Germany
