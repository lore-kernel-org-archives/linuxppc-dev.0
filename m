Return-Path: <joakim.tjernlund@transmode.se>
Received: from gw1.transmode.se (gw1.transmode.se [213.115.205.20])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 96457B7CFB
	for <linuxppc-dev@ozlabs.org>; Wed,  3 Mar 2010 19:49:09 +1100 (EST)
In-Reply-To: <4B8E17A7.10509@denx.de>
References: <4B8E17A7.10509@denx.de>
Subject: Re: [PATCH 0/4] 8xx: Optimize TLB Miss code.
To: hs@denx.de
Message-ID: <OF5AEF2DED.4E6AA5A2-ONC12576DB.002FD2D9-C12576DB.00305B81@transmode.se>
From: Joakim Tjernlund <joakim.tjernlund@transmode.se>
Date: Wed, 3 Mar 2010 09:48:11 +0100
MIME-Version: 1.0
Content-type: text/plain; charset=US-ASCII
Cc: Scott Wood <scottwood@freescale.com>, linuxppc-dev@ozlabs.org,
	Wolfgang Denk <wd@denx.de>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Heiko Schocher <hs@denx.de> wrote on 2010/03/03 09:02:47:
>
> Hello Joakim,
>
> I tried your 4 patches on a MPC855M based system:

Thanks a lot for testing this for me!

>
> -bash-3.2# cat /proc/cpuinfo
> processor       : 0
> cpu             : 8xx
> clock           : 66.000000MHz
> revision        : 0.0 (pvr 0050 0000)
> bogomips        : 8.25
> timebase        : 4125000
> platform        : TQM8xx
> model           : TQM8xx
> Memory          : 32 MB
> -bash-3.2# cat /proc/version
> Linux version 2.6.33-rc6-01500-gbddcb41-dirty (hs@xpert.denx.de) (gcc version
> 4.2.2) #9 Tue Mar 2 18:08:49 CET 2010
> -bash-3.2#
>
> First I looked for the Boottime:
>
> Booting Linux:
>
>                            2.6.33 2.6.33tunned
> ... until "Freeing unused kernel memory" message (= enter user space)    ~4s    ~4s
> ... until "login:" message (= full multi-user mode)          56s    56s
>
> and I did a Performance test with lmbench, see:
> http://sourceforge.net/projects/lmbench
>
> Here the results:
> (The first 4 rows are the results for the kernel without your patches,
>  the next 4 rows are the results for the kernel with your patches)
>
> make[1]: Entering directory `/home/hs/lmbench-3.0-a9/results'

I see both ups and downs in this test, don't quite understand why.
What is your config w.r.t SWAP, MODULES, CPU6 and CPU15?


>
>                  L M B E N C H  3 . 0   S U M M A R Y
>                  ------------------------------------
>        (Alpha software, do not distribute)
>
> Basic system parameters
> ------------------------------------------------------------------------------
> Host                 OS Description              Mhz  tlb  cache  mem   scal
>                                                      pages line   par   load
>                                                            bytes
> --------- ------------- ----------------------- ---- ----- ----- ------ ----
> tqm8xx    Linux 2.6.33-       powerpc-linux-gnu   66    32    16 1.0400    1
> tqm8xx    Linux 2.6.33-       powerpc-linux-gnu   66     7    16 1.0400    1
> tqm8xx    Linux 2.6.33-       powerpc-linux-gnu   66     7    16 1.0400    1
> tqm8xx    Linux 2.6.33-       powerpc-linux-gnu   66    32    16 1.0400    1
> tqm8xx    Linux 2.6.33-       powerpc-linux-gnu   66    32    16 1.0400    1
> tqm8xx    Linux 2.6.33-       powerpc-linux-gnu   66     7    16 1.0400    1
> tqm8xx    Linux 2.6.33-       powerpc-linux-gnu   66     7    16 1.0400    1
> tqm8xx    Linux 2.6.33-       powerpc-linux-gnu   66    32    16 1.0400    1
>
> Processor, Processes - times in microseconds - smaller is better
> ------------------------------------------------------------------------------
> Host                 OS  Mhz null null      open slct sig  sig  fork exec sh
>                              call  I/O stat clos TCP  inst hndl proc proc proc
> --------- ------------- ---- ---- ---- ---- ---- ---- ---- ---- ---- ---- ----
> tqm8xx    Linux 2.6.33-   66 2.97 10.3 129. 1377 272. 21.8 91.3 6949 29.K 89.K
> tqm8xx    Linux 2.6.33-   66 3.06 10.5 124. 1375 273. 21.8 91.3 7136 30.K 89.K
> tqm8xx    Linux 2.6.33-   66 3.06 10.6 129. 1365 272. 21.2 96.6 6889 29.K 89.K
> tqm8xx    Linux 2.6.33-   66 3.06 10.5 124. 1309 272. 21.8 101. 6896 29.K 89.K
> tqm8xx    Linux 2.6.33-   66 2.97 8.86 126. 1336 273. 21.7 84.2 6785 29.K 88.K
> tqm8xx    Linux 2.6.33-   66 3.06 8.90 130. 1343 263. 21.3 84.7 7080 29.K 88.K
> tqm8xx    Linux 2.6.33-   66 3.52 8.97 129. 1339 270. 22.4 84.4 6823 29.K 88.K
> tqm8xx    Linux 2.6.33-   66 2.97 8.99 127. 1333 261. 22.4 87.0 7037 29.K 87.K
>

[SNIP integer/float test, these are not relevant]

>
> Context switching - times in microseconds - smaller is better
> -------------------------------------------------------------------------
> Host                 OS  2p/0K 2p/16K 2p/64K 8p/16K 8p/64K 16p/16K 16p/64K
>                          ctxsw  ctxsw  ctxsw ctxsw  ctxsw   ctxsw   ctxsw
> --------- ------------- ------ ------ ------ ------ ------ ------- -------
> tqm8xx    Linux 2.6.33-   92.6  109.6  110.9  137.5  173.8   151.8   199.3
> tqm8xx    Linux 2.6.33-   95.8  108.5  104.7  137.1  172.7   150.9   194.7
> tqm8xx    Linux 2.6.33-   95.8  118.8   97.5  146.4  162.0   160.8   190.1
> tqm8xx    Linux 2.6.33-   92.9  111.9  101.0  138.1  166.6   152.3   192.0
> tqm8xx    Linux 2.6.33-   90.8  108.5  116.2  134.3  171.8   147.1   210.0
> tqm8xx    Linux 2.6.33-  100.1  111.4  105.0  136.4  173.1   148.3   200.8
> tqm8xx    Linux 2.6.33-   98.7  111.3  111.8  135.7  172.5   147.9   200.9
> tqm8xx    Linux 2.6.33-   92.0  117.9  109.9  141.6  170.4   154.9   196.4
>
> *Local* Communication latencies in microseconds - smaller is better
> ---------------------------------------------------------------------
> Host                 OS 2p/0K  Pipe AF     UDP  RPC/   TCP  RPC/ TCP
>                         ctxsw       UNIX         UDP         TCP conn
> --------- ------------- ----- ----- ---- ----- ----- ----- ----- ----
> tqm8xx    Linux 2.6.33-  92.6 338.4 581. 720.1       1047.       2749
> tqm8xx    Linux 2.6.33-  95.8 334.0 595. 725.0       1051.       2754
> tqm8xx    Linux 2.6.33-  95.8 330.9 574. 720.1       1047.       2772
> tqm8xx    Linux 2.6.33-  92.9 338.8 574. 714.3       1046.       2742
> tqm8xx    Linux 2.6.33-  90.8 322.1 576. 734.9       1012.       2706
> tqm8xx    Linux 2.6.33- 100.1 326.0 565. 719.5       1027.       2702
> tqm8xx    Linux 2.6.33-  98.7 322.8 571. 713.8       1028.       2711
> tqm8xx    Linux 2.6.33-  92.0 328.1 549. 714.1       1022.       2696
>
> *Remote* Communication latencies in microseconds - smaller is better
> ---------------------------------------------------------------------
> Host                 OS   UDP  RPC/  TCP   RPC/ TCP
>                                UDP         TCP  conn
> --------- ------------- ----- ----- ----- ----- ----
> tqm8xx    Linux 2.6.33-
> tqm8xx    Linux 2.6.33-
> tqm8xx    Linux 2.6.33-
> tqm8xx    Linux 2.6.33-
> tqm8xx    Linux 2.6.33-
> tqm8xx    Linux 2.6.33-
> tqm8xx    Linux 2.6.33-
> tqm8xx    Linux 2.6.33-
>
> File & VM system latencies in microseconds - smaller is better
> -------------------------------------------------------------------------------
> Host                 OS   0K File      10K File     Mmap    Prot   Page   100fd
>                         Create Delete Create Delete Latency Fault  Fault  selct
> --------- ------------- ------ ------ ------ ------ ------- ----- ------- -----
> tqm8xx    Linux 2.6.33- 5917.2 3968.3  31.2K 4329.0  4147.0  18.8    34.1 135.2
> tqm8xx    Linux 2.6.33- 5714.3 3937.0  32.3K 6060.6  4210.0  14.2    34.5 131.4
> tqm8xx    Linux 2.6.33- 5747.1 4000.0  31.2K 4329.0  4114.0 7.692    34.0 133.1
> tqm8xx    Linux 2.6.33- 5747.1 4081.6  30.3K 4273.5  4100.0  18.2    34.2 135.0
> tqm8xx    Linux 2.6.33- 5714.3 3952.6  31.2K 4273.5  4130.0  33.5    35.1 136.1
> tqm8xx    Linux 2.6.33- 5714.3 3906.2  31.2K 6060.6  4105.0  25.7    35.5 135.9
> tqm8xx    Linux 2.6.33- 5681.8 3921.6  32.3K 4255.3  4144.0  23.5    35.0 134.9
> tqm8xx    Linux 2.6.33- 5649.7 3937.0  30.3K 4237.3  4116.0  21.6    35.3 135.3
>
> *Local* Communication bandwidths in MB/s - bigger is better
> -----------------------------------------------------------------------------
> Host                OS  Pipe AF    TCP  File   Mmap  Bcopy  Bcopy  Mem   Mem
>                              UNIX      reread reread (libc) (hand) read write
> --------- ------------- ---- ---- ---- ------ ------ ------ ------ ---- -----
> tqm8xx    Linux 2.6.33- 14.8 15.6 10.1   21.0   55.5   32.3   34.5 55.6  53.0
> tqm8xx    Linux 2.6.33- 14.8 15.6 10.7   21.0   55.5   32.3   34.5 55.6  53.0
> tqm8xx    Linux 2.6.33- 14.8 15.7 12.7   21.0   55.5   32.3   34.5 55.6  53.0
> tqm8xx    Linux 2.6.33- 14.8 15.6 13.9   21.0   55.5   32.3   34.5 55.6  53.0
> tqm8xx    Linux 2.6.33- 14.8 15.8 12.9   21.0   55.7   32.5   34.6 55.8  53.1
> tqm8xx    Linux 2.6.33- 14.8 15.7 14.0   21.0   55.7   32.4   34.6 55.8  53.1
> tqm8xx    Linux 2.6.33- 14.8 15.8 12.9   21.0   55.7   32.5   34.6 55.8  53.1
> tqm8xx    Linux 2.6.33- 14.8 15.8 13.0   21.0   55.7   32.5   34.6 55.8  53.1
>
> Memory latencies in nanoseconds - smaller is better
>     (WARNING - may not be correct, check graphs)
> ------------------------------------------------------------------------------
> Host                 OS   Mhz   L1 $   L2 $    Main mem    Rand mem    Guesses
> --------- -------------   ---   ----   ----    --------    --------    -------
> tqm8xx    Linux 2.6.33-    66   31.8  141.0       184.0      1165.7
> tqm8xx    Linux 2.6.33-    66   31.8  141.2       184.2      1165.3
> tqm8xx    Linux 2.6.33-    66   31.8  141.3       184.3      1165.6
> tqm8xx    Linux 2.6.33-    66   31.8  141.3       184.2      1166.2
> tqm8xx    Linux 2.6.33-    66   31.8  141.0       171.8      1100.5    No L2 cache?
> tqm8xx    Linux 2.6.33-    66   31.8  141.0       171.8      1102.5    No L2 cache?
> tqm8xx    Linux 2.6.33-    66   31.8  141.0       171.8      1101.7    No L2 cache?
> tqm8xx    Linux 2.6.33-    66   31.8  141.0       171.8      1101.6    No L2 cache?
> make[1]: Leaving directory `/home/hs/lmbench-3.0-a9/results'
>
> bye
> Heiko
>
> --
> DENX Software Engineering GmbH,     MD: Wolfgang Denk & Detlev Zundel
> HRB 165235 Munich, Office: Kirchenstr.5, D-82194 Groebenzell, Germany
>
