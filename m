Return-Path: <michael@ozlabs.org>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 40qyzk3gCpzDqlg
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 23 May 2018 00:42:42 +1000 (AEST)
From: Michael Ellerman <mpe@ellerman.id.au>
To: greg@kroah.com
Cc: stable@vger.kernel.org,
	tglx@linutronix.de,
	linuxppc-dev@ozlabs.org
Subject: [PATCH stable 4.16 10/14] powerpc/64s: Wire up cpu_show_spectre_v1()
Date: Wed, 23 May 2018 00:41:21 +1000
Message-Id: <20180522144125.10345-11-mpe@ellerman.id.au>
In-Reply-To: <20180522144125.10345-1-mpe@ellerman.id.au>
References: <20180522144125.10345-1-mpe@ellerman.id.au>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

commit 56986016cb8cd9050e601831fe89f332b4e3c46e upstream.

Add a definition for cpu_show_spectre_v1() to override the generic
version. Currently this just prints "Not affected" or "Vulnerable"
based on the firmware flag.

Although the kernel does have array_index_nospec() in a few places, we
haven't yet audited all the powerpc code to see where it's necessary,
so for now we don't list that as a mitigation.

Signed-off-by: Michael Ellerman <mpe@ellerman.id.au>
---
 arch/powerpc/kernel/security.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/arch/powerpc/kernel/security.c b/arch/powerpc/kernel/security.c
index 865db6f8bcca..0eace3cac818 100644
--- a/arch/powerpc/kernel/security.c
+++ b/arch/powerpc/kernel/security.c
@@ -50,3 +50,11 @@ ssize_t cpu_show_meltdown(struct device *dev, struct device_attribute *attr, cha
 
 	return sprintf(buf, "Vulnerable\n");
 }
+
+ssize_t cpu_show_spectre_v1(struct device *dev, struct device_attribute *attr, char *buf)
+{
+	if (!security_ftr_enabled(SEC_FTR_BNDS_CHK_SPEC_BAR))
+		return sprintf(buf, "Not affected\n");
+
+	return sprintf(buf, "Vulnerable\n");
+}
-- 
2.14.1
