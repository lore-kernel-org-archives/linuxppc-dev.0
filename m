Return-Path: <hs@denx.de>
Received: from a.relay.invitel.net (a.relay.invitel.net [62.77.203.3])
	by ozlabs.org (Postfix) with ESMTP id 3A9A2B70ED
	for <linuxppc-dev@ozlabs.org>; Fri, 21 Jan 2011 17:59:36 +1100 (EST)
Date: Fri, 21 Jan 2011 07:53:02 +0100
From: Heiko Schocher <hs@denx.de>
Subject: Re: mpc880 linux-2.6.32 slow running processes
In-reply-to: <OF14B8C2B7.A99F8A1E-ONC1257815.0057AC0A-C1257815.0057F664@transmode.se>
To: Joakim Tjernlund <joakim.tjernlund@transmode.se>
Message-id: <4D392D4E.2000004@denx.de>
MIME-version: 1.0
Content-type: text/plain; charset=ISO-8859-1
References: <AANLkTin5XTnDEu1BJUOeF0UWtfEpotW5Bq__i8g6U05h@mail.gmail.com>
	<4D24B725.2020300@evidence.eu.com>
	<20110105174256.29fd378a@udp111988uds.am.freescale.net>
	<4D25BB08.7000001@evidence.eu.com>
	<OFB0350E05.07B070EF-ONC1257810.005CAF17-C1257810.005CAF19@transmode.se>
	<AANLkTinbdEc2kTVHZp3b31V6sFSqOfquUidb5BZYdgEX@mail.gmail.com>
	<OFBA8894F8.FF5AA75D-ONC1257812.00773DA9-C1257812.00776196@transmode.se>
	<AANLkTi=cAswFh1cFCU=nomd6yg5Ux9jK0x9h9s7f2571@mail.gmail.com>
	<OFCA182CE3.B20BFA9C-ONC1257814.005C7CE1-C1257814.005CF1A7@transmode.se>
	<OF14B8C2B7.A99F8A1E-ONC1257815.0057AC0A-C1257815.0057F664@transmode.se>
Cc: Wolfgang Denk <wd@denx.de>, Rafael Beims <rbeims@gmail.com>,
	scottwood <scottwood@freescale.com>,
	linuxppc-dev <linuxppc-dev@ozlabs.org>, michael@evidence.eu.com,
	RFeany <RFeany@mrv.com>
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
>> Sent by: linuxppc-dev-bounces+joakim.tjernlund=transmode.se@lists.ozlabs.org
>>
>> Rafael Beims <rbeims@gmail.com> wrote on 2011/01/10 17:35:38:
>>>> Once you have tested it and it works, please send a patch to remove the 8xx workaround.
>>>> Make sure Scott is cc:ed
>>>>
>>>>
>>> I tested linux-2.6.33 on my ppc880 board today, and even without the
>>> slowdown.patch applied, the board runs processes with good
>>> performance.
>>> It really seems that the problem is solved from linux-2.6.33 on.
>>>
>>> I'm not sure what you mean by sending a patch to remove the
>>> workaround. The only thing that I did in the 2.6.32 version was to
>>> apply the slowdown.patch attached in the message from Michael.
>>>
>>> Could you clarify please?
>> Yes, this part in arch/powerpc/mm/pgtable.c:
>> #ifdef CONFIG_8xx
>>          /* On 8xx, cache control instructions (particularly
>>           * "dcbst" from flush_dcache_icache) fault as write
>>           * operation if there is an unpopulated TLB entry
>>           * for the address in question. To workaround that,
>>           * we invalidate the TLB here, thus avoiding dcbst
>>           * misbehaviour.
>>           */
>>          /* 8xx doesn't care about PID, size or ind args */
>>          _tlbil_va(addr, 0, 0, 0);
>> #endif /* CONFIG_8xx */
>>
>> Should be removed in >= 2.6.33 kernels.
>> My 8xx TLB work fixes this problem more efficiently.
> 
> Can you test these 2 patches on recent 2.6 linux:
>>From 9024200169bf86b4f34cb3b1ebf68e0056237bc0 Mon Sep 17 00:00:00 2001
> From: Joakim Tjernlund <Joakim.Tjernlund@transmode.se>
> Date: Tue, 11 Jan 2011 13:43:42 +0100
> Subject: [PATCH 1/2] powerpc: Move 8xx invalidation of non present TLBs
[...]
> and
> 
>>From 0ef93601290a75b087495dddeee6062a870f1dc6 Mon Sep 17 00:00:00 2001
> From: Joakim Tjernlund <Joakim.Tjernlund@transmode.se>
> Date: Tue, 11 Jan 2011 13:55:22 +0100
> Subject: [PATCH 2/2] powerpc: Remove 8xx redundant dcbst workaround.

Tested this on a board similliar to the mainline tqm8xx board with
lmbench:

-bash-3.2# cat /proc/cpuinfo
processor       : 0
cpu             : 8xx
clock           : 80.000000MHz
revision        : 0.0 (pvr 0050 0000)
bogomips        : 10.00
timebase        : 5000000
platform        : KUP4K
model           : KUP4K
Memory          : 96 MB
-bash-3.2#

-bash-3.2# cat /proc/version
Linux version 2.6.34-00064-g3e81b6b (hs@pollux.denx.de) (gcc version 4.2.2) #89 Thu Jan 20 08:39:52 CET 2011
-bash-3.2#

(First run of lmbench without your 2 patches, the two other runs with it)

-bash-3.2# make see
cd results && make summary >summary.out 2>summary.errs
cd results && make percent >percent.out 2>percent.errs
-bash-3.2# cat results/summary.out
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
kup4k     Linux 2.6.34-       powerpc-linux-gnu   79    28    16 1.1400    1
kup4k     Linux 2.6.34-       powerpc-linux-gnu   79    28    16 1.0200    1
kup4k     Linux 2.6.34-       powerpc-linux-gnu   79    28    16 1.1000    1

Processor, Processes - times in microseconds - smaller is better
------------------------------------------------------------------------------
Host                 OS  Mhz null null      open slct sig  sig  fork exec sh
                             call  I/O stat clos TCP  inst hndl proc proc proc
--------- ------------- ---- ---- ---- ---- ---- ---- ---- ---- ---- ---- ----
kup4k     Linux 2.6.34-   79 2.58 12.3 126. 1285 353. 22.8 149. 8418 34.K 101K
kup4k     Linux 2.6.34-   79 2.59 13.1 127. 1273 320. 23.4 127. 8251 33.K 100K
kup4k     Linux 2.6.34-   79 2.47 13.1 127. 1288 315. 23.6 128. 8413 34.K 101K

Basic integer operations - times in nanoseconds - smaller is better
-------------------------------------------------------------------
Host                 OS  intgr intgr  intgr  intgr  intgr
                          bit   add    mul    div    mod
--------- ------------- ------ ------ ------ ------ ------
kup4k     Linux 2.6.34-   12.6   14.4 1.3500  103.9  170.6
kup4k     Linux 2.6.34-   13.2   15.0 1.3100  100.0  170.5
kup4k     Linux 2.6.34-   13.2   14.4 1.2900  104.1  162.1

Basic uint64 operations - times in nanoseconds - smaller is better
------------------------------------------------------------------
Host                 OS int64  int64  int64  int64  int64
                         bit    add    mul    div    mod
--------- ------------- ------ ------ ------ ------ ------
kup4k     Linux 2.6.34-    12.          11.1 1637.9 1602.4
kup4k     Linux 2.6.34-    13.          11.1 1643.6 1604.2
kup4k     Linux 2.6.34-    13.          11.1 1639.7 1600.8

Basic float operations - times in nanoseconds - smaller is better
-----------------------------------------------------------------
Host                 OS  float  float  float  float
                         add    mul    div    bogo
--------- ------------- ------ ------ ------ ------
kup4k     Linux 2.6.34-  840.5 1304.3 4593.3 8703.0
kup4k     Linux 2.6.34-  843.5 1366.6 4601.7 8814.0
kup4k     Linux 2.6.34-  807.8 1377.5 4610.0 8710.0

Basic double operations - times in nanoseconds - smaller is better
------------------------------------------------------------------
Host                 OS  double double double double
                         add    mul    div    bogo
--------- ------------- ------  ------ ------ ------
kup4k     Linux 2.6.34- 1309.2 2235.2 3132.2  13.9K
kup4k     Linux 2.6.34- 1252.0 2339.0 2993.8  13.9K
kup4k     Linux 2.6.34- 1311.2 2335.2 2997.2  13.9K

Context switching - times in microseconds - smaller is better
-------------------------------------------------------------------------
Host                 OS  2p/0K 2p/16K 2p/64K 8p/16K 8p/64K 16p/16K 16p/64K
                         ctxsw  ctxsw  ctxsw ctxsw  ctxsw   ctxsw   ctxsw
--------- ------------- ------ ------ ------ ------ ------ ------- -------
kup4k     Linux 2.6.34-  131.8  144.7  130.8  168.4  207.8   190.7   248.1
kup4k     Linux 2.6.34-  129.4  142.4  140.8  186.4  211.1   187.0   257.9
kup4k     Linux 2.6.34-  121.3  155.6  131.0  196.8  201.5   198.5   240.7

*Local* Communication latencies in microseconds - smaller is better
---------------------------------------------------------------------
Host                 OS 2p/0K  Pipe AF     UDP  RPC/   TCP  RPC/ TCP
                        ctxsw       UNIX         UDP         TCP conn
--------- ------------- ----- ----- ---- ----- ----- ----- ----- ----
kup4k     Linux 2.6.34- 131.8 444.2 771. 1024.       1432.       3876
kup4k     Linux 2.6.34- 129.4 455.2 722. 1021.       1434.       3831
kup4k     Linux 2.6.34- 121.3 458.8 761. 1004.       1435.       3866

*Remote* Communication latencies in microseconds - smaller is better
---------------------------------------------------------------------
Host                 OS   UDP  RPC/  TCP   RPC/ TCP
                               UDP         TCP  conn
--------- ------------- ----- ----- ----- ----- ----
kup4k     Linux 2.6.34-
kup4k     Linux 2.6.34-
kup4k     Linux 2.6.34-

File & VM system latencies in microseconds - smaller is better
-------------------------------------------------------------------------------
Host                 OS   0K File      10K File     Mmap    Prot   Page   100fd
                        Create Delete Create Delete Latency Fault  Fault  selct
--------- ------------- ------ ------ ------ ------ ------- ----- ------- -----
kup4k     Linux 2.6.34-  16.7K  10.3K  90.9K  13.7K   22.6K  27.1    43.4 117.9
kup4k     Linux 2.6.34-  16.9K  15.6K 100.0K  16.1K   22.7K 9.590    39.8 119.2
kup4k     Linux 2.6.34-  16.7K  13.5K 100.0K  15.9K   22.8K 9.306    39.8 119.6

*Local* Communication bandwidths in MB/s - bigger is better
-----------------------------------------------------------------------------
Host                OS  Pipe AF    TCP  File   Mmap  Bcopy  Bcopy  Mem   Mem
                             UNIX      reread reread (libc) (hand) read write
--------- ------------- ---- ---- ---- ------ ------ ------ ------ ---- -----
kup4k     Linux 2.6.34- 13.3 13.3 11.0   18.3   49.5   23.7   23.3 49.5  35.5
kup4k     Linux 2.6.34- 13.2 13.4 10.8   18.4   49.5   23.4   23.2 49.5  35.4
kup4k     Linux 2.6.34- 13.1 13.2 11.0   18.3   49.5   23.7   23.4 49.5  35.5

Memory latencies in nanoseconds - smaller is better
    (WARNING - may not be correct, check graphs)
------------------------------------------------------------------------------
Host                 OS   Mhz   L1 $   L2 $    Main mem    Rand mem    Guesses
--------- -------------   ---   ----   ----    --------    --------    -------
kup4k     Linux 2.6.34-    79   26.4  278.6       277.0      1145.6    No L2 cache?
kup4k     Linux 2.6.34-    79   26.4  278.7       277.1      1147.1    No L2 cache?
kup4k     Linux 2.6.34-    79   26.4  278.8       276.6      1146.9    No L2 cache?
make[1]: Leaving directory `/home/hs/lmbench-3.0-a9/results'
-bash-3.2#

bye,
Heiko
-- 
DENX Software Engineering GmbH,     MD: Wolfgang Denk & Detlev Zundel
HRB 165235 Munich, Office: Kirchenstr.5, D-82194 Groebenzell, Germany
