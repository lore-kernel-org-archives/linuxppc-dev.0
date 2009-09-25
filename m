Return-Path: <RFeany@mrv.com>
Received: from bos-spam.mrv.com (mx5.mrv.com [140.179.254.12])
	by ozlabs.org (Postfix) with ESMTP id D9AEEB7B9B
	for <linuxppc-dev@ozlabs.org>; Sat, 26 Sep 2009 07:19:04 +1000 (EST)
Date: Fri, 25 Sep 2009 14:18:48 -0700
From: Rex Feany <RFeany@mrv.com>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: Re: [PATCH] powerpc/8xx: fix regression introduced by cache
	coherency rewrite
Message-ID: <20090925211848.GA3371@compile2.chatsunix.int.mrv.com>
References: <20090924004552.GA11737@compile2.chatsunix.int.mrv.com>
	<1253774659.7103.405.camel@pasglop>
	<20090924233346.GA445@compile2.chatsunix.int.mrv.com>
	<1253836376.7103.469.camel@pasglop>
	<20090925013528.GA2584@compile2.chatsunix.int.mrv.com>
	<1253843480.7103.492.camel@pasglop>
	<1253847827.7103.504.camel@pasglop>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1253847827.7103.504.camel@pasglop>
Cc: "linuxppc-dev@ozlabs.org" <linuxppc-dev@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Thus spake Benjamin Herrenschmidt (benh@kernel.crashing.org):

> 
> > I think there's more finishyness to 8xx than we thought. IE. That
> > tlbil_va might have more reasons to be there than what the comment
> > seems to advertize. Can you try to move it even higher up ? IE.
> > Unconditionally at the beginning of set_pte_filter ?
> > 
> > Also, if that doesn't help, can you try putting one in
> > set_access_flags_filter() just below ?
> 
> Ok, I got a refresher on the whole concept of "unpopulated TLB entries"
> on 8xx, and that's damn scary. I think what mislead me initially is that
> the comment around the workaround is simply not properly describing the
> extent of the problem :-)

Oh boy, that sounds bad. Where is a good place to read about this?

> So I'm not going to make the 8xx TLB miss code sane, that's beyond what
> I'm prepare to do with it, but I suspect that this should fix it (on top
> of upstream). Let me know if that's enough or if we also need to put
> one of these in ptep_set_access_flags().
> 
> Please let me know if that works for you.

Putting the tlbil_va() in the top of set_pte_filter() doesn't work - it
hangs on boot before it even prints any messages to the console.

However, adding tlbil_va() to ptep_set_access_flags() as you suggested
makes everything happy. I need to test it some more, but it looks good
so far. Below is what I am testing now.

thanks!
/rex.


diff --git a/arch/powerpc/mm/pgtable.c b/arch/powerpc/mm/pgtable.c
index 5304093..aef552a 100644
--- a/arch/powerpc/mm/pgtable.c
+++ b/arch/powerpc/mm/pgtable.c
@@ -176,18 +176,19 @@ static pte_t set_pte_filter(pte_t pte, unsigned long addr)
 		struct page *pg = maybe_pte_to_page(pte);
 		if (!pg)
 			return pte;
-		if (!test_bit(PG_arch_1, &pg->flags)) {
 #ifdef CONFIG_8xx
-			/* On 8xx, cache control instructions (particularly
-			 * "dcbst" from flush_dcache_icache) fault as write
-			 * operation if there is an unpopulated TLB entry
-			 * for the address in question. To workaround that,
-			 * we invalidate the TLB here, thus avoiding dcbst
-			 * misbehaviour.
-			 */
-			/* 8xx doesn't care about PID, size or ind args */
-			_tlbil_va(addr, 0, 0, 0);
+		/* On 8xx, cache control instructions (particularly
+		 * "dcbst" from flush_dcache_icache) fault as write
+		 * operation if there is an unpopulated TLB entry
+		 * for the address in question. To workaround that,
+		 * we invalidate the TLB here, thus avoiding dcbst
+		 * misbehaviour.
+		 */
+		/* 8xx doesn't care about PID, size or ind args */
+		_tlbil_va(addr, 0, 0, 0);
 #endif /* CONFIG_8xx */
+
+		if (!test_bit(PG_arch_1, &pg->flags)) {
 			flush_dcache_icache_page(pg);
 			set_bit(PG_arch_1, &pg->flags);
 		}
@@ -308,6 +309,12 @@ int ptep_set_access_flags(struct vm_area_struct *vma, unsigned long address,
 	int changed;
 	entry = set_access_flags_filter(entry, vma, dirty);
 	changed = !pte_same(*(ptep), entry);
+
+#ifdef CONFIG_8xx
+	/* 8xx doesn't care about PID, size or ind args */
+	_tlbil_va(address, 0, 0, 0);
+#endif /* CONFIG_8xx */
+
 	if (changed) {
 		if (!(vma->vm_flags & VM_HUGETLB))
 			assert_pte_locked(vma->vm_mm, address);
