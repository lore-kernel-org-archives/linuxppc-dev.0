Return-Path: <dgibson@ozlabs.org>
Date: Thu, 26 Jul 2007 16:59:02 +1000
From: David Gibson <david@gibson.dropbear.id.au>
To: Kumar Gala <galak@kernel.crashing.org>
Subject: Re: Fwd: [PATCH] bootwrapper: adds cuboot for MPC7448HPC2 platform
Message-ID: <20070726065902.GD1149@localhost.localdomain>
References: <1184144056.23579.16.camel@localhost.localdomain>
	<B37B73EC-54FE-442C-A1FF-348D89D3D840@kernel.crashing.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <B37B73EC-54FE-442C-A1FF-348D89D3D840@kernel.crashing.org>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Thu, Jul 26, 2007 at 01:28:10AM -0500, Kumar Gala wrote:
> 
> 
> Begin forwarded message:
> 
> >From: Zang Roy-r61911 <tie-fei.zang@freescale.com>
> >Date: July 11, 2007 3:54:16 AM CDT
> >To: Paul Mackerras <paulus@samba.org>
> >Cc: Kumar Gala <galak@kernel.crashing.org>, linuxppc-dev list  
> ><linuxppc-dev@ozlabs.org>
> >Subject: [PATCH] bootwrapper: adds cuboot for MPC7448HPC2 platform
> >
> >From: Roy Zang <tie-fei.zang@freescale.com>
> >
> >This patch adds cuboot support for MPC7448HPC2 platform.
> >The cuImage can be used with legacy u-boot without FDT support.
> >
> >Signed-off-by: Roy Zang <tie-fei.zang@freescale.com>

[snip]

> >--- /dev/null
> >+++ b/arch/powerpc/boot/cuboot-hpc2.c
> >@@ -0,0 +1,48 @@
> >+/*
> >+ * Copyright (C) 2007 Freescale Semiconductor, Inc. All rights  
> >reserved.
> >+ *
> >+ * Author: Roy Zang <tie-fei.zang@freescale.com>
> >+ *
> >+ * Description:
> >+ * Old U-boot compatibility for mpc7448hpc2 board
> >+ * Based on the code of Scott Wood <scottwood@freescale.com>
> >+ * for 83xx and 85xx.
> >+ *
> >+ * This is free software; you can redistribute it and/or modify
> >+ * it under the terms of  the GNU General  Public License as  
> >published by
> >+ * the Free Software Foundation;  either version 2 of the   
> >License, or
> >+ * (at your option) any later version.
> >+ *
> >+ */
> >+
> >+#include "ops.h"
> >+#include "stdio.h"
> >+#include "cuboot.h"
> >+
> >+#define TARGET_HAS_ENET1
> >+#include "ppcboot.h"

Including ppcboot.h without first defining TARGET_* defines which give
the type of system seems... fragile at best, broken at worst.  Surely
this can only work by accident.

-- 
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson
