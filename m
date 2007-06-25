Return-Path: <segher@kernel.crashing.org>
Received: from mail-in-05.arcor-online.net (mail-in-05.arcor-online.net
	[151.189.21.45])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mx.arcor.de",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id 8FE64DDEE8
	for <linuxppc-dev@ozlabs.org>; Mon, 25 Jun 2007 19:13:22 +1000 (EST)
In-Reply-To: <200706251247.51518.yur@emcraft.com>
References: <200706251247.51518.yur@emcraft.com>
Mime-Version: 1.0 (Apple Message framework v623)
Content-Type: text/plain; charset=US-ASCII; format=flowed
Message-Id: <c14777659bdfd350085cf8c3ae648b20@kernel.crashing.org>
From: Segher Boessenkool <segher@kernel.crashing.org>
Subject: Re: [PATCH] ppc: Marvell mv64x60 drivers for ppc platforms fix
Date: Mon, 25 Jun 2007 11:11:51 +0200
To: Yuri Tikhonov <yur@emcraft.com>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

> +mv64x60-$(CONFIG_PCI)          += mv64x60_pci.o
> +obj-$(CONFIG_MV64X60)          += $(mv64x60-y) mv64x60_pic.o 
> mv64x60_dev.o

How about

mv64x60-pci-$(CONFIG_PCI)      += mv64x60_pci.o
mv64x60-objs                   := $(mv64x60-pci-y) mv64x60_pic.o 
mv64x60_dev.o
obj-$(CONFIG_MV64X60)          += mv64x60.o

so you can build it is a module, too (although other things
might be preventing that right now)?


Segher
