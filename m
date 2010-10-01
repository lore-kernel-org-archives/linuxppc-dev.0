Return-Path: <imunsie@au1.ibm.com>
Received: from e23smtp07.au.ibm.com (e23smtp07.au.ibm.com [202.81.31.140])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e23smtp07.au.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id 5B0D0B711F
	for <linuxppc-dev@lists.ozlabs.org>;
	Fri,  1 Oct 2010 17:06:34 +1000 (EST)
Received: from d23relay05.au.ibm.com (d23relay05.au.ibm.com [202.81.31.247])
	by e23smtp07.au.ibm.com (8.14.4/8.13.1) with ESMTP id o9176WbC029166
	for <linuxppc-dev@lists.ozlabs.org>; Fri, 1 Oct 2010 17:06:32 +1000
Received: from d23av01.au.ibm.com (d23av01.au.ibm.com [9.190.234.96])
	by d23relay05.au.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
	o9176W6g1884226
	for <linuxppc-dev@lists.ozlabs.org>; Fri, 1 Oct 2010 17:06:32 +1000
Received: from d23av01.au.ibm.com (loopback [127.0.0.1])
	by d23av01.au.ibm.com (8.14.4/8.13.1/NCO v10.0 AVout) with ESMTP id
	o9176VFx019101
	for <linuxppc-dev@lists.ozlabs.org>; Fri, 1 Oct 2010 17:06:32 +1000
From: "Ian Munsie" <imunsie@au1.ibm.com>
To: linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
	benh@kernel.crashing.org
Subject: [PATCH 18/18] powerpc: Fix jiffies variable on little endian
Date: Fri,  1 Oct 2010 17:06:11 +1000
Message-Id: <1285916771-18033-19-git-send-email-imunsie@au1.ibm.com>
In-Reply-To: <1285916771-18033-1-git-send-email-imunsie@au1.ibm.com>
References: <1285916771-18033-1-git-send-email-imunsie@au1.ibm.com>
Cc: Michal Marek <mmarek@suse.cz>, Denys Vlasenko <vda.linux@googlemail.com>,
	Rusty Russell <rusty@rustcorp.com.au>,
	Tim Abbott <tabbott@ksplice.com>, paulus@samba.org,
	Ian Munsie <imunsie@au1.ibm.com>, Sean MacLennan <smaclennan@pikatech.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

From: Ian Munsie <imunsie@au1.ibm.com>

The vmlinux linker script sets the jiffies variable to the low word of
the jiffies_64 variable. This patch corrects which word is used on
little endian.

Signed-off-by: Ian Munsie <imunsie@au1.ibm.com>
---
 arch/powerpc/kernel/vmlinux.lds.S |    4 ++++
 1 files changed, 4 insertions(+), 0 deletions(-)

diff --git a/arch/powerpc/kernel/vmlinux.lds.S b/arch/powerpc/kernel/vmlinux.lds.S
index 8a0deef..7a9010f 100644
--- a/arch/powerpc/kernel/vmlinux.lds.S
+++ b/arch/powerpc/kernel/vmlinux.lds.S
@@ -34,8 +34,12 @@ OUTPUT_ARCH(powerpc:common64)
 jiffies = jiffies_64;
 #else
 OUTPUT_ARCH(powerpc:common)
+#ifdef CONFIG_CPU_LITTLE_ENDIAN
+jiffies = jiffies_64;
+#else
 jiffies = jiffies_64 + 4;
 #endif
+#endif
 SECTIONS
 {
 	. = 0;
-- 
1.7.1
