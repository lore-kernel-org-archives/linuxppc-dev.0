Return-Path: <davem@davemloft.net>
Received: from shards.monkeyblade.net (shards.monkeyblade.net
 [IPv6:2001:4f8:3:36:211:85ff:fe63:a549])
 by lists.ozlabs.org (Postfix) with ESMTP id 7221B1A001E
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 23 Jun 2015 23:27:41 +1000 (AEST)
Date: Tue, 23 Jun 2015 06:39:26 -0700 (PDT)
Message-Id: <20150623.063926.723221732046739833.davem@davemloft.net>
To: alex.popov@linux.com
Cc: pantelis.antoniou@gmail.com, vbordug@ru.mvista.com,
 christophe.leroy@c-s.fr, linuxppc-dev@lists.ozlabs.org,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 1/1] net: fs_enet: Fix NETIF_F_SG feature for
 Freescale MPC5121
From: David Miller <davem@davemloft.net>
In-Reply-To: <1434839566-31704-1-git-send-email-alex.popov@linux.com>
References: <1434839566-31704-1-git-send-email-alex.popov@linux.com>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

From: Alexander Popov <alex.popov@linux.com>
Date: Sun, 21 Jun 2015 01:32:46 +0300

> Commit 4fc9b87bae25 ("net: fs_enet: Implement NETIF_F_SG feature")
> brings a trouble to Freescale MPC512x: a kernel oops happens
> during sending non-linear sk_buff with .data not aligned by 4.
> 
> Log quotation:
 ...
> The reason:
> 
> MPC5121 FEC requires 4-byte alignment for TX data buffer and calls
> tx_skb_align_workaround() for copying sk_buff with not aligned .data to a new
> sk_buff with aligned one. But tx_skb_align_workaround() uses
> skb_copy_from_linear_data() which doesn't work for non-linear sk_buff:
> a new sk_buff has non-zero nr_frags and zero .data_len.
> 
> So improve the condition of calling tx_skb_align_workaround() and use
> skb_linearize() in it.
> 
> Signed-off-by: Alexander Popov <alex.popov@linux.com>

Applied, thanks.
