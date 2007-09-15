Return-Path: <segher@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 476BDDDE07
	for <linuxppc-dev@ozlabs.org>; Sat, 15 Sep 2007 10:50:38 +1000 (EST)
In-Reply-To: <200709150221.57825.arnd@arndb.de>
References: <200709150221.57825.arnd@arndb.de>
Mime-Version: 1.0 (Apple Message framework v623)
Content-Type: text/plain; charset=US-ASCII; format=flowed
Message-Id: <7268aef0e0f5d31dc4d07d583406a6af@kernel.crashing.org>
From: Segher Boessenkool <segher@kernel.crashing.org>
Subject: Re: [PATCH] add Kconfig option for optimizing for cell
Date: Sat, 15 Sep 2007 02:50:23 +0200
To: Arnd Bergmann <arnd@arndb.de>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

> +config TUNE_CELL
> +	bool "Optimize for Cell Broadband Engine"
> +	depends on PPC64
> +	help
> +	  Cause the compiler to optimize for the PPE of the Cell Broadband
> +	  Engine. This will make the code run considerably faster on Cell
> +	  but somewhat slower on other machines. This option only changes
> +	  the scheduling of instructions, not the selection of instructions
> +	  itself,

It _does_ change instruction selection, which is the main factor
in the slowdown on other machines (and a big part of the speedup
on Cell, too).  It doesn't change which insns the compiler is
allowed to use though, which is probably what you wanted to say?


Segher
