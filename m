Return-Path: <bsingharora@gmail.com>
Received: from mail-pf0-x244.google.com (mail-pf0-x244.google.com
 [IPv6:2607:f8b0:400e:c00::244])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3sb6Jm6xV7zDqXr
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 16 Sep 2016 17:26:00 +1000 (AEST)
Received: by mail-pf0-x244.google.com with SMTP id 6so310440pfl.2
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 16 Sep 2016 00:26:00 -0700 (PDT)
Subject: [PATCH v2] Remove duplicate setting of the B field in tlbie
To: "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>,
 Paul Mackerras <paulus@ozlabs.org>, Michael Ellerman <mpe@ellerman.id.au>
Cc: kvm-ppc@vger.kernel.org, LINUX FOR POWERPC <linuxppc-dev@lists.ozlabs.org>
From: Balbir Singh <bsingharora@gmail.com>
Message-ID: <f706a4d0-40d5-2eaa-67d9-8fb02475ca4d@gmail.com>
Date: Fri, 16 Sep 2016 17:25:50 +1000
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


Remove duplicate setting of the the "B" field when doing a tlbie(l).
In compute_tlbie_rb(), the "B" field is set again just before
returning the rb value to be used for tlbie(l).

Signed-off-by: Balbir Singh <bsingharora@gmail.com>
---
Changelog - Leave the more readable version around

 arch/powerpc/include/asm/kvm_book3s_64.h | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/arch/powerpc/include/asm/kvm_book3s_64.h b/arch/powerpc/include/asm/kvm_book3s_64.h
index 88d17b4..aa7d4fd 100644
--- a/arch/powerpc/include/asm/kvm_book3s_64.h
+++ b/arch/powerpc/include/asm/kvm_book3s_64.h
@@ -159,7 +159,6 @@ static inline unsigned long compute_tlbie_rb(unsigned long v, unsigned long r,
 	/* This covers 14..54 bits of va*/
 	rb = (v & ~0x7fUL) << 16;		/* AVA field */
 
-	rb |= (v >> HPTE_V_SSIZE_SHIFT) << 8;	/*  B field */
 	/*
 	 * AVA in v had cleared lower 23 bits. We need to derive
 	 * that from pteg index
@@ -211,7 +210,7 @@ static inline unsigned long compute_tlbie_rb(unsigned long v, unsigned long r,
 		break;
 	}
 	}
-	rb |= (v >> 54) & 0x300;		/* B field */
+	rb |= (v >> HPTE_V_SSIZE_SHIFT) << 8;	/* B field */
 	return rb;
 }
 
-- 
2.5.5
