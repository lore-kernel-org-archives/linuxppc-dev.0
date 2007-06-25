Return-Path: <yur@emcraft.com>
Received: from ocean.emcraft.com (ocean.emcraft.com [213.221.7.182])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 01C53DDEF1
	for <linuxppc-dev@ozlabs.org>; Mon, 25 Jun 2007 19:49:37 +1000 (EST)
From: Yuri Tikhonov <yur@emcraft.com>
To: Segher Boessenkool <segher@kernel.crashing.org>
Subject: Re: [PATCH] ppc: Marvell mv64x60 drivers for ppc platforms fix
Date: Mon, 25 Jun 2007 13:51:55 +0400
References: <200706251247.51518.yur@emcraft.com>
	<c14777659bdfd350085cf8c3ae648b20@kernel.crashing.org>
In-Reply-To: <c14777659bdfd350085cf8c3ae648b20@kernel.crashing.org>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Message-Id: <200706251351.55868.yur@emcraft.com>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


 Hi Segher,

 The mv64x60 driver has no support for compiling as a module. Built-in only. 
And I think there is no much sense in making the driver which provide you 
with such a base stuff as a boot console, ethernet, etc. to be a LKM.

 Regards, Yuri.

On Monday 25 June 2007 13:11, you wrote:
> > +mv64x60-$(CONFIG_PCI)          += mv64x60_pci.o
> > +obj-$(CONFIG_MV64X60)          += $(mv64x60-y) mv64x60_pic.o
> > mv64x60_dev.o
>
> How about
>
> mv64x60-pci-$(CONFIG_PCI)      += mv64x60_pci.o
> mv64x60-objs                   := $(mv64x60-pci-y) mv64x60_pic.o
> mv64x60_dev.o
> obj-$(CONFIG_MV64X60)          += mv64x60.o
>
> so you can build it is a module, too (although other things
> might be preventing that right now)?
>
>
> Segher
