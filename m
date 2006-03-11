Return-Path: <gerhard_pircher@gmx.net>
Received: from mail.gmx.net (mail.gmx.de [213.165.64.20])
	by ozlabs.org (Postfix) with SMTP id 2387F679E2
	for <linuxppc-dev@ozlabs.org>; Sun, 12 Mar 2006 00:28:24 +1100 (EST)
Date: Sat, 11 Mar 2006 14:28:22 +0100 (MET)
From: "Gerhard Pircher" <gerhard_pircher@gmx.net>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
MIME-Version: 1.0
References: <1142032411.4057.31.camel@localhost.localdomain>
Subject: Re: Unmapping pages from the linear addressing without HIGHMEM support
Message-ID: <20006.1142083702@www079.gmx.net>
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
> Betreff: Re: Unmapping pages from the linear addressing
> without HIGHMEM support
> Datum: Sat, 11 Mar 2006 10:13:30 +1100
> 
> > That would mean I cannot reuse the code in dma-mapping.c, right?
> > Killing the BAT mappings or limiting the memory size covered by the
> > BATs seems to be fairly easy, but I guess I have to setup my own page
> > table for the reserved DMA memory area and implement my own
> > alloc_pages() function!?
> 
> No, just limit the size of the BAT mapping and mark some of the top
> pages of the address space reserved... That should be enough.
> 
Okay, I will try that first. Marking some of the pages as reserved sounds
like the code you implemented for the uninorth_agp driver with this
"agp_special_page". I guess I still have to modify the code in dma_mapping.c
to use the reserved address space for the consistent memory allocation
(CONSISTENT_BASE, CONSISTENT_END)?

Thanks again!

Gerhard

-- 
"Feel free" mit GMX FreeMail!
Monat für Monat 10 FreeSMS inklusive! http://www.gmx.net
