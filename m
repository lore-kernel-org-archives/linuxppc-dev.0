Return-Path: <a13xp0p0v88@gmail.com>
Received: from mail-wg0-x230.google.com (mail-wg0-x230.google.com
 [IPv6:2a00:1450:400c:c00::230])
 (using TLSv1 with cipher ECDHE-RSA-RC4-SHA (128/128 bits))
 (Client CN "smtp.gmail.com",
 Issuer "Google Internet Authority G2" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 0FAB32C00A0
 for <linuxppc-dev@lists.ozlabs.org>; Sat,  7 Dec 2013 07:27:43 +1100 (EST)
MIME-Version: 1.0
In-Reply-To: <20131006111038.GN14747@book.gsilab.sittig.org>
References: <1380809202-16192-1-git-send-email-a13xp0p0v88@gmail.com>
 <20131006111038.GN14747@book.gsilab.sittig.org>
Date: Sat, 7 Dec 2013 00:27:36 +0400
Message-ID: <CAF0T0X6XhHk5qhwk=Kzu_YvMNduZaMqNxGWRyyeNP8LWzDJziw@mail.gmail.com>
Subject: Re: [PATCH RFC v4 2/5] dma: mpc512x: add support for peripheral
 transfers
From: Alexander Popov <a13xp0p0v88@gmail.com>
To: Gerhard Sittig <gsi@denx.de>, Dan Williams <dan.j.williams@intel.com>,
 Vinod Koul <vinod.koul@intel.com>, Lars-Peter Clausen <lars@metafoo.de>,
 Arnd Bergmann <arnd@arndb.de>,
 Anatolij Gustschin <agust@denx.de>, Alexander Popov <a13xp0p0v88@gmail.com>,
 devicetree-discuss@lists.ozlabs.org, linuxppc-dev@lists.ozlabs.org
Content-Type: text/plain; charset=ISO-8859-1
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

2013/10/6 Gerhard Sittig <gsi@denx.de>:
> On Thu, Oct 03, 2013 at 18:06 +0400, Alexander Popov wrote:
>> +
>> +             spin_lock_irqsave(&mchan->lock, flags);
>> +
>> +             if (cfg->direction == DMA_DEV_TO_MEM) {
>
> Note that cfg->direction is of a different type than
> DMA_DEV_TO_MEM (of different type than the 'direction' parameter
> in the preparation routine) -- it's mere coincidence that the
> numeric values happen to match at the moment.

Gerhard, it seems to me that this code is correct.
Cite from dmaengine.h:

  * struct dma_slave_config - dma slave channel runtime config
  * @direction: whether the data shall go in or out on this slave
  * channel, right now. DMA_TO_DEVICE and DMA_FROM_DEVICE are
  * legal values, DMA_BIDIRECTIONAL is not acceptable since we
  * need to differentiate source and target addresses.
  ...
  struct dma_slave_config {
          enum dma_transfer_direction direction;
          ...
  };

The comment above the definition is obsolete, isn't it?

Thanks
Alexander
