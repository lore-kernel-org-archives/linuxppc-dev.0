Return-Path: <srinivas.kandagatla@st.com>
Received: from eu1sys200aog101.obsmtp.com (eu1sys200aog101.obsmtp.com
 [207.126.144.111])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client did not present a certificate)
 by ozlabs.org (Postfix) with ESMTPS id D7C392C0089
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 14 Sep 2012 18:50:36 +1000 (EST)
From: Srinivas KANDAGATLA <srinivas.kandagatla@st.com>
To: davem@davemloft.net, robherring2@gmail.com, bergner@us.ibm.com,
 devicetree-discuss@lists.ozlabs.org
Subject: [PATCH v2 0/7] Introduce of_get_child_by_name.
Date: Fri, 14 Sep 2012 09:17:12 +0100
Message-Id: <1347610632-20061-1-git-send-email-srinivas.kandagatla@st.com>
Cc: jassi.brar@samsung.com, srinivas.kandagatla@st.com, afleming@freescale.com,
 netdev@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

From: Srinivas Kandagatla <srinivas.kandagatla@st.com>

This patch series introduces of_get_child_by_name function to get a 
child node by its name in a given parent node and also removes code 
duplication in some of the existing driver code by using of_get_child_by_name.

Normally if a driver want to get a child node it would iterate all the nodes
of parent and compare its name and then get it.
This use case is becoming common as device trees are used more, so moving this 
functionality to a libary function makes sense.

Having of_get_child_by_name libary function would avoid code duplication,
errors and is more convenient.

Changes from v1:
	-rename of_get_child to of_get_child_by_name.
	-remove read lock in of_get_child_by_name.
	-make use of of_get_child_by_name in the existing kernel code.

Srinivas Kandagatla (7):
  dt: introduce of_get_child_by_name to get child node by name.
  dt/powerpc: Use of_get_child_by_name to get a named child.
  dt/powerpc/powernv: Use of_get_child_by_name to get a named child.
  dt/powerpc/sysdev: Use of_get_child_by_name to get a named child.
  dt/net/fsl_pq_mdio: Use of_get_child_by_name to get a named child.
  dt/s3c64xx/spi: Use of_get_child_by_name to get a named child.
  dt/tty/opal: Use of_get_child_by_name to get a named child.

 arch/powerpc/kernel/prom.c                   |    5 +----
 arch/powerpc/platforms/powernv/opal.c        |    6 ++----
 arch/powerpc/sysdev/qe_lib/qe.c              |    5 +----
 drivers/net/ethernet/freescale/fsl_pq_mdio.c |    5 +----
 drivers/of/base.c                            |   25 +++++++++++++++++++++++++
 drivers/spi/spi-s3c64xx.c                    |    4 +---
 drivers/tty/hvc/hvc_opal.c                   |    9 ++-------
 include/linux/of.h                           |    2 ++
 8 files changed, 35 insertions(+), 26 deletions(-)
