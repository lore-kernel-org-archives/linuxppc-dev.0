Return-Path: <j.neuschaefer@gmx.net>
Received: from mout.gmx.net (mout.gmx.net [212.227.17.20])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3zdDN36GL7zF0jG
 for <linuxppc-dev@lists.ozlabs.org>; Fri,  9 Feb 2018 23:07:44 +1100 (AEDT)
From: =?UTF-8?q?Jonathan=20Neusch=C3=A4fer?= <j.neuschaefer@gmx.net>
To: linux-kernel@vger.kernel.org
Cc: Joel Stanley <joel@jms.id.au>, linuxppc-dev@lists.ozlabs.org,
 linux-gpio@vger.kernel.org, devicetree@vger.kernel.org,
 =?UTF-8?q?Jonathan=20Neusch=C3=A4fer?= <j.neuschaefer@gmx.net>
Subject: [PATCH v3 0/4] Nintendo Wii GPIO driver
Date: Fri,  9 Feb 2018 13:07:27 +0100
Message-Id: <20180209120732.17863-1-j.neuschaefer@gmx.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

v2: https://www.spinics.net/lists/devicetree/msg211283.html

This series adds a driver for the GPIO controller used in the Nintendo
Wii game console.

Previous versions of this series included a patch to kernel/resource.c
("resource: Extend the PPC32 reserved memory hack") to work around a
resource allocation problem on PPC32. In this version, I dropped this
patch, because the problem will be solved differently and in a separate
patchset.

I also dropped the dt-bindings patch, because Linus Walleij has already
applied it.

Jonathan Neuschäfer (4):
  powerpc: wii: Explicitly configure GPIO owner for poweroff pin
  gpio: Add GPIO driver for Nintendo Wii
  powerpc: wii.dts: Add ngpios property
  powerpc: wii.dts: Add GPIO line names

 arch/powerpc/boot/dts/wii.dts            |   9 +++
 arch/powerpc/platforms/embedded6xx/wii.c |   7 ++
 drivers/gpio/Kconfig                     |   9 +++
 drivers/gpio/Makefile                    |   1 +
 drivers/gpio/gpio-hlwd.c                 | 115 +++++++++++++++++++++++++++++++
 5 files changed, 141 insertions(+)
 create mode 100644 drivers/gpio/gpio-hlwd.c

-- 
2.15.1
