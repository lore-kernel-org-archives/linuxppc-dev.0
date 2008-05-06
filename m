Return-Path: <jgarzik@pobox.com>
Received: from mail.dvmed.net (srv5.dvmed.net [207.36.208.214])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id F4229DDF1E
	for <linuxppc-dev@ozlabs.org>; Wed,  7 May 2008 02:18:47 +1000 (EST)
Message-ID: <482084DE.9030309@pobox.com>
Date: Tue, 06 May 2008 12:18:38 -0400
From: Jeff Garzik <jgarzik@pobox.com>
MIME-Version: 1.0
To: Anton Vorontsov <avorontsov@ru.mvista.com>
Subject: Re: [PATCH 1/3] [NET] uli526x: initialize the hardware prior to
	requesting interrupts
References: <20080429155313.GA28166@polina.dev.rtsoft.ru>
In-Reply-To: <20080429155313.GA28166@polina.dev.rtsoft.ru>
Content-Type: text/plain; charset=UTF-8; format=flowed
Cc: netdev@vger.kernel.org, linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Anton Vorontsov wrote:
> The firmware on MPC8610HPCD boards enables ULI ethernet and leaves it
> in some funky state before booting Linux. For drivers, it's always good
> idea to (re)initialize the hardware prior to requesting interrupts.
> 
> This patch fixes the following oops:
> 
> Oops: Kernel access of bad area, sig: 11 [#1]
> MPC86xx HPCD
> NIP: c0172820 LR: c017287c CTR: 00000000
> [...]
> NIP [c0172820] allocate_rx_buffer+0x2c/0xb0
> LR [c017287c] allocate_rx_buffer+0x88/0xb0
> Call Trace:
> [df82bdc0] [c017287c] allocate_rx_buffer+0x88/0xb0 (unreliable)
> [df82bde0] [c0173000] uli526x_interrupt+0xe4/0x49c
> [df82be20] [c0045418] request_irq+0xf0/0x114
> [df82be50] [c01737b0] uli526x_open+0x48/0x160
> [df82be70] [c0201184] dev_open+0xb0/0xe8
> [df82be80] [c0200104] dev_change_flags+0x90/0x1bc
> [df82bea0] [c035fab0] ip_auto_config+0x214/0xef4
> [df82bf60] [c03421c8] kernel_init+0xc4/0x2ac
> [df82bff0] [c0010834] kernel_thread+0x44/0x60
> Instruction dump:
> 4e800020 9421ffe0 7c0802a6 bfa10014 7c7e1b78 90010024 80030060 83e30054
> 2b80002f 419d0078 3fa0c039 48000058 <907f0010> 80630088 2f830000 419e0014
> 
> Signed-off-by: Anton Vorontsov <avorontsov@ru.mvista.com>
> ---
>  drivers/net/tulip/uli526x.c |    8 ++++----
>  1 files changed, 4 insertions(+), 4 deletions(-)

applied 1-2
