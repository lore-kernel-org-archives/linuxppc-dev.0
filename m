Return-Path: <dan.j.williams@gmail.com>
Received: from an-out-0708.google.com (an-out-0708.google.com [209.85.132.241])
	by ozlabs.org (Postfix) with ESMTP id 8D9CFDDE2E
	for <linuxppc-dev@ozlabs.org>; Thu, 12 Jul 2007 02:56:33 +1000 (EST)
Received: by an-out-0708.google.com with SMTP id c37so309663anc
	for <linuxppc-dev@ozlabs.org>; Wed, 11 Jul 2007 09:56:32 -0700 (PDT)
Message-ID: <e9c3a7c20707110956r5ea91fd1q1d0b33b9583fe91c@mail.gmail.com>
Date: Wed, 11 Jul 2007 09:56:31 -0700
From: "Dan Williams" <dan.j.williams@intel.com>
Sender: dan.j.williams@gmail.com
To: "Zhang Wei-r63237" <Wei.Zhang@freescale.com>
Subject: Re: [PATCH 3/4] Extend the DMA-engine API.
In-Reply-To: <46B96294322F7D458F9648B60E15112C6F3CED@zch01exm26.fsl.freescale.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
References: <11840607111926-git-send-email-wei.zhang@freescale.com>
	<e9c3a7c20707101141m17e313e2k99be5b7197edc910@mail.gmail.com>
	<46B96294322F7D458F9648B60E15112C6F3CED@zch01exm26.fsl.freescale.net>
Cc: shannon.nelson@intel.com, linux-kernel@vger.kernel.org,
	linuxppc-dev@ozlabs.org, paulus@samba.org, akpm@linux-foundation.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On 7/11/07, Zhang Wei-r63237 <Wei.Zhang@freescale.com> wrote:
> Hi, Dan,
>
> Do you mention here: http://marc.info/?l=linux-raid&m=118290909614463&w=2 ?
> I see the async_tx is located at crypto/ of the above page, but my patch is for DMA engine in drivers/dma and for DMA engine driver.
>
> Thanks!
> Wei.

Hi Wei,

I was referring to:
http://marc.info/?l=linux-raid&m=118290909528910&w=2

async_tx is an api that exploits the raw capabilities of the new
dmaengine interface.  For your case when the existing api calls do not
provide the proper interface you can open code something like the
following:

tx = dev->device_prep_dma_<operation>(chan, len, int_flag)
tx->tx_set_src(dma_addr_t, tx, index /* for multi-source ops */)
tx->tx_set_dest(dma_addr_t, tx, index)
tx->tx_submit(tx)

The expectation is that the most common usages of dmaengines will use
async_tx calls, or the 'dma_async_memcpy_foo_to_bar' helper routines.

--
Dan
