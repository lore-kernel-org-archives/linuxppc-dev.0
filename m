Return-Path: <a13xp0p0v88@gmail.com>
Received: from mail-la0-x22a.google.com (mail-la0-x22a.google.com
 [IPv6:2a00:1450:4010:c03::22a])
 (using TLSv1 with cipher ECDHE-RSA-RC4-SHA (128/128 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id 32C302C00A6
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 24 Feb 2014 22:09:50 +1100 (EST)
Received: by mail-la0-f42.google.com with SMTP id ec20so1094414lab.15
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 24 Feb 2014 03:09:44 -0800 (PST)
From: Alexander Popov <a13xp0p0v88@gmail.com>
To: Gerhard Sittig <gsi@denx.de>, Dan Williams <dan.j.williams@intel.com>,
 Vinod Koul <vinod.koul@intel.com>, Lars-Peter Clausen <lars@metafoo.de>,
 Arnd Bergmann <arnd@arndb.de>, Anatolij Gustschin <agust@denx.de>,
 Alexander Popov <a13xp0p0v88@gmail.com>, linuxppc-dev@lists.ozlabs.org,
 dmaengine@vger.kernel.org
Subject: [PATCH RFC v8 0/5] MPC512x DMA slave s/g support, OF DMA lookup
Date: Mon, 24 Feb 2014 15:09:27 +0400
Message-Id: <1393240172-18769-1-git-send-email-a13xp0p0v88@gmail.com>
Cc: devicetree@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

2013/7/14 Gerhard Sittig <gsi@denx.de>:
> this series
> - introduces slave s/g support (that's support for DMA transfers which
>    involve peripherals in contrast to mem-to-mem transfers)
> - adds device tree based lookup support for DMA channels
> - combines floating patches and related feedback which already covered
>    several aspects of what the suggested LPB driver needs, to demonstrate
>    how integration might be done
> - carries Q&D SD card support to enable another DMA client during test,
>    while this patch needs to get dropped upon pickup

Changes in v2:
> - re-order mpc8308 related code paths for improved readability, no
>    change in behaviour, introduction of symbolic channel names here
>    already
> - squash 'execute() start condition' and 'terminate all' into the
>    introduction of 'slave s/g prep' and 'device control' support; refuse
>    s/g lists with more than one item since slave support is operational
>    yet proper s/g support is missing (can get addressed later)
> - always start transfers from software on MPC8308 as there are no
>    external request lines for peripheral flow control
> - drop dt-bindings header file and symbolic channel names in OF nodes

Changes in v3 and v4:
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

Changes in v5:
 Part 2/5:
 - add and improve comments;
 - improve the code moving transfer descriptors from 'queued' to 'active' list
    in mpc_dma_execute();
 - allow mpc_dma_prep_slave_sg() to run with non-empty 'active' list;
 - take 'mdesc' back to 'free' list in case of error in mpc_dma_prep_slave_sg();
 - improve checks of the transfer parameters;
 - provide the default value for 'maxburst' in mpc_dma_device_control().

Changes in v6:
 Part 2/5:
 - remove doubtful comment;
 - fix coding style issues;
 - set default value for 'maxburst' to 1 which applies to most cases;
 Part 3/5:
 - use dma_get_slave_channel() instead of dma_request_channel()
    in new function of_dma_xlate_by_chan_id() according recommendations of
    Arnd Bergmann;
 Part 4/5:
 - set DMA_PRIVATE flag for MPC512x DMA controller since its driver relies on
    of_dma_xlate_by_chan_id() which doesn't use dma_request_channel()
    any more; (removed in v7)
 - resolve little patch conflict;
 Part 5/5:
 - resolve little patch conflict;

Changes in v7:
 Part 2:
 - improve comment;
 Part 4:
 - split in two separate patches. Part 4/6 contains device tree
    binding document and in part 5/6 MPC512x DMA controller is registered
    for device tree channel lookup;
 - remove setting DMA_PRIVATE flag for MPC512x DMA controller from part 5/6;

Changes in v8:
 Part 2:
 - improve comments;
 - fix style issues;
 Part 6:
 - remove since it has become obsolete;

> known issues:
> - it's yet to get confirmed whether MPC8308 can use slave support or
>    whether the DMA controller's driver shall actively reject it, the
>    information that's available so far suggests that peripheral transfers
>    to IP bus attached I/O is useful and shall not get blocked right away
 - adding support for transfers which don't increment the RAM address or
    do increment the peripheral "port's" address is easy with
    this implementation; but which options of the common API
    should be used for specifying such transfers?
2014/02/13 Gerhard Sittig <gsi@denx.de>:
> - The MPC512x DMA completely lacks a binding document, so one
>    should get added.
> - The MPC8308 hardware is similar and can re-use the MPC512x
>    binding, which should be stated.
> - The Linux implementation currently has no OF based channel
>    lookup support, so '#dma-cells' is "a future feature".  I guess
>    the binding can and should already discuss the feature,
>    regardless of whether all implementations support it.


Alexander Popov (3):
  dma: mpc512x: reorder mpc8308 specific instructions
  dma: mpc512x: add support for peripheral transfers
  dma: of: Add common xlate function for matching by channel id

Gerhard Sittig (2):
  dma: mpc512x: add device tree binding document
  dma: mpc512x: register for device tree channel lookup

 .../devicetree/bindings/dma/mpc512x-dma.txt        |  55 ++++
 arch/powerpc/boot/dts/mpc5121.dtsi                 |   1 +
 drivers/dma/mpc512x_dma.c                          | 298 +++++++++++++++++++--
 drivers/dma/of-dma.c                               |  35 +++
 include/linux/of_dma.h                             |   4 +
 5 files changed, 368 insertions(+), 25 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/dma/mpc512x-dma.txt

-- 
1.8.4.2
