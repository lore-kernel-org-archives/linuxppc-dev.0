Return-Path: <John.Linn@xilinx.com>
Received: from WA4EHSOBE005.bigfish.com (outbound-wa4.frontbridge.com
	[216.32.181.16]) by ozlabs.org (Postfix) with ESMTP id 49EF5DDFD5
	for <linuxppc-dev@ozlabs.org>; Wed, 25 Jun 2008 07:07:57 +1000 (EST)
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Subject: RE: [PATCH] [RFC] powerpc: Xilinx: adding virtex5 powerpc 440 support
Date: Tue, 24 Jun 2008 15:07:48 -0600
In-Reply-To: <20080623213556.3378316a@zod.rchland.ibm.com>
References: <20080623162856.D5FA41CA806C@mail66-dub.bigfish.com><20080623150846.40d65f08@zod.rchland.ibm.com><20080623213038.490C110B806B@mail11-dub.bigfish.com>
	<20080623213556.3378316a@zod.rchland.ibm.com>
From: John Linn <John.Linn@xilinx.com>
To: "Grant Likely" <grant.likely@secretlab.ca>
Message-ID: <20080624210750.A21E314006F@mail88-wa4.bigfish.com>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Hi Grant,

It appears that you designed the simpleImage around Xilinx FPGAs.

Since we have to initialize the 16550 UART in the bootstrap and there's
no boot loader, were you thinking we would add the 16550 initialization
to simpleboot.c?

Why do we want a flat binary rather than an elf file for the target?

Thanks,
John

>From Grant's commit:

This target produces a flat binary rather than an ELF file,
fixes the entry point at the beginning of the image, and takes
a complete device tree with no fixups needed.

-----Original Message-----
From: Josh Boyer [mailto:jwboyer@linux.vnet.ibm.com] =

Sent: Monday, June 23, 2008 7:36 PM
To: John Linn
Cc: linuxppc-dev@ozlabs.org
Subject: Re: [PATCH] [RFC] powerpc: Xilinx: adding virtex5 powerpc 440
support

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
> =

> I'll try to better understand if we can detect the compressed device
> tree and if we really have to disable the APU.
> =

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


This email and any attachments are intended for the sole use of the named r=
ecipient(s) and contain(s) confidential information that may be proprietary=
, privileged or copyrighted under applicable law. If you are not the intend=
ed recipient, do not read, copy, or forward this email message or any attac=
hments. Delete this email message and any attachments immediately.
