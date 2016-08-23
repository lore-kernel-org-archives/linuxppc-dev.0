Return-Path: <haokexin@gmail.com>
Received: from mail-yw0-x241.google.com (mail-yw0-x241.google.com
 [IPv6:2607:f8b0:4002:c05::241])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3sJDN26KTJzDrK6
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 23 Aug 2016 12:07:14 +1000 (AEST)
Received: by mail-yw0-x241.google.com with SMTP id z8so4426952ywa.0
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 22 Aug 2016 19:07:14 -0700 (PDT)
From: Kevin Hao <haokexin@gmail.com>
To: linuxppc-dev@lists.ozlabs.org,
	devicetree@vger.kernel.org
Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Michael Ellerman <mpe@ellerman.id.au>, Rob Herring <robh+dt@kernel.org>,
 Scott Wood <oss@buserror.net>
Subject: [PATCH 0/5] ppc32: use the default
 of_platform_default_populate_init() for 83xx boards
Date: Tue, 23 Aug 2016 10:06:54 +0800
Message-Id: <1471918019-19472-1-git-send-email-haokexin@gmail.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Hi,

This is a follow on patch series of [1]. This tries to drop the arch specific
codes of bus probe by using the common of_platform_default_populate_init()
function. I just took the 83xx boards as an example. If you guys think that
this is doable, I can change the remaining ppc boards to use this method for
the of probe.

[1] https://patchwork.ozlabs.org/patch/658531/

Kevin Hao (5):
  of/platform: introduce arch_want_default_of_probe()
  powerpc: introduce arch_enable_default_of_probe()
  of/platform: introduce a generic way to declare a platform bus
  powerpc/83xx: factor out the common codes of setup arch functions
  powerpc/83xx: enable the default of probe

 arch/powerpc/include/asm/setup.h          |  1 +
 arch/powerpc/kernel/of_platform.c         | 12 +++++++++++
 arch/powerpc/platforms/83xx/asp834x.c     |  6 +-----
 arch/powerpc/platforms/83xx/km83xx.c      |  7 +------
 arch/powerpc/platforms/83xx/misc.c        | 33 +++++++++++++++----------------
 arch/powerpc/platforms/83xx/mpc830x_rdb.c |  7 +------
 arch/powerpc/platforms/83xx/mpc831x_rdb.c |  7 +------
 arch/powerpc/platforms/83xx/mpc832x_mds.c |  7 +------
 arch/powerpc/platforms/83xx/mpc832x_rdb.c |  7 +------
 arch/powerpc/platforms/83xx/mpc834x_itx.c | 17 +---------------
 arch/powerpc/platforms/83xx/mpc834x_mds.c |  7 +------
 arch/powerpc/platforms/83xx/mpc836x_mds.c |  7 +------
 arch/powerpc/platforms/83xx/mpc836x_rdk.c |  7 +------
 arch/powerpc/platforms/83xx/mpc837x_mds.c |  7 +------
 arch/powerpc/platforms/83xx/mpc837x_rdb.c |  7 +------
 arch/powerpc/platforms/83xx/mpc83xx.h     |  2 +-
 arch/powerpc/platforms/83xx/sbc834x.c     |  7 +------
 drivers/of/platform.c                     | 21 ++++++++++++++++----
 include/asm-generic/vmlinux.lds.h         |  2 ++
 include/linux/of.h                        | 22 +++++++++++++++++++++
 include/linux/of_platform.h               |  6 ++++++
 21 files changed, 90 insertions(+), 109 deletions(-)

-- 
2.5.5
