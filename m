Return-Path: <ulfalizer@gmail.com>
Received: from mail-lf0-x243.google.com (mail-lf0-x243.google.com
 [IPv6:2a00:1450:4010:c07::243])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3zZVGQ42kvzDqvG
 for <linuxppc-dev@lists.ozlabs.org>; Mon,  5 Feb 2018 12:23:26 +1100 (AEDT)
Received: by mail-lf0-x243.google.com with SMTP id o89so39452079lfg.10
 for <linuxppc-dev@lists.ozlabs.org>; Sun, 04 Feb 2018 17:23:26 -0800 (PST)
From: Ulf Magnusson <ulfalizer@gmail.com>
To: linux-kernel@vger.kernel.org
Cc: linux-kbuild@vger.kernel.org, tfiga@chromium.org, paul.burton@mips.com,
 m.szyprowski@samsung.com, egtvedt@samfundet.no, linus.walleij@linaro.org,
 vgupta@synopsys.com, mgorman@techsingularity.net, hch@lst.de,
 mina86@mina86.com, robh@kernel.org, sboyd@codeaurora.org,
 paulus@ozlabs.org, will.deacon@arm.com, tony@atomide.com,
 npiggin@gmail.com, yamada.masahiro@socionext.com,
 Ulf Magnusson <ulfalizer@gmail.com>,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Michael Ellerman <mpe@ellerman.id.au>, kvm-ppc@vger.kernel.org,
 linuxppc-dev@lists.ozlabs.org
Subject: [PATCH 02/20] KVM: PPC: Book3S PR: Fix broken select due to
 misspelling
Date: Mon,  5 Feb 2018 02:21:14 +0100
Message-Id: <20180205012146.23981-3-ulfalizer@gmail.com>
In-Reply-To: <20180205012146.23981-1-ulfalizer@gmail.com>
References: <20180205012146.23981-1-ulfalizer@gmail.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Commit 76d837a4c0f9 ("KVM: PPC: Book3S PR: Don't include SPAPR TCE code
on non-pseries platforms") added a reference to the globally undefined
symbol PPC_SERIES. Looking at the rest of the commit, PPC_PSERIES was
probably intended.

Change PPC_SERIES to PPC_PSERIES.

Discovered with the
https://github.com/ulfalizer/Kconfiglib/blob/master/examples/list_undefined.py
script.

Signed-off-by: Ulf Magnusson <ulfalizer@gmail.com>
---
 arch/powerpc/kvm/Kconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/powerpc/kvm/Kconfig b/arch/powerpc/kvm/Kconfig
index f884a0529dfe..68a0e9d5b440 100644
--- a/arch/powerpc/kvm/Kconfig
+++ b/arch/powerpc/kvm/Kconfig
@@ -69,7 +69,7 @@ config KVM_BOOK3S_64
 	select KVM_BOOK3S_64_HANDLER
 	select KVM
 	select KVM_BOOK3S_PR_POSSIBLE if !KVM_BOOK3S_HV_POSSIBLE
-	select SPAPR_TCE_IOMMU if IOMMU_SUPPORT && (PPC_SERIES || PPC_POWERNV)
+	select SPAPR_TCE_IOMMU if IOMMU_SUPPORT && (PPC_PSERIES || PPC_POWERNV)
 	---help---
 	  Support running unmodified book3s_64 and book3s_32 guest kernels
 	  in virtual machines on book3s_64 host processors.
-- 
2.14.1
