Return-Path: <paulus@ozlabs.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Message-ID: <17696.48842.41851.905802@cargo.ozlabs.ibm.com>
Date: Mon, 2 Oct 2006 17:24:58 +1000
From: Paul Mackerras <paulus@samba.org>
To: Kim Phillips <kim.phillips@freescale.com>
Subject: Re: [PATCH 1/15] Update for ucc_geth driver
In-Reply-To: <20060930183311.1d50638c.kim.phillips@freescale.com>
References: <20060930183311.1d50638c.kim.phillips@freescale.com>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Kim Phillips writes:

>  	if (bcsr_regs == NULL)
> -		bcsr_regs = (u8 *) ioremap(BCSR_PHYS_ADDR, BCSR_SIZE);
> +		bcsr_regs = get_bcsr();
>  	bcsr_regs[14] |= 0x40;

Umm, if the BSCR is really so unique to each board, how come this
driver is frobbing a specific bit?  How does the ucc_geth driver know
about the layout of a given board's BCSR?

Also, this patch means that the kernel won't build (assuming you have
the ucc_geth driver in your config) until we get to patch 9/15, where
get_bcsr gets defined.

Lastly, shouldn't this patch be going through Jeff Garzik?

Paul.
