Return-Path: <ebs@ebshome.net>
Received: from gate.ebshome.net (gate.ebshome.net [64.81.67.12])
	(using TLSv1 with cipher EDH-RSA-DES-CBC3-SHA (168/168 bits))
	(Client CN "gate.ebshome.net", Issuer "gate.ebshome.net" (not verified))
	by ozlabs.org (Postfix) with ESMTP id 4128C67A71
	for <linuxppc-embedded@ozlabs.org>;
	Fri, 18 Mar 2005 03:25:12 +1100 (EST)
Date: Thu, 17 Mar 2005 08:25:09 -0800
From: Eugene Surovegin <ebs@ebshome.net>
To: Brian Waite <waite@skycomputers.com>
Message-ID: <20050317162509.GB5762@gate.ebshome.net>
References: <200503170953.02626.waite@skycomputers.com>
	<200503171111.39210.waite@skycomputers.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <200503171111.39210.waite@skycomputers.com>
Cc: linuxppc-embedded@ozlabs.org
Subject: Re: [PATCH] ppc32: 3/2 HDPU platform fix PCI bus 1 enumeration
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

On Thu, Mar 17, 2005 at 11:11:34AM -0500, Brian Waite wrote:
>   Signed-off-by: Brian Waite <waite@skycomputers.com>
>   Add the proper bus enumeration code that was missing for bus 1.
> 
> ===== linux-2.5/arch/ppc/platforms/hdpu.c 1.2 vs edited =====
> 262a263,273
> > 	mv64x60_set_bus(&bh, 0, 0);
> > 	bh.hose_a->first_busno = 0;
> > 	bh.hose_a->last_busno = 0xff;
> > 	bh.hose_a->last_busno = pciauto_bus_scan(bh.hose_a, 0);
> > 
> > 	bh.hose_b->first_busno = bh.hose_a->last_busno + 1;
> > 	mv64x60_set_bus(&bh, 1, bh.hose_b->first_busno);
> > 	bh.hose_b->last_busno = 0xff;
> > 	bh.hose_b->last_busno = pciauto_bus_scan(bh.hose_b,
> > 		bh.hose_b->first_busno);
> > 

You probably didn't want to send _context_ diff :).

--
Eugene
