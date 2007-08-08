Return-Path: <avorontsov@ru.mvista.com>
Received: from buildserver.ru.mvista.com (unknown [85.21.88.6])
	by ozlabs.org (Postfix) with ESMTP id D4E6DDDE1E
	for <linuxppc-dev@ozlabs.org>; Thu,  9 Aug 2007 03:05:50 +1000 (EST)
Received: from localhost (unknown [10.150.0.9])
	by buildserver.ru.mvista.com (Postfix) with ESMTP id E62098814
	for <linuxppc-dev@ozlabs.org>; Wed,  8 Aug 2007 22:05:47 +0500 (SAMST)
Date: Wed, 8 Aug 2007 21:07:28 +0400
From: Anton Vorontsov <avorontsov@ru.mvista.com>
To: linuxppc-dev@ozlabs.org
Subject: [PATCH v3 0/2] SPI support for fsl_soc and mpc832x_rdb
Message-ID: <20070808170728.GA21118@localhost.localdomain>
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

This is v3. The only objection I can imagine is about "fsl,device-id".
Though in the v2 nobody complained, thus it's stayed intact.

If you want to, complain now. I'll give up and will remove it. ;-)

Changelog:

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
