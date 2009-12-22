Return-Path: <ptyser@xes-inc.com>
Received: from xes-mad.com (xes-mad.com [216.165.139.218])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 924BDB6F1A
	for <linuxppc-dev@ozlabs.org>; Tue, 22 Dec 2009 12:50:50 +1100 (EST)
From: Peter Tyser <ptyser@xes-inc.com>
To: linuxppc-dev@ozlabs.org
Subject: [PATCH v2 0/3] powerpc: Add support for FIT uImages
Date: Mon, 21 Dec 2009 19:50:40 -0600
Message-Id: <1261446643-21714-1-git-send-email-ptyser@xes-inc.com>
Cc: Peter Tyser <ptyser@xes-inc.com>, linux-kbuild@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

These patches add support for creating the "new" FIT uImage type
that U-Boot can use.  Additional info about FIT images can be
found in the doc/uImage.FIT/ directory of the U-Boot source.
Here's a link to a howto which gives an overview of the format:
http://git.denx.de/cgi-bin/gitweb.cgi?p=u-boot.git;a=blob;f=doc/uImage.FIT/howto.txt;h=8065e9e1d8d4d65a9b5fe0fce08d3709183d0ee4;hb=HEAD

I've only added support for PowerPC, but the arm, avr32, blackfin,
and sh arches could use the same framework in theory.  The change
is especially useful on PowerPC since it creates 1 FIT uImage that
combines the functionality of an "old" uImage format, a device
tree blob, and possibly a ramdisk.

Changes since v1:
- Add 'dts-v1' header to scripts/mkits.sh output
- Don't strip leading 0x from dts addresses
- Default to using kernel dtc if the user doesn't have it in their path

Peter Tyser (3):
  powerpc: Use scripts/mkuboot.sh instead of 'mkimage'
  powerpc: Add support for creating FIT uImages
  powerpc: Add support for ram filesystems in FIT uImages

 arch/powerpc/Makefile        |    4 +-
 arch/powerpc/boot/.gitignore |    1 +
 arch/powerpc/boot/Makefile   |    8 ++-
 arch/powerpc/boot/wrapper    |   43 +++++++++++--
 scripts/mkits.sh             |  141 ++++++++++++++++++++++++++++++++++++++++++
 5 files changed, 190 insertions(+), 7 deletions(-)
 create mode 100755 scripts/mkits.sh
