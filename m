Return-Path: <avorontsov@ru.mvista.com>
Received: from buildserver.ru.mvista.com (unknown [85.21.88.6])
	by ozlabs.org (Postfix) with ESMTP id 0AFF3DDD0B
	for <linuxppc-dev@ozlabs.org>; Fri,  3 Aug 2007 03:34:48 +1000 (EST)
Received: from localhost (unknown [10.150.0.9])
	by buildserver.ru.mvista.com (Postfix) with ESMTP id ABE5A8810
	for <linuxppc-dev@ozlabs.org>; Thu,  2 Aug 2007 22:34:45 +0500 (SAMST)
Date: Thu, 2 Aug 2007 21:33:35 +0400
From: Anton Vorontsov <avorontsov@ru.mvista.com>
To: linuxppc-dev@ozlabs.org
Subject: [RFC][PATCH v2 0/2] SPI support for fsl_soc and mpc832x_rdb
Message-ID: <20070802173335.GA25369@localhost.localdomain>
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

Thanks for the previous review! Here is updated version, also needs
your comments.

Changelog:

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


Thanks!

-- 
Anton Vorontsov
email: cbou@mail.ru
backup email: ya-cbou@yandex.ru
irc://irc.freenode.net/bd2
