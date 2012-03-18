Return-Path: <paul.gortmaker@windriver.com>
Received: from mail.windriver.com (mail.windriver.com [147.11.1.11])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client CN "mail.windriver.com",
 Issuer "Intel External Basic Issuing CA 3A" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id F135CB6FAA
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 19 Mar 2012 08:39:41 +1100 (EST)
From: Paul Gortmaker <paul.gortmaker@windriver.com>
To: davem@davemloft.net, eric.dumazet@gmail.com, therbert@google.com
Subject: [PATCH v2 net-next 0/4] Gianfar byte queue limits
Date: Sun, 18 Mar 2012 17:39:17 -0400
Message-Id: <1332106761-18293-1-git-send-email-paul.gortmaker@windriver.com>
In-Reply-To: <1332089787-24086-1-git-send-email-paul.gortmaker@windriver.com>
References: <1332089787-24086-1-git-send-email-paul.gortmaker@windriver.com>
Cc: netdev@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
 Paul Gortmaker <paul.gortmaker@windriver.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Identical to v1 but with the additional patch suggested by Eric.
Compile tested.  The v1 text follows below the pull request.

Sorry for the near back-to-back sends; I would have liked to have
got this out earlier in the week and not so close to net-next
closing, but that just didn't happen...

Thanks,
Paul
---

The following changes since commit cdf485be3a63d1f34293740fb726088c6840ceea:

  ixgbe: dcb: use DCB config values for FCoE traffic class on open (2012-03-14 00:49:10 -0700)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/paulg/linux.git gianfar-bql

for you to fetch changes up to 5407b14c6792d6ff122ecb1a2a6acffad60ef389:

  gianfar: use netif_tx_queue_stopped instead of __netif_subqueue_stopped (2012-03-18 17:11:22 -0400)

----------------------------------------------------------------
Paul Gortmaker (4):
      gianfar: Add support for byte queue limits.
      gianfar: constify giant block of status descriptor strings
      gianfar: delete orphaned version strings and dead macros
      gianfar: use netif_tx_queue_stopped instead of __netif_subqueue_stopped

 drivers/net/ethernet/freescale/gianfar.c         |   22 ++++++++++++++++------
 drivers/net/ethernet/freescale/gianfar.h         |    3 ---
 drivers/net/ethernet/freescale/gianfar_ethtool.c |    2 +-
 3 files changed, 17 insertions(+), 10 deletions(-)


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
> Paul.
> ---
> 
> [1] http://lists.openwall.net/netdev/2012/01/06/64
> 
> Paul Gortmaker (3):
>   gianfar: Add support for byte queue limits.
>   gianfar: constify giant block of status descriptor strings
>   gianfar: delete orphaned version strings and dead macros
> 
>  drivers/net/ethernet/freescale/gianfar.c         |   22 ++++++++++++++++------
>  drivers/net/ethernet/freescale/gianfar.h         |    3 ---
>  drivers/net/ethernet/freescale/gianfar_ethtool.c |    2 +-
>  3 files changed, 17 insertions(+), 10 deletions(-)
> 
-- 
1.7.9.1
