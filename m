Return-Path: <srinivas.kandagatla@st.com>
From: Srinivas KANDAGATLA <srinivas.kandagatla@st.com>
To: benh@kernel.crashing.org
Subject: [RESEND PATCH v3 3/5] dt/powerpc/sysdev: Use of_get_child_by_name to
 get a named child.
Date: Mon, 17 Sep 2012 12:58:39 +0100
Message-Id: <1347883119-16750-1-git-send-email-srinivas.kandagatla@st.com>
Cc: kgene.kim@samsung.com, srinivas.kandagatla@st.com,
 devicetree-discuss@lists.ozlabs.org, broonie@opensource.wolfsonmicro.com,
 robherring2@gmail.com, ben-linux@fluff.org, linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

From: Srinivas Kandagatla <srinivas.kandagatla@st.com>

As follow-up to "dt: introduce of_get_child_by_name to get child node by
name." patch, This patch removes some of the code duplication in the
driver by replacing it with of_get_child_by_name instead.

Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@st.com>
---
 arch/powerpc/sysdev/qe_lib/qe.c |    5 +----
 1 files changed, 1 insertions(+), 4 deletions(-)

diff --git a/arch/powerpc/sysdev/qe_lib/qe.c b/arch/powerpc/sysdev/qe_lib/qe.c
index b043675..d094e51 100644
--- a/arch/powerpc/sysdev/qe_lib/qe.c
+++ b/arch/powerpc/sysdev/qe_lib/qe.c
@@ -568,10 +568,7 @@ struct qe_firmware_info *qe_get_firmware_info(void)
 	}
 
 	/* Find the 'firmware' child node */
-	for_each_child_of_node(qe, fw) {
-		if (strcmp(fw->name, "firmware") == 0)
-			break;
-	}
+	fw = of_get_child_by_name(qe, "firmware");
 
 	of_node_put(qe);
 
-- 
1.7.0.4
