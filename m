Return-Path: <avorontsov@ru.mvista.com>
Received: from buildserver.ru.mvista.com (unknown [85.21.88.6])
	by ozlabs.org (Postfix) with ESMTP id 6ACB4DDDE6
	for <linuxppc-dev@ozlabs.org>; Tue, 21 Aug 2007 23:45:19 +1000 (EST)
Received: from localhost (unknown [10.150.0.9])
	by buildserver.ru.mvista.com (Postfix) with ESMTP id B7C798810
	for <linuxppc-dev@ozlabs.org>; Tue, 21 Aug 2007 18:45:16 +0500 (SAMST)
Date: Tue, 21 Aug 2007 17:45:37 +0400
From: Anton Vorontsov <avorontsov@ru.mvista.com>
To: linuxppc-dev@ozlabs.org
Subject: [PATCH v4 0/2] SPI support for fsl_soc and mpc832x_rdb
Message-ID: <20070821134537.GA7428@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf8
Reply-To: avorontsov@ru.mvista.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Hi all,

Thanks for the previous reviews, this is v4 against Linus' tree,
as of today.

Changelog:

v3 -> v4
  - removed fsl,device-id property from SPI nodes;
  - instead of fsl_spi_info structure, now fsl_spi_init() accepting
    four arguments;
  - machine_is(mpc832x_rdb) added in the beginning of
    mpc832x_spi_init().

v2 -> v3
o Device tree:
  - completely removed mmc node;
  - removed pio-handles and pio-maps.

o board file:
  - Instead of par_io_of_config(), now par_io_config_pin() used to
    configure GPIO pins, which does not require device tree node.

v1 -> v2
o Device tree:
  - cosmetic cleanups (@01 -> @1);
  - device-id renamed to fsl,device-id;
  - removed max-chipselect and sysclk properties from spi node;
  - removed chipselect property from mmc node, now reg property
    used for this purpose, thereby address-cells and size-cells
    added to the spi node;
  - other non-mandatory (device-id, device_type, compatible, ...)
    properties removed from mmc node, today board file is using
    of_find_node_by_name(), instead of of_find_compatible_node();
  - "qe" mode renamed to "cpu-qe".

o board file <-> fsl_soc interaction
  - fsl_soc no longer scans for SPI nodes in the arch initcall.
    Also it's no longer exports any global variables. Instead, it's
    export fsl_spi_init function now, which accepts pointer to the
    fsl_spi_board_info structure;
  - board file fills fsl_spi_board_info structure and issues
    fsl_spi_init(), which register SPI devices and SPI board infos.
    Various sanity checks also perfromed.

    I'd want to note that if spi_mpc83xx will be converted to
    of_platform_driver then the scheme described above will not
    work anymore, and I'll have to revert back ugly hacks:
    global variables for activate/deactivate_cs functions. I see
    no other options.

Thanks,

-- 
Anton Vorontsov
email: cbou@mail.ru
backup email: ya-cbou@yandex.ru
irc://irc.freenode.net/bd2
