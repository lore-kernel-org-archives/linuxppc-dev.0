Return-Path: <>
Received: from fllnx210.ext.ti.com (fllnx210.ext.ti.com [198.47.19.17])
 (using TLSv1 with cipher DHE-RSA-CAMELLIA256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3yrtK91XRlzDrJ8
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  6 Dec 2017 07:15:24 +1100 (AEDT)
From: "Andrew F. Davis" <afd@ti.com>
To: Thierry Reding <thierry.reding@gmail.com>, Russell King
 <linux@armlinux.org.uk>, Samuel Ortiz <sameo@linux.intel.com>, Benjamin
 Herrenschmidt <benh@kernel.crashing.org>, Miguel Ojeda Sandonis
 <miguel.ojeda.sandonis@gmail.com>
CC: <linuxppc-dev@lists.ozlabs.org>, <linux-wireless@vger.kernel.org>,
 <linux-pwm@vger.kernel.org>, <kernel-janitors@vger.kernel.org>,
 <linux-kernel@vger.kernel.org>, "Andrew F . Davis" <afd@ti.com>
Subject: [PATCH v4 0/5] Remove unneeded build directory traversals
Date: Tue, 5 Dec 2017 13:44:51 -0600
Message-ID: <20171205194456.23612-1-afd@ti.com>
MIME-Version: 1.0
Content-Type: text/plain
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Hello all,

I was building a kernel for x86 and noticed Make still descended into
directories like drivers/gpu/drm/hisilicon, this seems kind of odd given
nothing will be built here. It looks to be due to some directories being
included in obj-y unconditionally instead of only when the relevant
CONFIG_ is set.

These patches are split by subsystem in-case, for some reason, a file in
a directory does need to be built, I believe I have checked for all
instances of this, but a quick review from some maintainers would be nice.

Thanks,
Andrew

Changes from v3:
 - Removed patches already taken by maintainers
 - Rebased on v4.15-rc1 (no changes needed)

Changes from v2:
 - Removed patches that would not work
 - Rebased on v4.11-rc1 (no changes needed)

Changes from v1:
 - Removed patches already taken by maintainers
 - Rebased on v4.10-rc1 (no changes needed)

Andrew F. Davis (5):
  pwm: Only descend into pwm directory when CONFIG_PWM is set
  amba: Only descend into amba directory when CONFIG_ARM_AMBA is set
  NFC: Only descend into nfc directory when CONFIG_NFC is set
  macintosh: Only descend into directory when CONFIG_MACINTOSH_DRIVERS
    is set
  auxdisplay: Only descend into directory when CONFIG_AUXDISPLAY is set

 drivers/Makefile | 14 +++++++++-----
 1 file changed, 9 insertions(+), 5 deletions(-)

-- 
2.15.0
