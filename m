Return-Path: <sshtylyov@ru.mvista.com>
Received: from imap.sh.mvista.com (unknown [63.81.120.155])
	by ozlabs.org (Postfix) with ESMTP id 4267ADE44B
	for <linuxppc-dev@ozlabs.org>; Tue,  8 Apr 2008 02:46:53 +1000 (EST)
Message-ID: <47FA4FD2.8060808@ru.mvista.com>
Date: Mon, 07 Apr 2008 20:46:10 +0400
From: Sergei Shtylyov <sshtylyov@ru.mvista.com>
MIME-Version: 1.0
To: Tejun Heo <htejun@gmail.com>
Subject: Re: [PATCH 6/13] devres: implement managed iomap interface
References: <11684073371547-git-send-email-htejun@gmail.com>
In-Reply-To: <11684073371547-git-send-email-htejun@gmail.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Cc: linuxppc-dev@ozlabs.org, gregkh@suse.de, linux-kernel@vger.kernel.org,
	linux-ide@vger.kernel.org, jgarzik@pobox.com, alan@lxorguk.ukuu.org.uk
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Tejun Heo wrote:

> +/**
> + * devm_ioremap - Managed ioremap()
> + * @dev: Generic device to remap IO address for
> + * @offset: BUS offset to map
> + * @size: Size of map
> + *
> + * Managed ioremap().  Map is automatically unmapped on driver detach.
> + */
> +void __iomem *devm_ioremap(struct device *dev, unsigned long offset,
> +			   unsigned long size)
> +{
> +	void __iomem **ptr, *addr;
> +
> +	ptr = devres_alloc(devm_ioremap_release, sizeof(*ptr), GFP_KERNEL);
> +	if (!ptr)
> +		return NULL;
> +
> +	addr = ioremap(offset, size);
> +	if (addr) {
> +		*ptr = addr;
> +		devres_add(dev, ptr);
> +	} else
> +		devres_free(ptr);
> +
> +	return addr;
> +}
> +EXPORT_SYMBOL(devm_ioremap);
> +
> +/**
> + * devm_ioremap_nocache - Managed ioremap_nocache()
> + * @dev: Generic device to remap IO address for
> + * @offset: BUS offset to map
> + * @size: Size of map
> + *
> + * Managed ioremap_nocache().  Map is automatically unmapped on driver
> + * detach.
> + */
> +void __iomem *devm_ioremap_nocache(struct device *dev, unsigned long offset,
> +				   unsigned long size)
> +{
> +	void __iomem **ptr, *addr;
> +
> +	ptr = devres_alloc(devm_ioremap_release, sizeof(*ptr), GFP_KERNEL);
> +	if (!ptr)
> +		return NULL;
> +
> +	addr = ioremap_nocache(offset, size);
> +	if (addr) {
> +		*ptr = addr;
> +		devres_add(dev, ptr);
> +	} else
> +		devres_free(ptr);
> +
> +	return addr;
> +}
> +EXPORT_SYMBOL(devm_ioremap_nocache);

    A very late comment but nevertheless... :-)
    Those functions are going to break on 32-bit platforms with extended 
physical address (well, that's starting with Pentiums which had 36-bit PAE :-) 
AND devices mapped beyond 4 GB (e.g. PowerPC 44x).  You should have used 
resource_size_t for the 'offset' parameter. As this most probably means that 
libata is broken on such platforms, I'm going to submit a patch...

WBR, Sergei
