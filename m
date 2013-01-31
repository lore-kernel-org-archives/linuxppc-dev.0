Return-Path: <toshi.kani@hp.com>
Received: from g1t0027.austin.hp.com (g1t0027.austin.hp.com [15.216.28.34])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client CN "smtp.hp.com",
 Issuer "VeriSign Class 3 Secure Server CA - G3" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 1815F2C0086
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 31 Jan 2013 12:56:52 +1100 (EST)
Message-ID: <1359596804.15120.108.camel@misato.fc.hp.com>
Subject: Re: [RFC PATCH v2 01/12] Add sys_hotplug.h for system device
 hotplug framework
From: Toshi Kani <toshi.kani@hp.com>
To: Greg KH <gregkh@linuxfoundation.org>
Date: Wed, 30 Jan 2013 18:46:44 -0700
In-Reply-To: <20130130045330.GF30002@kroah.com>
References: <1357861230-29549-1-git-send-email-toshi.kani@hp.com>
 <1357861230-29549-2-git-send-email-toshi.kani@hp.com>
 <20130130045330.GF30002@kroah.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Cc: linux-s390@vger.kernel.org, jiang.liu@huawei.com, wency@cn.fujitsu.com,
 linux-mm@kvack.org, yinghai@kernel.org, linux-kernel@vger.kernel.org,
 rjw@sisk.pl, linux-acpi@vger.kernel.org, isimatu.yasuaki@jp.fujitsu.com,
 srivatsa.bhat@linux.vnet.ibm.com, guohanjun@huawei.com, bhelgaas@google.com,
 akpm@linux-foundation.org, linuxppc-dev@lists.ozlabs.org, lenb@kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Tue, 2013-01-29 at 23:53 -0500, Greg KH wrote:
> On Thu, Jan 10, 2013 at 04:40:19PM -0700, Toshi Kani wrote:
> > Added include/linux/sys_hotplug.h, which defines the system device
> > hotplug framework interfaces used by the framework itself and
> > handlers.
> > 
> > The order values define the calling sequence of handlers.  For add
> > execute, the ordering is ACPI->MEM->CPU.  Memory is onlined before
> > CPU so that threads on new CPUs can start using their local memory.
> > The ordering of the delete execute is symmetric to the add execute.
> > 
> > struct shp_request defines a hot-plug request information.  The
> > device resource information is managed with a list so that a single
> > request may target to multiple devices.
> > 
> > Signed-off-by: Toshi Kani <toshi.kani@hp.com>
> > ---
> >  include/linux/sys_hotplug.h |  181 +++++++++++++++++++++++++++++++++++++++++++
> >  1 file changed, 181 insertions(+)
> >  create mode 100644 include/linux/sys_hotplug.h
> > 
> > diff --git a/include/linux/sys_hotplug.h b/include/linux/sys_hotplug.h
> > new file mode 100644
> > index 0000000..86674dd
> > --- /dev/null
> > +++ b/include/linux/sys_hotplug.h
> > @@ -0,0 +1,181 @@
> > +/*
> > + * sys_hotplug.h - System device hot-plug framework
> > + *
> > + * Copyright (C) 2012 Hewlett-Packard Development Company, L.P.
> > + *	Toshi Kani <toshi.kani@hp.com>
> > + *
> > + * This program is free software; you can redistribute it and/or modify
> > + * it under the terms of the GNU General Public License version 2 as
> > + * published by the Free Software Foundation.
> > + */
> > +
> > +#ifndef _LINUX_SYS_HOTPLUG_H
> > +#define _LINUX_SYS_HOTPLUG_H
> > +
> > +#include <linux/list.h>
> > +#include <linux/device.h>
> > +
> > +/*
> > + * System device hot-plug operation proceeds in the following order.
> > + *   Validate phase -> Execute phase -> Commit phase
> > + *
> > + * The order values below define the calling sequence of platform
> > + * neutral handlers for each phase in ascending order.  The order
> > + * values of firmware-specific handlers are defined in sys_hotplug.h
> > + * under firmware specific directories.
> > + */
> > +
> > +/* All order values must be smaller than this value */
> > +#define SHP_ORDER_MAX				0xffffff
> > +
> > +/* Add Validate order values */
> > +
> > +/* Add Execute order values */
> > +#define SHP_MEM_ADD_EXECUTE_ORDER		100
> > +#define SHP_CPU_ADD_EXECUTE_ORDER		110
> > +
> > +/* Add Commit order values */
> > +
> > +/* Delete Validate order values */
> > +#define SHP_CPU_DEL_VALIDATE_ORDER		100
> > +#define SHP_MEM_DEL_VALIDATE_ORDER		110
> > +
> > +/* Delete Execute order values */
> > +#define SHP_CPU_DEL_EXECUTE_ORDER		10
> > +#define SHP_MEM_DEL_EXECUTE_ORDER		20
> > +
> > +/* Delete Commit order values */
> > +
> 
> Empty value?

Yes, in this version, all the delete commit order values are defined in
<acpi/sys_hotplug.h>.

> Anyway, as I said before, don't use "values", just call things directly
> in the order you need to.
> 
> This isn't like other operating systems, we don't need to be so
> "flexible", we can modify the core code as much as we want and need to
> if future things come along :)

Understood.  As described in the previous email, I will define them with
enum and avoid using values.

Thanks,
-Toshi
