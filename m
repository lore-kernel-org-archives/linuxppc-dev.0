Return-Path: <galak@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 5CEFBDDE01
	for <linuxppc-dev@ozlabs.org>; Wed,  6 Feb 2008 16:44:38 +1100 (EST)
Message-Id: <B8F9E742-06AC-430B-A176-A17690C8C729@kernel.crashing.org>
From: Kumar Gala <galak@kernel.crashing.org>
To: Kim Phillips <kim.phillips@freescale.com>
In-Reply-To: <20080201180958.7c66bff3.kim.phillips@freescale.com>
Content-Type: text/plain; charset=US-ASCII; format=flowed; delsp=yes
Mime-Version: 1.0 (Apple Message framework v915)
Subject: Re: [PATCH 2/3] powerpc: fsl_soc: fix mpc83xx_spi device registration
Date: Tue, 5 Feb 2008 23:44:06 -0600
References: <20080201180958.7c66bff3.kim.phillips@freescale.com>
Cc: linuxppc-dev <linuxppc-dev@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


On Feb 1, 2008, at 6:09 PM, Kim Phillips wrote:

> calling platform_device_register after platform_device_alloc causes
> this:
>
> kobject (c3841a70): tried to init an initialized object, something  
> is seriously wrong.
> Call Trace:
> [c381fe20] [c0007bb8] show_stack+0x3c/0x194 (unreliable)
> [c381fe50] [c01322a8] kobject_init+0xb8/0xbc
> [c381fe60] [c01591cc] device_initialize+0x30/0x9c
> [c381fe80] [c015ee34] platform_device_register+0x1c/0x34
> [c381fea0] [c02f1fe0] of_fsl_spi_probe+0x21c/0x22c
> [c381ff30] [c02f2044] fsl_spi_init+0x54/0x160
> [c381ff60] [c02f3924] __machine_initcall_mpc832x_rdb_mpc832x_spi_init 
> +0x120/0x138
> [c381ff70] [c02e61b4] kernel_init+0x98/0x284
> [c381fff0] [c000f740] kernel_thread+0x44/0x60
>
> fixed by calling platform_device_add (second half of
> platform_device_register) instead.
>
> Signed-off-by: Kim Phillips <kim.phillips@freescale.com>

applied.

- k
