Return-Path: <Paul.Gortmaker@windriver.com>
Received: from mail.windriver.com (mail.windriver.com [147.11.1.11])
 (using TLSv1.1 with cipher ECDHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 927191A09B8
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 19 Oct 2015 10:04:07 +1100 (AEDT)
From: Paul Gortmaker <paul.gortmaker@windriver.com>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
CC: <linux-kernel@vger.kernel.org>, Paul Gortmaker
 <paul.gortmaker@windriver.com>, Andy Gross <agross@codeaurora.org>, Anton
 Blanchard <anton@samba.org>,
 David Brown <davidb@codeaurora.org>, Jiri Slaby <jslaby@suse.com>,
 Kumar Gala <galak@codeaurora.org>, Matthias Brugger
 <matthias.bgg@gmail.com>, Michael Ellerman <mpe@ellerman.id.au>, Nicolas
 Ferre <nicolas.ferre@atmel.com>, <linux-arm-kernel@lists.infradead.org>,
 <linux-arm-msm@vger.kernel.org>, <linux-mediatek@lists.infradead.org>,
 <linuxppc-dev@lists.ozlabs.org>, <linux-serial@vger.kernel.org>,
 <linux-soc@vger.kernel.org>
Subject: [PATCH 0/5] drivers/tty: make more bool drivers explicitly non-modular
Date: Sun, 18 Oct 2015 18:21:13 -0400
Message-ID: <1445206878-12455-1-git-send-email-paul.gortmaker@windriver.com>
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

This next set of patches to drivers/tty fixes up more drivers that would
perhaps appear modular when looking at the code, but are controlled by
a bool Kconfig.  We make sure they don't look modular and get rid
of module related code in the drivers that would never be used.

The one common thread here for all the patches is that we also
scrap the .remove functions which would only be used for module
unload (impossible) and driver unbind.  For the drivers here, there
doesn't seem to be a sensible unbind use case (vs. e.g. a multiport
PCI ethernet driver where one port is unbound and passed through to
a kvm guest or similar).  Hence we just explicitly disallow any
driver unbind operations to help prevent root from doing something
illogical to the machine that they could have done previously.

We've already done this for drivers/tty/serial/mpsc.c previously.

Build tested for allmodconfig on ARM64 and powerpc for tty/tty-testing.

Paul.

---

Cc: Andy Gross <agross@codeaurora.org>
Cc: Anton Blanchard <anton@samba.org>
Cc: David Brown <davidb@codeaurora.org>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Jiri Slaby <jslaby@suse.com>
Cc: Kumar Gala <galak@codeaurora.org>
Cc: Matthias Brugger <matthias.bgg@gmail.com>
Cc: Michael Ellerman <mpe@ellerman.id.au>
Cc: Nicolas Ferre <nicolas.ferre@atmel.com>
Cc: linux-arm-kernel@lists.infradead.org
Cc: linux-arm-msm@vger.kernel.org
Cc: linux-mediatek@lists.infradead.org
Cc: linuxppc-dev@lists.ozlabs.org
Cc: linux-serial@vger.kernel.org
Cc: linux-soc@vger.kernel.org

Paul Gortmaker (5):
  drivers/tty: make hvc/hvc_vio.c explicitly non-modular
  drivers/tty: make ehv_bytechan.c explicitly non-modular
  drivers/tty/serial: make serial/atmel_serial.c explicitly non-modular
  drivers/tty/serial: make msm_serial.c explicitly non-modular
  drivers/tty/serial: make 8250/8250_mtk.c explicitly non-modular

 drivers/tty/ehv_bytechan.c         | 40 +++------------------------------
 drivers/tty/hvc/hvc_vio.c          | 29 ++++--------------------
 drivers/tty/serial/8250/8250_mtk.c | 35 ++++++-----------------------
 drivers/tty/serial/atmel_serial.c  | 45 ++++----------------------------------
 drivers/tty/serial/msm_serial.c    | 30 ++++---------------------
 5 files changed, 22 insertions(+), 157 deletions(-)

-- 
2.6.1
