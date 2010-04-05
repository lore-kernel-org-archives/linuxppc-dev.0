Return-Path: <eric.dumazet@gmail.com>
Received: from mail-bw0-f217.google.com (mail-bw0-f217.google.com
	[209.85.218.217]) by ozlabs.org (Postfix) with ESMTP id 9B465B7D15
	for <linuxppc-dev@ozlabs.org>; Tue,  6 Apr 2010 07:29:59 +1000 (EST)
Received: by bwz9 with SMTP id 9so3028023bwz.9
	for <linuxppc-dev@ozlabs.org>; Mon, 05 Apr 2010 14:29:57 -0700 (PDT)
Subject: Re: [PATCH] [V3] Add non-Virtex5 support for LL TEMAC driver
From: Eric Dumazet <eric.dumazet@gmail.com>
To: John Linn <john.linn@xilinx.com>
In-Reply-To: <d9134316-bd07-46a8-91d4-c30f27baeb60@SG2EHSMHS007.ehs.local>
References: <d9134316-bd07-46a8-91d4-c30f27baeb60@SG2EHSMHS007.ehs.local>
Content-Type: text/plain; charset="UTF-8"
Date: Mon, 05 Apr 2010 23:29:53 +0200
Message-ID: <1270502993.9013.36.camel@edumazet-laptop>
Mime-Version: 1.0
Cc: linuxppc-dev@ozlabs.org, netdev@vger.kernel.org,
	John Tyner <jtyner@cs.ucr.edu>, michal.simek@petalogix.com,
	john.williams@petalogix.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Le lundi 05 avril 2010 à 15:11 -0600, John Linn a écrit :
> This patch adds support for using the LL TEMAC Ethernet driver on
> non-Virtex 5 platforms by adding support for accessing the Soft DMA
> registers as if they were memory mapped instead of solely through the
> DCR's (available on the Virtex 5).
> 
> The patch also updates the driver so that it runs on the MicroBlaze.
> The changes were tested on the PowerPC 440, PowerPC 405, and the
> MicroBlaze platforms.
> 
> Signed-off-by: John Tyner <jtyner@cs.ucr.edu>
> Signed-off-by: John Linn <john.linn@xilinx.com>
> 
> ---

> +/* Align the IP data in the packet on word boundaries as MicroBlaze
> + * needs it.
> + */
> +
>  #define XTE_ALIGN       32
> -#define BUFFER_ALIGN(adr) ((XTE_ALIGN - ((u32) adr)) % XTE_ALIGN)
> +#define BUFFER_ALIGN(adr) ((34 - ((u32) adr)) % XTE_ALIGN)
>  

Very interesting way of doing this, but why such convoluted thing ?

Because of the % 32, this is equivalent to :

#define BUFFER_ALIGN(adr) ((2 - ((u32) adr)) % XTE_ALIGN)

But wait, dont we recognise the magic constant NET_IP_ALIGN ?

So, I ask, cant you use netdev_alloc_skb_ip_align() in this driver ?
