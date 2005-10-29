Return-Path: <paulus@ozlabs.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Message-ID: <17251.2983.358202.164993@cargo.ozlabs.ibm.com>
Date: Sat, 29 Oct 2005 15:41:59 +1000
From: Paul Mackerras <paulus@samba.org>
To: sven.luther@wanadoo.fr
In-Reply-To: <200510290047.j9T0lNNJ030117@shell0.pdx.osdl.net>
References: <200510290047.j9T0lNNJ030117@shell0.pdx.osdl.net>
Cc: akpm@osdl.org, linuxppc-dev@ozlabs.org, luther@debian.org,
	linuxppc64-dev@ozlabs.org
Subject: Re: [patch 38/43] Various powerpc 32bit ppc64 build fixes
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Sven Luther writes:

> +ifeq ($(CONFIG_6xx),y)
>  obj-$(CONFIG_PPC_PMAC)		+= pmac_pic.o pmac_setup.o pmac_time.o \
>  					pmac_feature.o pmac_pci.o pmac_sleep.o \
>  					pmac_low_i2c.o pmac_cache.o
> +else
> +obj-$(CONFIG_PPC_PMAC)		+= pmac_pic.o pmac_setup.o pmac_time.o \
> +					pmac_feature.o pmac_pci.o pmac_sleep.o \
> +					pmac_low_i2c.o
> +endif

This is a bit gross.  How about:

pmac-$(CONFIG_6xx)		:= pmac_cache.o
obj-$(CONFIG_PPC_PMAC)		+= pmac_pic.o pmac_setup.o pmac_time.o \
					pmac_feature.o pmac_pci.o pmac_sleep.o \
					pmac_low_i2c.o $(pmac-y)

Care to send a revised patch?

Paul.
