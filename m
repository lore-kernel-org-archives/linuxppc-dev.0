Return-Path: <gerhard_pircher@gmx.net>
Received: from mail.gmx.net (mail.gmx.net [213.165.64.21])
	by ozlabs.org (Postfix) with SMTP id CA2336893D
	for <linuxppc-dev@ozlabs.org>; Mon, 16 Jan 2006 19:11:56 +1100 (EST)
Date: Mon, 16 Jan 2006 09:11:54 +0100 (MET)
From: "Gerhard Pircher" <gerhard_pircher@gmx.net>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
MIME-Version: 1.0
References: <1137367531.4823.42.camel@localhost.localdomain>
Subject: Re: AGPGART driver for ArticiaS - ioremap() problem
Message-ID: <19548.1137399114@www099.gmx.net>
Content-Type: text/plain; charset="iso-8859-1"
Cc: linuxppc-dev@ozlabs.org, debian-powerpc@lists.debian.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

> --- Ursprüngliche Nachricht ---
> Von: Benjamin Herrenschmidt <benh@kernel.crashing.org>
> An: Gerhard Pircher <gerhard_pircher@gmx.net>
> Kopie: linuxppc-dev@ozlabs.org, debian-powerpc@lists.debian.org
> Betreff: Re: AGPGART driver for ArticiaS - ioremap() problem
> Datum: Mon, 16 Jan 2006 10:25:31 +1100
> 
> >Actually at least the bridge does everthing right until now (IMHO :-).
> >The bridge is detected and also the aperture size is read out correctly
> >from the registers. After that, the agp_backend_initialize() function in
> >drivers/cahr/agp/backend.c calls the create_gatt_table() function of the
> >driver (articias_create_gatt_table). Based on the detected aperture size 
> >and its definitions, this function allocates pages for the GATT table
> >(alloc_gatt_pages). The function then tries to map this pages with
> >ioremap_nocache(virt_to_gatt(table, (PAGE_SIZE * (1 << page_order))).
> >But ioremap_nocache() cannot remap the pages, because the following code 
> >snipped in __ioremap (arch/ppc/mm/pgtable.c) is trigged:
> 
> Yes, you are not allowed to ioremap RAM on ppc at least not with
> CONFIG_6xx. You should leave it cacheable and use explicit cache flush
> like the UniNorth driver.

Ah, okay. So at least the approach to use the Uninorth code was a step in
the right direction. But that requires changes in the DRI and X server code,
right?

Thanks!

regards,

Gerhard

-- 
10 GB Mailbox, 100 FreeSMS/Monat http://www.gmx.net/de/go/topmail
+++ GMX - die erste Adresse für Mail, Message, More +++
