Return-Path: <yur@emcraft.com>
Received: from ocean.emcraft.com (ocean.emcraft.com [213.221.7.182])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id F0A3CDDEFF
	for <linuxppc-dev@ozlabs.org>; Sat, 17 Jan 2009 23:26:57 +1100 (EST)
Date: Sat, 17 Jan 2009 15:26:57 +0300
From: Yuri Tikhonov <yur@emcraft.com>
Message-ID: <20244211.20090117152657@emcraft.com>
To: Dan Williams <dan.j.williams@intel.com>
Subject: Re[4]: [PATCH 03/11][v3] async_tx: add support for asynchronous RAID6
	recovery operations
In-Reply-To: <e9c3a7c20901161037l6ab42609td327f6f33406e2d@mail.gmail.com>
References: <200901130343.14016.yur@emcraft.com>
	<e9c3a7c20901141706v17215220s22d973f81369be72@mail.gmail.com>
	<498243073.20090116145142@emcraft.com>
	<e9c3a7c20901161037l6ab42609td327f6f33406e2d@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Cc: linux-raid@vger.kernel.org, linuxppc-dev@ozlabs.org, wd@denx.de,
	dzu@denx.de, yanok@emcraft.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Friday, January 16, 2009 you wrote:

> On Fri, Jan 16, 2009 at 4:51 AM, Yuri Tikhonov <yur@emcraft.com> wrote:
>>  The reason why I preferred to use async_pq() instead of async_xor()
>> here is to maximize the chance that the whole D+D recovery operation
>> will be handled in one ADMA device, i.e. without channels switch and
>> the latency introduced because of that.
>>

> This should be a function of the async_tx_find_channel implementation.
>  The default version tries to keep a chain of operations on one
> channel.

> struct dma_chan *
> __async_tx_find_channel(struct dma_async_tx_descriptor *depend_tx,
>         enum dma_transaction_type tx_type)
> {
>         /* see if we can keep the chain on one channel */
>         if (depend_tx &&
>             dma_has_cap(tx_type, depend_tx->chan->device->cap_mask))
>                 return depend_tx->chan;
>         return dma_find_channel(tx_type);
> }

 Right. Then I need to update my ADMA driver, and add support for=20
explicit DMA_XOR capability on channels which can process DMA_PQ.
Thanks.

 Regards, Yuri

 --
 Yuri Tikhonov, Senior Software Engineer
 Emcraft Systems, www.emcraft.com
