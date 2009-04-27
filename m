Return-Path: <timur@freescale.com>
Received: from az33egw02.freescale.net (az33egw02.freescale.net
	[192.88.158.103])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "az33egw02.freescale.net",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id 98740DDDA2
	for <linuxppc-dev@ozlabs.org>; Tue, 28 Apr 2009 06:26:44 +1000 (EST)
Message-ID: <49F614FC.70000@freescale.com>
Date: Mon, 27 Apr 2009 15:26:36 -0500
From: Timur Tabi <timur@freescale.com>
MIME-Version: 1.0
To: David Hawkins <dwh@ovro.caltech.edu>
Subject: Re: [PATCH] fsldma: use PCI Read Multiple command
References: <20090424183517.GB23140@ovro.caltech.edu>	<D7CCA83BB0796C49BC0BB53B6AB1208928CA1D@zch01exm21.fsl.freescale.net>
	<ed82fe3e0904270731g2d2519a7mc12e4152c716c0a9@mail.gmail.com>
	<49F608B7.9080409@ovro.caltech.edu>
	<49F60A3A.4060402@freescale.com>
	<49F61416.8040501@ovro.caltech.edu>
In-Reply-To: <49F61416.8040501@ovro.caltech.edu>
Content-Type: text/plain; charset=ISO-8859-1
Cc: linuxppc-dev@ozlabs.org, Dan Williams <dan.j.williams@intel.com>,
	Liu Dave-R63238 <DaveLiu@freescale.com>,
	linux-kernel@vger.kernel.org, Ira Snyder <iws@ovro.caltech.edu>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

David Hawkins wrote:

> PRC_RM - PCI read multiple
>    The default PCI read command used by the DMA controller is
>    PCI Read (PCI command 6h). When the burst length is 32-bytes
>    or longer, PCI Read Line (PCI command Eh) is used (undocumented
>    feature of the controller). Using PCI read multiple
>    (PCI command Ch) results in high-performance across PCI
>    bridges. DMA transfers to non-prefetchable PCI registers
>    should not result in prefetched reads, even when using
>    the PCI read multiple command.

I was thinking more along the lines of:

"This driver tells the DMA controller to use the PCI Read Multiple
command, instead of the PCI Read Line command, for PCI read operations.
 Please be aware that this setting may result in read pre-fetching on
some platforms."

-- 
Timur Tabi
Linux kernel developer at Freescale
