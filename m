Return-Path: <a13xp0p0v88@gmail.com>
Received: from mail-wg0-x232.google.com (mail-wg0-x232.google.com
 [IPv6:2a00:1450:400c:c00::232])
 (using TLSv1 with cipher ECDHE-RSA-RC4-SHA (128/128 bits))
 (Client CN "smtp.gmail.com",
 Issuer "Google Internet Authority G2" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 4C6CB2C00C1
 for <linuxppc-dev@lists.ozlabs.org>; Fri,  4 Oct 2013 00:00:29 +1000 (EST)
MIME-Version: 1.0
In-Reply-To: <1373803321-11628-1-git-send-email-gsi@denx.de>
References: <1373642781-32631-1-git-send-email-gsi@denx.de>
 <1373803321-11628-1-git-send-email-gsi@denx.de>
Date: Thu, 3 Oct 2013 18:00:22 +0400
Message-ID: <CAF0T0X6NE=wFYMzVEm4F9CQWXN-Bu201Z8duEH9kevOhB53jCg@mail.gmail.com>
Subject: Re: [PATCH RFC v2 0/5] MPC512x DMA slave s/g support, OF DMA lookup
From: Alexander Popov <a13xp0p0v88@gmail.com>
To: Gerhard Sittig <gsi@denx.de>
Content-Type: text/plain; charset=ISO-8859-1
Cc: Lars-Peter Clausen <lars@metafoo.de>, Arnd Bergmann <arnd@arndb.de>,
 Vinod Koul <vinod.koul@intel.com>, devicetree-discuss@lists.ozlabs.org,
 Alexander Popov <a13xp0p0v88@gmail.com>, Dan Williams <djbw@fb.com>,
 Anatolij Gustschin <agust@denx.de>, linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

v2013/7/14 Gerhard Sittig <gsi@denx.de>:
> this series
> - introduces slave s/g support (that's support for DMA transfers which
>   involve peripherals in contrast to mem-to-mem transfers)
> - adds device tree based lookup support for DMA channels
> - combines floating patches and related feedback which already covered
>   several aspects of what the suggested LPB driver needs, to demonstrate
>   how integration might be done
> - carries Q&D SD card support to enable another DMA client during test,
>   while this patch needs to get dropped upon pickup
>
> changes since v1:
> - re-order mpc8308 related code paths for improved readability, no
>   change in behaviour, introduction of symbolic channel names here
>   already
> - squash 'execute() start condition' and 'terminate all' into the
>   introduction of 'slave s/g prep' and 'device control' support; refuse
>   s/g lists with more than one item since slave support is operational
>   yet proper s/g support is missing (can get addressed later)
> - always start transfers from software on MPC8308 as there are no
>   external request lines for peripheral flow control
> - drop dt-bindings header file and symbolic channel names in OF nodes

Changes since v2 (RFC v3 was badly formed, excuse me for that):
Part 1/5:
- use #define instead of enum since individual channels don't require
special handling.
Part 2/5:
- add a flag "will_access_peripheral" to DMA transfer descriptor
  according recommendations of Gerhard Sittig.
  This flag is set in mpc_dma_prep_memcpy() and mpc_dma_prep_slave_sg()
  and is evaluated in mpc_dma_execute() to choose a type of start for
the transfer.
- prevent descriptors of transfers which involve peripherals from
being chained together;
  each of such transfers needs hardware initiated start.
- add locking while working with struct mpc_dma_chan
  according recommendations of Lars-Peter Clausen.
- remove default nbytes value. Client kernel modules must set
  src_maxburst and dst_maxburst fields of struct dma_slave_config (dmaengine.h).
Part 6/8:
  unchanged.
Part 7/8:
  unchanged.
Part 8/8:
  unchanged.

These changes are tested on MPC5125
- with SCLPC driver (transfers between dev and mem work fine).
- with dmatest module (all 64 DMA channels can perform mem-to-mem transfers
  which can be chained in one DMA transaction).

> known issues:
> - it's yet to get confirmed whether MPC8308 can use slave support or
>   whether the DMA controller's driver shall actively reject it, the
>   information that's available so far suggests that peripheral transfers
>   to IP bus attached I/O is useful and shall not get blocked right away
>
