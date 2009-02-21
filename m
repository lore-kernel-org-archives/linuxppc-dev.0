Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 79D7FDDF11
	for <linuxppc-dev@ozlabs.org>; Sat, 21 Feb 2009 15:38:20 +1100 (EST)
Subject: Re: ioremap fails for a device in PCI-E slot on AMCC katmai board
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Shubhada Pugaonkar <shubhada@chelsio.com>
In-Reply-To: <8A71B368A89016469F72CD08050AD33402D57562@maui.asicdesigners.com>
References: <8A71B368A89016469F72CD08050AD33402D57562@maui.asicdesigners.com>
Content-Type: text/plain
Date: Sat, 21 Feb 2009 15:38:03 +1100
Message-Id: <1235191083.8805.207.camel@pasglop>
Mime-Version: 1.0
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Fri, 2009-02-20 at 17:35 -0800, Shubhada Pugaonkar wrote:

> ****************************************************
> 
> cxgb3_main.c:
> 
>         mmio_start = pci_resource_start(pdev, 0);
> 
>         mmio_len = pci_resource_len(pdev, 0);
> 
>         ai = t3_get_adapter_info(ent->driver_data);
> 

My bet is that mmio_start is an unsigned long instead of a
resource_size_t and thus gets cropped (ie, driver bug).

 (/me goes read the source)

Yes, indeed, that's the problem. Change the definition
of mmio_start and mmio_len to resource_size_t, that should
fix it. I suspect the other driver has the same problem.

Note: They will still get cropped, I suspect, when copied
to netdev->mem_start, nothing much to do here, but fortunately
those fields aren't used.

BTW. If you do patches to fix those drivers, please send them
to the netdev@vger.kernel.org mailing list too.

Cheers,
Ben.
