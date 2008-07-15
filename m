Return-Path: <miltonm@bga.com>
Received: from ruth.realtime.net (mercury.realtime.net [205.238.132.86])
	by ozlabs.org (Postfix) with ESMTP id 01B97DF379
	for <linuxppc-dev@ozlabs.org>; Wed, 16 Jul 2008 01:55:51 +1000 (EST)
Mime-Version: 1.0 (Apple Message framework v624)
In-Reply-To: <DCEAAC0833DD314AB0B58112AD99B93B04AE61BC@ismail.innsys.innovsys.com>
Content-Type: text/plain; charset=US-ASCII; delsp=yes; format=flowed
Message-Id: <9dc3e1e709ad1aa47ae4c73f18c4d5e0@bga.com>
From: Milton Miller <miltonm@bga.com>
Subject: Re: 82xx performance
Date: Tue, 15 Jul 2008 10:57:22 -0500
To: Rune Torgersen <runet@innovsys.com>
Cc: ppcdev <linuxppc-dev@ozlabs.org>, Arnd Bergmann <arnd@arndb.de>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Tue Jul 15 02:34:03 EST 2008, Rune Togersen wrote:
> We are looking into switching kernels from 2.6.18 (ppc) to 2.6.25
> (powerpc).
> I have been trying to run some benchmarks to see how the new kernel
> compares to the old one.
>
> So far it is performing worse.
>
> One test I ran was just compiling a 2.6.18 kernel on the system.
> The .25 performed 5 to 7 % slower:
>
> 2.6.18, make vmlinux
> real    74m1.328s
> user    68m48.196s
> sys     4m35.961s
>
> 2.6.25, make vmlinux
> real    79m13.361s
> user    72m41.318s
> sys     5m46.744s
>
> I also ran lmbench3. (slightly outdated, but still works)
> Most (if not all) results are worse on .25, especially context
> switching.
>
> Is this expected behaviour or is there anything I need to look at in my
> config?
> (I'll send config if anybody is interested)
>
>
>                  L M B E N C H  3 . 0   S U M M A R Y
>                  ------------------------------------
>                  (Alpha software, do not distribute)
>
> Basic system parameters
> ----------------------------------------------------------------------- 
> -
> ------
> Host                 OS Description              Mhz  tlb  cache  mem  
> scal
>                                                      pages line   par  
> load
>                                                            bytes
> --------- ------------- ----------------------- ---- ----- -----  
> ------ ----
> 9919_unit  Linux 2.6.25       powerpc-linux-gnu  434    32    32  
> 1.0000 1
> 9919_unit  Linux 2.6.18       powerpc-linux-gnu  445    32    32  
> 1.0100 1

Hmm, processor MHz is off by 11/445

>
> Processor, Processes - times in microseconds - smaller is better
> ----------------------------------------------------------------------- 
> - ------
> Host                 OS  Mhz null null      open slct sig  sig  fork  
> exec sh
>                              call  I/O stat clos TCP  inst hndl proc  
> proc proc
> --------- ------------- ---- ---- ---- ---- ---- ---- ---- ---- ----  
> ---- ----
> 9919_unit  Linux 2.6.25  434 0.47 1.26 10.7 35.6 34.1 1.76 14.3 2646  
> 9964 33.K
> 9919_unit  Linux 2.6.18  445 0.35 1.24 9.27 22.9 32.7 1.87 13.8 2157  
> 7825 26.K
>

> Basic integer operations - times in nanoseconds - smaller is better
> -------------------------------------------------------------------
> Host                 OS  intgr intgr  intgr  intgr  intgr
>                           bit   add    mul    div    mod
> --------- ------------- ------ ------ ------ ------ ------
> 9919_unit  Linux 2.6.25 2.3300 0.0100   10.7   46.2   56.0
> 9919_unit  Linux 2.6.18 2.2300 0.0100   10.3   45.4   54.1
>
> Basic float operations - times in nanoseconds - smaller is better
> -----------------------------------------------------------------
> Host                 OS  float  float  float  float
>                          add    mul    div    bogo
> --------- ------------- ------ ------ ------ ------
> 9919_unit  Linux 2.6.25 9.9500   10.1   46.2   66.2
> 9919_unit  Linux 2.6.18 9.1100 9.0800   45.8   67.1
>
> Basic double operations - times in nanoseconds - smaller is better
> ------------------------------------------------------------------
> Host                 OS  double double double double
>                          add    mul    div    bogo
> --------- ------------- ------  ------ ------ ------
> 9919_unit  Linux 2.6.25 9.3400   11.6   78.6  100.2
> 9919_unit  Linux 2.6.18 9.1600   11.1   77.2   97.8
>

Integer and float operations are also off ...

> Context switching - times in microseconds - smaller is better
> ----------------------------------------------------------------------- 
> -
> -
> Host                 OS  2p/0K 2p/16K 2p/64K 8p/16K 8p/64K 16p/16K  
> 16p/64K
>                          ctxsw  ctxsw  ctxsw ctxsw  ctxsw   ctxsw ctxsw
> --------- ------------- ------ ------ ------ ------ ------ -------  
> -------
> 9919_unit  Linux 2.6.25   20.6   86.2   28.5  103.8   38.7   111.8 57.4
> 9919_unit  Linux 2.6.18 5.3300   63.2   17.9   73.4   23.1    74.9 26.2
>
> *Local* Communication latencies in microseconds - smaller is better
> ---------------------------------------------------------------------
> Host                 OS 2p/0K  Pipe AF     UDP  RPC/   TCP  RPC/ TCP
>                         ctxsw       UNIX         UDP         TCP conn
> --------- ------------- ----- ----- ---- ----- ----- ----- ----- ----
> 9919_unit  Linux 2.6.25  20.6  68.8 131. 353.1 533.4 461.7       1269
> 9919_unit  Linux 2.6.18 5.330  36.1 87.8 225.3 402.7 331.8 520.1 970.
>
> File & VM system latencies in microseconds - smaller is better
> ----------------------------------------------------------------------- 
> --------
> Host                 OS   0K File      10K File     Mmap    Prot   Page
> 100fd
>                         Create Delete Create Delete Latency Fault   
> Fault
> selct
> --------- ------------- ------ ------ ------ ------ ------- -----  
> ------- -----
> 9919_unit  Linux 2.6.25  222.3  172.4 1003.0  350.5   41.5K 1.734     
> 10.5  18.0
> 9919_unit  Linux 2.6.18  181.5  144.3  789.3  293.9   23.9K 7.09560   
> 19.3
>
> *Local* Communication bandwidths in MB/s - bigger is better
> ----------------------------------------------------------------------- 
> ------
> Host                OS  Pipe AF    TCP  File   Mmap  Bcopy  Bcopy  Mem
> Mem
>                              UNIX      reread reread (libc) (hand) read
> write
> --------- ------------- ---- ---- ---- ------ ------ ------ ------  
> ---- -----
> 9919_unit  Linux 2.6.25 34.2 34.7 21.5   55.5  161.8   79.9   79.2  
> 160. 116.1
> 9919_unit  Linux 2.6.18 40.1 37.4 29.7   60.0  165.8   80.6   81.1  
> 165. 117.8
>
> Memory latencies in nanoseconds - smaller is better
>     (WARNING - may not be correct, check graphs)
> ----------------------------------------------------------------------- 
> -------
> Host                 OS   Mhz   L1 $   L2 $    Main mem    Rand mem
> Guesses
> --------- -------------   ---   ----   ----    --------    --------  
> -------
> 9919_unit  Linux 2.6.25   434 4.8150  174.6  183.3       511.8    No  
> L2 cache?
> 9919_unit  Linux 2.6.18   445 4.6880  174.1  175.4       497.5    No  
> L2 cache?

And memory latency is off 13/500.

That sounds like it will be 16/666.

Are you using the same board and the same firmware?

If so, look at /proc/cpuinfo and/or the boot log to see what
frequency linux thinks the processor is running at.  It sounds
like someone introduced or fixed a rounding error error calculating
the timebase frequency for your board.

Please try the sleep test: sleep for 100 seconds, and time with
either a stopwatch or another system.  I think you will find they
take different amounts of time, and all the results need to be scaled.
You might be able to see it reading the hardware clock.

Actually, once you track that down, rerun and see what you find.

milton
