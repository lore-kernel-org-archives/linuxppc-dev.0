Return-Path: <glikely@secretlab.ca>
Received: from mail-gx0-f16.google.com (mail-gx0-f16.google.com
	[209.85.217.16]) by ozlabs.org (Postfix) with ESMTP id BC5BADDF95
	for <linuxppc-dev@ozlabs.org>; Sat, 10 Jan 2009 10:09:40 +1100 (EST)
Received: by gxk9 with SMTP id 9so4025484gxk.9
	for <linuxppc-dev@ozlabs.org>; Fri, 09 Jan 2009 15:09:38 -0800 (PST)
Message-ID: <fa686aa40901091509h1db19787t3f7ac53752bb8531@mail.gmail.com>
Date: Fri, 9 Jan 2009 16:09:37 -0700
From: "Grant Likely" <grant.likely@secretlab.ca>
To: "Benjamin Herrenschmidt" <benh@kernel.crashing.org>,
	linuxppc-dev <linuxppc-dev@ozlabs.org>,
	"Josh Boyer" <jwboyer@linux.vnet.ibm.com>
Subject: Please pull linux-2.6-mpc52xx.git
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Hey Ben,

Here is my last minute pull request.  It's pretty simple stuff all
around, mostly in the bug-fix category.  One new of_i2c() helper
function.  Biggest change is the xilinx spi driver; but it doesn't
even compile without this.  I have not included the media5200 platform
support patch because it is a little borderline for so late in the
window.

Technically the xilinx changes are 4xx patches and would normally go
through Josh, but since they only touch Xilinx drivers, and don't
affect any other 4xx platforms I'm sending them to you directly.

Sorry for the lateness of this pull request, I got mired in board
breakage over the last week.  Yeah, it's a lame excuse, but it's the
one I'm using.

The following changes since commit 5886188dc7ba9a76babcd37452f44079a9a77f71:
  Benjamin Krill (1):
        serial: Add driver for the Cell Network Processor serial port NWP device

are available in the git repository at:

  git://git.secretlab.ca/git/linux-2.6-mpc52xx next

Grant Likely (1):
      powerpc/mpc52xx: Properly update irq_desc when set_type() is called.

John Linn (1):
      Xilinx: SPI: updated driver for device tree

Jon Smirl (1):
      drivers/of: Add the of_find_i2c_device_by_node function.

Wolfram Sang (1):
      powerpc/mpc52xx: remove dead code from GPIO driver

Yuri Tikhonov (1):
      powerpc/xsysace: add compatible string for non-ipcore instance

roel kluin (1):
      powerpc/mpc5121: fix NULL test in mpc5121_clk_get utility function.

 arch/powerpc/platforms/512x/clock.c        |    4 +-
 arch/powerpc/platforms/52xx/mpc52xx_gpio.c |    3 -
 arch/powerpc/platforms/52xx/mpc52xx_pic.c  |    8 ++-
 drivers/block/xsysace.c                    |    1 +
 drivers/of/of_i2c.c                        |   19 ++++
 drivers/spi/xilinx_spi.c                   |  137 ++++++++++++++++-----------
 include/linux/of_i2c.h                     |    3 +
 7 files changed, 113 insertions(+), 62 deletions(-)

Thanks,
g.



-- 
Grant Likely, B.Sc., P.Eng.
Secret Lab Technologies Ltd.
