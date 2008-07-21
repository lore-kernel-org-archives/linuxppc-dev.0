Return-Path: <smaclennan@pikatech.com>
Received: from yow.seanm.ca (toronto-hs-216-138-233-67.s-ip.magma.ca
	[216.138.233.67]) by ozlabs.org (Postfix) with SMTP id 604FFDE154
	for <linuxppc-dev@ozlabs.org>; Tue, 22 Jul 2008 03:05:36 +1000 (EST)
Date: Mon, 21 Jul 2008 13:05:36 -0400
From: Sean MacLennan <smaclennan@pikatech.com>
To: "David Miller" <davem@davemloft.net>
Subject: Re: Networkl problems with lastest kernel....
Message-ID: <20080721130536.3ca72f3e@lappy.seanm.ca>
In-Reply-To: <20080721.093110.141511905.davem@davemloft.net>
References: <20080721121829.28faffab@lappy.seanm.ca>
	<20080721.093110.141511905.davem@davemloft.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Mon, 21 Jul 2008 09:31:10 -0700 (PDT)
"David Miller" <davem@davemloft.net> wrote:

> If I had a penny for every driver with broken TX queue handling...
> 
> Please try this patch, thanks:
> 
> diff --git a/drivers/net/ibm_newemac/core.c
> b/drivers/net/ibm_newemac/core.c index 2e720f2..4e01d29 100644
> --- a/drivers/net/ibm_newemac/core.c
> +++ b/drivers/net/ibm_newemac/core.c
> @@ -1157,6 +1157,7 @@ static int emac_open(struct net_device *ndev)
>  	mal_enable_rx_channel(dev->mal, dev->mal_rx_chan);
>  	emac_tx_enable(dev);
>  	emac_rx_enable(dev);
> +	netif_start_queue(dev);
>  	emac_netif_start(dev);

I had to change the dev to an ndev. dev is an struct emac_instance and
ndev is the struct net_device.

It still crashes, but in a different way. I think the problem is deeper
than I thought. The kernel has been OOPSing on a reboot in the
nfs_remount or there abouts for a few days. I thought the problem was
in a debug driver I was using... so I ignored it for now.

But it does it without the debug driver.... so I think I have a
corruption somewhere in the kernel.

But I have attached the new OOPS anyway.

Cheers,
  Sean

------------[ cut here ]------------
Kernel BUG at c01ba66c [verbose debug info unavailable]
Oops: Exception in kernel mode, sig: 5 [#1]
Warp
Modules linked in:
NIP: c01ba66c LR: c015da58 CTR: 00000000
REGS: cf839e90 TRAP: 0700   Not tainted  (2.6.26-pika)
MSR: 00029000 <EE,ME>  CR: 44000042  XER: 0000005f
TASK = cf81e880[5] 'events/0' THREAD: cf838000
GPR00: 00000000 cf839f40 cf81e880 c02fd5a8 cf97856a 00000002 00000002
ffffffff GPR08: c02fd5a8 00000001 00000000 00000001 24000048 00000000
0ffac000 007fff9c GPR16: 00400684 00800000 007fff00 0ffa93c4 00000002
c02e95f8 c02f0000 c02e95f8 GPR24: c02f0000 00000000 c0030000 cf984404
cf9843d0 cf984000 cf984380 cf984000 NIP [c01ba66c]
__netif_schedule+0x28/0x84 LR [c015da58] emac_link_timer+0x704/0x754
Call Trace:
[cf839f40] [c015c9f4] __emac_set_multicast_list+0x5c/0xb0 (unreliable)
[cf839f60] [c015da58] emac_link_timer+0x704/0x754
[cf839f80] [c002db54] run_workqueue+0x9c/0x138
[cf839fa0] [c002df54] worker_thread+0x50/0xb4
[cf839fd0] [c0031424] kthread+0x84/0x8c
[cf839ff0] [c000c518] kernel_thread+0x48/0x64
Instruction dump:
4e800020 4bfffe48 7c0802a6 3d60c030 9421ffe0 396bd5a8 90010024 bfa10014 
7c681b78 7c6b5a78 200b0000 7d605914 <0f0b0000> 39200002 38030024
7d600028 ---[ end trace 3e8d5079b3c922db ]---
