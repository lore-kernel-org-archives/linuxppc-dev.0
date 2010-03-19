Return-Path: <konrad.wilk@oracle.com>
Received: from acsinet14.oracle.com (acsinet14.oracle.com [141.146.126.236])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "acsinet14.oracle.com",
	Issuer "VeriSign Trust Network" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id 2E900B7D0C
	for <linuxppc-dev@lists.ozlabs.org>;
	Sat, 20 Mar 2010 07:22:29 +1100 (EST)
Received: from acsinet11.oracle.com (acsinet11.oracle.com [141.146.126.233])
	by acsinet14.oracle.com (Sentrion-MP-4.0.0/Sentrion-MP-4.0.0) with
	ESMTP id o2JKMRLC023380
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=OK)
	for <linuxppc-dev@lists.ozlabs.org>; Fri, 19 Mar 2010 20:22:27 GMT
Date: Fri, 19 Mar 2010 15:51:14 -0400
From: Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>
To: Albert Herranz <albert_herranz@yahoo.es>
Subject: Re: [PATCH v5 08/10] wii: add mem2 dma mapping ops
Message-ID: <20100319195114.GD31908@phenom.dumpdata.com>
References: <1269023546-25534-1-git-send-email-albert_herranz@yahoo.es>
	<1269023546-25534-9-git-send-email-albert_herranz@yahoo.es>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1269023546-25534-9-git-send-email-albert_herranz@yahoo.es>
Cc: iommu@lists.linux-foundation.org, linux-usb@vger.kernel.org,
	linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

> +/*
> + * The mem2_dma "device".
> + *
> + * This device "owns" a pool of coherent MEM2 memory that can be shared among
> + * several devices requiring MEM2 DMA buffers, instead of dedicating specific
> + * pools for each device.
> + *
> + * A device can use the shared coherent MEM2 memory pool by calling
> + * wii_set_mem2_dma_constraints().
> + *
> + */
> +
> +struct mem2_dma {
> +	struct platform_device *pdev;
> +

The space there isn't neccessary.

> +	dma_addr_t dma_base;

I think you need only one of them. You don't seem to use 'base'
> +	void *base;
> +	size_t size;
> +};
