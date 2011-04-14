Return-Path: <dwg@au1.ibm.com>
Date: Thu, 14 Apr 2011 10:43:03 +1000
From: David Gibson <dwg@au1.ibm.com>
To: Josh Boyer <jwboyer@linux.vnet.ibm.com>
Subject: Re: [PATCH 2/2] powerpc: Add an ePAPR compliant boot wrapper
Message-ID: <20110414004303.GZ3151@yookeroo>
References: <34e3e03a96888bc8c20013aa65712123ccf94649.1302676893.git.michael@ellerman.id.au>
	<732a8ac3a24023f021908d03bd84b76638f381f1.1302676893.git.michael@ellerman.id.au>
	<20110413130512.GD26874@zod.rchland.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20110413130512.GD26874@zod.rchland.ibm.com>
Cc: Michael Ellerman <michael@ozlabs.org>, linuxppc-dev@ozlabs.org,
	Paul Mackerras <paulus@samba.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Wed, Apr 13, 2011 at 09:05:12AM -0400, Josh Boyer wrote:
> On Wed, Apr 13, 2011 at 04:38:56PM +1000, Michael Ellerman wrote:
> >+++ b/arch/powerpc/boot/epapr.c
> >@@ -0,0 +1,69 @@
> >+/*
> >+ * Bootwrapper for ePAPR compliant firmwares
> 
> Out of curiosity, do we have a list of the ePAPR compliant firmwares (if
> any)?

The one this has been tested with is a revised (internal, so far)
version of SLOF.  For the platform that I believe Michael is in the
middle of upstreaming support for.

> >+ *
> >+ * Copyright 2010 David Gibson <david@gibson.dropbear.id.au>, IBM Corporation.
> >+ *
> >+ * Based on earlier bootwrappers by:
> >+ * (c) Benjamin Herrenschmidt <benh@kernel.crashing.org>, IBM Corp,\
> >+ *   and
> >+ * Scott Wood <scottwood@freescale.com>
> >+ * Copyright (c) 2007 Freescale Semiconductor, Inc.
> >+ *
> >+ * This program is free software; you can redistribute it and/or modify it
> >+ * under the terms of the GNU General Public License version 2 as published
> >+ * by the Free Software Foundation.
> >+ */
> >+
> >+#include "ops.h"
> >+#include "stdio.h"
> >+#include "planetcore.h"
> >+#include "dcr.h"
> >+#include "4xx.h"
> >+#include "io.h"
> 
> Do you need planetcore, dcr, and 4xx.h included here?  I don't see
> anything used that would require them.

Ah, no.  Leftovers from the files I based this on, I think.

-- 
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson
