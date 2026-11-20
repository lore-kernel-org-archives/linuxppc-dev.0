Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 43920606A6D7
	for <linuxppc-dev@archiver.kernel.org>; Fri, 20 Nov 2026 19:34:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=ORn7GyKa
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4jWQW44vWlz30TY;
	Sat, 21 Nov 2026 06:33:52 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2607:f8b0:4864:20::b132"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1795203232;
	cv=none; b=Z7BpQboM7DZNc+kmns+S4qFgoKQhAEXTv6Wt9hKoVhqfQrDCFDd2rOV+fz/U2Vo4No+10ArHfr6RNliamNjK0EQ5FAdKqzKW3/qTgdsacddeBODe3FDdnsY1th3PvXJX+NZ2T76gwIBvogIMcQ61MguaiJ1B6PIQ++axAsBbTfskuflymfi8fh7nbHfyl2/KjvAHBUXoBCe7i1zEKgVoI+2TPRZXrYAve+gL+YfeCnjnztfMBG++IEyxkBmFzqY+1DOh47NVShtlpAyWizecP5LxnfVnqjlKFKQD27XBhCKeJEWgb+8aLkJEVsBoMwEGa3TbfH71rXEFsCZlh6LSNA==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1795203232; c=relaxed/relaxed;
	bh=SYGSMC4mInP9yOLco1WrFx7aItxWYf+k5DNyaKookJA=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=XeODhEvSXlSqXyE0U2o1l+ZOSxgfpW6pqH40bZwpVzZuzahVSmlb9BMmmIlFTAIWR/bG3HipyzU0KZDA67UCQfg1nEdsNTawaGPr1dMJ7o6Jkq9sPdMDfUtuSJdq0mkekZ4b8zWlYvTNDCbUiVESfFKTmhh6zunCc3w0MzRaub4TYH2dLWphmPZpyaIQ1e9VHw1LCcQ479BM4GtN5uBOiz1TC86LCbm0oxLwpB/iaJFgYo8BQu5zr8XuI6KoyZwlFJ54yrVdAHPKW3FJ3P4fyv92m/bu6m9U3JCUeVIwkge54p46pwu3yWRq6xrwC/y6M9Ffnf6WMrEaElFsY+ne5A==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com; dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=ORn7GyKa; dkim-atps=neutral; spf=pass (client-ip=2607:f8b0:4864:20::b132; helo=mail-yx1-xb132.google.com; envelope-from=mattst88@gmail.com; receiver=lists.ozlabs.org) smtp.mailfrom=gmail.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=ORn7GyKa;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=gmail.com (client-ip=2607:f8b0:4864:20::b132; helo=mail-yx1-xb132.google.com; envelope-from=mattst88@gmail.com; receiver=lists.ozlabs.org)
Received: from mail-yx1-xb132.google.com (mail-yx1-xb132.google.com [IPv6:2607:f8b0:4864:20::b132])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4jWQW2234Dz30DZ
	for <linuxppc-dev@lists.ozlabs.org>; Sat, 21 Nov 2026 06:33:50 +1100 (AEDT)
Received: by mail-yx1-xb132.google.com with SMTP id 956f58d0204a3-67db6d4054eso1654452d50.1
        for <linuxppc-dev@lists.ozlabs.org>; Fri, 20 Nov 2026 11:33:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795203228; x=1795808028; darn=lists.ozlabs.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=SYGSMC4mInP9yOLco1WrFx7aItxWYf+k5DNyaKookJA=;
        b=ORn7GyKaiMkrAmPHKRR/MfJPj2s/WOzpMW20vn44Q/JACTF+nMLK4gvRtYL810cVid
         on0Xm2fGj2K/NH0bGaqNt6VvgOQpGRN+Hnsx69D/6ox4Phs4PkWLH1jcXAAyCK6NJrqR
         tHv0QThRX4I4xrX137sLsPE1hVPkVy9DfBIHsuaDCJ2xANAR1T8uOVLnmxZH+Q8CbtKH
         i9LngvoGe/m8tu7Q4GsAW6COo6cEOFfPYbwdh9UjXitzlOzNmtkjtOfHQEPVa6dNQIKT
         dAIlPB2izxwDDfVCyRU3OApHsPjhyWOhsj3mhpXnaPXMBUEliLOsL+CKJcPf6R7GjZzn
         u5Ug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795203228; x=1795808028;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=SYGSMC4mInP9yOLco1WrFx7aItxWYf+k5DNyaKookJA=;
        b=vouwTO887jfJN8lCZCHpYJSyw+fZ9yJC+h2bRPitqYUb1HbpLVC1CEytKMSMt9XtgB
         jTafV0knxGPnk6I+SfFW26dkGrKsM9JPz/W3H2zsG7/dzLbgs3AhmgqZVpsxplXJkN7+
         DflWyPFfx2gsI8r9UOAsh5/swUJKZDiAuBqTmzDO/NfKJaNgPigu1i7re/1woj+mEzfg
         IRmOBtIQqylRG+aQaZtA3xygpoFqnWp7Q6SWl2UsXZNDUqLOedHPU+rA3hLJFh8oVNTD
         bo8Bl4KSTBgV4p3ur/IBKRi0QZ6UJgtqPGzTbotwGA2vADKFfOOtIy9eyBQg/RR/pyVu
         O4LQ==
X-Gm-Message-State: APuU4Z/BrjvutU+nC84lC7P7QWApujraLDfNNrj7JbFvtB0Cvr+xc3wa
	WQBWblCibc2GXn76lhJE+RAC54CAO8NlgXTckWbzMtzak06CKnRtWuAV
X-Gm-Gg: AZFdTZdyZ9czsjMRNQVBML8xh5WmW5Nk30aKVritK0GktaJWzww4rGHEPwc4Xv7UDNh
	SE2fWmmN7xYwpmaoUuOTqODkrnXu/h9ssCLE2h9S2IptAeRxCjTh2f4acdBsHlpI6FUmLnwP4YM
	hI9ORkEOTeUGf1SNd+HrDowzpboeTKbhdkC7/rrF1VvtOuX/NL2GjO+eHvXLiV62IsO/k2Xxuqo
	5N9KpJTvSECsEPxkn2NPLFcZhjBEaDUSOcZPjrNmiid59dWwaKF8oDF7C7n5iG0BOJjqOBT0Ju1
	6mqIr3f2u8gal3N3hsO71vJGB/skJIaIg62CB7Yn9qvTASPI1DFxYLCq3HUBkqt/uYpeOWElE4V
	9kKMZdRikQA4+zJAK29SN+S6/QOHcHm7RkcKgsGupnAaOsuQOToWjiAwIF0324jfuhaIm5Ix4an
	49B+5F7d6gFdxWLu4yWoxHCEN9F5oT5GfAZPiFGZLDS6rv064Hzy6Ab5xPW/wbic1XoBJ8CByBi
	JeIk4B2Y1BHFENe3HdutUvML95Vcjw3CQuo7RYx1nBJu6ugkAGW9K/A0lH5B8X6ryTauhYYatAS
	LMndm/Ratz2M3F6dCvc/ZrCsDJX7xWpTaPgdAaSq7XxQRg/evQej541YWb6v4xxQKfI1oO8vMCu
	AUXBKzCeF99agWL7YNs+H9f19MtDzOxbQywKvGKijdw==
X-Received: by 2002:a05:690e:4806:b0:67d:c29e:9446 with SMTP id 956f58d0204a3-67df43fbc09mr1155990d50.47.1795203227770;
        Fri, 20 Nov 2026 11:33:47 -0800 (PST)
Received: from localhost ([2600:1702:7a90:6f9f:66f3:d5d6:2d12:d460])
        by smtp.gmail.com with ESMTPSA id 956f58d0204a3-67df33b7502sm2036571d50.20.2026.11.20.11.33.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 20 Nov 2026 11:33:46 -0800 (PST)
From: Matt Turner <mattst88@gmail.com>
Date: Fri, 20 Nov 2026 14:33:42 -0500
Subject: [PATCH 3/4] EDAC/mpc7448_l2: Add a driver for the MPC7448 L2 cache
X-Mailing-List: linuxppc-dev@lists.ozlabs.org
List-Id: <linuxppc-dev.lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev+help@lists.ozlabs.org>
List-Owner: <mailto:linuxppc-dev+owner@lists.ozlabs.org>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Archive: <https://lore.kernel.org/linuxppc-dev/>,
  <https://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Subscribe: <mailto:linuxppc-dev+subscribe@lists.ozlabs.org>,
  <mailto:linuxppc-dev+subscribe-digest@lists.ozlabs.org>,
  <mailto:linuxppc-dev+subscribe-nomail@lists.ozlabs.org>
Precedence: list
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261120-ppc32-l2-ecc-v1-3-98fc8e6e0a32@gmail.com>
References: <20261120-ppc32-l2-ecc-v1-0-98fc8e6e0a32@gmail.com>
In-Reply-To: <20261120-ppc32-l2-ecc-v1-0-98fc8e6e0a32@gmail.com>
To: Madhavan Srinivasan <maddy@linux.ibm.com>, 
 Michael Ellerman <mpe@ellerman.id.au>, Nicholas Piggin <npiggin@gmail.com>, 
 "Christophe Leroy (CS GROUP)" <chleroy@kernel.org>, 
 "Ritesh Harjani (IBM)" <ritesh.list@gmail.com>, 
 Shrikanth Hegde <sshegde@linux.ibm.com>, Borislav Petkov <bp@alien8.de>, 
 Tony Luck <tony.luck@intel.com>, Matt Turner <mattst88@gmail.com>
Cc: linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org, 
 linux-edac@vger.kernel.org
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=7077; i=mattst88@gmail.com;
 h=from:subject:message-id; bh=Jhl93cquvatpIX79cI6EiLvX4rUe9XzrZIGQXnwVAyo=;
 b=owGbwMvMwCW25rVmCc8sv+mMp9WSGLIZFky5+oHVRmnLE5euxqTPBfKPagy5Dkx1mbvEbJLZS
 qVLn704Oj6yMIhxMcwUU2SJW6/IMqttx1Kf09K/YOawMoEMkRZpYAACFga+3MS8UiMdIz1TbUM9
 QyBDxygeIqfHoJFZXFyaWqSbVlDkkJdfkliSmZ9XrJdfkJpXkF6gl5aZVpKRkV9UnAo0Qi8vtcT
 U1dHNyNDAxNLRwszJwtHUxNnZydDJzdHR2dXJyNLcxMDZ0tHE1dKcgYtTAOaazmyG/6F8L4994G
 WX6ZkeI5Ky+PFvPXdudcbv5+fwrFsvlHdglyfDP+u37ldWmte4/TPvuuD2hXeS74yKrpgDoRET5
 26Xe8Jqxg0A
X-Developer-Key: i=mattst88@gmail.com; a=openpgp;
 fpr=3BB639E56F861FA2E86505690FDD682D974CA72A
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_PASS,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Report MPC7448 L2 errors through EDAC, with one instance per CPU.

Single-bit errors are corrected by the hardware and only counted, so
poll L2ERRCTL[L2CCOUNT] and L2ERRDET and report the count as
correctable errors.  Report the L2 machine checks counted by the arch
code as uncorrectable errors, along with any multi-bit ECC or tag parity
error found in L2ERRDET without one, since clearing L2ERRDET would
otherwise lose it.

PowerMacs have no device tree node for the L2, so bind to a faux
device.

Signed-off-by: Matt Turner <mattst88@gmail.com>
---
 MAINTAINERS                    |   1 +
 drivers/edac/Kconfig           |   9 +++
 drivers/edac/Makefile          |   1 +
 drivers/edac/mpc7448_l2_edac.c | 160 +++++++++++++++++++++++++++++++++++++++++
 4 files changed, 171 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index 4ea66ea2be2d..0d02f0a7316c 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -9754,6 +9754,7 @@ L:	linuxppc-dev@lists.ozlabs.org
 S:	Maintained
 F:	arch/powerpc/include/asm/mpc7448_l2.h
 F:	arch/powerpc/kernel/mpc7448_l2.c
+F:	drivers/edac/mpc7448_l2_edac.c
 
 EDAC-MPC85XX
 L:	linux-edac@vger.kernel.org
diff --git a/drivers/edac/Kconfig b/drivers/edac/Kconfig
index 4c70729b0d3a..c3256da3d6fd 100644
--- a/drivers/edac/Kconfig
+++ b/drivers/edac/Kconfig
@@ -320,6 +320,15 @@ config EDAC_MPC85XX
 	  Support for error detection and correction on the Freescale
 	  MPC8349, MPC8560, MPC8540, MPC8548, T4240
 
+config EDAC_MPC7448_L2
+	tristate "Freescale MPC7448 L2 cache"
+	depends on PPC_BOOK3S_32
+	help
+	  Support for error detection and correction on the L2 cache of
+	  the Freescale MPC7448 processor.  Correctable errors are found
+	  by polling the L2 error counter, and uncorrectable errors are
+	  reported by the machine check handler.
+
 config EDAC_LAYERSCAPE
 	tristate "Freescale Layerscape DDR"
 	depends on ARCH_LAYERSCAPE || SOC_LS1021A
diff --git a/drivers/edac/Makefile b/drivers/edac/Makefile
index 4020ea60738a..06c951d680f7 100644
--- a/drivers/edac/Makefile
+++ b/drivers/edac/Makefile
@@ -51,6 +51,7 @@ obj-$(CONFIG_EDAC_PASEMI)		+= pasemi_edac.o
 
 mpc85xx_edac_mod-y			:= fsl_ddr_edac.o mpc85xx_edac.o
 obj-$(CONFIG_EDAC_MPC85XX)		+= mpc85xx_edac_mod.o
+obj-$(CONFIG_EDAC_MPC7448_L2)		+= mpc7448_l2_edac.o
 
 layerscape_edac_mod-y			:= fsl_ddr_edac.o layerscape_edac.o
 obj-$(CONFIG_EDAC_LAYERSCAPE)		+= layerscape_edac_mod.o
diff --git a/drivers/edac/mpc7448_l2_edac.c b/drivers/edac/mpc7448_l2_edac.c
new file mode 100644
index 000000000000..a62c7a2e7147
--- /dev/null
+++ b/drivers/edac/mpc7448_l2_edac.c
@@ -0,0 +1,160 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * EDAC driver for the MPC7448 on-chip L2 cache.
+ *
+ * Single-bit ECC errors are corrected by the hardware and only counted in
+ * L2ERRCTL[L2CCOUNT], so they are found by polling.  Multi-bit ECC and tag
+ * parity errors raise a machine check (arch/powerpc/kernel/mpc7448_l2.c)
+ * and are reported here at the next poll, if the system survived it.
+ * Errors latched in L2ERRDET without a machine check are reported as
+ * uncorrectable too.
+ */
+
+#include <linux/bitfield.h>
+#include <linux/cpu.h>
+#include <linux/device/faux.h>
+#include <linux/edac.h>
+#include <linux/module.h>
+#include <linux/smp.h>
+#include <linux/sprintf.h>
+
+#include <asm/mpc7448_l2.h>
+#include <asm/reg.h>
+
+#include "edac_module.h"
+
+#define DRV_NAME	"mpc7448_l2_edac"
+
+static struct faux_device *mpc7448_l2_fdev;
+
+struct mpc7448_l2_poll {
+	struct mpc7448_l2_err err;
+	u32 ctl;
+	unsigned int mce_ue;
+};
+
+static void mpc7448_l2_poll_cpu(void *info)
+{
+	struct mpc7448_l2_poll *p = info;
+
+	p->ctl = mfspr(SPRN_L2ERRCTL);
+	if (p->ctl & L2ERRCTL_L2CCOUNT)
+		mtspr(SPRN_L2ERRCTL, p->ctl & ~L2ERRCTL_L2CCOUNT);
+
+	mpc7448_l2_err_capture(&p->err);
+
+	p->mce_ue = mpc7448_l2_mce_take();
+}
+
+static void mpc7448_l2_report(struct edac_device_ctl_info *edac_dev,
+			      unsigned int cpu, const struct mpc7448_l2_poll *p)
+{
+	unsigned int ce, ue;
+	char msg[64];
+
+	ce = FIELD_GET(L2ERRCTL_L2CCOUNT, p->ctl) ?:
+	     !!(p->err.det & L2ERR_SBECCERR);
+	if (ce) {
+		if (p->err.det & L2ERR_SBECCERR)
+			snprintf(msg, sizeof(msg), "single-bit ECC at 0x%09llx",
+				 mpc7448_l2_err_paddr(&p->err));
+		else
+			snprintf(msg, sizeof(msg), "single-bit ECC");
+		edac_device_handle_ce_count(edac_dev, ce, cpu, 0, msg);
+	}
+
+	/* Errors latched without a machine check */
+	ue = !!(p->err.det & L2ERR_MBECCERR) + !!(p->err.det & L2ERR_TPARERR);
+	if (ue) {
+		mpc7448_l2_err_print(&p->err);
+		snprintf(msg, sizeof(msg), "%s at 0x%09llx",
+			 p->err.det & L2ERR_TPARERR ? "tag parity" : "multi-bit ECC",
+			 mpc7448_l2_err_paddr(&p->err));
+		edac_device_handle_ue_count(edac_dev, ue, cpu, 0, msg);
+	}
+
+	/* The machine check handler has already printed the details */
+	if (p->mce_ue)
+		edac_device_handle_ue_count(edac_dev, p->mce_ue, cpu, 0,
+					    "machine check");
+}
+
+static void mpc7448_l2_check_cpu(struct edac_device_ctl_info *edac_dev,
+				 unsigned int cpu)
+{
+	struct mpc7448_l2_poll p;
+
+	if (!smp_call_function_single(cpu, mpc7448_l2_poll_cpu, &p, 1))
+		mpc7448_l2_report(edac_dev, cpu, &p);
+}
+
+static void mpc7448_l2_check(struct edac_device_ctl_info *edac_dev)
+{
+	unsigned int cpu;
+
+	cpus_read_lock();
+	for_each_online_cpu(cpu)
+		mpc7448_l2_check_cpu(edac_dev, cpu);
+	cpus_read_unlock();
+}
+
+static int mpc7448_l2_probe(struct faux_device *fdev)
+{
+	struct edac_device_ctl_info *edac_dev;
+
+	edac_dev = edac_device_alloc_ctl_info(0, "cpu", nr_cpu_ids, "L", 1, 2,
+					      edac_device_alloc_index());
+	if (!edac_dev)
+		return -ENOMEM;
+
+	edac_dev->dev = &fdev->dev;
+	edac_dev->mod_name = DRV_NAME;
+	edac_dev->ctl_name = "MPC7448_L2";
+	edac_dev->dev_name = dev_name(&fdev->dev);
+	edac_dev->edac_check = mpc7448_l2_check;
+
+	if (edac_device_add_device(edac_dev)) {
+		edac_device_free_ctl_info(edac_dev);
+		return -ENXIO;
+	}
+
+	faux_device_set_drvdata(fdev, edac_dev);
+	return 0;
+}
+
+static void mpc7448_l2_remove(struct faux_device *fdev)
+{
+	struct edac_device_ctl_info *edac_dev = faux_device_get_drvdata(fdev);
+
+	edac_device_del_device(&fdev->dev);
+	edac_device_free_ctl_info(edac_dev);
+}
+
+static const struct faux_device_ops mpc7448_l2_ops = {
+	.probe = mpc7448_l2_probe,
+	.remove = mpc7448_l2_remove,
+};
+
+static int __init mpc7448_l2_edac_init(void)
+{
+	if (PVR_VER(mfspr(SPRN_PVR)) != PVR_VER_7448)
+		return -ENODEV;
+
+	opstate_init();
+
+	mpc7448_l2_fdev = faux_device_create(DRV_NAME, NULL, &mpc7448_l2_ops);
+	if (!mpc7448_l2_fdev)
+		return -ENODEV;
+
+	return 0;
+}
+module_init(mpc7448_l2_edac_init);
+
+static void __exit mpc7448_l2_edac_exit(void)
+{
+	faux_device_destroy(mpc7448_l2_fdev);
+}
+module_exit(mpc7448_l2_edac_exit);
+
+MODULE_LICENSE("GPL");
+MODULE_DESCRIPTION("MPC7448 L2 cache EDAC driver");

-- 
2.56.1


