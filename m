Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D14A606A6E5
	for <linuxppc-dev@archiver.kernel.org>; Fri, 20 Nov 2026 19:34:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=uXBNF866
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4jWQW54zsFz30Vd;
	Sat, 21 Nov 2026 06:33:53 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2607:f8b0:4864:20::b132"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1795203233;
	cv=none; b=RpKU5TN01/awIyUSdJlisr+LQeM/UgPKPiVNx1m19fzKB8LGkC/wDRMlp7cbcm4SIhYKDpN1CsiiErglKUF/gWrKHMDuUNP2icnR5Va827UCUf2TZ5/tXmTayLcA7Gpv75md9DUohsLkX+O/b9l980IsHqCKMdspgdveW3al0ErnnjgRPzLboU4wXqeeiE7VgCnqwOpS7b54pPYBworNNIbnY9vBCW1/40udKYktFAQaqGGdZwV95MPykID9vqIvZmQX+Pjr75iEg9u980wOmf9f4tz942w4JZ7EU+OCLm8jtXcGlHfrE37fal5FPMwSb0T8ZMJJBRL7CZ0ciWEZbw==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1795203233; c=relaxed/relaxed;
	bh=vJ6tZtEnlK9qkgGnFkn4tgGXrQ/769dDFL4QlkxqQAg=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=khrAGlnrlbMs01rIaLHfUyHF3BpvHezyX2avhrFgp2PuDQvvG7kC2xFMk8ohLl1oyJSXTQOu3XWXInSb5Yrb8P8qhXeb3DTDOz9AS4AM6LnjMNyKySi1VOWYRPg1uzR/X/Kq+O+AIReFtauESN6whJsle6dFxSw+L0oX4OMmkrqgXIqGwltXS2qqpB+etMlbqqft22rfiKO1L2rMhBuP+c/tl/DLt5gr7Apo/vH+T+O6tlnshzEYbdmC4eZsH/EF9eZ7XrEw4NWXRy9sagZ16ZsAyaFu6otX36l9sjO7WS4bpZhZIEREbP66DftDdM764TSWQsEm0+/uXGI6SceMJA==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com; dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=uXBNF866; dkim-atps=neutral; spf=pass (client-ip=2607:f8b0:4864:20::b132; helo=mail-yx1-xb132.google.com; envelope-from=mattst88@gmail.com; receiver=lists.ozlabs.org) smtp.mailfrom=gmail.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=uXBNF866;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=gmail.com (client-ip=2607:f8b0:4864:20::b132; helo=mail-yx1-xb132.google.com; envelope-from=mattst88@gmail.com; receiver=lists.ozlabs.org)
Received: from mail-yx1-xb132.google.com (mail-yx1-xb132.google.com [IPv6:2607:f8b0:4864:20::b132])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4jWQW34Hmcz30Qv
	for <linuxppc-dev@lists.ozlabs.org>; Sat, 21 Nov 2026 06:33:51 +1100 (AEDT)
Received: by mail-yx1-xb132.google.com with SMTP id 956f58d0204a3-67be1e468a8so1277283d50.0
        for <linuxppc-dev@lists.ozlabs.org>; Fri, 20 Nov 2026 11:33:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795203229; x=1795808029; darn=lists.ozlabs.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=vJ6tZtEnlK9qkgGnFkn4tgGXrQ/769dDFL4QlkxqQAg=;
        b=uXBNF866HTjRoJsIOLiwvvNbaZWEafmidB9Avdhz01pZmGAi87o4bYv8F5PNHvN0hM
         EYwKT14ilzNBlQp0Eok4JE1hYCirYwqIgS7+YfKZ8xLtrjhxS72uxwyKyUUnUxUQmFKi
         0PeUa+OAWWlBCRvi+h5L4ikyKnqqZPujA51capyy4gKqB5VQxlzfOOkoNkx4TTGqMOma
         ANfXk6AUxmrBJrmc9pezWDlDmKTueefKKon+SoZwHsWQwQBlSnD0BDS+IJnVQOf0z7qf
         nr8rkDPRrFESEoIyyaQ0nYgOkQ0Fr0hmk4t43Egi1Am5kmh9bxmPCEmldSRmtS2QbfYq
         lI1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795203229; x=1795808029;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=vJ6tZtEnlK9qkgGnFkn4tgGXrQ/769dDFL4QlkxqQAg=;
        b=BiCdcIu78uQ4h+M4JyYckshULHHMtGTEF8l2EaDDYV4aOuBbgdQfgF0N6w/2r+C/cf
         R91T+hRCGrPMkEq/VX3SByNMLzt4vz2tMwDtBPptCoH28+xccm7XLi0Ogeeep8xU+nxc
         1hRS9BojzCGUp+unS7YWBVIB0C+Gvg3HVyQUofZg5KN6HhpSf8l/asvQZmLpyVduKGhh
         ReiFia1EyWj9nIL+OzMADe4QQ7/x3baYE/UBwsp36b8Tg0kc1/CEFdLQlIW0m4HVPUUw
         Y3Zpmd1S6+utPDYwSApKWjpxd5tzBHQHYxbo2cwoRyF5BYg+KswR7z73qhWcQinf5qIH
         khRQ==
X-Gm-Message-State: APuU4Z8cCr4PSSj6DIU9qbgu0hZ3nrJtBm624dxjAFQCLKdaekqRsQSR
	vdBOmVajO8FYy9Ht5nUwdkTLde8HPtsHZ1ObFYTRzUvpHwEY2uD8ojvR
X-Gm-Gg: AZFdTZexwoZT6UbsH5dOknUwBgxdWiMXrj6Zv30wzkI6t1fTET8rgm+jSAQIt+RrQC6
	Cm5l7Oedze13bGPluFQ15U06QSARhHAOt+OAJYhmKgUWYjN9Vyxr6N7Vck9gghG4Em7OCHzSz4K
	rqRexV6Y11cm6+GT0RPDTjMumYaiFOCDdc5rxxRGzWFPTlSGQAiFwWxOxi+69E+KQcw6OW9IpSa
	5zfQlVhnAx4LL3vt5En62MyyCXfJLbZdxBqb2+0HN7CZTrzgB++MEGeccaIEZ9qwyDqQf9RVbuN
	7ojc0GfuAXtlml6FJygeHixjLOLgPQfQ3b67cvb67GVvPKHwbkSjalc1QvEwOx9DrQtJDYQAtSc
	KU5Cx9+5gllfk29g8gMMdyyY7zagbyqJbOn2ix+fUNlLjJj8/u9zo9nClkZaOQVIK/hvGzLeR4p
	pem3r3PABJMwZKoRad0htAnysEolcMo8+SyJ0hOznRmhglBmq9CGvftPwkdiSXzJMqZ42VflISp
	Jj2aOB1fBHcA53F+ecxaQCakrxT75Oj+hsqZ4yE3/VUzQlPUPmRgC0EFj3pEisLbQVzdZn00oVr
	ZEQNt4vI8fAt/KQzuaJByPbib2pU5c0Gl/ziioHHQHkgNHIb/6aXN4skZ9ZuVdLimK8auKWR0VE
	2/8p1A99VRdF9tHLX0Azh2/G4kTS2wn/AoS0V33+CHGI=
X-Received: by 2002:a05:690e:1187:b0:67d:ba3f:a9a6 with SMTP id 956f58d0204a3-67df43ce269mr1734293d50.21.1795203229219;
        Fri, 20 Nov 2026 11:33:49 -0800 (PST)
Received: from localhost ([2600:1702:7a90:6f9f:66f3:d5d6:2d12:d460])
        by smtp.gmail.com with ESMTPSA id 956f58d0204a3-67df330bfb1sm2149725d50.6.2026.11.20.11.33.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 20 Nov 2026 11:33:48 -0800 (PST)
From: Matt Turner <mattst88@gmail.com>
Date: Fri, 20 Nov 2026 14:33:43 -0500
Subject: [PATCH 4/4] EDAC/mpc7448_l2: Add error injection
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
Message-Id: <20261120-ppc32-l2-ecc-v1-4-98fc8e6e0a32@gmail.com>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=10492; i=mattst88@gmail.com;
 h=from:subject:message-id; bh=XNCxMKgi+jdMDTi3VczwwKddmdxn919Rql+cTqKYU2o=;
 b=owGbwMvMwCW25rVmCc8sv+mMp9WSGLIZFkwJVOA03ix1b+0mh8z5HzWuKqjr3Tpac0XtzaxfJ
 usqPxqXdXxkYRDjYpgppsgSt16RZVbbjqU+p6V/wcxhZQIZIi3SwAAELAx8uYl5pUY6Rnqm2oZ6
 hkCGjlE8RE6PQSOzuLg0tUg3raDIIS+/JLEkMz+vWC+/IDWvIL1ALy0zrSQjI7+oOBVohF5eaom
 pq6ObkaGBiaWjhZmThaOpibOzk6GTm6Ojs6uTkaW5iYGzpaOJq6U5AxenAMw1/swM/wynzjju9y
 F7m/Xil7N0tzyZMr9M8erChXxfeJlYg+aylQgx/I8Sefvp4+eZiWf7uT8wTp39an61zt/aTIn9h
 lFtTFbrJHgA
X-Developer-Key: i=mattst88@gmail.com; a=openpgp;
 fpr=3BB639E56F861FA2E86505690FDD682D974CA72A
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_PASS,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Expose the L2 error injection registers as inject_data_hi,
inject_data_lo and inject_ctrl.  Writing a CPU number to inject_trigger
injects the error into a private buffer on that CPU and reports what
was detected.

L2 machine checks are not recoverable, so machine check reporting is
masked while the injected errors are consumed.  Tag injection is not
offered: it corrupts the tags of unrelated lines too, and hung the
machine in testing.

Signed-off-by: Matt Turner <mattst88@gmail.com>
---
 arch/powerpc/include/asm/reg.h |   1 +
 drivers/edac/mpc7448_l2_edac.c | 284 ++++++++++++++++++++++++++++++++++++++++-
 2 files changed, 284 insertions(+), 1 deletion(-)

diff --git a/arch/powerpc/include/asm/reg.h b/arch/powerpc/include/asm/reg.h
index 2f4adf5a606e..15c97ff8b12a 100644
--- a/arch/powerpc/include/asm/reg.h
+++ b/arch/powerpc/include/asm/reg.h
@@ -760,6 +760,7 @@
 #define L3CR_PMSIZ		0x00000001	/* L3 private memory size */
 
 #define SPRN_MSSCR0	0x3f6	/* Memory Subsystem Control Register 0 */
+#define   MSSCR0_L2PFE	0x00000003	/* L2 prefetch engines */
 #define SPRN_MSSSR0	0x3f7	/* Memory Subsystem Status Register 1 */
 #define   MSSSR0_L2TAG	0x00040000	/* L2 tag parity error */
 #define   MSSSR0_L2DAT	0x00020000	/* L2 data parity/ECC error */
diff --git a/drivers/edac/mpc7448_l2_edac.c b/drivers/edac/mpc7448_l2_edac.c
index a62c7a2e7147..157f6ff99cf6 100644
--- a/drivers/edac/mpc7448_l2_edac.c
+++ b/drivers/edac/mpc7448_l2_edac.c
@@ -11,12 +11,17 @@
  */
 
 #include <linux/bitfield.h>
+#include <linux/cache.h>
 #include <linux/cpu.h>
 #include <linux/device/faux.h>
 #include <linux/edac.h>
+#include <linux/gfp.h>
+#include <linux/io.h>
+#include <linux/kstrtox.h>
 #include <linux/module.h>
 #include <linux/smp.h>
 #include <linux/sprintf.h>
+#include <linux/sysfs.h>
 
 #include <asm/mpc7448_l2.h>
 #include <asm/reg.h>
@@ -25,6 +30,32 @@
 
 #define DRV_NAME	"mpc7448_l2_edac"
 
+/*
+ * Injection buffer layout.  The target line is followed by aliases one
+ * L1 way (4 KB) apart, which map to the same L1 set and evict the target
+ * from the 8-way L1 into the L2.  With the L1's PLRU replacement, eight
+ * misses evict the target when nothing else touches its set; INJ_NALIAS
+ * is twice that.  The L2 is filled in 64-byte lines of two 32-byte blocks.
+ */
+#define INJ_STRIDE	4096
+#define INJ_NALIAS	16
+#define INJ_ORDER	get_order((INJ_NALIAS + 1) * INJ_STRIDE)
+#define INJ_PATTERN	0x12345678
+
+/*
+ * Tag injection (L2ERRINJCTL[TERRIEN]) is not offered: it also corrupts
+ * the tags of unrelated lines sharing the L2 sets that are written while
+ * injection is enabled, which hung the machine in testing.
+ */
+#define INJ_CTL_MASK	(L2ERRINJCTL_ECCMB | L2ERRINJCTL_DERRIEN | \
+			 L2ERRINJCTL_ECCERRIM)
+
+struct mpc7448_l2_pdata {
+	u32 inj_hi;
+	u32 inj_lo;
+	u32 inj_ctl;
+};
+
 static struct faux_device *mpc7448_l2_fdev;
 
 struct mpc7448_l2_poll {
@@ -98,11 +129,261 @@ static void mpc7448_l2_check(struct edac_device_ctl_info *edac_dev)
 	cpus_read_unlock();
 }
 
+struct mpc7448_l2_inj {
+	u32 *buf;
+	u32 hi;
+	u32 lo;
+	u32 ctl;
+	u32 val;
+	struct mpc7448_l2_poll poll;
+};
+
+static u32 *inj_alias(u32 *a, unsigned int i)
+{
+	return (u32 *)((char *)a + i * INJ_STRIDE);
+}
+
+/* Flush the L2 lines of aliases first to last from the L1 and L2 */
+static void inj_flush(u32 *a, unsigned int first, unsigned int last)
+{
+	unsigned int i;
+
+	for (i = first; i <= last; i++) {
+		dcbf(inj_alias(a, i));
+		dcbf((char *)inj_alias(a, i) + 32);
+	}
+	mb();	/* wait for the flushes to complete */
+}
+
+/* Change a mode SPR with no cache operations or stores in flight */
+#define inj_mtspr(rn, v)					\
+do {								\
+	mb();	/* complete earlier accesses first */		\
+	mtspr(rn, v);						\
+	mb();	/* and the SPR write itself */			\
+	isync();						\
+} while (0)
+
+/*
+ * Every L2 write while injection is enabled is corrupted, so keep the
+ * window short: modify the target in the L1, enable injection, cast the
+ * target out to the L2 by loading its aliases, and disable injection.
+ * The aliases are filled into the L2 during the window and take the error
+ * too.  Then flush the aliases, read the target back, and flush it.
+ */
+static noinline u32 mpc7448_l2_inject_window(u32 *a, u32 hi, u32 lo, u32 ctl)
+{
+	unsigned int i;
+	u32 val;
+
+	inj_flush(a, 0, INJ_NALIAS);
+
+	/*
+	 * A castout that misses in the L2 goes to memory, so load the target
+	 * to allocate its L2 line before modifying it in the L1.
+	 */
+	READ_ONCE(*a);
+	WRITE_ONCE(*a, INJ_PATTERN);
+	mb();	/* modify the target before injection starts */
+
+	mtspr(SPRN_L2ERRINJHI, hi);
+	mtspr(SPRN_L2ERRINJLO, lo);
+	mtspr(SPRN_L2ERRINJCTL, ctl);
+	mb();	/* start injection before the castout */
+
+	for (i = 1; i <= INJ_NALIAS; i++)
+		READ_ONCE(*inj_alias(a, i));
+	mb();	/* wait for the castout and the alias fills */
+
+	mtspr(SPRN_L2ERRINJCTL, 0);
+	mtspr(SPRN_L2ERRINJHI, 0);
+	mtspr(SPRN_L2ERRINJLO, 0);
+	mb();	/* stop injection before anything else reaches the L2 */
+
+	inj_flush(a, 1, INJ_NALIAS);
+	val = READ_ONCE(*a);
+	inj_flush(a, 0, 0);
+
+	return val;
+}
+
+static void mpc7448_l2_inject_cpu(void *info)
+{
+	struct mpc7448_l2_inj *inj = info;
+	u32 inten = mfspr(SPRN_L2ERRINTEN);
+	u32 msscr0 = mfspr(SPRN_MSSCR0);
+	u32 *a = inj->buf;
+
+	/* The prefetch engines would fill (and corrupt) other lines */
+	if (msscr0 & MSSCR0_L2PFE)
+		inj_mtspr(SPRN_MSSCR0, msscr0 & ~MSSCR0_L2PFE);
+
+	/*
+	 * A dry run without injection leaves only the buffer in the
+	 * target's L1 set and the window's code in the L1 instruction
+	 * cache, so nothing else is cast out to the L2 during the window.
+	 */
+	mpc7448_l2_inject_window(a, 0, 0, 0);
+
+	/* L2 machine checks are not recoverable, so poll for these errors */
+	inj_mtspr(SPRN_L2ERRINTEN, 0);
+
+	inj->val = mpc7448_l2_inject_window(a, inj->hi, inj->lo, inj->ctl);
+	mpc7448_l2_poll_cpu(&inj->poll);
+
+	inj_mtspr(SPRN_L2ERRINTEN, inten);
+	if (msscr0 & MSSCR0_L2PFE)
+		inj_mtspr(SPRN_MSSCR0, msscr0);
+}
+
+static ssize_t inject_show(u32 val, char *data)
+{
+	return sysfs_emit(data, "0x%08x\n", val);
+}
+
+static ssize_t inject_store(u32 *val, u32 mask, const char *data,
+			    size_t count)
+{
+	u32 v;
+	int ret;
+
+	ret = kstrtou32(data, 0, &v);
+	if (ret)
+		return ret;
+	if (v & ~mask)
+		return -EINVAL;
+
+	*val = v;
+	return count;
+}
+
+static ssize_t inject_data_hi_show(struct edac_device_ctl_info *edac_dev,
+				   char *data)
+{
+	struct mpc7448_l2_pdata *pdata = edac_dev->pvt_info;
+
+	return inject_show(pdata->inj_hi, data);
+}
+
+static ssize_t inject_data_hi_store(struct edac_device_ctl_info *edac_dev,
+				    const char *data, size_t count)
+{
+	struct mpc7448_l2_pdata *pdata = edac_dev->pvt_info;
+
+	return inject_store(&pdata->inj_hi, ~0U, data, count);
+}
+
+static ssize_t inject_data_lo_show(struct edac_device_ctl_info *edac_dev,
+				   char *data)
+{
+	struct mpc7448_l2_pdata *pdata = edac_dev->pvt_info;
+
+	return inject_show(pdata->inj_lo, data);
+}
+
+static ssize_t inject_data_lo_store(struct edac_device_ctl_info *edac_dev,
+				    const char *data, size_t count)
+{
+	struct mpc7448_l2_pdata *pdata = edac_dev->pvt_info;
+
+	return inject_store(&pdata->inj_lo, ~0U, data, count);
+}
+
+static ssize_t inject_ctrl_show(struct edac_device_ctl_info *edac_dev,
+				char *data)
+{
+	struct mpc7448_l2_pdata *pdata = edac_dev->pvt_info;
+
+	return inject_show(pdata->inj_ctl, data);
+}
+
+static ssize_t inject_ctrl_store(struct edac_device_ctl_info *edac_dev,
+				 const char *data, size_t count)
+{
+	struct mpc7448_l2_pdata *pdata = edac_dev->pvt_info;
+
+	return inject_store(&pdata->inj_ctl, INJ_CTL_MASK, data, count);
+}
+
+static ssize_t inject_trigger_store(struct edac_device_ctl_info *edac_dev,
+				    const char *data, size_t count)
+{
+	struct mpc7448_l2_pdata *pdata = edac_dev->pvt_info;
+	struct mpc7448_l2_inj inj;
+	struct page *page;
+	unsigned int cpu;
+	int ret;
+
+	ret = kstrtouint(data, 0, &cpu);
+	if (ret)
+		return ret;
+	if (cpu >= nr_cpu_ids)
+		return -EINVAL;
+
+	page = alloc_pages(GFP_KERNEL, INJ_ORDER);
+	if (!page)
+		return -ENOMEM;
+
+	inj.buf = page_address(page);
+	inj.hi = pdata->inj_hi;
+	inj.lo = pdata->inj_lo;
+	inj.ctl = pdata->inj_ctl;
+
+	cpus_read_lock();
+	if (cpu_online(cpu))
+		ret = smp_call_function_single(cpu, mpc7448_l2_inject_cpu,
+					       &inj, 1);
+	else
+		ret = -ENXIO;
+	cpus_read_unlock();
+
+	if (!ret)
+		edac_device_printk(edac_dev, KERN_INFO,
+				   "cpu%u: injected ctl 0x%08x data 0x%08x_%08x at 0x%llx: read 0x%08x (wrote 0x%08x)\n",
+				   cpu, inj.ctl, inj.hi, inj.lo,
+				   (unsigned long long)virt_to_phys(inj.buf),
+				   inj.val, INJ_PATTERN);
+
+	__free_pages(page, INJ_ORDER);
+
+	if (ret)
+		return ret;
+
+	mpc7448_l2_report(edac_dev, cpu, &inj.poll);
+	return count;
+}
+
+static const struct edac_dev_sysfs_attribute mpc7448_l2_sysfs_attributes[] = {
+	{
+		.attr = { .name = "inject_data_hi", .mode = 0600 },
+		.show = inject_data_hi_show,
+		.store = inject_data_hi_store,
+	},
+	{
+		.attr = { .name = "inject_data_lo", .mode = 0600 },
+		.show = inject_data_lo_show,
+		.store = inject_data_lo_store,
+	},
+	{
+		.attr = { .name = "inject_ctrl", .mode = 0600 },
+		.show = inject_ctrl_show,
+		.store = inject_ctrl_store,
+	},
+	{
+		.attr = { .name = "inject_trigger", .mode = 0200 },
+		.store = inject_trigger_store,
+	},
+	{
+		.attr = { .name = NULL },
+	},
+};
+
 static int mpc7448_l2_probe(struct faux_device *fdev)
 {
 	struct edac_device_ctl_info *edac_dev;
 
-	edac_dev = edac_device_alloc_ctl_info(0, "cpu", nr_cpu_ids, "L", 1, 2,
+	edac_dev = edac_device_alloc_ctl_info(sizeof(struct mpc7448_l2_pdata),
+					      "cpu", nr_cpu_ids, "L", 1, 2,
 					      edac_device_alloc_index());
 	if (!edac_dev)
 		return -ENOMEM;
@@ -112,6 +393,7 @@ static int mpc7448_l2_probe(struct faux_device *fdev)
 	edac_dev->ctl_name = "MPC7448_L2";
 	edac_dev->dev_name = dev_name(&fdev->dev);
 	edac_dev->edac_check = mpc7448_l2_check;
+	edac_dev->sysfs_attributes = mpc7448_l2_sysfs_attributes;
 
 	if (edac_device_add_device(edac_dev)) {
 		edac_device_free_ctl_info(edac_dev);

-- 
2.56.1


