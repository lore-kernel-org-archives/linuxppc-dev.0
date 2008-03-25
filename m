Return-Path: <scottwood@freescale.com>
Received: from de01egw01.freescale.net (de01egw01.freescale.net
	[192.88.165.102])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id ADD54DDF08
	for <linuxppc-dev@ozlabs.org>; Wed, 26 Mar 2008 01:58:50 +1100 (EST)
Date: Tue, 25 Mar 2008 09:58:41 -0500
From: Scott Wood <scottwood@freescale.com>
To: Laurent Pinchart <laurentp@cse-semaphore.com>
Subject: Re: [PATCH] cpm_uart: Allocate DPRAM memory for SMC ports on
	CPM2-based platforms.
Message-ID: <20080325145841.GG13187@ld0162-tx32.am.freescale.net>
References: <200803251224.45408.laurentp@cse-semaphore.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <200803251224.45408.laurentp@cse-semaphore.com>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Tue, Mar 25, 2008 at 12:24:40PM +0100, Laurent Pinchart wrote:
> I was concerned this would break udbg, but udbg doesn't seem to be supported
> on PQ2-based platforms.

Yes, it is (see arch/powerpc/sysdev/cpm_common.c).

> This patch modifies the device tree address usage to reference the SMC
> parameter RAM base pointer instead of a pre-allocated RAM section and
> allocates memory from the CPM dual-port RAM when initialising the SMC port.
> CPM1-based platforms are not affected.

Please maintain backward compatibility with older device trees (by
checking the length of the second reg resource).  At the very least,
update the device trees that are affected.

> +	offset = cpm_dpalloc(PROFF_SMC_SIZE, 64);
> +	out_be16(pram, offset);

Up to this point, if we don't reset the CPM prior to any dpalloc calls
(and if we do, udbg printk breaks), the SMC could be running and
clobbering some other bit of dpram, which could have been allocated to
something else.

After this point, even if you don't reset the CPM, udbg printk is broken
because you moved pram.  The udbg disabling will have to be moved before
this.

-Scott
