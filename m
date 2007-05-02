Return-Path: <timur@freescale.com>
Received: from de01egw01.freescale.net (de01egw01.freescale.net
	[192.88.165.102])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "de01egw01.freescale.net",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id CA568DDF58
	for <linuxppc-dev@ozlabs.org>; Thu,  3 May 2007 01:54:29 +1000 (EST)
Message-ID: <4638B42B.7040208@freescale.com>
Date: Wed, 02 May 2007 10:54:19 -0500
From: Timur Tabi <timur@freescale.com>
MIME-Version: 1.0
To: Arnd Bergmann <arnd@arndb.de>
Subject: Re: [PATCH 1/6] powerpc: split out CPU specific options into a new
	Kconfig file
References: <20070502114709.074174446@arndb.de>
	<20070502115644.638734471@arndb.de>
In-Reply-To: <20070502115644.638734471@arndb.de>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Cc: linuxppc-dev@ozlabs.org, paulus@samba.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Arnd Bergmann wrote:

> +config CLASSIC32
> +	bool "52xx/6xx/7xx/74xx"
> +	select PPC_FPU
> +	select 6xx
> +	help
> +	  There are four families of PowerPC chips supported.  The more common
> +	  types (601, 603, 604, 740, 750, 7400), the Motorola embedded
> +	  versions (821, 823, 850, 855, 860, 52xx, 82xx, 83xx), the AMCC
> +	  embedded versions (403 and 405) and the high end 64 bit Power
> +	  processors (POWER 3, POWER4, and IBM PPC970 also known as G5).

Is this help text still accurate?  The bool line says "52xx/6xx/7xx/74xx", but you talk 
about many more processors in the help text.  You mention the 83xx, but not the 85xx or 
86xx, nor do you mention Freescale.  Not only that, but the help text implies that 8xx, 
52xx, 82xx, and 83xx are part of the same family, but the bool text implies that 52xx is 
part of a different family.

> +	  This option is the catch-all for 6xx types, including some of the
> +	  embedded versions.  Unless there is see an option for the specific
> +	  chip family you are using, you want this option.

So CLASSIC32 is only for 6xx families, not any of the others?  Then what's the "select 
6xx" for?  Isn't that redundant?

> +	  You do not want this if you are building a kernel for a 64 bit
> +	  IBM RS/6000 or an Apple G5, choose 6xx.

This needs to be reworded, as the English doesn't make sense.

-- 
Timur Tabi
Linux Kernel Developer @ Freescale
