Return-Path: <b07421@freescale.com>
Received: from de01egw02.freescale.net (de01egw02.freescale.net
	[192.88.165.103])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "de01egw02.freescale.net",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id 6BCAFDDEED
	for <linuxppc-dev@ozlabs.org>; Wed, 16 Jan 2008 03:41:05 +1100 (EST)
Date: Tue, 15 Jan 2008 10:40:53 -0600
From: Scott Wood <scottwood@freescale.com>
To: Kumar Gala <galak@kernel.crashing.org>
Subject: Re: [PATCH] fsl_soc: Fix get_immrbase() to use ranges,
	rather than reg.
Message-ID: <20080115164053.GA10812@ld0162-tx32.am.freescale.net>
References: <20080114162935.GA27862@ld0162-tx32.am.freescale.net>
	<BFCCA52A-85B7-4DD5-ACF4-2F3E65CFD7FD@kernel.crashing.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <BFCCA52A-85B7-4DD5-ACF4-2F3E65CFD7FD@kernel.crashing.org>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Mon, Jan 14, 2008 at 08:37:27PM -0600, Kumar Gala wrote:
> >diff --git a/arch/powerpc/sysdev/fsl_soc.c b/arch/powerpc/sysdev/ 
> >fsl_soc.c
> >index 3ace747..7502e03 100644
> >--- a/arch/powerpc/sysdev/fsl_soc.c
> >+++ b/arch/powerpc/sysdev/fsl_soc.c
> >@@ -54,10 +54,18 @@ phys_addr_t get_immrbase(void)
> >	soc = of_find_node_by_type(NULL, "soc");
> >	if (soc) {
> >		int size;
> >-		const void *prop = of_get_property(soc, "reg", &size);
> >+		u32 naddr;
> >+		const u32 *prop = of_get_property(soc, "#address-cells", 
> >&size);
> >+
> >+		if (prop && size == 4)
> >+			naddr = *prop;
> >+		else
> >+			naddr = 2;
> 
> Why default to two?

Because that's what the OF spec says the default is?

> >+		prop = of_get_property(soc, "ranges", &size);
> >+		if (prop && size == 12)
> >+			immrbase = of_translate_address(soc, prop + naddr);

Grr, I thought I removed the size == 12 check...

> >-		if (prop)
> >-			immrbase = of_translate_address(soc, prop);
> 
> why not make your code an else case if we don't have reg?

Why?

> or something like, than we don't have to worry about adjust anything,  
> and if you don't have any children its kinda a pointless device tree :)

It's not pointless, it's just incomplete.

> 	if (soc) {
> 		struct device_node *child = of_get_next_child(soc, NULL);
> 		if (child) {
> 			const void *prop = of_get_property(soc, "ranges", 
> 			NULL);
> 			if (prop)
> 				immrbase = of_translate_address(child, prop);
> 			of_node_put(child);
> 		}
> 		of_node_put(soc);
> 	}

Why go out of our way to fail on a childless soc node?

-Scott
