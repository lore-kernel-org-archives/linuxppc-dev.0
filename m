Return-Path: <dwh@ovro.caltech.edu>
Received: from ovro.ovro.caltech.edu (ovro.ovro.caltech.edu [192.100.16.2])
	by ozlabs.org (Postfix) with ESMTP id 007F0DDDF0
	for <linuxppc-dev@ozlabs.org>; Tue, 28 Apr 2009 06:41:39 +1000 (EST)
Message-ID: <49F6187F.8020703@ovro.caltech.edu>
Date: Mon, 27 Apr 2009 13:41:35 -0700
From: David Hawkins <dwh@ovro.caltech.edu>
MIME-Version: 1.0
To: Timur Tabi <timur@freescale.com>
Subject: Re: [PATCH] fsldma: use PCI Read Multiple command
References: <20090424183517.GB23140@ovro.caltech.edu>	<D7CCA83BB0796C49BC0BB53B6AB1208928CA1D@zch01exm21.fsl.freescale.net>
	<ed82fe3e0904270731g2d2519a7mc12e4152c716c0a9@mail.gmail.com>
	<49F608B7.9080409@ovro.caltech.edu>
	<49F60A3A.4060402@freescale.com>
	<49F61416.8040501@ovro.caltech.edu> <49F614FC.70000@freescale.com>
In-Reply-To: <49F614FC.70000@freescale.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
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

Hi Timur,

>> PRC_RM - PCI read multiple
>>    The default PCI read command used by the DMA controller is
>>    PCI Read (PCI command 6h). When the burst length is 32-bytes
>>    or longer, PCI Read Line (PCI command Eh) is used (undocumented
>>    feature of the controller). Using PCI read multiple
>>    (PCI command Ch) results in high-performance across PCI
>>    bridges. DMA transfers to non-prefetchable PCI registers
>>    should not result in prefetched reads, even when using
>>    the PCI read multiple command.
> 
> I was thinking more along the lines of:
> 
> "This driver tells the DMA controller to use the PCI Read Multiple
> command, instead of the PCI Read Line command, for PCI read operations.
>  Please be aware that this setting may result in read pre-fetching on
> some platforms."

Ok, thanks.

Ira will add your comment to the body of the code near
the PRC_RM command and submit a new patch.

Cheers,
Dave
