Return-Path: <akpm@linux-foundation.org>
Received: from smtp1.linux-foundation.org (smtp1.linux-foundation.org
	[140.211.169.13])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "smtp.linux-foundation.org",
	Issuer "CA Cert Signing Authority" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id B2AE3DDE25
	for <linuxppc-dev@ozlabs.org>; Thu, 21 Aug 2008 11:16:32 +1000 (EST)
Received: from imap1.linux-foundation.org (imap1.linux-foundation.org
	[140.211.169.55])
	by smtp1.linux-foundation.org (8.14.2/8.13.5/Debian-3ubuntu1.1) with
	ESMTP id m7L1GQ8J017717
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO)
	for <linuxppc-dev@ozlabs.org>; Wed, 20 Aug 2008 18:16:27 -0700
Received: from akpm.corp.google.com (localhost [127.0.0.1])
	by imap1.linux-foundation.org
	(8.13.5.20060308/8.13.5/Debian-3ubuntu1.1) with SMTP id
	m7L1GQqe009374
	for <linuxppc-dev@ozlabs.org>; Wed, 20 Aug 2008 18:16:26 -0700
Date: Wed, 20 Aug 2008 18:16:26 -0700
From: Andrew Morton <akpm@linux-foundation.org>
To: linuxppc-dev@ozlabs.org
Subject: powerpc allmodconfig in current -mm
Message-Id: <20080820181626.0347c270.akpm@linux-foundation.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

/opt/crosstool/gcc-4.1.0-glibc-2.3.6/powerpc64-unknown-linux-gnu/bin/powerpc64-unknown-linux-gnu-ld: .tmp_vmlinux1: section .data.gcov lma 0xc000000002c2bb78 overlaps previous sections
/opt/crosstool/gcc-4.1.0-glibc-2.3.6/powerpc64-unknown-linux-gnu/bin/powerpc64-unknown-linux-gnu-ld: .tmp_vmlinux2: section .data.gcov lma 0xc000000002cdbb78 overlaps previous sections
/opt/crosstool/gcc-4.1.0-glibc-2.3.6/powerpc64-unknown-linux-gnu/bin/powerpc64-unknown-linux-gnu-ld: .tmp_vmlinux3: section .data.gcov lma 0xc000000002cdbb78 overlaps previous sections
/opt/crosstool/gcc-4.1.0-glibc-2.3.6/powerpc64-unknown-linux-gnu/bin/powerpc64-unknown-linux-gnu-ld: vmlinux: section .data.gcov lma 0xc000000002cdbb78 overlaps previous sections

that probably happens in linux-next and maybe mainline too.




Also....

From: Andrew Morton <akpm@linux-foundation.org>

powerpc allmodconfig:

ERROR: "CMO_PageSize" [arch/powerpc/platforms/pseries/cmm.ko] undefined!

(needed for 2.6.27)

Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
---

 arch/powerpc/platforms/pseries/setup.c |    1 +
 1 file changed, 1 insertion(+)

diff -puN arch/powerpc/platforms/pseries/setup.c~powerpc-export-cmo_pagesize arch/powerpc/platforms/pseries/setup.c
--- a/arch/powerpc/platforms/pseries/setup.c~powerpc-export-cmo_pagesize
+++ a/arch/powerpc/platforms/pseries/setup.c
@@ -71,6 +71,7 @@
 int CMO_PrPSP = -1;
 int CMO_SecPSP = -1;
 unsigned long CMO_PageSize = (ASM_CONST(1) << IOMMU_PAGE_SHIFT);
+EXPORT_SYMBOL(CMO_PageSize);
 
 int fwnmi_active;  /* TRUE if an FWNMI handler is present */
 
_
