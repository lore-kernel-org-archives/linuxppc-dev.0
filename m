Return-Path: <a13xp0p0v88@gmail.com>
MIME-Version: 1.0
In-Reply-To: <1373803321-11628-1-git-send-email-gsi@denx.de>
References: <1373642781-32631-1-git-send-email-gsi@denx.de>
 <1373803321-11628-1-git-send-email-gsi@denx.de>
Date: Tue, 16 Jul 2013 13:27:23 +0400
Message-ID: <CAF0T0X4jtO6MStWEs3B=9pCv76LfAGyE7W3JL+Xg2T46gvuomQ@mail.gmail.com>
Subject: Re: [PATCH RFC v2 0/5] MPC512x DMA slave s/g support, OF DMA lookup
From: Alexander Popov <a13xp0p0v88@gmail.com>
To: Gerhard Sittig <gsi@denx.de>
Content-Type: text/plain; charset=ISO-8859-1
Cc: Lars-Peter Clausen <lars@metafoo.de>, Arnd Bergmann <arnd@arndb.de>,
 Vinod Koul <vinod.koul@intel.com>, devicetree-discuss@lists.ozlabs.org,
 Dan Williams <djbw@fb.com>, Anatolij Gustschin <agust@denx.de>,
 linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Hello everyone!

Hello Gerhard!
Thanks for your work.

2013/7/14 Gerhard Sittig <gsi@denx.de>:
> known issues:
> - currently encoded constraints do work for SD card and LPB test suite
>   (all known DMA clients ATM), but will need more tuning or support for
>   automatic adjustment for transfers of arbitrary length

NBYTES of data is read from / written to DMA client's port in one burst
after DMA controller receives service request from that DMA client.

Different DMA clients want different NBYTES:
SCLPC wants 4 and SD card wants 64, other clients might want something
different.
So having default case with magic number 64 is totally wrong.

What if we simply remove it from [PATCH RFC v2 2/5]:

               len = sg_dma_len(sg);

               if (mchan->tcd_nunits)
                       tcd->nbytes = mchan->tcd_nunits * 4;
-               else
-                       tcd->nbytes = 64;

               if (!IS_ALIGNED(len, tcd->nbytes))
                       return NULL;

and make SD card driver use fields
src_addr_width, dst_addr_width and src_maxburst / dst_maxburst
of dma_slave_config which is a part of standard API (dmaengine.h):

#define DEFAULT_WORDS_PER_TRANSFER    16
...

struct dma_slave_config dma_conf = {};
...

if (dma_conf.direction = DMA_MEM_TO_DEV) {
        dma_conf.dst_maxburst = DEFAULT_WORDS_PER_TRANSFER;
} else {
        dma_conf.src_maxburst = DEFAULT_WORDS_PER_TRANSFER;
}

dma_conf.dst_addr_width = DMA_SLAVE_BUSWIDTH_4_BYTES;
dma_conf.src_addr_width = DMA_SLAVE_BUSWIDTH_4_BYTES;
...

if (dma_dev->device_control(chan, DMA_SLAVE_CONFIG,
                (unsigned long)&dma_conf)) {
        goto err_dma_prep;
}

This code for SD card driver would be very similar to the code from
SCLPC driver.

Best regards,
Alexander
