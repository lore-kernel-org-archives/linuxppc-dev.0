Return-Path: <a13xp0p0v88@gmail.com>
Received: from mail-la0-x233.google.com (mail-la0-x233.google.com
 [IPv6:2a00:1450:4010:c03::233])
 (using TLSv1 with cipher ECDHE-RSA-RC4-SHA (128/128 bits))
 (Client CN "smtp.gmail.com",
 Issuer "Google Internet Authority G2" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 094592C03F9
 for <linuxppc-dev@lists.ozlabs.org>; Fri,  1 Nov 2013 18:16:23 +1100 (EST)
Received: by mail-la0-f51.google.com with SMTP id ea20so3077711lab.38
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 01 Nov 2013 00:16:17 -0700 (PDT)
From: Alexander Popov <a13xp0p0v88@gmail.com>
To: Gerhard Sittig <gsi@denx.de>, Dan Williams <dan.j.williams@intel.com>,
 Vinod Koul <vinod.koul@intel.com>, Lars-Peter Clausen <lars@metafoo.de>,
 Arnd Bergmann <arnd@arndb.de>, Anatolij Gustschin <agust@denx.de>,
 Alexander Popov <a13xp0p0v88@gmail.com>, linuxppc-dev@lists.ozlabs.org,
 devicetree@vger.kernel.org
Subject: [PATCH RFC v5 0/5] MPC512x DMA slave s/g support, OF DMA lookup
Date: Fri,  1 Nov 2013 11:19:29 +0400
Message-Id: <1383290374-17484-1-git-send-email-a13xp0p0v88@gmail.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

03.10.2013 18:00, Alexander Popov <a13xp0p0v88@gmail.com>:
> v2013/7/14 Gerhard Sittig <gsi@denx.de>:
>> this series
>> - introduces slave s/g support (that's support for DMA transfers which
>>    involve peripherals in contrast to mem-to-mem transfers)
>> - adds device tree based lookup support for DMA channels
>> - combines floating patches and related feedback which already covered
>>    several aspects of what the suggested LPB driver needs, to demonstrate
>>    how integration might be done
>> - carries Q&D SD card support to enable another DMA client during test,
>>    while this patch needs to get dropped upon pickup
>>

Changes in v2:
>> - re-order mpc8308 related code paths for improved readability, no
>>    change in behaviour, introduction of symbolic channel names here
>>    already
>> - squash 'execute() start condition' and 'terminate all' into the
>>    introduction of 'slave s/g prep' and 'device control' support; refuse
>>    s/g lists with more than one item since slave support is operational
>>    yet proper s/g support is missing (can get addressed later)
>> - always start transfers from software on MPC8308 as there are no
>>    external request lines for peripheral flow control
>> - drop dt-bindings header file and symbolic channel names in OF nodes

Changes in v3 and v4:
> Part 1/5:
> - use #define instead of enum since individual channels don't require
>    special handling.
> Part 2/5:
> - add a flag "will_access_peripheral" to DMA transfer descriptor
>    according recommendations of Gerhard Sittig.
>    This flag is set in mpc_dma_prep_memcpy() and mpc_dma_prep_slave_sg()
>    and is evaluated in mpc_dma_execute() to choose a type of start for
>    the transfer.
> - prevent descriptors of transfers which involve peripherals from
>    being chained together;
>    each of such transfers needs hardware initiated start.
> - add locking while working with struct mpc_dma_chan
>    according recommendations of Lars-Peter Clausen.
> - remove default nbytes value. Client kernel modules must set
>    src_maxburst and dst_maxburst fields of struct dma_slave_config (dmaengine.h).

Changes in v5:
 Part 2/5::
 - add and improve comments;
 - improve the code moving transfer descriptors from 'queued' to 'active' list
    in mpc_dma_execute();
 - allow mpc_dma_prep_slave_sg() to run with non-empty 'active' list;
 - take 'mdesc' back to 'free' list in case of error in mpc_dma_prep_slave_sg();
 - improve checks of the transfer parameters;
 - provide the default value for 'maxburst' in mpc_dma_device_control().

Last changes are tested on MPC5125
 - with SCLPC driver (transfers between dev and mem work fine);
 - with dmatest module (all 64 DMA channels can perform mem-to-mem transfers
    which are chained correctly now).

>> known issues:
>> - it's yet to get confirmed whether MPC8308 can use slave support or
>>    whether the DMA controller's driver shall actively reject it, the
>>    information that's available so far suggests that peripheral transfers
>>    to IP bus attached I/O is useful and shall not get blocked right away
 - adding support for transfers which don't increment the RAM address or
    do increment the peripheral "port's" address is easy with
    this implementation; but which options of the common API
    should be used for specifying such transfers?


Alexander Popov (2):
  dma: mpc512x: reorder mpc8308 specific instructions
  dma: mpc512x: add support for peripheral transfers

Gerhard Sittig (2):
  dma: mpc512x: register for device tree channel lookup
  HACK mmc: mxcmmc: enable clocks for the MPC512x

Lars-Peter Clausen (1):
  dma: of: Add common xlate function for matching by channel id

 .../devicetree/bindings/dma/mpc512x-dma.txt        |  55 ++++
 arch/powerpc/boot/dts/mpc5121.dtsi                 |   1 +
 drivers/dma/mpc512x_dma.c                          | 295 +++++++++++++++++++--
 drivers/dma/of-dma.c                               |  47 ++++
 drivers/mmc/host/mxcmmc.c                          |  41 ++-
 include/linux/of_dma.h                             |   4 +
 6 files changed, 404 insertions(+), 39 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/dma/mpc512x-dma.txt

-- 
1.7.11.3
