Return-Path: <gregkh@mini.kroah.org>
Received: from mx2.suse.de (mx2.suse.de [195.135.220.15])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mx2.suse.de",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id 9DFB6DDEC4
	for <linuxppc-embedded@ozlabs.org>;
	Thu,  8 Mar 2007 04:14:22 +1100 (EST)
Message-Id: <20070307171229.446952598@mini.kroah.org>
References: <20070307171035.150802805@mini.kroah.org>
Date: Wed, 07 Mar 2007 09:10:57 -0800
From: Greg KH <gregkh@suse.de>
To: linux-kernel@vger.kernel.org, stable@kernel.org
Subject: [patch 022/101] Fix compile error for e500 core based processors
Cc: Theodore Ts'o <tytso@mit.edu>, Zwane Mwaikambo <zwane@arm.linux.org.uk>,
	linuxppc-embedded@ozlabs.org, Justin Forbes <jmforbes@linuxtx.org>,
	Chris Wedgwood <reviews@ml.cw.f00f.org>,
	Randy Dunlap <rdunlap@xenotime.net>, Michael Krufky <mkrufky@linuxtv.org>,
	Chuck Ebbert <cebbert@redhat.com>, Dave Jones <davej@redhat.com>,
	Chuck Wolber <chuckw@quantumlinux.com>,
	akpm@linux-foundation.org, torvalds@linux-foundation.org,
	alan@lxorguk.ukuu.org.uk
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

From: Rojhalat Ibrahim <imr@rtschenk.de>

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
Signed-off-by: Greg Kroah-Hartman <gregkh@suse.de>

---
 arch/ppc/kernel/ppc_ksyms.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- linux-2.6.20.1.orig/arch/ppc/kernel/ppc_ksyms.c
+++ linux-2.6.20.1/arch/ppc/kernel/ppc_ksyms.c
@@ -270,7 +270,7 @@ EXPORT_SYMBOL(mmu_hash_lock); /* For MOL
 extern long *intercept_table;
 EXPORT_SYMBOL(intercept_table);
 #endif /* CONFIG_PPC_STD_MMU */
-#if defined(CONFIG_40x) || defined(CONFIG_BOOKE)
+#ifdef CONFIG_PPC_DCR_NATIVE
 EXPORT_SYMBOL(__mtdcr);
 EXPORT_SYMBOL(__mfdcr);
 #endif

--
