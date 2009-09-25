Return-Path: <RFeany@mrv.com>
Received: from bos-spam.mrv.com (mx5.mrv.com [140.179.254.12])
	by ozlabs.org (Postfix) with ESMTP id 3D6C4B7B80
	for <linuxppc-dev@ozlabs.org>; Fri, 25 Sep 2009 11:35:33 +1000 (EST)
Date: Thu, 24 Sep 2009 18:35:28 -0700
From: Rex Feany <RFeany@mrv.com>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: Re: [PATCH] powerpc/8xx: fix regression introduced by cache
	coherency rewrite
Message-ID: <20090925013528.GA2584@compile2.chatsunix.int.mrv.com>
References: <20090924004552.GA11737@compile2.chatsunix.int.mrv.com>
	<1253774659.7103.405.camel@pasglop>
	<20090924233346.GA445@compile2.chatsunix.int.mrv.com>
	<1253836376.7103.469.camel@pasglop>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1253836376.7103.469.camel@pasglop>
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

> > Your tree hangs on boot, similar to what I saw without the 8xx
> > work-around patch -- it is hard to tell if it is the same though. :(
> 
> There's no backtrace ? Where does it hang ? Also which workaround
> patch ? The missing tlbil_va() or the _PAGE_SPECIAL problem ?
> 

Ben, I'm sorry, my last email was basically useless. I was refering to the
missing tlbil_va().  The system doesn't crash, but it does seem to hang right
after "Freeing unused kernel memory: 100k init" using your tree.

If I move the tlbil_va() outside of the test for PG_arch_1 :

diff --git a/arch/powerpc/mm/pgtable.c b/arch/powerpc/mm/pgtable.c
index 5304093..d927269 100644
--- a/arch/powerpc/mm/pgtable.c
+++ b/arch/powerpc/mm/pgtable.c
@@ -176,7 +176,7 @@ static pte_t set_pte_filter(pte_t pte, unsigned long addr)
                struct page *pg = maybe_pte_to_page(pte);
                if (!pg)
                        return pte;
-               if (!test_bit(PG_arch_1, &pg->flags)) {
+
 #ifdef CONFIG_8xx
                        /* On 8xx, cache control instructions (particularly
                         * "dcbst" from flush_dcache_icache) fault as write
@@ -188,6 +188,8 @@ static pte_t set_pte_filter(pte_t pte, unsigned long addr)
                        /* 8xx doesn't care about PID, size or ind args */
                        _tlbil_va(addr, 0, 0, 0);
 #endif /* CONFIG_8xx */
+
+               if (!test_bit(PG_arch_1, &pg->flags)) {
                        flush_dcache_icache_page(pg);
                        set_bit(PG_arch_1, &pg->flags);
                }

Then I can boot and get to a shell, but userspace is slow. 8 seconds to mount
/proc (vs. less then a second using my old kernel)! Maybe this is an
unrelated issue?  I'm pretty clueless about the details, I'm sorry.
PG_arch_1 is used to prevent a cache flush unless it is actually needed?
Then why would changing the location of the tlbil_va() make a difference?

take care!
/rex.
