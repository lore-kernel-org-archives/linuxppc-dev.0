Return-Path: <glikely@secretlab.ca>
Received: from nz-out-0506.google.com (nz-out-0506.google.com [64.233.162.234])
	by ozlabs.org (Postfix) with ESMTP id 222D1DDF58
	for <linuxppc-dev@ozlabs.org>; Thu, 11 Oct 2007 01:40:41 +1000 (EST)
Received: by nz-out-0506.google.com with SMTP id i1so185225nzh
	for <linuxppc-dev@ozlabs.org>; Wed, 10 Oct 2007 08:40:39 -0700 (PDT)
Message-ID: <fa686aa40710100840i33592b91r9066f1c709736fcb@mail.gmail.com>
Date: Wed, 10 Oct 2007 09:40:36 -0600
From: "Grant Likely" <grant.likely@secretlab.ca>
Sender: glikely@secretlab.ca
To: "Josh Boyer" <jwboyer@linux.vnet.ibm.com>,
	linuxppc-dev <linuxppc-dev@ozlabs.org>,
	"Antonino A. Daplas" <adaplas@gmail.com>,
	"Andrei Konovalov" <akonovalov@ru.mvista.com>
Subject: Please pull linux-2.6-virtex.git
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Josh, please pull:

git://git.secretlab.ca/git/linux-2.6-virtex.git virtex-for-2.6.24

This tree is based on Paulus' current top-of-tree.

There are some minor changes in here plus the XilinxFB migration to
use of_platform bus.  Normally fb changes go in via the -mm tree; but
I've confirmed with Tony that it's okay to go in via the powerpc tree
(which probably makes sense because it depends on the port of virtex
support to arch/powerpc).  The xilinxfb patches have also been acked
by Andrei, the xilinxfb author.

If I can get an account for patchwork; I can also take responsibility
for updating the state of virtex patches there.

The following changes since commit dcccb37e98e0444b0c6a03b303855771aa463c96:
  Grant Likely (1):
        [POWERPC] Lite5200: Use comma delimiter format for lists in device tree

are available in the git repository at:

  git://git.secretlab.ca/git/linux-2.6-virtex.git virtex-for-2.6.24

Grant Likely (11):
      [POWERPC] XilinxFB: add banner output to probe routine when
DEBUG is defined
      [POWERPC] XilinxFB: Replace calls to printk with dev_dbg, dev_err, etc.
      [POWERPC] XilinxFB: rename failout labels to reflect failure
      [POWERPC] XilinxFB: Split device setup from bus binding
      [POWERPC] XilinxFB: cleanup platform_bus binding to use platform bus API.
      [POWERPC] XilinxFB: add of_platform bus binding
      [POWERPC] XilinxFB: Make missing pdata structure non-fatal
      [POWERPC] XilinxFB: sparse fixes
      [POWERPC] Virtex: Fix URL for Xilinx Virtex support in MAINTAINERS
      [POWERPC] Don't build arch/powerpc/sysdev/dcr.c for ARCH=ppc kernels
      [POWERPC] Uartlite: bootwrapper bug fix, getc loops forever

 MAINTAINERS                  |    2 +-
 arch/powerpc/boot/uartlite.c |    4 +-
 arch/powerpc/sysdev/Makefile |    2 +-
 drivers/video/xilinxfb.c     |  279 ++++++++++++++++++++++++++++++------------
 4 files changed, 203 insertions(+), 84 deletions(-)


-- 
Grant Likely, B.Sc., P.Eng.
Secret Lab Technologies Ltd.
grant.likely@secretlab.ca
(403) 399-0195
