Return-Path: <galak@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id E0B16DDEFF
	for <linuxppc-dev@ozlabs.org>; Wed, 17 Dec 2008 05:20:19 +1100 (EST)
Message-Id: <6C14C18C-D709-4E69-8B47-C8A13380D713@kernel.crashing.org>
From: Kumar Gala <galak@kernel.crashing.org>
To: Anton Vorontsov <avorontsov@ru.mvista.com>
In-Reply-To: <20081205165504.GA30966@oksana.dev.rtsoft.ru>
Content-Type: text/plain; charset=US-ASCII; format=flowed; delsp=yes
Mime-Version: 1.0 (Apple Message framework v929.2)
Subject: Re: [PATCH] powerpc/83xx: Fix few build errors with
	CONFIG_QUICC_ENGINE=n
Date: Tue, 16 Dec 2008 12:18:07 -0600
References: <20081205165504.GA30966@oksana.dev.rtsoft.ru>
Cc: linuxppc-dev@ozlabs.org, Timur Tabi <timur@freescale.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


On Dec 5, 2008, at 10:55 AM, Anton Vorontsov wrote:

> Some 83xx boards were not ready for the optional QUICC Engine support.
>
> This patch fixes following build errors:
>
> arch/powerpc/platforms/built-in.o: In function `flush_disable_caches':
> (.text+0xb308): undefined reference to `par_io_data_set'
> arch/powerpc/platforms/built-in.o: In function `flush_disable_caches':
> (.text+0xb334): undefined reference to `par_io_data_set'
> arch/powerpc/platforms/built-in.o: In function `flush_disable_caches':
> (.text+0xb408): undefined reference to `qe_ic_get_high_irq'
> arch/powerpc/platforms/built-in.o: In function `flush_disable_caches':
> (.text+0xb478): undefined reference to `qe_ic_get_low_irq'
> arch/powerpc/platforms/built-in.o: In function `mpc832x_spi_init':
> mpc832x_rdb.c:(.init.text+0x574c): undefined reference to  
> `par_io_config_pin'
> mpc832x_rdb.c:(.init.text+0x5768): undefined reference to  
> `par_io_config_pin'
> mpc832x_rdb.c:(.init.text+0x5784): undefined reference to  
> `par_io_config_pin'
> mpc832x_rdb.c:(.init.text+0x57a0): undefined reference to  
> `par_io_config_pin'
> mpc832x_rdb.c:(.init.text+0x57bc): undefined reference to  
> `par_io_config_pin'
> arch/powerpc/platforms/built-in.o:mpc832x_rdb.c:(.init.text+0x57d8):  
> more undefined references to `par_io_config_pin' follow
> arch/powerpc/platforms/built-in.o: In function `mpc836x_rdk_init_IRQ':
> mpc836x_rdk.c:(.init.text+0x5e84): undefined reference to `qe_ic_init'
> arch/powerpc/platforms/built-in.o: In function  
> `mpc836x_rdk_setup_arch':
> mpc836x_rdk.c:(.init.text+0x5f10): undefined reference to `qe_reset'
> make: *** [.tmp_vmlinux1] Error 1
>
> Signed-off-by: Anton Vorontsov <avorontsov@ru.mvista.com>
> ---
>
> This patch implements traditional way of !QE case handling.
> Alternative version is coming (w/o ifdefs in the board files).
>
> p.s. I don't know if it is 2.6.28 material...

what's the state of this patch vs the alternate version?

- k
