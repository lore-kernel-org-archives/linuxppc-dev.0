Return-Path: <mgorman@suse.de>
Received: from mx2.suse.de (cantor2.suse.de [195.135.220.15])
 (using TLSv1 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 073711A06C0
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  2 Dec 2014 21:12:20 +1100 (AEDT)
Date: Tue, 2 Dec 2014 10:12:10 +0000
From: Mel Gorman <mgorman@suse.de>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: Re: [PATCH 02/10] mm: Add p[te|md] protnone helpers for use by NUMA
 balancing
Message-ID: <20141202101210.GA6043@suse.de>
References: <1416578268-19597-1-git-send-email-mgorman@suse.de>
 <1416578268-19597-3-git-send-email-mgorman@suse.de>
 <1417473519.7182.6.camel@kernel.crashing.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15
In-Reply-To: <1417473519.7182.6.camel@kernel.crashing.org>
Cc: Rik van Riel <riel@redhat.com>,
 Linus Torvalds <torvalds@linux-foundation.org>,
 Hugh Dickins <hughd@google.com>, Linux Kernel <linux-kernel@vger.kernel.org>,
 Linux-MM <linux-mm@kvack.org>, Ingo Molnar <mingo@redhat.com>,
 Paul Mackerras <paulus@samba.org>,
 Aneesh Kumar <aneesh.kumar@linux.vnet.ibm.com>,
 Sasha Levin <sasha.levin@oracle.com>, Dave Jones <davej@redhat.com>,
 LinuxPPC-dev <linuxppc-dev@lists.ozlabs.org>,
 Kirill Shutemov <kirill.shutemov@linux.intel.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Tue, Dec 02, 2014 at 09:38:39AM +1100, Benjamin Herrenschmidt wrote:
> On Fri, 2014-11-21 at 13:57 +0000, Mel Gorman wrote:
> 
> >  #ifdef CONFIG_NUMA_BALANCING
> > +/*
> > + * These work without NUMA balancing but the kernel does not care. See the
> > + * comment in include/asm-generic/pgtable.h
> > + */
> > +static inline int pte_protnone(pte_t pte)
> > +{
> > +	return (pte_val(pte) &
> > +		(_PAGE_PRESENT | _PAGE_USER)) == _PAGE_PRESENT;
> > +}
> 
> I would add a comment clarifying that this only works for user pages,
> ie, this accessor will always return "true" for a kernel page on ppc.
> 

diff --git a/arch/powerpc/include/asm/pgtable.h b/arch/powerpc/include/asm/pgtable.h
index 490bd6d..7b889a3 100644
--- a/arch/powerpc/include/asm/pgtable.h
+++ b/arch/powerpc/include/asm/pgtable.h
@@ -41,7 +41,8 @@ static inline pgprot_t pte_pgprot(pte_t pte)	{ return __pgprot(pte_val(pte) & PA
 #ifdef CONFIG_NUMA_BALANCING
 /*
  * These work without NUMA balancing but the kernel does not care. See the
- * comment in include/asm-generic/pgtable.h
+ * comment in include/asm-generic/pgtable.h . On powerpc, this will only
+ * work for user pages and always return true for kernel pages.
  */
 static inline int pte_protnone(pte_t pte)
 {

-- 
Mel Gorman
SUSE Labs
