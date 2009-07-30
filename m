Return-Path: <galak@kernel.crashing.org>
Received: from ozlabs.org (ozlabs.org [203.10.76.45])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mx.ozlabs.org",
	Issuer "CA Cert Signing Authority" (verified OK))
	by bilbo.ozlabs.org (Postfix) with ESMTPS id 3EAFEB7B8C
	for <linuxppc-dev@lists.ozlabs.org>;
	Thu, 30 Jul 2009 14:19:05 +1000 (EST)
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 8D5BCDDD1B
	for <linuxppc-dev@ozlabs.org>; Thu, 30 Jul 2009 14:19:04 +1000 (EST)
Message-Id: <14071D6F-05F7-41A4-AA6A-797D6DFE45CF@kernel.crashing.org>
From: Kumar Gala <galak@kernel.crashing.org>
To: Anton Vorontsov <avorontsov@ru.mvista.com>
In-Reply-To: <20090720213643.GA4209@oksana.dev.rtsoft.ru>
Content-Type: text/plain; charset=US-ASCII; format=flowed; delsp=yes
Mime-Version: 1.0 (Apple Message framework v935.3)
Subject: Re: [PATCH] powerpc/83xx: Fix PCI IO base address on MPC837xE-RDB
	boards
Date: Wed, 29 Jul 2009 23:18:58 -0500
References: <20090720213643.GA4209@oksana.dev.rtsoft.ru>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


On Jul 20, 2009, at 4:36 PM, Anton Vorontsov wrote:

> U-Boot maps PCI IO at 0xe0300000, while current dts files specify
> 0xe2000000. This leads to the following oops with  
> CONFIG_8139TOO_PIO=y.
>
> 8139too Fast Ethernet driver 0.9.28
> Machine check in kernel mode.
> Caused by (from SRR1=41000): Transfer error ack signal
> Oops: Machine check, sig: 7 [#1]
> MPC837x RDB
> [...]
> NIP [00000900] 0x900
> LR [c0439df8] rtl8139_init_board+0x238/0x524
> Call Trace:
> [cf831d90] [c0439dcc] rtl8139_init_board+0x20c/0x524 (unreliable)
> [cf831de0] [c043a15c] rtl8139_init_one+0x78/0x65c
> [cf831e40] [c0235250] pci_call_probe+0x20/0x30
> [...]
>
> This patch fixes the issue by specifying the correct PCI IO base
> address.
>
> Signed-off-by: Anton Vorontsov <avorontsov@ru.mvista.com>
> ---
> arch/powerpc/boot/dts/mpc8377_rdb.dts |    2 +-
> arch/powerpc/boot/dts/mpc8378_rdb.dts |    2 +-
> arch/powerpc/boot/dts/mpc8379_rdb.dts |    2 +-
> 3 files changed, 3 insertions(+), 3 deletions(-)

applied to merge

- k
