Return-Path: <SRS0=7Eaw=QE=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0E48CC282C8
	for <linuxppc-dev@archiver.kernel.org>; Mon, 28 Jan 2019 20:49:07 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6FA2D214DA
	for <linuxppc-dev@archiver.kernel.org>; Mon, 28 Jan 2019 20:49:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=synopsys.com header.i=@synopsys.com header.b="YpYhvRXM"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6FA2D214DA
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=synopsys.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 43pMDc1p53zDqN3
	for <linuxppc-dev@archiver.kernel.org>; Tue, 29 Jan 2019 07:49:04 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=synopsys.com
 (client-ip=198.182.47.9; helo=smtprelay.synopsys.com;
 envelope-from=alexey.brodkin@synopsys.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=pass (p=none dis=none) header.from=synopsys.com
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=synopsys.com header.i=@synopsys.com header.b="YpYhvRXM";
 dkim-atps=neutral
X-Greylist: delayed 335 seconds by postgrey-1.36 at bilbo;
 Tue, 29 Jan 2019 02:30:45 AEDT
Received: from smtprelay.synopsys.com (smtprelay4.synopsys.com [198.182.47.9])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256
 bits)) (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 43pD9K3wPGzDqH2
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 29 Jan 2019 02:30:43 +1100 (AEDT)
Received: from mailhost.synopsys.com (dc8-mailhost2.synopsys.com
 [10.13.135.210])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by smtprelay.synopsys.com (Postfix) with ESMTPS id C8B2C24E25F6;
 Mon, 28 Jan 2019 07:25:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=synopsys.com; s=mail;
 t=1548689106; bh=afxPWU9HKvPzmWVUiTH0Za043YQ4WRUd9wosugz7V+U=;
 h=From:To:Cc:Subject:Date:From;
 b=YpYhvRXMie0yX3Pc5pfWywR1+7ECX7946Wm3R3SAoTOMLN1KcP37kSvXJJtB4/TsY
 fwU4A3DmE8jo7Fklxec5g2oaMQYppTQu2d+Ds7BugIdjVFAv7cwVqXn8CpKVgAB5sY
 vpNXBbBB/WSfhzcdud14iVOF7iTJ8xx+hI6vEwwHjl3JnHA4+JfeiLRIm3yAdlG0MR
 LKlTUQt3IHSHQBfQCglhtG18HT7V6lbuKhhhrV4HE6H5PimysiBz9/KHt7Omph1WlL
 WpepgFRVBu4jSMw5dwBJIdngNDk1NDkStfCFtRN9BA6L0oHzmVWlkHD36zwcz6dl5I
 fDDvcgHwYgl2w==
Received: from ru20arcgnu1.internal.synopsys.com
 (ru20arcgnu1.internal.synopsys.com [10.121.9.48])
 by mailhost.synopsys.com (Postfix) with ESMTP id A7BCFA0057;
 Mon, 28 Jan 2019 15:24:38 +0000 (UTC)
From: Alexey Brodkin <alexey.brodkin@synopsys.com>
To: linux-kernel@vger.kernel.org
Subject: [PATCH] configs: Get rid of obsolete CONFIG_ENABLE_WARN_DEPRECATED
Date: Mon, 28 Jan 2019 18:24:34 +0300
Message-Id: <20190128152434.41969-1-abrodkin@synopsys.com>
X-Mailer: git-send-email 2.16.2
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Tue, 29 Jan 2019 07:45:22 +1100
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
Cc: Rich Felker <dalias@libc.org>, Adam Borowski <kilobyte@angband.pl>,
 Linus Walleij <linus.walleij@linaro.org>,
 Alexey Brodkin <alexey.brodkin@synopsys.com>,
 Liviu Dudau <liviu.dudau@arm.com>, Eric Anholt <eric@anholt.net>,
 Paul Mackerras <paulus@samba.org>, Alessia Mantegazza <amantegazza@vaga.pv.it>,
 sparclinux@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>,
 Stefan Wahren <stefan.wahren@i2se.com>,
 Florian Fainelli <f.fainelli@gmail.com>,
 Anders Roxell <anders.roxell@linaro.org>,
 Yoshinori Sato <ysato@users.sourceforge.jp>, Jonathan Corbet <corbet@lwn.net>,
 linux-sh@vger.kernel.org, x86@kernel.org, Russell King <linux@armlinux.org.uk>,
 Krzysztof Kozlowski <krzk@kernel.org>,
 linux-stm32@st-md-mailman.stormreply.com, Ingo Molnar <mingo@redhat.com>,
 bcm-kernel-feedback-list@broadcom.com, Kevin Hilman <khilman@baylibre.com>,
 Federico Vaga <federico.vaga@vaga.pv.it>,
 Uwe Kleine-Konig <u.kleine-koenig@pengutronix.de>,
 Geert Uytterhoeven <geert@linux-m68k.org>, linux-snps-arc@lists.infradead.org,
 Eugeniy Paltsev <eugeniy.paltsev@synopsys.com>,
 uclinux-h8-devel@lists.sourceforge.jp, Jonas Bonn <jonas@southpole.se>,
 Alexandre Torgue <alexandre.torgue@st.com>, Arnd Bergmann <arnd@arndb.de>,
 Ray Jui <rjui@broadcom.com>, Vineet Gupta <vineet.gupta1@synopsys.com>,
 Vladimir Zapolskiy <vz@mleia.com>, linux-m68k@lists.linux-m68k.org,
 Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>, Borislav Petkov <bp@alien8.de>,
 linux-rpi-kernel@lists.infradead.org, nios2-dev@lists.rocketboards.org,
 Bjorn Helgaas <bhelgaas@google.com>, Stafford Horne <shorne@gmail.com>,
 Stefan Kristiansson <stefan.kristiansson@saunalahti.fi>,
 linux-arm-kernel@lists.infradead.org, Scott Branden <sbranden@broadcom.com>,
 linux-doc@vger.kernel.org, Patrice Chotard <patrice.chotard@st.com>,
 Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>,
 Paul Burton <paul.burton@mips.com>, openrisc@lists.librecores.org,
 Maxime Coquelin <mcoquelin.stm32@gmail.com>,
 Sudeep Holla <sudeep.holla@arm.com>, Ley Foon Tan <lftan@altera.com>,
 Andrew Morton <akpm@linux-foundation.org>, linuxppc-dev@lists.ozlabs.org,
 "David S. Miller" <davem@davemloft.net>
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

This Kconfig option was removed during v4.19 development in
commit 771c035372a0 ("deprecate the '__deprecated' attribute warnings entirely and for good")
so there's no point to keep it in defconfigs any longer.

FWIW defconfigs were patched with:
--------------------------->8----------------------
find . -name *_defconfig -exec sed -i '/CONFIG_ENABLE_WARN_DEPRECATED/d' {} \;
--------------------------->8----------------------

Signed-off-by: Alexey Brodkin <abrodkin@synopsys.com>
Cc: Jonathan Corbet <corbet@lwn.net>
Cc: Federico Vaga <federico.vaga@vaga.pv.it>
Cc: Vineet Gupta <vgupta@synopsys.com>
Cc: Russell King <linux@armlinux.org.uk>
Cc: Florian Fainelli <f.fainelli@gmail.com>
Cc: Ray Jui <rjui@broadcom.com>
Cc: Scott Branden <sbranden@broadcom.com>
Cc: bcm-kernel-feedback-list@broadcom.com
Cc: Eric Anholt <eric@anholt.net>
Cc: Stefan Wahren <stefan.wahren@i2se.com>
Cc: "Uwe Kleine-Konig" <u.kleine-koenig@pengutronix.de>
Cc: Vladimir Zapolskiy <vz@mleia.com>
Cc: Liviu Dudau <liviu.dudau@arm.com>
Cc: Sudeep Holla <sudeep.holla@arm.com>
Cc: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Cc: Maxime Coquelin <mcoquelin.stm32@gmail.com>
Cc: Alexandre Torgue <alexandre.torgue@st.com>
Cc: Yoshinori Sato <ysato@users.sourceforge.jp>
Cc: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: Ley Foon Tan <lftan@altera.com>
Cc: Jonas Bonn <jonas@southpole.se>
Cc: Stefan Kristiansson <stefan.kristiansson@saunalahti.fi>
Cc: Stafford Horne <shorne@gmail.com>
Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: Paul Mackerras <paulus@samba.org>
Cc: Michael Ellerman <mpe@ellerman.id.au>
Cc: Rich Felker <dalias@libc.org>
Cc: "David S. Miller" <davem@davemloft.net>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Ingo Molnar <mingo@redhat.com>
Cc: Borislav Petkov <bp@alien8.de>
Cc: x86@kernel.org
Cc: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Cc: Andrew Morton <akpm@linux-foundation.org>
Cc: Alessia Mantegazza <amantegazza@vaga.pv.it>
Cc: Kevin Hilman <khilman@baylibre.com>
Cc: Eugeniy Paltsev <Eugeniy.Paltsev@synopsys.com>
Cc: Anders Roxell <anders.roxell@linaro.org>
Cc: Linus Walleij <linus.walleij@linaro.org>
Cc: Arnd Bergmann <arnd@arndb.de>
Cc: Patrice Chotard <patrice.chotard@st.com>
Cc: Krzysztof Kozlowski <krzk@kernel.org>
Cc: Bjorn Helgaas <bhelgaas@google.com>
Cc: Paul Burton <paul.burton@mips.com>
Cc: Adam Borowski <kilobyte@angband.pl>
Cc: linux-doc@vger.kernel.org
Cc: linux-snps-arc@lists.infradead.org
Cc: linux-arm-kernel@lists.infradead.org
Cc: linux-rpi-kernel@lists.infradead.org
Cc: linux-stm32@st-md-mailman.stormreply.com
Cc: uclinux-h8-devel@lists.sourceforge.jp
Cc: linux-m68k@lists.linux-m68k.org
Cc: nios2-dev@lists.rocketboards.org
Cc: openrisc@lists.librecores.org
Cc: linuxppc-dev@lists.ozlabs.org
Cc: linux-sh@vger.kernel.org
Cc: sparclinux@vger.kernel.org
---
 Documentation/process/4.Coding.rst                    | 2 +-
 Documentation/translations/it_IT/process/4.Coding.rst | 2 +-
 arch/arc/configs/axs101_defconfig                     | 1 -
 arch/arc/configs/axs103_defconfig                     | 1 -
 arch/arc/configs/axs103_smp_defconfig                 | 1 -
 arch/arc/configs/haps_hs_defconfig                    | 1 -
 arch/arc/configs/haps_hs_smp_defconfig                | 1 -
 arch/arc/configs/hsdk_defconfig                       | 1 -
 arch/arc/configs/nps_defconfig                        | 1 -
 arch/arc/configs/nsim_700_defconfig                   | 1 -
 arch/arc/configs/nsim_hs_defconfig                    | 1 -
 arch/arc/configs/nsim_hs_smp_defconfig                | 1 -
 arch/arc/configs/nsimosci_defconfig                   | 1 -
 arch/arc/configs/nsimosci_hs_defconfig                | 1 -
 arch/arc/configs/nsimosci_hs_smp_defconfig            | 1 -
 arch/arc/configs/tb10x_defconfig                      | 1 -
 arch/arc/configs/vdk_hs38_defconfig                   | 1 -
 arch/arc/configs/vdk_hs38_smp_defconfig               | 1 -
 arch/arm/configs/bcm2835_defconfig                    | 1 -
 arch/arm/configs/cns3420vb_defconfig                  | 1 -
 arch/arm/configs/efm32_defconfig                      | 1 -
 arch/arm/configs/eseries_pxa_defconfig                | 1 -
 arch/arm/configs/gemini_defconfig                     | 1 -
 arch/arm/configs/lpc18xx_defconfig                    | 1 -
 arch/arm/configs/mini2440_defconfig                   | 1 -
 arch/arm/configs/moxart_defconfig                     | 1 -
 arch/arm/configs/mps2_defconfig                       | 1 -
 arch/arm/configs/nuc910_defconfig                     | 1 -
 arch/arm/configs/nuc950_defconfig                     | 1 -
 arch/arm/configs/nuc960_defconfig                     | 1 -
 arch/arm/configs/stm32_defconfig                      | 1 -
 arch/h8300/configs/edosk2674_defconfig                | 1 -
 arch/h8300/configs/h8300h-sim_defconfig               | 1 -
 arch/h8300/configs/h8s-sim_defconfig                  | 1 -
 arch/m68k/configs/amcore_defconfig                    | 1 -
 arch/m68k/configs/stmark2_defconfig                   | 1 -
 arch/nios2/configs/10m50_defconfig                    | 1 -
 arch/nios2/configs/3c120_defconfig                    | 1 -
 arch/openrisc/configs/or1ksim_defconfig               | 1 -
 arch/openrisc/configs/simple_smp_defconfig            | 1 -
 arch/powerpc/configs/mpc512x_defconfig                | 1 -
 arch/powerpc/configs/ppc6xx_defconfig                 | 1 -
 arch/sh/configs/apsh4a3a_defconfig                    | 1 -
 arch/sh/configs/edosk7705_defconfig                   | 1 -
 arch/sh/configs/espt_defconfig                        | 1 -
 arch/sh/configs/sdk7786_defconfig                     | 1 -
 arch/sh/configs/sh2007_defconfig                      | 1 -
 arch/sh/configs/sh7724_generic_defconfig              | 1 -
 arch/sh/configs/sh7763rdp_defconfig                   | 1 -
 arch/sh/configs/sh7770_generic_defconfig              | 1 -
 arch/sh/configs/sh7785lcr_defconfig                   | 1 -
 arch/sh/configs/ul2_defconfig                         | 1 -
 arch/sh/configs/urquell_defconfig                     | 1 -
 arch/sparc/configs/sparc32_defconfig                  | 1 -
 arch/sparc/configs/sparc64_defconfig                  | 1 -
 arch/x86/configs/i386_defconfig                       | 1 -
 arch/x86/configs/x86_64_defconfig                     | 1 -
 57 files changed, 2 insertions(+), 57 deletions(-)

diff --git a/Documentation/process/4.Coding.rst b/Documentation/process/4.Coding.rst
index cfe264889447..4b7a5ab3cec1 100644
--- a/Documentation/process/4.Coding.rst
+++ b/Documentation/process/4.Coding.rst
@@ -249,7 +249,7 @@ features; most of these are found in the "kernel hacking" submenu.  Several
 of these options should be turned on for any kernel used for development or
 testing purposes.  In particular, you should turn on:
 
- - ENABLE_WARN_DEPRECATED, ENABLE_MUST_CHECK, and FRAME_WARN to get an
+ - ENABLE_MUST_CHECK and FRAME_WARN to get an
    extra set of warnings for problems like the use of deprecated interfaces
    or ignoring an important return value from a function.  The output
    generated by these warnings can be verbose, but one need not worry about
diff --git a/Documentation/translations/it_IT/process/4.Coding.rst b/Documentation/translations/it_IT/process/4.Coding.rst
index c61059015e52..c05b89e616dd 100644
--- a/Documentation/translations/it_IT/process/4.Coding.rst
+++ b/Documentation/translations/it_IT/process/4.Coding.rst
@@ -264,7 +264,7 @@ La maggior parte di queste opzioni possono essere attivate per qualsiasi
 kernel utilizzato per lo sviluppo o a scopo di test.  In particolare dovreste
 attivare:
 
- - ENABLE_WARN_DEPRECATED, ENABLE_MUST_CHECK, e FRAME_WARN per ottenere degli
+ - ENABLE_MUST_CHECK e FRAME_WARN per ottenere degli
    avvertimenti dedicati a problemi come l'uso di interfacce deprecate o
    l'ignorare un importante valore di ritorno di una funzione.  Il risultato
    generato da questi avvertimenti può risultare verboso, ma non bisogna
diff --git a/arch/arc/configs/axs101_defconfig b/arch/arc/configs/axs101_defconfig
index 020d4493edfd..e31a8ebc3ecc 100644
--- a/arch/arc/configs/axs101_defconfig
+++ b/arch/arc/configs/axs101_defconfig
@@ -99,7 +99,6 @@ CONFIG_NFS_FS=y
 CONFIG_NFS_V3_ACL=y
 CONFIG_NLS_CODEPAGE_437=y
 CONFIG_NLS_ISO8859_1=y
-# CONFIG_ENABLE_WARN_DEPRECATED is not set
 # CONFIG_ENABLE_MUST_CHECK is not set
 CONFIG_STRIP_ASM_SYMS=y
 CONFIG_SOFTLOCKUP_DETECTOR=y
diff --git a/arch/arc/configs/axs103_defconfig b/arch/arc/configs/axs103_defconfig
index 666314fffc60..e0e8567f0d75 100644
--- a/arch/arc/configs/axs103_defconfig
+++ b/arch/arc/configs/axs103_defconfig
@@ -97,7 +97,6 @@ CONFIG_NFS_FS=y
 CONFIG_NFS_V3_ACL=y
 CONFIG_NLS_CODEPAGE_437=y
 CONFIG_NLS_ISO8859_1=y
-# CONFIG_ENABLE_WARN_DEPRECATED is not set
 # CONFIG_ENABLE_MUST_CHECK is not set
 CONFIG_STRIP_ASM_SYMS=y
 CONFIG_SOFTLOCKUP_DETECTOR=y
diff --git a/arch/arc/configs/axs103_smp_defconfig b/arch/arc/configs/axs103_smp_defconfig
index 429832b8560b..fcbc952bc75b 100644
--- a/arch/arc/configs/axs103_smp_defconfig
+++ b/arch/arc/configs/axs103_smp_defconfig
@@ -100,7 +100,6 @@ CONFIG_NFS_FS=y
 CONFIG_NFS_V3_ACL=y
 CONFIG_NLS_CODEPAGE_437=y
 CONFIG_NLS_ISO8859_1=y
-# CONFIG_ENABLE_WARN_DEPRECATED is not set
 # CONFIG_ENABLE_MUST_CHECK is not set
 CONFIG_STRIP_ASM_SYMS=y
 CONFIG_SOFTLOCKUP_DETECTOR=y
diff --git a/arch/arc/configs/haps_hs_defconfig b/arch/arc/configs/haps_hs_defconfig
index 240dd2cd5148..f56cc2070c11 100644
--- a/arch/arc/configs/haps_hs_defconfig
+++ b/arch/arc/configs/haps_hs_defconfig
@@ -75,7 +75,6 @@ CONFIG_EXT2_FS_XATTR=y
 CONFIG_TMPFS=y
 # CONFIG_MISC_FILESYSTEMS is not set
 CONFIG_NFS_FS=y
-# CONFIG_ENABLE_WARN_DEPRECATED is not set
 # CONFIG_ENABLE_MUST_CHECK is not set
 CONFIG_DEBUG_MEMORY_INIT=y
 # CONFIG_DEBUG_PREEMPT is not set
diff --git a/arch/arc/configs/haps_hs_smp_defconfig b/arch/arc/configs/haps_hs_smp_defconfig
index 14ae7e5acc7c..b6f2482c7e74 100644
--- a/arch/arc/configs/haps_hs_smp_defconfig
+++ b/arch/arc/configs/haps_hs_smp_defconfig
@@ -78,7 +78,6 @@ CONFIG_EXT2_FS_XATTR=y
 CONFIG_TMPFS=y
 # CONFIG_MISC_FILESYSTEMS is not set
 CONFIG_NFS_FS=y
-# CONFIG_ENABLE_WARN_DEPRECATED is not set
 # CONFIG_ENABLE_MUST_CHECK is not set
 CONFIG_SOFTLOCKUP_DETECTOR=y
 # CONFIG_DEBUG_PREEMPT is not set
diff --git a/arch/arc/configs/hsdk_defconfig b/arch/arc/configs/hsdk_defconfig
index 87b23b7fb781..6fd3d29546af 100644
--- a/arch/arc/configs/hsdk_defconfig
+++ b/arch/arc/configs/hsdk_defconfig
@@ -71,7 +71,6 @@ CONFIG_NFS_FS=y
 CONFIG_NFS_V3_ACL=y
 CONFIG_NLS_CODEPAGE_437=y
 CONFIG_NLS_ISO8859_1=y
-# CONFIG_ENABLE_WARN_DEPRECATED is not set
 # CONFIG_ENABLE_MUST_CHECK is not set
 CONFIG_STRIP_ASM_SYMS=y
 CONFIG_SOFTLOCKUP_DETECTOR=y
diff --git a/arch/arc/configs/nps_defconfig b/arch/arc/configs/nps_defconfig
index 6e84060e7c90..51f466fce5f9 100644
--- a/arch/arc/configs/nps_defconfig
+++ b/arch/arc/configs/nps_defconfig
@@ -77,7 +77,6 @@ CONFIG_NFS_FS=y
 CONFIG_NFS_V3_ACL=y
 CONFIG_ROOT_NFS=y
 CONFIG_DEBUG_INFO=y
-# CONFIG_ENABLE_WARN_DEPRECATED is not set
 # CONFIG_ENABLE_MUST_CHECK is not set
 CONFIG_MAGIC_SYSRQ=y
 CONFIG_DEBUG_MEMORY_INIT=y
diff --git a/arch/arc/configs/nsim_700_defconfig b/arch/arc/configs/nsim_700_defconfig
index 219c2a65294b..318e4cd29629 100644
--- a/arch/arc/configs/nsim_700_defconfig
+++ b/arch/arc/configs/nsim_700_defconfig
@@ -56,6 +56,5 @@ CONFIG_EXT2_FS_XATTR=y
 CONFIG_TMPFS=y
 # CONFIG_MISC_FILESYSTEMS is not set
 CONFIG_NFS_FS=y
-# CONFIG_ENABLE_WARN_DEPRECATED is not set
 # CONFIG_ENABLE_MUST_CHECK is not set
 # CONFIG_DEBUG_PREEMPT is not set
diff --git a/arch/arc/configs/nsim_hs_defconfig b/arch/arc/configs/nsim_hs_defconfig
index 739b90e5e893..c15807b0e0c1 100644
--- a/arch/arc/configs/nsim_hs_defconfig
+++ b/arch/arc/configs/nsim_hs_defconfig
@@ -56,6 +56,5 @@ CONFIG_EXT2_FS_XATTR=y
 CONFIG_TMPFS=y
 # CONFIG_MISC_FILESYSTEMS is not set
 CONFIG_NFS_FS=y
-# CONFIG_ENABLE_WARN_DEPRECATED is not set
 # CONFIG_ENABLE_MUST_CHECK is not set
 # CONFIG_DEBUG_PREEMPT is not set
diff --git a/arch/arc/configs/nsim_hs_smp_defconfig b/arch/arc/configs/nsim_hs_smp_defconfig
index b5895bdf3a93..65e983fd942b 100644
--- a/arch/arc/configs/nsim_hs_smp_defconfig
+++ b/arch/arc/configs/nsim_hs_smp_defconfig
@@ -55,5 +55,4 @@ CONFIG_EXT2_FS_XATTR=y
 CONFIG_TMPFS=y
 # CONFIG_MISC_FILESYSTEMS is not set
 CONFIG_NFS_FS=y
-# CONFIG_ENABLE_WARN_DEPRECATED is not set
 # CONFIG_ENABLE_MUST_CHECK is not set
diff --git a/arch/arc/configs/nsimosci_defconfig b/arch/arc/configs/nsimosci_defconfig
index 35dfc6491a09..08c5b99ac341 100644
--- a/arch/arc/configs/nsimosci_defconfig
+++ b/arch/arc/configs/nsimosci_defconfig
@@ -68,5 +68,4 @@ CONFIG_TMPFS=y
 # CONFIG_MISC_FILESYSTEMS is not set
 CONFIG_NFS_FS=y
 CONFIG_NFS_V3_ACL=y
-# CONFIG_ENABLE_WARN_DEPRECATED is not set
 # CONFIG_ENABLE_MUST_CHECK is not set
diff --git a/arch/arc/configs/nsimosci_hs_defconfig b/arch/arc/configs/nsimosci_hs_defconfig
index 1638e5bc9672..5b5e26d67955 100644
--- a/arch/arc/configs/nsimosci_hs_defconfig
+++ b/arch/arc/configs/nsimosci_hs_defconfig
@@ -66,5 +66,4 @@ CONFIG_TMPFS=y
 # CONFIG_MISC_FILESYSTEMS is not set
 CONFIG_NFS_FS=y
 CONFIG_NFS_V3_ACL=y
-# CONFIG_ENABLE_WARN_DEPRECATED is not set
 # CONFIG_ENABLE_MUST_CHECK is not set
diff --git a/arch/arc/configs/nsimosci_hs_smp_defconfig b/arch/arc/configs/nsimosci_hs_smp_defconfig
index 11cfbdb0f441..26af9b2f7fcb 100644
--- a/arch/arc/configs/nsimosci_hs_smp_defconfig
+++ b/arch/arc/configs/nsimosci_hs_smp_defconfig
@@ -77,6 +77,5 @@ CONFIG_TMPFS=y
 # CONFIG_MISC_FILESYSTEMS is not set
 CONFIG_NFS_FS=y
 CONFIG_NFS_V3_ACL=y
-# CONFIG_ENABLE_WARN_DEPRECATED is not set
 # CONFIG_ENABLE_MUST_CHECK is not set
 CONFIG_FTRACE=y
diff --git a/arch/arc/configs/tb10x_defconfig b/arch/arc/configs/tb10x_defconfig
index e71ade3cf9c8..5b5119d2b5d5 100644
--- a/arch/arc/configs/tb10x_defconfig
+++ b/arch/arc/configs/tb10x_defconfig
@@ -92,7 +92,6 @@ CONFIG_CONFIGFS_FS=y
 # CONFIG_MISC_FILESYSTEMS is not set
 # CONFIG_NETWORK_FILESYSTEMS is not set
 CONFIG_DEBUG_INFO=y
-# CONFIG_ENABLE_WARN_DEPRECATED is not set
 CONFIG_STRIP_ASM_SYMS=y
 CONFIG_DEBUG_FS=y
 CONFIG_HEADERS_CHECK=y
diff --git a/arch/arc/configs/vdk_hs38_defconfig b/arch/arc/configs/vdk_hs38_defconfig
index 1e59a2e9c602..816b831838dd 100644
--- a/arch/arc/configs/vdk_hs38_defconfig
+++ b/arch/arc/configs/vdk_hs38_defconfig
@@ -88,7 +88,6 @@ CONFIG_NFS_FS=y
 CONFIG_NFS_V3_ACL=y
 CONFIG_NLS_CODEPAGE_437=y
 CONFIG_NLS_ISO8859_1=y
-# CONFIG_ENABLE_WARN_DEPRECATED is not set
 # CONFIG_ENABLE_MUST_CHECK is not set
 CONFIG_STRIP_ASM_SYMS=y
 CONFIG_DEBUG_SHIRQ=y
diff --git a/arch/arc/configs/vdk_hs38_smp_defconfig b/arch/arc/configs/vdk_hs38_smp_defconfig
index b5c3f6c54b03..d9d0f9376d7a 100644
--- a/arch/arc/configs/vdk_hs38_smp_defconfig
+++ b/arch/arc/configs/vdk_hs38_smp_defconfig
@@ -93,7 +93,6 @@ CONFIG_NFS_FS=y
 CONFIG_NFS_V3_ACL=y
 CONFIG_NLS_CODEPAGE_437=y
 CONFIG_NLS_ISO8859_1=y
-# CONFIG_ENABLE_WARN_DEPRECATED is not set
 # CONFIG_ENABLE_MUST_CHECK is not set
 CONFIG_STRIP_ASM_SYMS=y
 CONFIG_DEBUG_SHIRQ=y
diff --git a/arch/arm/configs/bcm2835_defconfig b/arch/arm/configs/bcm2835_defconfig
index bb6a35fb1dd7..6030a7bf9715 100644
--- a/arch/arm/configs/bcm2835_defconfig
+++ b/arch/arm/configs/bcm2835_defconfig
@@ -158,7 +158,6 @@ CONFIG_PRINTK_TIME=y
 CONFIG_BOOT_PRINTK_DELAY=y
 CONFIG_DYNAMIC_DEBUG=y
 CONFIG_DEBUG_INFO=y
-# CONFIG_ENABLE_WARN_DEPRECATED is not set
 # CONFIG_ENABLE_MUST_CHECK is not set
 CONFIG_UNUSED_SYMBOLS=y
 CONFIG_DEBUG_MEMORY_INIT=y
diff --git a/arch/arm/configs/cns3420vb_defconfig b/arch/arm/configs/cns3420vb_defconfig
index c6dcd6e4f4e6..419b73564f29 100644
--- a/arch/arm/configs/cns3420vb_defconfig
+++ b/arch/arm/configs/cns3420vb_defconfig
@@ -60,7 +60,6 @@ CONFIG_EXT2_FS_XATTR=y
 CONFIG_AUTOFS4_FS=y
 CONFIG_FSCACHE=y
 CONFIG_TMPFS=y
-# CONFIG_ENABLE_WARN_DEPRECATED is not set
 # CONFIG_ENABLE_MUST_CHECK is not set
 CONFIG_DEBUG_FS=y
 # CONFIG_ARM_UNWIND is not set
diff --git a/arch/arm/configs/efm32_defconfig b/arch/arm/configs/efm32_defconfig
index 860d27138e6f..ee42158f41ec 100644
--- a/arch/arm/configs/efm32_defconfig
+++ b/arch/arm/configs/efm32_defconfig
@@ -94,7 +94,6 @@ CONFIG_ROMFS_BACKED_BY_MTD=y
 # CONFIG_NETWORK_FILESYSTEMS is not set
 CONFIG_PRINTK_TIME=y
 CONFIG_DEBUG_INFO=y
-# CONFIG_ENABLE_WARN_DEPRECATED is not set
 # CONFIG_ENABLE_MUST_CHECK is not set
 CONFIG_MAGIC_SYSRQ=y
 # CONFIG_SCHED_DEBUG is not set
diff --git a/arch/arm/configs/eseries_pxa_defconfig b/arch/arm/configs/eseries_pxa_defconfig
index cd27d651463c..eabb784cf7da 100644
--- a/arch/arm/configs/eseries_pxa_defconfig
+++ b/arch/arm/configs/eseries_pxa_defconfig
@@ -103,7 +103,6 @@ CONFIG_NFS_V3=y
 CONFIG_PARTITION_ADVANCED=y
 CONFIG_NLS_CODEPAGE_437=y
 CONFIG_NLS_ISO8859_1=y
-# CONFIG_ENABLE_WARN_DEPRECATED is not set
 # CONFIG_ENABLE_MUST_CHECK is not set
 CONFIG_CRYPTO_CBC=m
 CONFIG_CRYPTO_PCBC=m
diff --git a/arch/arm/configs/gemini_defconfig b/arch/arm/configs/gemini_defconfig
index 553777ac2814..ef9aae89907d 100644
--- a/arch/arm/configs/gemini_defconfig
+++ b/arch/arm/configs/gemini_defconfig
@@ -87,6 +87,5 @@ CONFIG_TMPFS_POSIX_ACL=y
 CONFIG_ROMFS_FS=y
 CONFIG_NLS_CODEPAGE_437=y
 CONFIG_NLS_ISO8859_1=y
-# CONFIG_ENABLE_WARN_DEPRECATED is not set
 # CONFIG_ENABLE_MUST_CHECK is not set
 CONFIG_DEBUG_FS=y
diff --git a/arch/arm/configs/lpc18xx_defconfig b/arch/arm/configs/lpc18xx_defconfig
index 23df2518203d..e46e46389201 100644
--- a/arch/arm/configs/lpc18xx_defconfig
+++ b/arch/arm/configs/lpc18xx_defconfig
@@ -162,7 +162,6 @@ CONFIG_JFFS2_FS=y
 # CONFIG_NETWORK_FILESYSTEMS is not set
 CONFIG_PRINTK_TIME=y
 CONFIG_DEBUG_INFO=y
-# CONFIG_ENABLE_WARN_DEPRECATED is not set
 # CONFIG_ENABLE_MUST_CHECK is not set
 CONFIG_DEBUG_FS=y
 CONFIG_MAGIC_SYSRQ=y
diff --git a/arch/arm/configs/mini2440_defconfig b/arch/arm/configs/mini2440_defconfig
index 88ea02e7ba19..d95a8059d30b 100644
--- a/arch/arm/configs/mini2440_defconfig
+++ b/arch/arm/configs/mini2440_defconfig
@@ -298,7 +298,6 @@ CONFIG_NLS_KOI8_R=m
 CONFIG_NLS_KOI8_U=m
 CONFIG_NLS_UTF8=m
 CONFIG_DEBUG_INFO=y
-# CONFIG_ENABLE_WARN_DEPRECATED is not set
 # CONFIG_ENABLE_MUST_CHECK is not set
 CONFIG_STRIP_ASM_SYMS=y
 CONFIG_DEBUG_FS=y
diff --git a/arch/arm/configs/moxart_defconfig b/arch/arm/configs/moxart_defconfig
index 2da0d9ee2107..078228a19339 100644
--- a/arch/arm/configs/moxart_defconfig
+++ b/arch/arm/configs/moxart_defconfig
@@ -125,7 +125,6 @@ CONFIG_CONFIGFS_FS=y
 CONFIG_JFFS2_FS=y
 CONFIG_PRINTK_TIME=y
 CONFIG_DEBUG_INFO=y
-# CONFIG_ENABLE_WARN_DEPRECATED is not set
 # CONFIG_ENABLE_MUST_CHECK is not set
 CONFIG_DEBUG_PAGEALLOC=y
 CONFIG_DEBUG_OBJECTS=y
diff --git a/arch/arm/configs/mps2_defconfig b/arch/arm/configs/mps2_defconfig
index 0bcdec7cc169..1d923dbb9928 100644
--- a/arch/arm/configs/mps2_defconfig
+++ b/arch/arm/configs/mps2_defconfig
@@ -100,7 +100,6 @@ CONFIG_ROOT_NFS=y
 CONFIG_NLS=y
 CONFIG_PRINTK_TIME=y
 CONFIG_DEBUG_INFO=y
-# CONFIG_ENABLE_WARN_DEPRECATED is not set
 # CONFIG_ENABLE_MUST_CHECK is not set
 CONFIG_DEBUG_FS=y
 # CONFIG_SCHED_DEBUG is not set
diff --git a/arch/arm/configs/nuc910_defconfig b/arch/arm/configs/nuc910_defconfig
index a72653645f9d..c0d152c02fba 100644
--- a/arch/arm/configs/nuc910_defconfig
+++ b/arch/arm/configs/nuc910_defconfig
@@ -47,7 +47,6 @@ CONFIG_ROMFS_FS=y
 CONFIG_PARTITION_ADVANCED=y
 CONFIG_NLS_CODEPAGE_437=y
 CONFIG_NLS_ISO8859_1=y
-# CONFIG_ENABLE_WARN_DEPRECATED is not set
 # CONFIG_ENABLE_MUST_CHECK is not set
 CONFIG_DEBUG_FS=y
 # CONFIG_CRC32 is not set
diff --git a/arch/arm/configs/nuc950_defconfig b/arch/arm/configs/nuc950_defconfig
index 614a0a28d0b4..8dde1186c2ef 100644
--- a/arch/arm/configs/nuc950_defconfig
+++ b/arch/arm/configs/nuc950_defconfig
@@ -64,6 +64,5 @@ CONFIG_ROMFS_FS=y
 CONFIG_PARTITION_ADVANCED=y
 CONFIG_NLS_CODEPAGE_437=y
 CONFIG_NLS_ISO8859_1=y
-# CONFIG_ENABLE_WARN_DEPRECATED is not set
 # CONFIG_ENABLE_MUST_CHECK is not set
 CONFIG_DEBUG_FS=y
diff --git a/arch/arm/configs/nuc960_defconfig b/arch/arm/configs/nuc960_defconfig
index b84bbd216153..6bb784f8eb5b 100644
--- a/arch/arm/configs/nuc960_defconfig
+++ b/arch/arm/configs/nuc960_defconfig
@@ -53,7 +53,6 @@ CONFIG_ROMFS_FS=y
 CONFIG_PARTITION_ADVANCED=y
 CONFIG_NLS_CODEPAGE_437=y
 CONFIG_NLS_ISO8859_1=y
-# CONFIG_ENABLE_WARN_DEPRECATED is not set
 # CONFIG_ENABLE_MUST_CHECK is not set
 CONFIG_DEBUG_FS=y
 # CONFIG_CRC32 is not set
diff --git a/arch/arm/configs/stm32_defconfig b/arch/arm/configs/stm32_defconfig
index ba805b757a8d..0258ba891376 100644
--- a/arch/arm/configs/stm32_defconfig
+++ b/arch/arm/configs/stm32_defconfig
@@ -80,7 +80,6 @@ CONFIG_EXT3_FS=y
 CONFIG_NLS=y
 CONFIG_PRINTK_TIME=y
 CONFIG_DEBUG_INFO=y
-# CONFIG_ENABLE_WARN_DEPRECATED is not set
 # CONFIG_ENABLE_MUST_CHECK is not set
 CONFIG_MAGIC_SYSRQ=y
 # CONFIG_SCHED_DEBUG is not set
diff --git a/arch/h8300/configs/edosk2674_defconfig b/arch/h8300/configs/edosk2674_defconfig
index 29fda12d5da9..23791dcf6c25 100644
--- a/arch/h8300/configs/edosk2674_defconfig
+++ b/arch/h8300/configs/edosk2674_defconfig
@@ -45,5 +45,4 @@ CONFIG_SERIAL_SH_SCI_CONSOLE=y
 # CONFIG_SYSFS is not set
 # CONFIG_MISC_FILESYSTEMS is not set
 CONFIG_DEBUG_INFO=y
-# CONFIG_ENABLE_WARN_DEPRECATED is not set
 # CONFIG_ENABLE_MUST_CHECK is not set
diff --git a/arch/h8300/configs/h8300h-sim_defconfig b/arch/h8300/configs/h8300h-sim_defconfig
index 80624f46b0ed..7fc9c2f0acc0 100644
--- a/arch/h8300/configs/h8300h-sim_defconfig
+++ b/arch/h8300/configs/h8300h-sim_defconfig
@@ -45,5 +45,4 @@ CONFIG_SERIAL_SH_SCI_EARLYCON=y
 # CONFIG_SYSFS is not set
 # CONFIG_MISC_FILESYSTEMS is not set
 CONFIG_DEBUG_INFO=y
-# CONFIG_ENABLE_WARN_DEPRECATED is not set
 # CONFIG_ENABLE_MUST_CHECK is not set
diff --git a/arch/h8300/configs/h8s-sim_defconfig b/arch/h8300/configs/h8s-sim_defconfig
index 29fda12d5da9..23791dcf6c25 100644
--- a/arch/h8300/configs/h8s-sim_defconfig
+++ b/arch/h8300/configs/h8s-sim_defconfig
@@ -45,5 +45,4 @@ CONFIG_SERIAL_SH_SCI_CONSOLE=y
 # CONFIG_SYSFS is not set
 # CONFIG_MISC_FILESYSTEMS is not set
 CONFIG_DEBUG_INFO=y
-# CONFIG_ENABLE_WARN_DEPRECATED is not set
 # CONFIG_ENABLE_MUST_CHECK is not set
diff --git a/arch/m68k/configs/amcore_defconfig b/arch/m68k/configs/amcore_defconfig
index 1ba10d57ddb1..0857cdbfde0c 100644
--- a/arch/m68k/configs/amcore_defconfig
+++ b/arch/m68k/configs/amcore_defconfig
@@ -88,7 +88,6 @@ CONFIG_ROMFS_FS=y
 CONFIG_ROMFS_BACKED_BY_BOTH=y
 # CONFIG_NETWORK_FILESYSTEMS is not set
 CONFIG_PRINTK_TIME=y
-# CONFIG_ENABLE_WARN_DEPRECATED is not set
 # CONFIG_ENABLE_MUST_CHECK is not set
 # CONFIG_SECTION_MISMATCH_WARN_ONLY is not set
 CONFIG_PANIC_ON_OOPS=y
diff --git a/arch/m68k/configs/stmark2_defconfig b/arch/m68k/configs/stmark2_defconfig
index 3d07b1de7eb0..69f23c7b0497 100644
--- a/arch/m68k/configs/stmark2_defconfig
+++ b/arch/m68k/configs/stmark2_defconfig
@@ -76,7 +76,6 @@ CONFIG_GPIO_GENERIC_PLATFORM=y
 CONFIG_FSCACHE=y
 # CONFIG_PROC_SYSCTL is not set
 CONFIG_PRINTK_TIME=y
-# CONFIG_ENABLE_WARN_DEPRECATED is not set
 # CONFIG_SECTION_MISMATCH_WARN_ONLY is not set
 CONFIG_SLUB_DEBUG_ON=y
 CONFIG_PANIC_ON_OOPS=y
diff --git a/arch/nios2/configs/10m50_defconfig b/arch/nios2/configs/10m50_defconfig
index c601c8ff1ae6..7977ab7e2ca6 100644
--- a/arch/nios2/configs/10m50_defconfig
+++ b/arch/nios2/configs/10m50_defconfig
@@ -77,4 +77,3 @@ CONFIG_NFS_V3_ACL=y
 CONFIG_ROOT_NFS=y
 CONFIG_SUNRPC_DEBUG=y
 CONFIG_DEBUG_INFO=y
-# CONFIG_ENABLE_WARN_DEPRECATED is not set
diff --git a/arch/nios2/configs/3c120_defconfig b/arch/nios2/configs/3c120_defconfig
index fce33588d55c..ceb97cd85ac1 100644
--- a/arch/nios2/configs/3c120_defconfig
+++ b/arch/nios2/configs/3c120_defconfig
@@ -74,4 +74,3 @@ CONFIG_NFS_V3_ACL=y
 CONFIG_ROOT_NFS=y
 CONFIG_SUNRPC_DEBUG=y
 CONFIG_DEBUG_INFO=y
-# CONFIG_ENABLE_WARN_DEPRECATED is not set
diff --git a/arch/openrisc/configs/or1ksim_defconfig b/arch/openrisc/configs/or1ksim_defconfig
index a73aa90501be..d8ff4f8ffb88 100644
--- a/arch/openrisc/configs/or1ksim_defconfig
+++ b/arch/openrisc/configs/or1ksim_defconfig
@@ -54,5 +54,4 @@ CONFIG_SERIAL_OF_PLATFORM=y
 # CONFIG_DNOTIFY is not set
 CONFIG_TMPFS=y
 CONFIG_NFS_FS=y
-# CONFIG_ENABLE_WARN_DEPRECATED is not set
 # CONFIG_ENABLE_MUST_CHECK is not set
diff --git a/arch/openrisc/configs/simple_smp_defconfig b/arch/openrisc/configs/simple_smp_defconfig
index b6e3c7e158e7..64278992df9c 100644
--- a/arch/openrisc/configs/simple_smp_defconfig
+++ b/arch/openrisc/configs/simple_smp_defconfig
@@ -61,6 +61,5 @@ CONFIG_SERIAL_OF_PLATFORM=y
 CONFIG_TMPFS=y
 CONFIG_NFS_FS=y
 CONFIG_XZ_DEC=y
-# CONFIG_ENABLE_WARN_DEPRECATED is not set
 # CONFIG_ENABLE_MUST_CHECK is not set
 # CONFIG_RCU_TRACE is not set
diff --git a/arch/powerpc/configs/mpc512x_defconfig b/arch/powerpc/configs/mpc512x_defconfig
index c2b1c4404683..e4bfb1101c0e 100644
--- a/arch/powerpc/configs/mpc512x_defconfig
+++ b/arch/powerpc/configs/mpc512x_defconfig
@@ -120,6 +120,5 @@ CONFIG_NFS_FS=y
 CONFIG_ROOT_NFS=y
 CONFIG_NLS_CODEPAGE_437=y
 CONFIG_NLS_ISO8859_1=y
-# CONFIG_ENABLE_WARN_DEPRECATED is not set
 # CONFIG_ENABLE_MUST_CHECK is not set
 # CONFIG_CRYPTO_HW is not set
diff --git a/arch/powerpc/configs/ppc6xx_defconfig b/arch/powerpc/configs/ppc6xx_defconfig
index 53687c3a70c4..7c6baf6df139 100644
--- a/arch/powerpc/configs/ppc6xx_defconfig
+++ b/arch/powerpc/configs/ppc6xx_defconfig
@@ -1123,7 +1123,6 @@ CONFIG_NLS_ISO8859_15=m
 CONFIG_NLS_KOI8_R=m
 CONFIG_NLS_KOI8_U=m
 CONFIG_DEBUG_INFO=y
-# CONFIG_ENABLE_WARN_DEPRECATED is not set
 CONFIG_UNUSED_SYMBOLS=y
 CONFIG_HEADERS_CHECK=y
 CONFIG_MAGIC_SYSRQ=y
diff --git a/arch/sh/configs/apsh4a3a_defconfig b/arch/sh/configs/apsh4a3a_defconfig
index 4710df43a5b5..6c7cdc3beb28 100644
--- a/arch/sh/configs/apsh4a3a_defconfig
+++ b/arch/sh/configs/apsh4a3a_defconfig
@@ -81,7 +81,6 @@ CONFIG_NLS_CODEPAGE_932=y
 CONFIG_NLS_ASCII=y
 CONFIG_NLS_ISO8859_1=y
 CONFIG_NLS_UTF8=y
-# CONFIG_ENABLE_WARN_DEPRECATED is not set
 # CONFIG_ENABLE_MUST_CHECK is not set
 CONFIG_DEBUG_FS=y
 CONFIG_DEBUG_KERNEL=y
diff --git a/arch/sh/configs/edosk7705_defconfig b/arch/sh/configs/edosk7705_defconfig
index db756e099052..ef7cc31997b1 100644
--- a/arch/sh/configs/edosk7705_defconfig
+++ b/arch/sh/configs/edosk7705_defconfig
@@ -32,6 +32,5 @@ CONFIG_SH_PCLK_FREQ=31250000
 # CONFIG_DNOTIFY is not set
 # CONFIG_PROC_FS is not set
 # CONFIG_SYSFS is not set
-# CONFIG_ENABLE_WARN_DEPRECATED is not set
 # CONFIG_ENABLE_MUST_CHECK is not set
 # CONFIG_CRC32 is not set
diff --git a/arch/sh/configs/espt_defconfig b/arch/sh/configs/espt_defconfig
index 2985fe7c6d50..444d75947e70 100644
--- a/arch/sh/configs/espt_defconfig
+++ b/arch/sh/configs/espt_defconfig
@@ -111,7 +111,6 @@ CONFIG_NLS_ISO8859_15=y
 CONFIG_NLS_KOI8_R=y
 CONFIG_NLS_KOI8_U=y
 CONFIG_NLS_UTF8=y
-# CONFIG_ENABLE_WARN_DEPRECATED is not set
 # CONFIG_ENABLE_MUST_CHECK is not set
 CONFIG_DEBUG_FS=y
 # CONFIG_CRYPTO_ANSI_CPRNG is not set
diff --git a/arch/sh/configs/sdk7786_defconfig b/arch/sh/configs/sdk7786_defconfig
index e9ee0c878ead..d16e9334cd98 100644
--- a/arch/sh/configs/sdk7786_defconfig
+++ b/arch/sh/configs/sdk7786_defconfig
@@ -209,7 +209,6 @@ CONFIG_NLS_ISO8859_1=y
 CONFIG_NLS_ISO8859_15=m
 CONFIG_NLS_UTF8=m
 CONFIG_PRINTK_TIME=y
-# CONFIG_ENABLE_WARN_DEPRECATED is not set
 # CONFIG_ENABLE_MUST_CHECK is not set
 CONFIG_MAGIC_SYSRQ=y
 CONFIG_DEBUG_KERNEL=y
diff --git a/arch/sh/configs/sh2007_defconfig b/arch/sh/configs/sh2007_defconfig
index 34094e05e892..a1cf6447dbb1 100644
--- a/arch/sh/configs/sh2007_defconfig
+++ b/arch/sh/configs/sh2007_defconfig
@@ -157,7 +157,6 @@ CONFIG_NLS_ISO8859_15=y
 CONFIG_NLS_KOI8_R=y
 CONFIG_NLS_KOI8_U=y
 CONFIG_NLS_UTF8=y
-# CONFIG_ENABLE_WARN_DEPRECATED is not set
 # CONFIG_ENABLE_MUST_CHECK is not set
 CONFIG_DEBUG_FS=y
 CONFIG_DEBUG_KERNEL=y
diff --git a/arch/sh/configs/sh7724_generic_defconfig b/arch/sh/configs/sh7724_generic_defconfig
index d15e53647983..d04bc27aa816 100644
--- a/arch/sh/configs/sh7724_generic_defconfig
+++ b/arch/sh/configs/sh7724_generic_defconfig
@@ -40,6 +40,5 @@ CONFIG_UIO_PDRV_GENIRQ=y
 # CONFIG_PROC_FS is not set
 # CONFIG_SYSFS is not set
 # CONFIG_MISC_FILESYSTEMS is not set
-# CONFIG_ENABLE_WARN_DEPRECATED is not set
 # CONFIG_ENABLE_MUST_CHECK is not set
 # CONFIG_CRC32 is not set
diff --git a/arch/sh/configs/sh7763rdp_defconfig b/arch/sh/configs/sh7763rdp_defconfig
index 2ef780fb9813..405bf62d22d0 100644
--- a/arch/sh/configs/sh7763rdp_defconfig
+++ b/arch/sh/configs/sh7763rdp_defconfig
@@ -113,7 +113,6 @@ CONFIG_NLS_ISO8859_15=y
 CONFIG_NLS_KOI8_R=y
 CONFIG_NLS_KOI8_U=y
 CONFIG_NLS_UTF8=y
-# CONFIG_ENABLE_WARN_DEPRECATED is not set
 # CONFIG_ENABLE_MUST_CHECK is not set
 CONFIG_DEBUG_FS=y
 # CONFIG_CRYPTO_ANSI_CPRNG is not set
diff --git a/arch/sh/configs/sh7770_generic_defconfig b/arch/sh/configs/sh7770_generic_defconfig
index 742634b37c0a..e5b733c2d988 100644
--- a/arch/sh/configs/sh7770_generic_defconfig
+++ b/arch/sh/configs/sh7770_generic_defconfig
@@ -42,6 +42,5 @@ CONFIG_UIO_PDRV_GENIRQ=y
 # CONFIG_PROC_FS is not set
 # CONFIG_SYSFS is not set
 # CONFIG_MISC_FILESYSTEMS is not set
-# CONFIG_ENABLE_WARN_DEPRECATED is not set
 # CONFIG_ENABLE_MUST_CHECK is not set
 # CONFIG_CRC32 is not set
diff --git a/arch/sh/configs/sh7785lcr_defconfig b/arch/sh/configs/sh7785lcr_defconfig
index 7098828d392e..5201bb78c6f9 100644
--- a/arch/sh/configs/sh7785lcr_defconfig
+++ b/arch/sh/configs/sh7785lcr_defconfig
@@ -109,7 +109,6 @@ CONFIG_NFSD_V4=y
 CONFIG_NLS_CODEPAGE_437=y
 CONFIG_NLS_CODEPAGE_932=y
 CONFIG_NLS_ISO8859_1=y
-# CONFIG_ENABLE_WARN_DEPRECATED is not set
 # CONFIG_ENABLE_MUST_CHECK is not set
 CONFIG_DEBUG_KERNEL=y
 CONFIG_DETECT_HUNG_TASK=y
diff --git a/arch/sh/configs/ul2_defconfig b/arch/sh/configs/ul2_defconfig
index 5f2921a85192..1b7412df12e0 100644
--- a/arch/sh/configs/ul2_defconfig
+++ b/arch/sh/configs/ul2_defconfig
@@ -82,7 +82,6 @@ CONFIG_NFSD=y
 CONFIG_NLS_CODEPAGE_437=y
 CONFIG_NLS_CODEPAGE_932=y
 CONFIG_NLS_ISO8859_1=y
-# CONFIG_ENABLE_WARN_DEPRECATED is not set
 # CONFIG_ENABLE_MUST_CHECK is not set
 CONFIG_CRYPTO_MICHAEL_MIC=y
 # CONFIG_CRYPTO_ANSI_CPRNG is not set
diff --git a/arch/sh/configs/urquell_defconfig b/arch/sh/configs/urquell_defconfig
index 7d5591b7c088..f891045e633a 100644
--- a/arch/sh/configs/urquell_defconfig
+++ b/arch/sh/configs/urquell_defconfig
@@ -136,7 +136,6 @@ CONFIG_NLS_CODEPAGE_437=y
 CONFIG_NLS_CODEPAGE_932=y
 CONFIG_NLS_ISO8859_1=y
 CONFIG_PRINTK_TIME=y
-# CONFIG_ENABLE_WARN_DEPRECATED is not set
 # CONFIG_ENABLE_MUST_CHECK is not set
 CONFIG_DEBUG_FS=y
 CONFIG_DEBUG_KERNEL=y
diff --git a/arch/sparc/configs/sparc32_defconfig b/arch/sparc/configs/sparc32_defconfig
index 207a43a2d8b3..2d4f34c52c67 100644
--- a/arch/sparc/configs/sparc32_defconfig
+++ b/arch/sparc/configs/sparc32_defconfig
@@ -75,7 +75,6 @@ CONFIG_NFS_FS=y
 CONFIG_ROOT_NFS=y
 CONFIG_RPCSEC_GSS_KRB5=m
 CONFIG_NLS=y
-# CONFIG_ENABLE_WARN_DEPRECATED is not set
 CONFIG_DEBUG_KERNEL=y
 CONFIG_DETECT_HUNG_TASK=y
 # CONFIG_SCHED_DEBUG is not set
diff --git a/arch/sparc/configs/sparc64_defconfig b/arch/sparc/configs/sparc64_defconfig
index 4d4e1cc6402f..ea547d596fcf 100644
--- a/arch/sparc/configs/sparc64_defconfig
+++ b/arch/sparc/configs/sparc64_defconfig
@@ -201,7 +201,6 @@ CONFIG_PROC_KCORE=y
 CONFIG_TMPFS=y
 CONFIG_HUGETLBFS=y
 CONFIG_PRINTK_TIME=y
-# CONFIG_ENABLE_WARN_DEPRECATED is not set
 CONFIG_MAGIC_SYSRQ=y
 CONFIG_DEBUG_KERNEL=y
 CONFIG_LOCKUP_DETECTOR=y
diff --git a/arch/x86/configs/i386_defconfig b/arch/x86/configs/i386_defconfig
index 4bb95d7ad947..7ca67c482f4c 100644
--- a/arch/x86/configs/i386_defconfig
+++ b/arch/x86/configs/i386_defconfig
@@ -287,7 +287,6 @@ CONFIG_NLS_ASCII=y
 CONFIG_NLS_ISO8859_1=y
 CONFIG_NLS_UTF8=y
 CONFIG_PRINTK_TIME=y
-# CONFIG_ENABLE_WARN_DEPRECATED is not set
 CONFIG_FRAME_WARN=1024
 CONFIG_MAGIC_SYSRQ=y
 # CONFIG_UNUSED_SYMBOLS is not set
diff --git a/arch/x86/configs/x86_64_defconfig b/arch/x86/configs/x86_64_defconfig
index 0fed049422a8..5d42a20e0986 100644
--- a/arch/x86/configs/x86_64_defconfig
+++ b/arch/x86/configs/x86_64_defconfig
@@ -286,7 +286,6 @@ CONFIG_NLS_ASCII=y
 CONFIG_NLS_ISO8859_1=y
 CONFIG_NLS_UTF8=y
 CONFIG_PRINTK_TIME=y
-# CONFIG_ENABLE_WARN_DEPRECATED is not set
 CONFIG_MAGIC_SYSRQ=y
 # CONFIG_UNUSED_SYMBOLS is not set
 CONFIG_DEBUG_KERNEL=y
-- 
2.16.2

