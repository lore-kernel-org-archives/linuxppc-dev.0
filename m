Return-Path: <eric.dumazet@gmail.com>
Received: from mail-pg0-x241.google.com (mail-pg0-x241.google.com
 [IPv6:2607:f8b0:400e:c05::241])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 418nNv0ZkMzDrcd
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 19 Jun 2018 09:29:18 +1000 (AEST)
Received: by mail-pg0-x241.google.com with SMTP id a14-v6so8246491pgw.10
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 18 Jun 2018 16:29:18 -0700 (PDT)
Subject: Re: [PATCH] Revert "net: pskb_trim_rcsum() and CHECKSUM_COMPLETE are
 friends"
To: Mathieu Malaterre <malat@debian.org>
Cc: schwab@linux-m68k.org, "David S. Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>, LKML <linux-kernel@vger.kernel.org>,
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
From: Eric Dumazet <eric.dumazet@gmail.com>
Message-ID: <21523399-92ee-f8da-1a3e-0561f62850b7@gmail.com>
Date: Mon, 18 Jun 2018 16:29:12 -0700
MIME-Version: 1.0
In-Reply-To: <CA+7wUszG3Tmq5qT7o7w7ttAU+bzyJfRORL_Qzk4wUG6y2gZUuw@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>



On 06/18/2018 11:45 AM, Mathieu Malaterre wrote:

> 
> Here is what I get on my side
> 
> [   53.628847] sungem: sungem wrong csum : 4e04/f97, len 64 bytes
> [   53.667063] sungem: sungem wrong csum : eea8/6eec, len 149 bytes
> [   58.648952] sungem: sungem wrong csum : 2095/3d06, len 64 bytes
> [   58.669414] sungem: sungem wrong csum : 5245/b50, len 149 bytes
> [   63.674451] sungem: sungem wrong csum : 2d8/5abd, len 149 bytes
> [   68.678233] sungem: sungem wrong csum : b8fc/a498, len 149 bytes
> [   73.685771] sungem: sungem wrong csum : 374/5a21, len 149 bytes
> [   78.689089] sungem: sungem wrong csum : d81/5014, len 149 bytes
> [   83.683261] sungem: sungem wrong csum : 4e04/f97, len 64 bytes
> [   83.690193] sungem: sungem wrong csum : c2f7/9a9d, len 149 bytes
> [   88.692511] sungem: sungem wrong csum : f4d8/68bc, len 149 bytes
> [   93.699915] sungem: sungem wrong csum : 1370/4a25, len 149 bytes
> [   98.703136] sungem: sungem wrong csum : e1b5/7bdf, len 149 bytes
> [  103.704230] sungem: sungem wrong csum : 5321/a74, len 149 bytes
> [  108.688912] sungem: sungem wrong csum : 2095/3d06, len 64 bytes
> [  108.706559] sungem: sungem wrong csum : ddbc/7fd8, len 149 bytes
> [  113.713189] sungem: sungem wrong csum : 5a65/330, len 149 bytes
> [  113.891697] sungem: sungem wrong csum : 4e04/f97, len 64 bytes
> [  118.717151] sungem: sungem wrong csum : f7c8/65cc, len 149 bytes
> [  123.722680] sungem: sungem wrong csum : 3d7a/201b, len 149 bytes
> [  128.726524] sungem: sungem wrong csum : c8fd/9497, len 149 bytes
> [  133.732045] sungem: sungem wrong csum : de0d/7f87, len 149 bytes
> [  135.529163] sungem: sungem wrong csum : 3089/b6dd, len 96 bytes
> [  135.529208] eth0: hw csum failure
> [  135.529220] CPU: 0 PID: 0 Comm: swapper Not tainted 4.17.0+ #7
> [  135.529226] Call Trace:
> [  135.529243] [dffedbe0] [c069ddac]
> __skb_checksum_complete+0xf0/0x108 (unreliable)

Thanks, then I guess next step would be to dump the content of the frames
having a wrong checksum, hoping we find an easy way to discard the CHECKSUM_COMPLETE
in a selective way.

Otherwise, we will need to remove CHECKSUM_COMPLETE setting in this driver.

diff --git a/drivers/net/ethernet/sun/sungem.c b/drivers/net/ethernet/sun/sungem.c
index 7a16d40a72d13cf1d522e8a3a396c826fe76f9b9..77a761f95be788bb86c8d917f613c9084818f826 100644
--- a/drivers/net/ethernet/sun/sungem.c
+++ b/drivers/net/ethernet/sun/sungem.c
@@ -857,6 +857,14 @@ static int gem_rx(struct gem *gp, int work_to_do)
 
                csum = (__force __sum16)htons((status & RXDCTRL_TCPCSUM) ^ 0xffff);
                skb->csum = csum_unfold(csum);
+               {
+               __wsum rsum = csum_partial(skb->data + ETH_HLEN, len - ETH_HLEN, 0);
+               if (csum != csum_fold(rsum) && net_ratelimit())
+                       pr_err("sungem wrong csum : %04x/%04x, len %u bytes\n",
+                               csum, csum_fold(rsum), len);
+                       print_hex_dump(KERN_ERR, "raw data: ", DUMP_PREFIX_OFFSET,
+                                           16, 1, skb->data, len, true);
+               }
                skb->ip_summed = CHECKSUM_COMPLETE;
                skb->protocol = eth_type_trans(skb, gp->dev);
 
