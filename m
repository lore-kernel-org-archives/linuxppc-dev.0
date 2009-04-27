Return-Path: <timur.tabi@gmail.com>
Received: from mail-qy0-f123.google.com (mail-qy0-f123.google.com
	[209.85.221.123]) by ozlabs.org (Postfix) with ESMTP id E9A31DDE98
	for <linuxppc-dev@ozlabs.org>; Tue, 28 Apr 2009 00:31:14 +1000 (EST)
Received: by qyk29 with SMTP id 29so6008757qyk.17
	for <linuxppc-dev@ozlabs.org>; Mon, 27 Apr 2009 07:31:13 -0700 (PDT)
MIME-Version: 1.0
Sender: timur.tabi@gmail.com
In-Reply-To: <D7CCA83BB0796C49BC0BB53B6AB1208928CA1D@zch01exm21.fsl.freescale.net>
References: <20090424183517.GB23140@ovro.caltech.edu>
	<D7CCA83BB0796C49BC0BB53B6AB1208928CA1D@zch01exm21.fsl.freescale.net>
Date: Mon, 27 Apr 2009 09:31:12 -0500
Message-ID: <ed82fe3e0904270731g2d2519a7mc12e4152c716c0a9@mail.gmail.com>
Subject: Re: [PATCH] fsldma: use PCI Read Multiple command
From: Timur Tabi <timur@freescale.com>
To: Liu Dave-R63238 <DaveLiu@freescale.com>
Content-Type: text/plain; charset=ISO-8859-1
Cc: Ira Snyder <iws@ovro.caltech.edu>, linux-kernel@vger.kernel.org,
	linuxppc-dev@ozlabs.org, Dan Williams <dan.j.williams@intel.com>,
	Zhang Wei <wei.zhang@freescale.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Mon, Apr 27, 2009 at 4:09 AM, Liu Dave-R63238 <DaveLiu@freescale.com> wrote:

> You are assuming the PCI memory space is prefetchable( no side effect)
> for DMA.
> Is it possible that DMA is from non-prefetchable memory space?

This should be a safe assumption for this driver.  Remember, this
driver just does offload memcpy, from one region to another.  So the
PCI memory that you are reading from should be just a buffer of data,
and there should be side-effect of reading it.

However, I would like to see a comment at the top of the file warning
people that copying from PCI memory will result in prefetched reads.

-- 
Timur Tabi
Linux kernel developer at Freescale
