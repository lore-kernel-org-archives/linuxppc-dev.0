Return-Path: <arnd@arndb.de>
Received: from moutng.kundenserver.de (moutng.kundenserver.de
	[212.227.126.177]) by ozlabs.org (Postfix) with ESMTP id 25F8BDE31D
	for <linuxppc-dev@ozlabs.org>; Wed, 20 Aug 2008 23:34:04 +1000 (EST)
From: Arnd Bergmann <arnd@arndb.de>
To: linuxppc-dev@ozlabs.org
Subject: Re: [PATCH 1/9] powerpc/44x: Add PowerPC 44x simple platform support
Date: Wed, 20 Aug 2008 15:33:21 +0200
References: <cover.1219160188.git.jwboyer@linux.vnet.ibm.com>
	<496103659f7b122a8301703b055ef4c6bd3092af.1219160188.git.jwboyer@linux.vnet.ibm.com>
In-Reply-To: <496103659f7b122a8301703b055ef4c6bd3092af.1219160188.git.jwboyer@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Message-Id: <200808201533.22258.arnd@arndb.de>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Tuesday 19 August 2008, Josh Boyer wrote:
> This adds a common board file for almost all of the "simple" PowerPC 44x
> boards that exist today.  This is intended to be a single place to add
> support for boards that do not differ in platform support from most of the
> evaluation boards that are used as reference platforms.  Boards that have
> specific requirements or custom hardware setup should still have their own
> board.c file.

The code looks correct, but since this is going to be example code
that may get copied into other platforms, I would take extra care
for coding style:

> +#include <linux/init.h>
> +#include <linux/of_platform.h>
> +
> +#include <asm/machdep.h>
> +#include <asm/prom.h>
> +#include <asm/udbg.h>
> +#include <asm/time.h>
> +#include <asm/uic.h>
> +#include <asm/pci-bridge.h>
> +#include <asm/ppc4xx.h>

#include lines should be ordered alphabetically in an ideal world.

> +static char *board[] __initdata = {
> +	"amcc,bamboo",
> +	"amcc,cayonlands",
> +	"ibm,ebony",
> +	"amcc,katmai",
> +	"amcc,rainier",
> +	"amcc,sequoia",
> +	"amcc,taishan",
> +	NULL
> +};

You don't need the NULL termination here, since the array is only
used statically and you can use ARRAY_SIZE().

> +static int __init ppc44x_probe(void)
> +{
> +	unsigned long root = of_get_flat_dt_root();
> +	int i = 0;
> +
> +	while (board[i]) {
> +		if (of_flat_dt_is_compatible(root, board[i]))
> +			break;
> +		i++;
> +	}

This looks like a for() loop in disguise, so you can better write
it as

	int i;
	for (i = 0; i < ARRAY_SIZE(board); i++) {
		if (of_flat_dt_is_compatible(root, board[i])) {
			ppc_pci_flags = PPC_PCI_REASSIGN_ALL_RSRC;
			return 1;
		}
	}
	return 0;


	Arnd <><
