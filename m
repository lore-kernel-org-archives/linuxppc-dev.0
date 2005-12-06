Return-Path: <marcelo.tosatti@cyclades.com>
Received: from hera.kernel.org (hera.kernel.org [140.211.167.34])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 93F4468867
	for <linuxppc-embedded@ozlabs.org>;
	Wed,  7 Dec 2005 04:14:04 +1100 (EST)
Date: Tue, 6 Dec 2005 15:13:53 -0200
From: Marcelo Tosatti <marcelo.tosatti@cyclades.com>
To: Vitaly Bordug <vbordug@ru.mvista.com>,
	Pantelis Antoniou <pantelis.antoniou@gmail.com>
Message-ID: <20051206171353.GA17594@dmt.cnet>
References: <438B379B.6090904@ru.mvista.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <438B379B.6090904@ru.mvista.com>
Cc: BLandau@nds.com, linuxppc-embedded list <linuxppc-embedded@ozlabs.org>
Subject: Re: [PATCH] ppc32: Adds MPC885ADS,
	MPC866ADS and MPC8272ADS-specific platform stuff for fs_enet
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

On Mon, Nov 28, 2005 at 08:00:11PM +0300, Vitaly Bordug wrote:
> Added proper ppc_sys identification and fs_platform_info's for MPC 885ADS, 
> 866ADS and 8272ADS. Assuming setbitsXX/clrbitsXX patch is applied.
> 
> 
> Signed-off-by: Vitaly Bordug <vbordug@ru.mvista.com>


diff --git a/arch/ppc/platforms/mpc8272ads_setup.c b/arch/ppc/platforms/mpc8272ads_setup.c
new file mode 100644
index 0000000..4f76b1b
--- /dev/null
+++ b/arch/ppc/platforms/mpc8272ads_setup.c
@@ -0,0 +1,253 @@
+/*
+ * arch/ppc/platforms/82xx/pq2ads_pd.c
+ *
+ * MPC82xx Board-specific PlatformDevice descriptions
+ *
+ * 2005 (c) MontaVista Software, Inc.
+ * Vitaly Bordug <vbordug@ru.mvista.com>
+ *
+ * This file is licensed under the terms of the GNU General Public License
+ * version 2. This program is licensed "as is" without any warranty of any
+ * kind, whether express or implied.
+ */

<snip>

+static int __init mpc8272ads_platform_notify(struct device *dev)
+{
+	static struct {
+		const char *bus_id;
+		void (*rtn) (struct platform_device * pdev, int idx);
+	} dev_map[] = {
+		{"fsl-cpm-fcc", mpc8272ads_fixup_enet_pdata},
+	};
+	struct platform_device *pdev;
+	int i, j, idx;
+	const char *s;
+	if (dev && dev->bus_id)
+		for (i = 0; i < ARRAY_SIZE(dev_map); i++) {
+			idx = -1;
+
+			if ((s = strrchr(dev->bus_id, '.')) != NULL)
+				idx = (int)simple_strtol(s + 1, NULL, 10);
+			else
+				s = dev->bus_id;
+			j = s - dev->bus_id;
+			if (!strncmp(dev->bus_id, dev_map[i].bus_id, j)) {
+				pdev =
+				    container_of(dev, struct platform_device,
+						 dev);
+				dev_map[i].rtn(pdev, idx);
+			}
+		}
+	return 0;
+}

Seems this loop is common to all boards and should be moved to a helper
function?
