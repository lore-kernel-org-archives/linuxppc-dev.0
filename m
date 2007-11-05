Return-Path: <scottwood@freescale.com>
Received: from az33egw02.freescale.net (az33egw02.freescale.net
	[192.88.158.103])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "az33egw02.freescale.net",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id 35204DDDFA
	for <linuxppc-embedded@ozlabs.org>;
	Tue,  6 Nov 2007 03:19:47 +1100 (EST)
Message-ID: <472F4298.60005@freescale.com>
Date: Mon, 05 Nov 2007 10:19:36 -0600
From: Scott Wood <scottwood@freescale.com>
MIME-Version: 1.0
To: Jochen Friedrich <jochen@scram.de>
Subject: Re: [PATCH] [POWERPC] Fix fs_enet module build
References: <472CDE02.1020804@scram.de>
In-Reply-To: <472CDE02.1020804@scram.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Cc: netdev <netdev@vger.kernel.org>, linux-kernel@vger.kernel.org,
	Jeff Garzik <jeff@garzik.org>,
	"linuxppc-embedded@ozlabs.org" <linuxppc-embedded@ozlabs.org>
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

Jochen Friedrich wrote:
> diff --git a/drivers/net/fs_enet/Makefile b/drivers/net/fs_enet/Makefile
> index 02d4dc1..2f7563a 100644
> --- a/drivers/net/fs_enet/Makefile
> +++ b/drivers/net/fs_enet/Makefile
> @@ -4,7 +4,15 @@
> 
> obj-$(CONFIG_FS_ENET) += fs_enet.o
> 
> -obj-$(CONFIG_8xx) += mac-fec.o mac-scc.o mii-fec.o
> -obj-$(CONFIG_CPM2) += mac-fcc.o mii-bitbang.o
> +fs_enet-$(CONFIG_8xx) += mac-fec.o mac-scc.o
> +fs_enet-$(CONFIG_CPM2) += mac-fcc.o
> +
> +ifeq ($(CONFIG_8xx),y)
> +        obj-$(CONFIG_FS_ENET) += mii-fec.o
> +endif
> +
> +ifeq ($(CONFIG_CPM2),y)
> +        obj-$(CONFIG_FS_ENET) += mii-bitbang.o
> +endif
> 
> fs_enet-objs := fs_enet-main.o

If we're going to mess with this, we should probably just make 
CONFIG_FS_ENET_SCC, CONFIG_FS_ENET_FCC, and CONFIG_FS_ENET_FEC, and have 
them depend on CONFIG_FS_ENET.

-Scott
