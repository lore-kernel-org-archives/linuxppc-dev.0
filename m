Return-Path: <srinivas.kandagatla@st.com>
From: Srinivas KANDAGATLA <srinivas.kandagatla@st.com>
To: robherring2@gmail.com, bergner@us.ibm.com,
 devicetree-discuss@lists.ozlabs.org
Subject: [RESEND PATCH v3 0/5] Introduce of_get_child_by_name
Date: Tue, 18 Sep 2012 08:08:10 +0100
Message-Id: <1347952090-24054-1-git-send-email-srinivas.kandagatla@st.com>
Cc: kgene.kim@samsung.com, srinivas.kandagatla@st.com,
 broonie@opensource.wolfsonmicro.com, afleming@freescale.com,
 ben-linux@fluff.org, linuxppc-dev@lists.ozlabs.org
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
errors, proper reference counting and is more convenient.

Changes from v3:
	- Removed extra of_get_node from of_get_child_by_name.
	- reordered of_put_node in hvc_opal.c
Changes from v2:
	- Fixed typo errors.
	- Removed bogus patches which used "type" instead of "name" 
	- Fixed reference counting in follow-up patches.

Changes from v1:
	-rename of_get_child to of_get_child_by_name.
	-remove read lock in of_get_child_by_name.
	-make use of of_get_child_by_name in the existing kernel code.

Srinivas Kandagatla (5):
  dt: introduce of_get_child_by_name to get child node by name
  dt/powerpc/powernv: Use of_get_child_by_name to get a named child
  dt/powerpc/sysdev: Use of_get_child_by_name to get a named child
  dt/s3c64xx/spi: Use of_get_child_by_name to get a named child
  dt/tty/opal: Use of_get_child_by_name to get a named child

 arch/powerpc/platforms/powernv/opal.c |    6 +++---
 arch/powerpc/sysdev/qe_lib/qe.c       |    5 +----
 drivers/of/base.c                     |   23 +++++++++++++++++++++++
 drivers/spi/spi-s3c64xx.c             |    7 ++++---
 drivers/tty/hvc/hvc_opal.c            |    9 ++-------
 include/linux/of.h                    |    2 ++
 6 files changed, 35 insertions(+), 17 deletions(-)
