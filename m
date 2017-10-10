Return-Path: <linuxram@us.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com
 [148.163.158.5])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3yBMpg0dslzDr4x
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 11 Oct 2017 03:22:50 +1100 (AEDT)
Received: from pps.filterd (m0098417.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.21/8.16.0.21) with SMTP id
 v9AGKbPG084354
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 10 Oct 2017 12:22:48 -0400
Received: from e17.ny.us.ibm.com (e17.ny.us.ibm.com [129.33.205.207])
 by mx0a-001b2d01.pphosted.com with ESMTP id 2dgygw83ex-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 10 Oct 2017 12:22:48 -0400
Received: from localhost
 by e17.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <linuxram@us.ibm.com>;
 Tue, 10 Oct 2017 12:22:47 -0400
Date: Tue, 10 Oct 2017 11:22:40 -0500
From: Ram Pai <linuxram@us.ibm.com>
To: Michael Ellerman <mpe@ellerman.id.au>
Cc: linuxppc-dev@lists.ozlabs.org, benh@kernel.crashing.org, paulus@samba.org,
 khandual@linux.vnet.ibm.com, aneesh.kumar@linux.vnet.ibm.com,
 bsingharora@gmail.com, hbabu@us.ibm.com, mhocko@kernel.org,
 bauerman@linux.vnet.ibm.com, ebiederm@xmission.com
Subject: [PATCH] powerpc/memkey: feature applies to PPC_BOOK3S_64 archs only
Reply-To: Ram Pai <linuxram@us.ibm.com>
References: <1507565506-17040-1-git-send-email-linuxram@us.ibm.com>
 <87zi8zwf6c.fsf@concordia.ellerman.id.au>
 <20171010161925.GB5334@ram.oc3035372033.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20171010161925.GB5334@ram.oc3035372033.ibm.com>
Message-Id: <20171010162240.GA5362@ram.oc3035372033.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Currently protection key feature is erroneously configured to
be enabled for any flavor of PPC64. This patch fixes it.

Signed-off-by: Ram Pai <linuxram@us.ibm.com>
---
 arch/powerpc/Kconfig |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/arch/powerpc/Kconfig b/arch/powerpc/Kconfig
index 7dee449..4b2b055 100644
--- a/arch/powerpc/Kconfig
+++ b/arch/powerpc/Kconfig
@@ -868,7 +868,7 @@ config PPC64_MEMORY_PROTECTION_KEYS
 	prompt "PowerPC Memory Protection Keys"
 	def_bool y
 	# Note: only available in 64-bit mode
-	depends on PPC64
+	depends on PPC_BOOK3S_64
 	select ARCH_USES_HIGH_VMA_FLAGS
 	select ARCH_HAS_PKEYS
 	---help---
-- 
1.7.1
