Return-Path: <imunsie@au1.ibm.com>
Received: from e23smtp03.au.ibm.com (e23smtp03.au.ibm.com [202.81.31.145])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e23smtp03.au.ibm.com",
	Issuer "GeoTrust SSL CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id 4D529B719A
	for <linuxppc-dev@lists.ozlabs.org>;
	Fri,  1 Oct 2010 17:06:31 +1000 (EST)
Received: from d23relay03.au.ibm.com (d23relay03.au.ibm.com [202.81.31.245])
	by e23smtp03.au.ibm.com (8.14.4/8.13.1) with ESMTP id o9172YNF001720
	for <linuxppc-dev@lists.ozlabs.org>; Fri, 1 Oct 2010 17:02:34 +1000
Received: from d23av02.au.ibm.com (d23av02.au.ibm.com [9.190.235.138])
	by d23relay03.au.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
	o9176UAa1421390
	for <linuxppc-dev@lists.ozlabs.org>; Fri, 1 Oct 2010 17:06:30 +1000
Received: from d23av02.au.ibm.com (loopback [127.0.0.1])
	by d23av02.au.ibm.com (8.14.4/8.13.1/NCO v10.0 AVout) with ESMTP id
	o9176U5K024855
	for <linuxppc-dev@lists.ozlabs.org>; Fri, 1 Oct 2010 17:06:30 +1000
From: "Ian Munsie" <imunsie@au1.ibm.com>
To: linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
	benh@kernel.crashing.org
Subject: [PATCH 16/18] powerpc: Fix endianness issues in alignment handler
Date: Fri,  1 Oct 2010 17:06:09 +1000
Message-Id: <1285916771-18033-17-git-send-email-imunsie@au1.ibm.com>
In-Reply-To: <1285916771-18033-1-git-send-email-imunsie@au1.ibm.com>
References: <1285916771-18033-1-git-send-email-imunsie@au1.ibm.com>
Cc: Andreas Schwab <schwab@linux-m68k.org>, Michael Neuling <mikey@neuling.org>,
	paulus@samba.org, Ian Munsie <imunsie@au1.ibm.com>,
	Anton Blanchard <anton@samba.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

From: Ian Munsie <imunsie@au1.ibm.com>

This patch reverses the order of the high and low bits in the alignment
handler on little endian, which should be enough to fix any alignment
exceptions.

Please note that this patch is largely untested.

Signed-off-by: Ian Munsie <imunsie@au1.ibm.com>
---
 arch/powerpc/kernel/align.c |   10 ++++++++++
 1 files changed, 10 insertions(+), 0 deletions(-)

diff --git a/arch/powerpc/kernel/align.c b/arch/powerpc/kernel/align.c
index 8184ee9..fc357c6 100644
--- a/arch/powerpc/kernel/align.c
+++ b/arch/powerpc/kernel/align.c
@@ -712,12 +712,22 @@ int fix_alignment(struct pt_regs *regs)
 		double dd;
 		unsigned char v[8];
 		struct {
+#ifdef __LITTLE_ENDIAN__
+			int	 low32;
+			unsigned hi32;
+#else
 			unsigned hi32;
 			int	 low32;
+#endif
 		} x32;
 		struct {
+#ifdef __LITTLE_ENDIAN__
+			short	      low16;
+			unsigned char hi48[6];
+#else
 			unsigned char hi48[6];
 			short	      low16;
+#endif
 		} x16;
 	} data;
 
-- 
1.7.1
