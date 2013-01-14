Return-Path: <toshi.kani@hp.com>
Received: from g1t0029.austin.hp.com (g1t0029.austin.hp.com [15.216.28.36])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client CN "smtp.hp.com",
 Issuer "VeriSign Class 3 Secure Server CA - G3" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 7FF612C0094
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 15 Jan 2013 02:51:47 +1100 (EST)
Message-ID: <1358177628.14145.49.camel@misato.fc.hp.com>
Subject: Re: [RFC PATCH v2 01/12] Add sys_hotplug.h for system device
 hotplug framework
From: Toshi Kani <toshi.kani@hp.com>
To: "Rafael J. Wysocki" <rjw@sisk.pl>
Date: Mon, 14 Jan 2013 08:33:48 -0700
In-Reply-To: <5036592.TuXAnGzk4M@vostro.rjw.lan>
References: <1357861230-29549-1-git-send-email-toshi.kani@hp.com>
 <1357861230-29549-2-git-send-email-toshi.kani@hp.com>
 <5036592.TuXAnGzk4M@vostro.rjw.lan>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Cc: linux-s390@vger.kernel.org, jiang.liu@huawei.com, wency@cn.fujitsu.com,
 linux-acpi@vger.kernel.org, gregkh@linuxfoundation.org,
 linux-kernel@vger.kernel.org, linux-mm@kvack.org,
 isimatu.yasuaki@jp.fujitsu.com, yinghai@kernel.org,
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

On Fri, 2013-01-11 at 22:23 +0100, Rafael J. Wysocki wrote:
> On Thursday, January 10, 2013 04:40:19 PM Toshi Kani wrote:
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
 :
> > +
> > +struct shp_device {
> > +	struct list_head	list;
> > +	struct device		*device;
> > +	enum shp_class		class;
> > +	union shp_dev_info	info;
> > +};
> > +
> > +/*
> > + * Hot-plug request
> > + */
> > +struct shp_request {
> > +	/* common info */
> > +	enum shp_operation	operation;	/* operation */
> > +
> > +	/* hot-plug event info: only valid for hot-plug operations */
> > +	void			*handle;	/* FW handle */
> 
> What's the role of handle here?

On ACPI-based platforms, the handle keeps a notified ACPI handle when a
hot-plug request is made.  ACPI bus handlers, acpi_add_execute() /
acpi_del_execute(), then scans / trims ACPI devices from the handle.

Thanks,
-Toshi
