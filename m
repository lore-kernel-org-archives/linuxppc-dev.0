Return-Path: <galak@kernel.crashing.org>
Received: from nommos.sslcatacombnetworking.com
	(nommos.sslcatacombnetworking.com [67.18.224.114])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id C468DDDE44
	for <linuxppc-embedded@ozlabs.org>;
	Sat, 10 Feb 2007 02:42:39 +1100 (EST)
Date: Fri, 9 Feb 2007 09:39:57 -0600 (CST)
From: Kumar Gala <galak@kernel.crashing.org>
To: stable@kernel.org
Subject: [PPC] Fix compile error for e500 core based processors
Message-ID: <Pine.LNX.4.64.0702090938360.26617@localhost.localdomain>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Cc: linux-kernel@vger.kernel.org, linuxppc-embedded@ozlabs.org
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

We get the following compiler error:

   CC      arch/ppc/kernel/ppc_ksyms.o
arch/ppc/kernel/ppc_ksyms.c:275: error: '__mtdcr' undeclared here (not in a function)
arch/ppc/kernel/ppc_ksyms.c:275: warning: type defaults to 'int' in declaration of '__mtdcr'
arch/ppc/kernel/ppc_ksyms.c:276: error: '__mfdcr' undeclared here (not in a function)
arch/ppc/kernel/ppc_ksyms.c:276: warning: type defaults to 'int' in declaration of '__mfdcr'
make[1]: *** [arch/ppc/kernel/ppc_ksyms.o] Error 1

This is due to the EXPORT_SYMBOL for __mtdcr/__mfdcr not having the proper CONFIG protection

Signed-off-by: Rojhalat Ibrahim <imr@rtschenk.de>
Signed-off-by: Kumar Gala <galak@kernel.crashing.org>

---

This should go in for 2.6.20,1, got in a sub-arch tree for 2.6.21.

- k

commit 862a7284980d809a583e9a34c774fab84e0a46f8
tree 021a5c277818f63a85d1cbecad69815bedce7174
parent 27630bec9478a2dd387c68b5e435ed3fdd3a513e
author Rojhalat Ibrahim <imr@rtschenk.de> Fri, 09 Feb 2007 15:10:38 +0100
committer Kumar Gala <galak@kernel.crashing.org> Fri, 09 Feb 2007 09:36:37 -0600

  arch/ppc/kernel/ppc_ksyms.c |    2 +-
  1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/arch/ppc/kernel/ppc_ksyms.c b/arch/ppc/kernel/ppc_ksyms.c
index 1f49503..1318b6f 100644
--- a/arch/ppc/kernel/ppc_ksyms.c
+++ b/arch/ppc/kernel/ppc_ksyms.c
@@ -271,7 +271,7 @@ EXPORT_SYMBOL(mmu_hash_lock); /* For MOL */
  extern long *intercept_table;
  EXPORT_SYMBOL(intercept_table);
  #endif /* CONFIG_PPC_STD_MMU */
-#if defined(CONFIG_40x) || defined(CONFIG_BOOKE)
+#ifdef CONFIG_PPC_DCR_NATIVE
  EXPORT_SYMBOL(__mtdcr);
  EXPORT_SYMBOL(__mfdcr);
  #endif
