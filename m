Return-Path: <olof@lixom.net>
Received: from mail.lixom.net (lixom.net [66.141.50.11])
	by ozlabs.org (Postfix) with ESMTP id 86C38DDE0C
	for <linuxppc-dev@ozlabs.org>; Sat,  8 Dec 2007 08:23:48 +1100 (EST)
Date: Fri, 7 Dec 2007 15:28:17 -0600
From: Olof Johansson <olof@lixom.net>
To: Balbir Singh <balbir@linux.vnet.ibm.com>
Subject: Re: [PATCH] Fake NUMA emulation for PowerPC
Message-ID: <20071207212817.GA391@lixom.net>
References: <20071207211425.10223.91240.sendpatchset@balbir-laptop>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20071207211425.10223.91240.sendpatchset@balbir-laptop>
Cc: linuxppc-dev@ozlabs.org, LKML <linux-kernel@vger.kernel.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Hi,

On Sat, Dec 08, 2007 at 02:44:25AM +0530, Balbir Singh wrote:

> Comments are as always welcome!

Care to explain what this is useful for? (Not saying it's a stupid idea,
just wondering what the reason for doing it is).

> diff -puN arch/powerpc/mm/numa.c~ppc-fake-numa-easy arch/powerpc/mm/numa.c
> --- linux-2.6.24-rc4-mm1/arch/powerpc/mm/numa.c~ppc-fake-numa-easy	2007-12-07 21:25:55.000000000 +0530
> +++ linux-2.6.24-rc4-mm1-balbir/arch/powerpc/mm/numa.c	2007-12-08 02:36:02.000000000 +0530
> @@ -24,6 +24,8 @@
>  
>  static int numa_enabled = 1;
>  
> +char *cmdline __initdata;
> +

Looks like this should be static.

> @@ -702,6 +744,9 @@ static int __init early_numa(char *p)
>  	if (strstr(p, "debug"))
>  		numa_debug = 1;
>  
> +	if (strstr(p, "fake="))
> +		cmdline = p + 5;	/* 5 is faster than strlen("fake=") */

This doesn't look right.

You check if it contains fake=, not if it starts with it. So if someone
did: "numa=foo,fake=bar", or even "numa=debug,fake=", things wouldn't
work right.


-Olof
