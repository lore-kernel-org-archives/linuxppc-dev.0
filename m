Return-Path: <arnd@arndb.de>
Received: from moutng.kundenserver.de (moutng.kundenserver.de
	[212.227.126.171]) by ozlabs.org (Postfix) with ESMTP id 810751007F3
	for <linuxppc-dev@lists.ozlabs.org>;
	Mon, 23 Nov 2009 09:48:28 +1100 (EST)
From: Arnd Bergmann <arnd@arndb.de>
To: linuxppc-dev@lists.ozlabs.org
Subject: Re: [RFC PATCH 17/19] powerpc: wii: bootmii starlet 'mini' firmware
	support
Date: Sun, 22 Nov 2009 23:48:20 +0100
References: <1258927311-4340-1-git-send-email-albert_herranz@yahoo.es>
	<1258927311-4340-17-git-send-email-albert_herranz@yahoo.es>
	<1258927311-4340-18-git-send-email-albert_herranz@yahoo.es>
In-Reply-To: <1258927311-4340-18-git-send-email-albert_herranz@yahoo.es>
MIME-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-1"
Message-Id: <200911222348.20652.arnd@arndb.de>
Cc: Albert Herranz <albert_herranz@yahoo.es>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Sunday 22 November 2009, Albert Herranz wrote:
> + *
> + */
> +struct mipc_device {
> +	void __iomem *io_base;
> +	int irq;
> +
> +	struct device *dev;
> +
> +	spinlock_t call_lock;	/* serialize firmware calls */
> +	spinlock_t io_lock;	/* serialize access to io registers */
> +
> +	struct mipc_infohdr *hdr;
> +
> +	struct mipc_req *in_ring;
> +	size_t in_ring_size;
> +	volatile u16 intail_idx;
> +
> +	struct mipc_req *out_ring;
> +	size_t out_ring_size;
> +	volatile u16 outhead_idx;
> +
> +	u32 tag;
> +};

The 'volatile' here seems out of place. What are you trying to protect
against?

The rest of the patch seems to be made up of layers of wrappers. They
are all well coded, but I got a feeling that the same could be achieved
with less of it.

	Arnd <>< 
