Return-Path: <gregkh@linuxfoundation.org>
Received: from mail.kernel.org (mail.kernel.org [198.145.19.201])
 by ozlabs.org (Postfix) with ESMTP id 6898B2C00AD
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 30 Jan 2013 19:09:42 +1100 (EST)
Date: Tue, 29 Jan 2013 23:58:30 -0500
From: Greg KH <gregkh@linuxfoundation.org>
To: Toshi Kani <toshi.kani@hp.com>
Subject: Re: [RFC PATCH v2 01/12] Add sys_hotplug.h for system device hotplug
 framework
Message-ID: <20130130045830.GH30002@kroah.com>
References: <1357861230-29549-1-git-send-email-toshi.kani@hp.com>
 <1357861230-29549-2-git-send-email-toshi.kani@hp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1357861230-29549-2-git-send-email-toshi.kani@hp.com>
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

On Thu, Jan 10, 2013 at 04:40:19PM -0700, Toshi Kani wrote:
> +/*
> + * Hot-plug device information
> + */

Again, stop it with the "generic" hotplug term here, and everywhere
else.  You are doing a very _specific_ type of hotplug devices, so spell
it out.  We've worked hard to hotplug _everything_ in Linux, you are
going to confuse a lot of people with this type of terms.

> +union shp_dev_info {
> +	struct shp_cpu {
> +		u32		cpu_id;
> +	} cpu;

What is this?  Why not point to the system device for the cpu?

> +	struct shp_memory {
> +		int		node;
> +		u64		start_addr;
> +		u64		length;
> +	} mem;

Same here, why not point to the system device?

> +	struct shp_hostbridge {
> +	} hb;
> +
> +	struct shp_node {
> +	} node;

What happened here with these?  Empty structures?  Huh?

> +};
> +
> +struct shp_device {
> +	struct list_head	list;
> +	struct device		*device;

No, make it a "real" device, embed the device into it.

But, again, I'm going to ask why you aren't using the existing cpu /
memory / bridge / node devices that we have in the kernel.  Please use
them, or give me a _really_ good reason why they will not work.

> +	enum shp_class		class;
> +	union shp_dev_info	info;
> +};
> +
> +/*
> + * Hot-plug request
> + */
> +struct shp_request {
> +	/* common info */
> +	enum shp_operation	operation;	/* operation */
> +
> +	/* hot-plug event info: only valid for hot-plug operations */
> +	void			*handle;	/* FW handle */
> +	u32			event;		/* FW event */

What is this?

greg k-h
