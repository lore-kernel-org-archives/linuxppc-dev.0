Return-Path: <rdreier@cisco.com>
Received: from sj-iport-6.cisco.com (sj-iport-6.cisco.com [171.71.176.117])
	(using TLSv1 with cipher RC4-SHA (128/128 bits))
	(Client CN "sj-iport-6.cisco.com", Issuer "Cisco SSCA" (not verified))
	by ozlabs.org (Postfix) with ESMTPS id B4BBADDE25
	for <linuxppc-embedded@ozlabs.org>;
	Thu, 28 Aug 2008 13:12:44 +1000 (EST)
From: Roland Dreier <rdreier@cisco.com>
To: vb <vb@vsbe.com>
Subject: Re: mmap and ppc460gt
References: <f608b67d0808261926p67e27770mb7c64cc14015b9ab@mail.gmail.com>
	<ada3akri1i5.fsf@cisco.com> <200808271013.18659.arnd@arndb.de>
	<f608b67d0808271613g2092b287o44c3418fb7d33499@mail.gmail.com>
	<adawsi2j8wt.fsf@cisco.com>
Date: Wed, 27 Aug 2008 20:12:41 -0700
In-Reply-To: <adawsi2j8wt.fsf@cisco.com> (Roland Dreier's message of "Wed, 27
	Aug 2008 17:11:14 -0700")
Message-ID: <adak5e1kf2u.fsf@cisco.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Arnd Bergmann <arnd@arndb.de>, linuxppc-embedded@ozlabs.org
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

OK, please try this and let me know if it helps:

diff --git a/arch/powerpc/mm/mem.c b/arch/powerpc/mm/mem.c
index 1c93c25..98d7bf9 100644
--- a/arch/powerpc/mm/mem.c
+++ b/arch/powerpc/mm/mem.c
@@ -75,11 +75,10 @@ static inline pte_t *virt_to_kpte(unsigned long vaddr)
 
 int page_is_ram(unsigned long pfn)
 {
-	unsigned long paddr = (pfn << PAGE_SHIFT);
-
 #ifndef CONFIG_PPC64	/* XXX for now */
-	return paddr < __pa(high_memory);
+	return pfn < max_pfn;
 #else
+	unsigned long paddr = (pfn << PAGE_SHIFT);
 	int i;
 	for (i=0; i < lmb.memory.cnt; i++) {
 		unsigned long base;
