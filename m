Return-Path: <eric.dumazet@gmail.com>
Received: from mail-pz0-f51.google.com (mail-pz0-f51.google.com
 [209.85.210.51])
 (using TLSv1 with cipher ECDHE-RSA-RC4-SHA (128/128 bits))
 (Client CN "smtp.gmail.com", Issuer "Google Internet Authority" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 7C049B6FD3
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 19 Mar 2012 07:30:41 +1100 (EST)
Received: by dady9 with SMTP id y9so10681123dad.38
 for <linuxppc-dev@lists.ozlabs.org>; Sun, 18 Mar 2012 13:30:39 -0700 (PDT)
Message-ID: <1332102634.3647.1.camel@edumazet-laptop>
Subject: Re: [PATCH net-next 0/3] Gianfar byte queue limits
From: Eric Dumazet <eric.dumazet@gmail.com>
To: Paul Gortmaker <paul.gortmaker@windriver.com>
Date: Sun, 18 Mar 2012 13:30:34 -0700
In-Reply-To: <1332089787-24086-1-git-send-email-paul.gortmaker@windriver.com>
References: <1332089787-24086-1-git-send-email-paul.gortmaker@windriver.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Cc: netdev@vger.kernel.org, linuxppc-dev@lists.ozlabs.org, davem@davemloft.net,
 therbert@google.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Le dimanche 18 mars 2012 à 12:56 -0400, Paul Gortmaker a écrit :
> The BQL support here is unchanged from what I posted earlier as an
> RFC[1] -- with the exception of the fact that I'm now happier with
> the runtime testing vs. the simple "hey it boots" that I'd done
> for the RFC.  Plus I added a couple trivial cleanup patches.
> 
> For testing, I made a couple spiders homeless by reviving an ancient
> 10baseT hub.  I connected an sbc8349 into that, and connected the
> yellowing hub into a GigE 16port, which was also connected to the
> recipient x86 box.
> 
> Gianfar saw the interface as follows:
> 
> fsl-gianfar e0024000.ethernet: eth0: mac: 00:a0:1e:a0:26:5a
> fsl-gianfar e0024000.ethernet: eth0: Running with NAPI enabled
> fsl-gianfar e0024000.ethernet: eth0: RX BD ring size for Q[0]: 256
> fsl-gianfar e0024000.ethernet: eth0: TX BD ring size for Q[0]: 256
> PHY: mdio@e0024520:19 - Link is Up - 10/Half
> 
> With the sbc8349 being diskless, I simply used an scp of /proc/kcore
> to the connected x86 box as a rudimentary Tx heavy workload.
> 
> BQL data was collected by changing into the dir:
> 
>   /sys/devices/e0000000.soc8349/e0024000.ethernet/net/eth0/queues/tx-0/byte_queue_limits
> 
> and running the following:
> 
>   for i in * ; do echo -n $i": " ; cat $i ; done
> 
> Running with the defaults, data like below was typical:
> 
> hold_time: 1000
> inflight: 4542
> limit: 3456
> limit_max: 1879048192
> limit_min: 0
> 
> hold_time: 1000
> inflight: 4542
> limit: 3378
> limit_max: 1879048192
> limit_min: 0
> 
> i.e. 2 or 3 MTU sized packets in flight and the limit value lying
> somewhere between those two values.
> 
> The interesting thing is that the interactive speed reported by scp
> seemed somewhat erratic, ranging from ~450 to ~700kB/s. (This was
> the only traffic on the old junk - perhaps expected oscillations such
> as those seen in isolated ARED tests?)  Average speed for 100M was:
> 
> 104857600 bytes (105 MB) copied, 172.616 s, 607 kB/s
> 

Still half duplex, or full duplex ?

Limiting to one packet on half duplex might avoid collisions :)

> Anyway, back to BQL testing; setting the values as follows:
> 
> hold_time: 1000
> inflight: 1514
> limit: 1400
> limit_max: 1400
> limit_min: 1000
> 
> had the effect of serializing the interface to a single packet, and
> the crusty old hub seemed much happier with this arrangement, keeping
> a constant speed and achieving the following on a 100MB Tx block:
> 
> 104857600 bytes (105 MB) copied, 112.52 s, 932 kB/s
> 
> It might be interesting to know more about why the defaults suffer
> the slowdown, but the hub could possibly be ancient spec violating
> trash.  Definitely something that nobody would ever use for anything
> today. (aside from contrived tests like this)
> 
> But it did give me an example of where I could see the effects of
> changing the BQL settings, and I'm reasonably confident they are
> working as expected.
> 

Seems pretty good to me !
