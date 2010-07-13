Return-Path: <B04825@freescale.com>
Received: from VA3EHSOBE010.bigfish.com (va3ehsobe006.messaging.microsoft.com
	[216.32.180.16]) by ozlabs.org (Postfix) with ESMTP id 78D1BB6EF0
	for <linuxppc-dev@lists.ozlabs.org>;
	Wed, 14 Jul 2010 05:10:56 +1000 (EST)
Received: from mail70-va3 (localhost.localdomain [127.0.0.1])	by
	mail70-va3-R.bigfish.com (Postfix) with ESMTP id 3E44B83039D	for
	<linuxppc-dev@lists.ozlabs.org>; Tue, 13 Jul 2010 18:55:31 +0000 (UTC)
Received: from VA3EHSMHS006.bigfish.com (unknown [10.7.14.250])	by
	mail70-va3.bigfish.com (Postfix) with ESMTP id 224B4DE804C	for
	<linuxppc-dev@lists.ozlabs.org>; Tue, 13 Jul 2010 18:55:31 +0000 (UTC)
Received: from az33smr01.freescale.net (az33smr01.freescale.net
	[10.64.34.199])	by az33egw02.freescale.net (8.14.3/8.14.3) with ESMTP
	id o6DItPOF013014	for <linuxppc-dev@lists.ozlabs.org>;
	Tue, 13 Jul 2010 11:55:25 -0700 (MST)
Received: from az33exm25.fsl.freescale.net (az33exm25.am.freescale.net
	[10.64.32.16])	by az33smr01.freescale.net (8.13.1/8.13.0) with ESMTP id
	o6DJ67to023658	for <linuxppc-dev@lists.ozlabs.org>;
	Tue, 13 Jul 2010 14:06:07 -0500 (CDT)
Message-ID: <4C3CB69D.4060400@freescale.com>
Date: Tue, 13 Jul 2010 13:55:25 -0500
From: Timur Tabi <timur@freescale.com>
MIME-Version: 1.0
To: Matthew McClintock <msm@freescale.com>
Subject: Re: [PATCH] powerpc:prom Export device tree physical	address via proc
References: <1279047011-28989-1-git-send-email-msm@freescale.com>
In-Reply-To: <1279047011-28989-1-git-send-email-msm@freescale.com>
Content-Type: text/plain; charset="ISO-8859-1"
Cc: linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Matthew McClintock wrote:

> +	if (prop)
> +		prom_remove_property(node, prop);
> +		prop = of_find_property(node, "linux,devietree-end", NULL);


Either the indentation is wrong, or you're missing some braces here.

> +	if (prop)
> +		prom_remove_property(node, prop);
> +
> +	flat_dt_start = (unsigned long)virt_to_phys(initial_boot_params);
> +	flat_dt_end = (unsigned long)virt_to_phys(initial_boot_params)
> +				+ initial_boot_params->totalsize;

I think these should be u64, not unsigned long, to ensure support for 64-bit
physical addresses.
