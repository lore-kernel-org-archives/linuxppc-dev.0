Return-Path: <galak@kernel.crashing.org>
Received: from nommos.sslcatacombnetworking.com
	(nommos.sslcatacombnetworking.com [67.18.224.114])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 2EBCBDDF2C
	for <linuxppc-dev@ozlabs.org>; Tue, 13 Mar 2007 08:09:00 +1100 (EST)
In-Reply-To: <20070312204204.GQ28545@ld0162-tx32.am.freescale.net>
References: <20070312204204.GQ28545@ld0162-tx32.am.freescale.net>
Mime-Version: 1.0 (Apple Message framework v752.2)
Content-Type: text/plain; charset=US-ASCII; delsp=yes; format=flowed
Message-Id: <4CB3B3D5-6D4A-4D67-92FC-3B8C38850326@kernel.crashing.org>
From: Kumar Gala <galak@kernel.crashing.org>
Subject: Re: [PATCH 17/19] bootwrapper: compatibility layer for old U-Boots
	(a.k.a. cuImage, cuboot)
Date: Mon, 12 Mar 2007 16:07:57 -0500
To: Scott Wood <scottwood@freescale.com>
Cc: linuxppc-dev@ozlabs.org, paulus@samba.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


On Mar 12, 2007, at 3:42 PM, Scott Wood wrote:

> Add a bootwrapper platform (cuboot) that takes a bd_t from a legacy
> U-Boot, and inserts data from it into a device tree which has been
> compiled into the kernel.  This should help ease the transition to
> arch/powerpc in cases where U-Boot has not yet been updated to pass a
> device tree, or where upgrading firmware isn't practical.
>
> The device trees currently in the kernel tree must have
> /chosen/linux,stdout-path added to work with cuboot.

Why is linux,stdout-path needed by cuboot?

> The kernel command line, mac addresses, and various clocks will be  
> filled
> in based on the bd_t.
>
> Signed-off-by: Scott Wood <scottwood@freescale.com>
> ---
>  arch/powerpc/Kconfig                      |   16 ++++
>  arch/powerpc/Makefile                     |    2 +-
>  arch/powerpc/boot/.gitignore              |    3 +
>  arch/powerpc/boot/Makefile                |   20 ++++-
>  arch/powerpc/boot/cuboot-83xx.c           |    4 +
>  arch/powerpc/boot/cuboot-85xx.c           |    4 +
>  arch/powerpc/boot/cuboot-86xx.c           |    4 +
>  arch/powerpc/boot/cuboot.c                |  137 ++++++++++++++++++ 
> +++++++++++
>  arch/powerpc/boot/ppcboot.h               |  103 ++++++++++++++++++ 
> ++++
>  arch/powerpc/boot/wrapper                 |   46 ++++++++--
>  arch/powerpc/platforms/83xx/mpc834x_mds.c |    5 +-

the whitespace fixup in mpc834x_mds.c shouldn't be part of this.

- k
