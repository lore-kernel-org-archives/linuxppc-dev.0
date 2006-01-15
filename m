Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 340C568A25
	for <linuxppc-dev@ozlabs.org>; Mon, 16 Jan 2006 10:25:42 +1100 (EST)
Subject: Re: AGPGART driver for ArticiaS - ioremap() problem
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Gerhard Pircher <gerhard_pircher@gmx.net>
In-Reply-To: <13039.1137366615@www38.gmx.net>
References: <13039.1137366615@www38.gmx.net>
Content-Type: text/plain
Date: Mon, 16 Jan 2006 10:25:31 +1100
Message-Id: <1137367531.4823.42.camel@localhost.localdomain>
Mime-Version: 1.0
Cc: linuxppc-dev@ozlabs.org, debian-powerpc@lists.debian.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


> Actually at least the bridge does everthing right until now (IMHO :-). The
> bridge is detected and also the aperture size is read out correctly from the
> registers. After that, the agp_backend_initialize() function in
> drivers/cahr/agp/backend.c calls the create_gatt_table() function of the
> driver (articias_create_gatt_table). Based on the detected aperture size and
> its definitions, this function allocates pages for the GATT table
> (alloc_gatt_pages). The function then tries to map this pages with
> ioremap_nocache(virt_to_gatt(table, (PAGE_SIZE * (1 << page_order))). But
> ioremap_nocache() cannot remap the pages, because the following code snipped
> in __ioremap (arch/ppc/mm/pgtable.c) is trigged:

Yes, you are not allowed to ioremap RAM on ppc at least not with
CONFIG_6xx. You should leave it cacheable and use explicit cache flush
like the UniNorth driver.

> As it can be seen in the following log, the table address (0xde200000 ->
> virt_to_gart(table) = 0x1e200000) is lower than the maximum amount of memory
> 0x20000000 (512MB) and therefore __ioremap() does not remap the pages.
