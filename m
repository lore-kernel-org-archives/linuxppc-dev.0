Return-Path: <f.fainelli@gmail.com>
Received: from mail-pf0-x242.google.com (mail-pf0-x242.google.com
 [IPv6:2607:f8b0:400e:c00::242])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3sKDSD2KnNzDrJy
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 25 Aug 2016 03:14:20 +1000 (AEST)
Received: by mail-pf0-x242.google.com with SMTP id i6so1562328pfe.0
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 24 Aug 2016 10:14:20 -0700 (PDT)
Subject: Re: [PATCH 3/3] net: fs_enet: make rx_copybreak value configurable
To: Christophe Leroy <christophe.leroy@c-s.fr>,
 Pantelis Antoniou <pantelis.antoniou@gmail.com>,
 Vitaly Bordug <vbordug@ru.mvista.com>, davem@davemloft.net
References: <cover.1472033140.git.christophe.leroy@c-s.fr>
 <0609ecd8fa7ecaa99a386e17f47027349cc3fdda.1472033140.git.christophe.leroy@c-s.fr>
Cc: linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
 netdev@vger.kernel.org
From: Florian Fainelli <f.fainelli@gmail.com>
Message-ID: <d0c26b9f-2a35-5e98-5d1d-06c649e02827@gmail.com>
Date: Wed, 24 Aug 2016 10:14:16 -0700
MIME-Version: 1.0
In-Reply-To: <0609ecd8fa7ecaa99a386e17f47027349cc3fdda.1472033140.git.christophe.leroy@c-s.fr>
Content-Type: text/plain; charset=utf-8
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 08/24/2016 03:36 AM, Christophe Leroy wrote:
> Measurement shows that on a MPC8xx running at 132MHz, the optimal
> limit is 112:
> * 114 bytes packets are processed in 147 TB ticks with higher copybreak
> * 114 bytes packets are processed in 148 TB ticks with lower copybreak
> * 128 bytes packets are processed in 154 TB ticks with higher copybreak
> * 128 bytes packets are processed in 148 TB ticks with lower copybreak
> * 238 bytes packets are processed in 172 TB ticks with higher copybreak
> * 238 bytes packets are processed in 148 TB ticks with lower copybreak
> 
> However it might be different on other processors
> and/or frequencies. So it is useful to make it configurable.
> 
> Signed-off-by: Christophe Leroy <christophe.leroy@c-s.fr>
> ---
>  drivers/net/ethernet/freescale/fs_enet/fs_enet-main.c | 8 +++++---
>  include/linux/fs_enet_pd.h                            | 1 -
>  2 files changed, 5 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/net/ethernet/freescale/fs_enet/fs_enet-main.c b/drivers/net/ethernet/freescale/fs_enet/fs_enet-main.c
> index addcae6..b59bbf8 100644
> --- a/drivers/net/ethernet/freescale/fs_enet/fs_enet-main.c
> +++ b/drivers/net/ethernet/freescale/fs_enet/fs_enet-main.c
> @@ -60,6 +60,10 @@ module_param(fs_enet_debug, int, 0);
>  MODULE_PARM_DESC(fs_enet_debug,
>  		 "Freescale bitmapped debugging message enable value");
>  
> +static int rx_copybreak = 240;
> +module_param(rx_copybreak, int, S_IRUGO | S_IWUSR);
> +MODULE_PARM_DESC(rx_copybreak, "Receive copy threshold");

There is an ethtool tunable knob for copybreak now, which you should
prefer over a module parameter, see
drivers/net/ethernet/cisco/enic/enic_ethtool.c
-- 
Florian
