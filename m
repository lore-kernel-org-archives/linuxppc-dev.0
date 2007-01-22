Return-Path: <paulus@ozlabs.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Message-ID: <17844.36037.859630.386937@cargo.ozlabs.ibm.com>
Date: Mon, 22 Jan 2007 21:07:01 +1100
From: Paul Mackerras <paulus@samba.org>
To: Vitaly Bordug <vbordug@ru.mvista.com>
Subject: Re: [PATCH 3/5] [FS_ENET] OF-related fixup for FEC and SCC MAC's
In-Reply-To: <20070113004213.1224.39653.stgit@localhost.localdomain>
References: <20070113004150.1224.58427.stgit@localhost.localdomain>
	<20070113004213.1224.39653.stgit@localhost.localdomain>
Cc: linuxppc-dev <linuxppc-dev@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Vitaly Bordug writes:

> +#ifndef CONFIG_PPC_MERGE
>  	FW(fecp, ivec, (fep->interrupt / 2) << 29);
> -	
> +#else
> +	FW(fecp, ivec, (irq_map[fep->interrupt].hwirq / 2) << 29);
> +#endif

This would be much cleaner if you use virq_to_hw() and add a
definition of virq_to_hw to the asm-ppc headers, so that you can avoid
putting ifdefs in code.

Also, it seems a bit bogus to be using the hardware interrupt number
directly here.

Is it just 82xx that uses this driver, or do other chips (85xx?) use
it too?

Paul.
