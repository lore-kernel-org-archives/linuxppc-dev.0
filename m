Return-Path: <scottwood@freescale.com>
Received: from az33egw02.freescale.net (az33egw02.freescale.net
	[192.88.158.103])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "az33egw02.freescale.net",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id ABC22DDF63
	for <linuxppc-dev@ozlabs.org>; Wed,  3 Oct 2007 03:10:35 +1000 (EST)
Message-ID: <47026884.4040909@freescale.com>
Date: Tue, 02 Oct 2007 10:49:24 -0500
From: Scott Wood <scottwood@freescale.com>
MIME-Version: 1.0
To: Timur Tabi <timur@freescale.com>
Subject: Re: [PATCH] cpm: Describe multi-user ram in its own device node.
References: <20070928190616.GB20213@loki.buserror.net>
	<20070929003005.59afc2a0@kernel.crashing.org>
	<08C0C9CB-C958-4B95-81B8-D0677CBA4399@kernel.crashing.org>
	<20070929104917.1585737e@kernel.crashing.org>
	<1B684498-FC47-4F01-A72E-DD27B259613A@kernel.crashing.org>
	<47011BED.8020206@freescale.com>
	<AD243886-65DE-4285-ADD3-1D4C5ABA2E3C@kernel.crashing.org>
	<47025A72.10404@freescale.com>
In-Reply-To: <47025A72.10404@freescale.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Cc: PowerPC dev list <linuxppc-dev@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Timur Tabi wrote:
> The code to process this node is qe_muram_init() in 
> arch/powerpc/sysdev/qe_lib/qe.c.
> 
>     if ((np = of_find_node_by_name(NULL, "data-only")) != NULL) {
>         address = *of_get_address(np, 0, &size, &flags);
>         of_node_put(np);
>         rh_attach_region(&qe_muram_info,
>             (void *)address, (int)size);
>     }
> 
> I think it would be trivial to modify this code to look for a 
> Scott-style muram node.  Heck, it could be modified to look for both, 
> and so we'll maintain compatibility.

I was thinking of just removing the muram code from qe_lib, and having 
it use the code in cpm_common.c.

BTW, searching the entire device tree for a node with the name 
"data-only", regardless of context, seems a bit insane to me.

-Scott
