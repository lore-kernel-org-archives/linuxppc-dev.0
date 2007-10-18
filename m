Return-Path: <sshtylyov@ru.mvista.com>
Received: from imap.sh.mvista.com (unknown [63.81.120.155])
	by ozlabs.org (Postfix) with ESMTP id 9E1D1DDF10
	for <linuxppc-dev@ozlabs.org>; Fri, 19 Oct 2007 00:45:37 +1000 (EST)
Message-ID: <4717719C.703@ru.mvista.com>
Date: Thu, 18 Oct 2007 18:45:48 +0400
From: Sergei Shtylyov <sshtylyov@ru.mvista.com>
MIME-Version: 1.0
To: Sergei Shtylyov <sshtylyov@ru.mvista.com>
Subject: Re: [PATCH 2.6.21-rt2] PowerPC: decrementer clockevent driver
References: <200705172142.26739.sshtylyov@ru.mvista.com>
In-Reply-To: <200705172142.26739.sshtylyov@ru.mvista.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Cc: linuxppc-dev@ozlabs.org, tglx@linutronix.de, mingo@elte.hu,
	linux-kernel@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Sergei Shtylyov wrote:
> Add PowerPC decrementer clock event driver.

> Every effort has been made to support the different implementations of the
> decrementer: the classic one (with 970 series variation), 40x and Book E
> specific ones.

> I had to make CONFIG_GENERIC_CLOCKEVENTS option selectable for the
> compatibility reasons -- this option is not compatible with the PPC64
> deterministic time accounting.

> Thanks to Daniel Walker and Thomas Gleixner for the suggestions they made...

> Signed-off-by: Sergei Shtylyov <sshtylyov@ru.mvista.com>

> Index: linux-2.6/arch/powerpc/Kconfig
> ===================================================================
> --- linux-2.6.orig/arch/powerpc/Kconfig
> +++ linux-2.6/arch/powerpc/Kconfig
> @@ -317,7 +317,7 @@ config PPC_STD_MMU_32
>  
>  config VIRT_CPU_ACCOUNTING
>  	bool "Deterministic task and CPU time accounting"
> -	depends on PPC64
> +	depends on PPC64 && !GENERIC_CLOCKEVENTS
>  	default y
>  	help
>  	  Select this option to enable more accurate task and CPU time

    Thomas, that part of the ppc-clockevents.patch (part of the -rt patch) is 
now broken, it makes CONFIG_MAX_ZONEORDER dependent on 
!CONFIG_GENERIC_CLOCKEVENTS -- this is probably due to patch's fuzzy logic.
Do I need to send a patch to fix this?

WBR, Sergei
