Return-Path: <jwboyer@linux.vnet.ibm.com>
Received: from e35.co.us.ibm.com (e35.co.us.ibm.com [32.97.110.153])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e35.co.us.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id BA256DE461
	for <linuxppc-dev@ozlabs.org>; Tue, 24 Jun 2008 11:39:18 +1000 (EST)
Received: from d03relay02.boulder.ibm.com (d03relay02.boulder.ibm.com
	[9.17.195.227])
	by e35.co.us.ibm.com (8.13.8/8.13.8) with ESMTP id m5O1dEFu008048
	for <linuxppc-dev@ozlabs.org>; Mon, 23 Jun 2008 21:39:14 -0400
Received: from d03av02.boulder.ibm.com (d03av02.boulder.ibm.com [9.17.195.168])
	by d03relay02.boulder.ibm.com (8.13.8/8.13.8/NCO v9.0) with ESMTP id
	m5O1dEjd148054
	for <linuxppc-dev@ozlabs.org>; Mon, 23 Jun 2008 19:39:14 -0600
Received: from d03av02.boulder.ibm.com (loopback [127.0.0.1])
	by d03av02.boulder.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id
	m5O1dEVv022447
	for <linuxppc-dev@ozlabs.org>; Mon, 23 Jun 2008 19:39:14 -0600
Date: Mon, 23 Jun 2008 21:35:56 -0400
From: Josh Boyer <jwboyer@linux.vnet.ibm.com>
To: John Linn <John.Linn@xilinx.com>
Subject: Re: [PATCH] [RFC] powerpc: Xilinx: adding virtex5 powerpc 440 support
Message-ID: <20080623213556.3378316a@zod.rchland.ibm.com>
In-Reply-To: <20080623213038.490C110B806B@mail11-dub.bigfish.com>
References: <20080623162856.D5FA41CA806C@mail66-dub.bigfish.com>
	<20080623150846.40d65f08@zod.rchland.ibm.com>
	<20080623213038.490C110B806B@mail11-dub.bigfish.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Mon, 23 Jun 2008 15:30:35 -0600
John Linn <John.Linn@xilinx.com> wrote:

> >> + *
> >> + * Copyright 2007 IBM Corporation
> >> + *   Based on cuboot-83xx.c, which is:
> >> + * Copyright (c) 2007 Freescale Semiconductor, Inc.
> >> + *
> >> + * This program is free software; you can redistribute it and/or
> modify
> >> it
> >> + * under the terms of the GNU General Public License version 2 as
> >> published
> >> + * by the Free Software Foundation.
> >> + */
> >> +
> >> +#include <stddef.h>
> >> +#include <stdio.h>
> >> +#include "ops.h"
> >> +#include "dcr.h"
> >> +#include "4xx.h"
> >> +#include "io.h"
> >> +#include "reg.h"
> >> +
> >> +BSS_STACK(4096);
> >> +
> >> +#include "types.h"
> >> +#include "gunzip_util.h"
> >> +#include <libfdt.h>
> >> +#include "../../../include/linux/autoconf.h"
> >
> >Ew.  We've never included the CONFIG_ variables from Kconfig in the
> >bootwrapper.  It's supposed to be independent of the kernel.
> >
> 
> I'll try to better understand if we can detect the compressed device
> tree and if we really have to disable the APU.
> 
> What's the reasoning for being independent of the kernel, maybe it's
> obvious to everyone but me?

The intention, as I understand it, is that the wrapper utilities can be
installed stand-alone and used to wrap other kernels if needs be.  In
practice I've not seen this happen yet, as most PowerPC kernels
are built directly from the kernel source.  Fedora does have a
separate package for the wrapper bits, but I'm not entirely sure it's
used.

My understanding could be totally wrong, and if so I'll politely ask
Paul or anyone else to hit me with a cluebat :).

josh
