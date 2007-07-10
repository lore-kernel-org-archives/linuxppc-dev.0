Return-Path: <randy.dunlap@ORACLE.COM>
Received: from agminet02.oracle.com (agminet02.oracle.com [141.146.126.229])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id F037FDDEBE
	for <linuxppc-dev@ozlabs.org>; Wed, 11 Jul 2007 02:37:48 +1000 (EST)
Received: from agminet01.oracle.com (agminet01.oracle.com [141.146.126.228])
	by agminet02.oracle.com (Switch-3.2.4/Switch-3.1.7) with ESMTP id
	l6AFgrnU003694
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO)
	for <linuxppc-dev@ozlabs.org>; Tue, 10 Jul 2007 10:42:53 -0500
Date: Tue, 10 Jul 2007 08:46:03 -0700
From: Randy Dunlap <randy.dunlap@ORACLE.COM>
To: Zhang Wei <wei.zhang@freescale.com>
Subject: Re: [PATCH 3/4] Extend the DMA-engine API.
Message-Id: <20070710084603.286d7bb8.randy.dunlap@oracle.com>
In-Reply-To: <11840607111926-git-send-email-wei.zhang@freescale.com>
References: <11840607111926-git-send-email-wei.zhang@freescale.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Cc: linuxppc-dev@ozlabs.org, akpm@linux-foundation.org, paulus@samba.org,
	linux-kernel@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Tue, 10 Jul 2007 17:45:11 +0800 Zhang Wei wrote:

> Add channel wait queue and transfer callback dma_xfer_callback().
> If the DMA controller and driver support interrupt, when the
> transfer is finished, it will wakeup the wait queue
> and call the callback function of the channel.
> 
> Add dma_async_raw_xfer() to API and device_raw_xfer() to struct dma_device
> for RAW physical address DMA transfer, which will be used at transfer
> between I/O address and memory address.
> 
> Signed-off-by: Zhang Wei <wei.zhang@freescale.com>
> ---
>  include/linux/dmaengine.h |   35 +++++++++++++++++++++++++++++++++++
>  1 files changed, 35 insertions(+), 0 deletions(-)

>  /**
> + * dma_async_raw_xfer - transfor data between physical addresses with callback

                           transfer

> + * @chan: DMA channel to be used
> + * @dest: destination address (physical)
> + * @src: source address (physical)
> + * @len: length
> + */
> +static inline dma_cookie_t dma_async_raw_xfer(struct dma_chan *chan,
> +				dma_addr_t dest, dma_addr_t src, size_t len,
> +				dma_xfer_callback cb, void *data)
> +{


---
~Randy
*** Remember to use Documentation/SubmitChecklist when testing your code ***
