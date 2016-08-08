Return-Path: <davem@davemloft.net>
Received: from mail-pf0-x244.google.com (mail-pf0-x244.google.com
 [IPv6:2607:f8b0:400e:c00::244])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3s7T4w2ZFYzDqd7
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  9 Aug 2016 06:08:47 +1000 (AEST)
Received: by mail-pf0-x244.google.com with SMTP id y134so25555902pfg.3
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 08 Aug 2016 13:08:47 -0700 (PDT)
Date: Mon, 08 Aug 2016 13:08:40 -0700 (PDT)
Message-Id: <20160808.130840.276329308290273424.davem@davemloft.net>
To: paul.gortmaker@windriver.com
Cc: netdev@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
Subject: Re: [PATCH -net] net/ethernet: tundra: fix dump_eth_one warning in
 tsi108_eth
From: David Miller <davem@davemloft.net>
In-Reply-To: <20160804200758.29835-1-paul.gortmaker@windriver.com>
References: <20160804200758.29835-1-paul.gortmaker@windriver.com>
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

From: Paul Gortmaker <paul.gortmaker@windriver.com>
Date: Thu, 4 Aug 2016 16:07:58 -0400

> The call site for this function appears as:
> 
>   #ifdef DEBUG
>         data->msg_enable = DEBUG;
>         dump_eth_one(dev);
>   #endif
> 
> ...leading to the following warning for !DEBUG builds:
> 
> drivers/net/ethernet/tundra/tsi108_eth.c:169:13: warning: 'dump_eth_one' defined but not used [-Wunused-function]
>  static void dump_eth_one(struct net_device *dev)
>              ^
> 
> ...when using the arch/powerpc/configs/mpc7448_hpc2_defconfig
> 
> Put the function definition under the same #ifdef as the call site
> to avoid the warning.
> 
> Cc: "David S. Miller" <davem@davemloft.net>
> Cc: netdev@vger.kernel.org
> Cc: linuxppc-dev@lists.ozlabs.org
> Signed-off-by: Paul Gortmaker <paul.gortmaker@windriver.com>

Applied, thanks.
