Return-Path: <eric.dumazet@gmail.com>
Received: from mail-pg0-x242.google.com (mail-pg0-x242.google.com
 [IPv6:2607:f8b0:400e:c05::242])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 419MbH6qDTzF0fX
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 20 Jun 2018 08:10:19 +1000 (AEST)
Received: by mail-pg0-x242.google.com with SMTP id w8-v6so487344pgp.7
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 19 Jun 2018 15:10:19 -0700 (PDT)
Subject: Re: [PATCH] Revert "net: pskb_trim_rcsum() and CHECKSUM_COMPLETE are
 friends"
To: Andreas Schwab <schwab@linux-m68k.org>
Cc: Mathieu Malaterre <malat@debian.org>,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 LKML <linux-kernel@vger.kernel.org>,
 Christophe LEROY <christophe.leroy@c-s.fr>, Meelis Roos <mroos@linux.ee>,
 netdev@vger.kernel.org, linuxppc-dev <linuxppc-dev@lists.ozlabs.org>
References: <20180615185645.8921-1-malat@debian.org>
 <fbb95c11-240c-1a11-0a62-0483908c577e@gmail.com>
 <CA+7wUsysaip70ARGQ7Byg1Zktfg0Y1esjEc9HxBGU4sKL8crhg@mail.gmail.com>
 <9d88677a-f2be-2089-79df-15df4e9a5dd6@gmail.com>
 <m2tvq1672p.fsf@linux-m68k.org>
 <e1a9b126-3226-72d0-82b2-b69ca5f59ccb@gmail.com> <87o9g8geu0.fsf@igel.home>
 <816ef746-5278-1d51-1d9d-55593e377681@gmail.com>
 <CA+7wUszG3Tmq5qT7o7w7ttAU+bzyJfRORL_Qzk4wUG6y2gZUuw@mail.gmail.com>
 <21523399-92ee-f8da-1a3e-0561f62850b7@gmail.com>
 <dd6f13bc-c5f2-85f8-c08d-837bc024fc7c@gmail.com> <87po0mvbgl.fsf@igel.home>
 <e1790720-911b-4d04-2215-752ec612e3d7@gmail.com>
From: Eric Dumazet <eric.dumazet@gmail.com>
Message-ID: <05645b90-d3bc-466d-116f-548f3ee39de9@gmail.com>
Date: Tue, 19 Jun 2018 15:10:14 -0700
MIME-Version: 1.0
In-Reply-To: <e1790720-911b-4d04-2215-752ec612e3d7@gmail.com>
Content-Type: text/plain; charset=utf-8
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>



On 06/19/2018 01:10 PM, Eric Dumazet wrote:
> 
> 
> On 06/19/2018 12:10 PM, Andreas Schwab wrote:
>> On Jun 18 2018, Eric Dumazet <eric.dumazet@gmail.com> wrote:
>>
>>> DUMP_PREFIX_ADDRESS might give us more information (say alignment problem, or crossing page boundaries)
>>
>> DUMP_PREFIX_ADDRESS is useless for that purpose.
>>
>> Here are some samples of broken csums:
>>
>> [  853.849225] sungem: sungem wrong csum : 9886/07be, len 94 bytes, c0000001fa187e02
>> [  853.849232] raw data: 00000000: 00 0d 93 43 81 62 18 d6 c7 51 b8 1c 08 00 45 10  ...C.b...Q....E.
>> [  853.849235] raw data: 00000010: 00 4c cb a0 40 00 40 11 d9 97 c0 a8 0a 01 c0 a8  .L..@.@.........
>> [  853.849237] raw data: 00000020: 0a 07 00 7b 00 7b 00 38 69 e1 1c 03 0c f7 00 00  ...{.{.8i.......
>> [  853.849240] raw data: 00000030: 08 f0 00 00 15 f0 c0 35 67 67 de d3 ca c9 d9 5b  .......5gg.....[
>> [  853.849242] raw data: 00000040: 1f ff de d3 d2 86 8f 67 fa f2 de d3 d2 86 8f 38  .......g.......8
>> [  853.849244] raw data: 00000050: 2f ff de d3 d2 86 8f 3b ff ff d1 93 bc 50        /......;.....P
> 
> Thanks.
> 
> 4 bytes in excess.
> 
> Might be the FCS, and it does not look like provided csum has a relation with it.
> 
> For some reason FCS stripping was disabled by :
> 
> commit 3e32011d4da6424b3bc65b1e1a047e30ac9882c7
> Author: Benjamin Herrenschmidt <benh@kernel.crashing.org>
> Date:   Mon May 19 09:39:11 2003 -0700
> 
>     [SUNGEM]: Updates from PowerPC people.
>     
>     Support more chips and split out all the complex PHY
>     handling into a seperate file.
> 
> 
> Since this NIC never had CHECKSUM_COMPLETE support (since we have to trim each skb,
> thus were forcing ip_summed to CHECKSUM_NONE) we probably should remove it and be happy.
> 
> Unless you guys find a way to let the NIC strip the FCS, and double check the csum is a real csum ;)
> 
> diff --git a/drivers/net/ethernet/sun/sungem.c b/drivers/net/ethernet/sun/sungem.c
> index 7a16d40a72d13cf1d522e8a3a396c826fe76f9b9..85439308375e95c3854e4a1561697d69ec85399b 100644
> --- a/drivers/net/ethernet/sun/sungem.c
> +++ b/drivers/net/ethernet/sun/sungem.c
> @@ -760,7 +760,6 @@ static int gem_rx(struct gem *gp, int work_to_do)
>         struct net_device *dev = gp->dev;
>         int entry, drops, work_done = 0;
>         u32 done;
> -       __sum16 csum;
>  
>         if (netif_msg_rx_status(gp))
>                 printk(KERN_DEBUG "%s: rx interrupt, done: %d, rx_new: %d\n",
> @@ -855,9 +854,6 @@ static int gem_rx(struct gem *gp, int work_to_do)
>                         skb = copy_skb;
>                 }
>  
> -               csum = (__force __sum16)htons((status & RXDCTRL_TCPCSUM) ^ 0xffff);
> -               skb->csum = csum_unfold(csum);
> -               skb->ip_summed = CHECKSUM_COMPLETE;
>                 skb->protocol = eth_type_trans(skb, gp->dev);
>  
>                 napi_gro_receive(&gp->napi, skb);
> 


If you have time, you also could check if changing the suspect (14 / 2) to ETH_HLEN would help
(and also enabling STRIP_FCS)



diff --git a/drivers/net/ethernet/sun/sungem.c b/drivers/net/ethernet/sun/sungem.c
index 7a16d40a72d13cf1d522e8a3a396c826fe76f9b9..672d6748ab44f0890e92d5ca55d6ff6834c20dc9 100644
--- a/drivers/net/ethernet/sun/sungem.c
+++ b/drivers/net/ethernet/sun/sungem.c
@@ -60,8 +60,7 @@
 #include <linux/sungem_phy.h>
 #include "sungem.h"
 
-/* Stripping FCS is causing problems, disabled for now */
-#undef STRIP_FCS
+#define STRIP_FCS
 
 #define DEFAULT_MSG    (NETIF_MSG_DRV          | \
                         NETIF_MSG_PROBE        | \
@@ -435,7 +434,7 @@ static int gem_rxmac_reset(struct gem *gp)
        writel(desc_dma & 0xffffffff, gp->regs + RXDMA_DBLOW);
        writel(RX_RING_SIZE - 4, gp->regs + RXDMA_KICK);
        val = (RXDMA_CFG_BASE | (RX_OFFSET << 10) |
-              ((14 / 2) << 13) | RXDMA_CFG_FTHRESH_128);
+              (ETH_HLEN << 13) | RXDMA_CFG_FTHRESH_128);
        writel(val, gp->regs + RXDMA_CFG);
        if (readl(gp->regs + GREG_BIFCFG) & GREG_BIFCFG_M66EN)
                writel(((5 & RXDMA_BLANK_IPKTS) |
@@ -857,6 +856,14 @@ static int gem_rx(struct gem *gp, int work_to_do)
 
                csum = (__force __sum16)htons((status & RXDCTRL_TCPCSUM) ^ 0xffff);
                skb->csum = csum_unfold(csum);
+               {
+               __wsum rsum = csum_partial(skb->data + ETH_HLEN, len - ETH_HLEN, 0);
+               if (csum != csum_fold(rsum) && net_ratelimit())
+                       pr_err("sungem wrong csum : %x/%x, len %u bytes\n",
+                               csum, csum_fold(rsum), len);
+                       print_hex_dump(KERN_ERR, "raw data: ", DUMP_PREFIX_OFFSET,
+                                           16, 1, skb->data, len, true);
+               }
                skb->ip_summed = CHECKSUM_COMPLETE;
                skb->protocol = eth_type_trans(skb, gp->dev);
 
@@ -1761,7 +1768,7 @@ static void gem_init_dma(struct gem *gp)
        writel(0, gp->regs + TXDMA_KICK);
 
        val = (RXDMA_CFG_BASE | (RX_OFFSET << 10) |
-              ((14 / 2) << 13) | RXDMA_CFG_FTHRESH_128);
+              (ETH_HLEN << 13) | RXDMA_CFG_FTHRESH_128);
        writel(val, gp->regs + RXDMA_CFG);
 
        writel(desc_dma >> 32, gp->regs + RXDMA_DBHI);
