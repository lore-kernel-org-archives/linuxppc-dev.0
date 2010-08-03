Return-Path: <error27@gmail.com>
Received: from mail-wy0-f170.google.com (mail-wy0-f170.google.com
	[74.125.82.170]) by ozlabs.org (Postfix) with ESMTP id 588EDB6EFF
	for <linuxppc-dev@ozlabs.org>; Wed,  4 Aug 2010 07:52:05 +1000 (EST)
Received: by wye20 with SMTP id 20so5803511wye.15
	for <linuxppc-dev@ozlabs.org>; Tue, 03 Aug 2010 14:52:02 -0700 (PDT)
Date: Tue, 3 Aug 2010 23:51:38 +0200
From: Dan Carpenter <error27@gmail.com>
To: Julia Lawall <julia@diku.dk>
Subject: Re: [PATCH 8/9] arch/powerpc/kernel: Drop unnecessary null test
Message-ID: <20100803215137.GU26313@bicker>
References: <Pine.LNX.4.64.1008032334420.20393@ask.diku.dk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <Pine.LNX.4.64.1008032334420.20393@ask.diku.dk>
Cc: devicetree-discuss@lists.ozlabs.org, kernel-janitors@vger.kernel.org,
	linux-kernel@vger.kernel.org, linuxppc-dev@ozlabs.org,
	Paul Mackerras <paulus@samba.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Tue, Aug 03, 2010 at 11:35:17PM +0200, Julia Lawall wrote:
> diff --git a/arch/powerpc/kernel/pci_of_scan.c b/arch/powerpc/kernel/pci_of_scan.c
> index 6ddb795..62dd363 100644
> --- a/arch/powerpc/kernel/pci_of_scan.c
> +++ b/arch/powerpc/kernel/pci_of_scan.c
> @@ -336,8 +336,7 @@ static void __devinit __of_scan_bus(struct device_node *node,
>  		if (dev->hdr_type == PCI_HEADER_TYPE_BRIDGE ||
>  		    dev->hdr_type == PCI_HEADER_TYPE_CARDBUS) {
>  			struct device_node *child = pci_device_to_OF_node(dev);
> -			if (dev)
> -				of_scan_pci_bridge(child, dev);
> +			of_scan_pci_bridge(child, dev);

The intention was probably to check "child" instead of "dev".
pci_device_to_OF_node() can return NULL.  On the other hand the code
has been this way for a year and no one has complained...

regards,
dan carpenter

>  		}
>  	}
>  }
