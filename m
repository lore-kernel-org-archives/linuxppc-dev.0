Return-Path: <scottwood@freescale.com>
Received: from az33egw01.freescale.net (az33egw01.freescale.net
	[192.88.158.102])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "az33egw01.freescale.net",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id C4ABFDDF0A
	for <linuxppc-dev@ozlabs.org>; Fri, 27 Jun 2008 05:25:59 +1000 (EST)
Date: Thu, 26 Jun 2008 14:25:32 -0500
From: Scott Wood <scottwood@freescale.com>
To: "Bryan O'Donoghue" <bodonoghue@codehermit.ie>
Subject: Re: [v2] Add support for Analogue & Micro ASP837E board
Message-ID: <20080626192532.GA12692@loki.buserror.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Thu, May 08, 2008 at 10:47:00PM +1000, Bryan O'Donoghue wrote:
> Greetings.
> 
> Attached is a patchset to support the  ASP8347E.

Sorry for the late reply...

> http://www.analogue-micro.com/ASP8347.html. Due to the fact that the board
> shipped with a root filesystem that requires devfs, you have to run a
> different rootfs with all current kernels. I've been using the 8xx root fs
> from the ELDK via NFS, for this.

8xx has a different cache block size (affecting dcbz, etc); I recommend
using a 6xx toolchain. You'll have floating point that way, as well.

> +	dt_fixup_memory(bd.bi_memstart, bd.bi_memsize);
> +	dt_fixup_mac_addresses(bd.bi_enetaddr);
> +	dt_fixup_cpu_clocks(bd.bi_intfreq, bd.bi_busfreq / 16, bd.bi_busfreq);
> +

timebase on 6xx is busfreq / 4, not busfreq / 16.

> +	node = finddevice("/soc/cpm/brg");
> +	if (node) {
> +		printf("BRG clock-frequency <- 0x%x (%dMHz)\r\n",
> +		       bd.bi_busfreq, MHZ(bd.bi_busfreq));
> +		setprop(node, "clock-frequency",  &bd.bi_busfreq, 4);
> +	}
> +
> +}

This doesn't exist at all on 834x, and is named differently on 832x/836x.

-Scott
