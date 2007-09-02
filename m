Return-Path: <jwboyer@linux.vnet.ibm.com>
Received: from e35.co.us.ibm.com (e35.co.us.ibm.com [32.97.110.153])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e35.co.us.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id 57775DDF25
	for <linuxppc-dev@ozlabs.org>; Mon,  3 Sep 2007 23:37:53 +1000 (EST)
Received: from d03relay04.boulder.ibm.com (d03relay04.boulder.ibm.com
	[9.17.195.106])
	by e35.co.us.ibm.com (8.13.8/8.13.8) with ESMTP id l83Dbd0V017891
	for <linuxppc-dev@ozlabs.org>; Mon, 3 Sep 2007 09:37:39 -0400
Received: from d03av02.boulder.ibm.com (d03av02.boulder.ibm.com [9.17.195.168])
	by d03relay04.boulder.ibm.com (8.13.8/8.13.8/NCO v8.5) with ESMTP id
	l83DbdUn353314
	for <linuxppc-dev@ozlabs.org>; Mon, 3 Sep 2007 07:37:39 -0600
Received: from d03av02.boulder.ibm.com (loopback [127.0.0.1])
	by d03av02.boulder.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id
	l83DbcvV014891
	for <linuxppc-dev@ozlabs.org>; Mon, 3 Sep 2007 07:37:38 -0600
Subject: Re: [patch 6/6] Walnut zImage wrapper
From: Josh Boyer <jwboyer@linux.vnet.ibm.com>
To: David Gibson <dwg@au1.ibm.com>
In-Reply-To: <20070903011352.GF31499@localhost.localdomain>
References: <20070831200449.598781000@linux.vnet.ibm.com> >
	<20070831200643.675381000@linux.vnet.ibm.com>
	<20070903011352.GF31499@localhost.localdomain>
Content-Type: text/plain
Date: Sun, 02 Sep 2007 08:58:38 -0500
Message-Id: <1188741519.3772.3.camel@localhost.localdomain>
Mime-Version: 1.0
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Mon, 2007-09-03 at 11:13 +1000, David Gibson wrote:
> On Fri, Aug 31, 2007 at 03:04:55PM -0500, Josh Boyer wrote:
> > Add zImage wrapper for walnut board
> > 
> > Signed-off-by: Josh Boyer <jwboyer@linux.vnet.ibm.com>
> 
> [snip]
> > --- /dev/null
> > +++ linux-2.6/arch/powerpc/boot/treeboot-walnut.c
> > @@ -0,0 +1,133 @@
> > +/*
> > + * Old U-boot compatibility for Walnut
> > + *
> > + * Author: Josh Boyer <jwboyer@linux.vnet.ibm.com>
> > + *
> > + * Copyright 2007 IBM Corporation
> > + *   Based on cuboot-83xx.c, which is:
> > + * Copyright (c) 2007 Freescale Semiconductor, Inc.
> > + *
> > + * This program is free software; you can redistribute it and/or modify it
> > + * under the terms of the GNU General Public License version 2 as published
> > + * by the Free Software Foundation.
> > + */
> > +
> > +#include "ops.h"
> > +#include "stdio.h"
> > +#include "dcr.h"
> > +#include "4xx.h"
> > +#include "io.h"
> > +
> > +BSS_STACK(4096);
> > +
> > +void ibm405gp_fixup_clocks(unsigned int sysclk, unsigned int ser_clk)
> > +{
> > +	u32 pllmr = mfdcr(0xb0);
> 
> Please add #defines for the DCR numbers, rather than using literals.

Oops.  Meant to do that cleanup before I sent out this round.  Will be
fixed.

josh
