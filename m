Return-Path: <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D1E8BCCA47D
	for <linuxppc-dev@archiver.kernel.org>; Wed, 22 Jun 2022 13:13:00 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4LSkMb2Mwhz3f1Z
	for <linuxppc-dev@archiver.kernel.org>; Wed, 22 Jun 2022 23:12:59 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=heyquark.com (client-ip=2001:4b98:dc4:8::229; helo=relay9-d.mail.gandi.net; envelope-from=ash@heyquark.com; receiver=<UNKNOWN>)
Received: from relay9-d.mail.gandi.net (relay9-d.mail.gandi.net [IPv6:2001:4b98:dc4:8::229])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4LSkKj1hkZz3bnn
	for <linuxppc-dev@lists.ozlabs.org>; Wed, 22 Jun 2022 23:11:20 +1000 (AEST)
Received: (Authenticated sender: ash@heyquark.com)
	by mail.gandi.net (Postfix) with ESMTPSA id E94F1FF808;
	Wed, 22 Jun 2022 13:11:12 +0000 (UTC)
From: Ash Logan <ash@heyquark.com>
To: paulus@samba.org,
	mpe@ellerman.id.au,
	christophe.leroy@csgroup.eu,
	robh+dt@kernel.org,
	benh@kernel.crashing.org
Subject: [PATCH v2 04/12] powerpc: wiiu: introduce wiiu platform
Date: Wed, 22 Jun 2022 23:10:29 +1000
Message-Id: <20220622131037.57604-5-ash@heyquark.com>
X-Mailer: git-send-email 2.36.1
In-Reply-To: <20220622131037.57604-1-ash@heyquark.com>
References: <20220302044406.63401-1-ash@heyquark.com>
 <20220622131037.57604-1-ash@heyquark.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-BeenThere: linuxppc-dev@lists.ozlabs.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>
Cc: devicetree@vger.kernel.org, linkmauve@linkmauve.fr, linux-kernel@vger.kernel.org, rw-r-r-0644@protonmail.com, linuxppc-dev@lists.ozlabs.org, j.ne@posteo.net
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev" <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

Adds empty platforms/wiiu for Nintendo Wii U console

Signed-off-by: Ash Logan <ash@heyquark.com>
---
 arch/powerpc/platforms/Kconfig       | 1 +
 arch/powerpc/platforms/Makefile      | 1 +
 arch/powerpc/platforms/wiiu/Kconfig  | 5 +++++
 arch/powerpc/platforms/wiiu/Makefile | 1 +
 4 files changed, 8 insertions(+)
 create mode 100644 arch/powerpc/platforms/wiiu/Kconfig
 create mode 100644 arch/powerpc/platforms/wiiu/Makefile

diff --git a/arch/powerpc/platforms/Kconfig b/arch/powerpc/platforms/Kconfig
index d41dad227de8..c4a9c3c0b409 100644
--- a/arch/powerpc/platforms/Kconfig
+++ b/arch/powerpc/platforms/Kconfig
@@ -22,6 +22,7 @@ source "arch/powerpc/platforms/40x/Kconfig"
 source "arch/powerpc/platforms/amigaone/Kconfig"
 source "arch/powerpc/platforms/book3s/Kconfig"
 source "arch/powerpc/platforms/microwatt/Kconfig"
+source "arch/powerpc/platforms/wiiu/Kconfig"
 
 config KVM_GUEST
 	bool "KVM Guest support"
diff --git a/arch/powerpc/platforms/Makefile b/arch/powerpc/platforms/Makefile
index 94470fb27c99..944ddd938711 100644
--- a/arch/powerpc/platforms/Makefile
+++ b/arch/powerpc/platforms/Makefile
@@ -24,3 +24,4 @@ obj-$(CONFIG_EMBEDDED6xx)	+= embedded6xx/
 obj-$(CONFIG_AMIGAONE)		+= amigaone/
 obj-$(CONFIG_PPC_BOOK3S)	+= book3s/
 obj-$(CONFIG_PPC_MICROWATT)	+= microwatt/
+obj-$(CONFIG_WIIU)		+= wiiu/
diff --git a/arch/powerpc/platforms/wiiu/Kconfig b/arch/powerpc/platforms/wiiu/Kconfig
new file mode 100644
index 000000000000..e5513205da3c
--- /dev/null
+++ b/arch/powerpc/platforms/wiiu/Kconfig
@@ -0,0 +1,5 @@
+# SPDX-License-Identifier: GPL-2.0
+
+config WIIU
+	bool "Nintendo Wii U"
+	depends on PPC_BOOK3S_32
diff --git a/arch/powerpc/platforms/wiiu/Makefile b/arch/powerpc/platforms/wiiu/Makefile
new file mode 100644
index 000000000000..f66554cd5c45
--- /dev/null
+++ b/arch/powerpc/platforms/wiiu/Makefile
@@ -0,0 +1 @@
+# SPDX-License-Identifier: GPL-2.0
-- 
2.36.1

