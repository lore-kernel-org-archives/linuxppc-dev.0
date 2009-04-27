Return-Path: <pku.leo@gmail.com>
Received: from yx-out-2324.google.com (yx-out-2324.google.com [74.125.44.29])
	by ozlabs.org (Postfix) with ESMTP id E1433DDDF6
	for <linuxppc-dev@ozlabs.org>; Mon, 27 Apr 2009 20:16:21 +1000 (EST)
Received: by yx-out-2324.google.com with SMTP id 8so1260676yxb.39
	for <linuxppc-dev@ozlabs.org>; Mon, 27 Apr 2009 03:16:19 -0700 (PDT)
MIME-Version: 1.0
Sender: pku.leo@gmail.com
In-Reply-To: <D7CCA83BB0796C49BC0BB53B6AB1208928CA1D@zch01exm21.fsl.freescale.net>
References: <20090424183517.GB23140@ovro.caltech.edu>
	<D7CCA83BB0796C49BC0BB53B6AB1208928CA1D@zch01exm21.fsl.freescale.net>
Date: Mon, 27 Apr 2009 18:16:19 +0800
Message-ID: <2a27d3730904270316u6c06eafeja75f6e9e5c83ed29@mail.gmail.com>
Subject: Re: [PATCH] fsldma: use PCI Read Multiple command
From: Li Yang <leoli@freescale.com>
To: Liu Dave-R63238 <DaveLiu@freescale.com>
Content-Type: text/plain; charset=UTF-8
Cc: linuxppc-dev@ozlabs.org, Dan Williams <dan.j.williams@intel.com>,
	linux-kernel@vger.kernel.org, Ira Snyder <iws@ovro.caltech.edu>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Mon, Apr 27, 2009 at 5:09 PM, Liu Dave-R63238 <DaveLiu@freescale.com> wrote:
>> By default, the Freescale 83xx DMA controller uses the PCI Read Line
>> command when reading data over the PCI bus. Setting the
>> controller to use the PCI Read Multiple command instead allows the
>> controller to read much larger bursts of data, which provides a
> drastic
>> speed increase.
>
> IIRC, the default for 83xx DMA controller uses the PCI mem read
> command, not mem read line.
>
> You are assuming the PCI memory space is prefetchable( no side effect)
> for DMA.
> Is it possible that DMA is from non-prefetchable memory space?

I guess it's not reasonable to use DMA from non-prefetchable memory.
So it's up to the driver which uses the DMA engine to prevent from
using DMA API on non-prefetchable memory.

- Leo
