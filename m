Return-Path: <shaggy@linux.vnet.ibm.com>
Subject: Re: [patch 5/5] powerpc: Dont clear _PAGE_COHERENT when _PAGE_SAO
	is set
From: Dave Kleikamp <shaggy@linux.vnet.ibm.com>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
In-Reply-To: <1215575177.8970.311.camel@pasglop>
References: <20080707142850.034542257@linux.vnet.ibm.com>
	<20080707143011.729373219@linux.vnet.ibm.com>
	<1215575177.8970.311.camel@pasglop>
Content-Type: text/plain
Date: Wed, 09 Jul 2008 10:28:07 -0500
Message-Id: <1215617287.30113.26.camel@norville.austin.ibm.com>
Mime-Version: 1.0
Cc: linuxppc-dev list <Linuxppc-dev@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Wed, 2008-07-09 at 13:46 +1000, Benjamin Herrenschmidt wrote:

> The old code looks bogus.. why clear M when G is set ? Only
> I should have mattered.

I can't find anywhere where G gets set without also setting I, so the
test seems redundant as well.

> I'll apply anyway as you aren't changing the existing behaviour here but
> maybe you can shoot me a fixup patch that removes the _PAGE_GUARDED
> condition completely here ?

No problem.  There is code in cell/beat_htab.c doing the same thing.
I've gone ahead and fixed it there too.

> It's legal to have G=1 M=1 pages and can even be useful under some
> circumstances.

It doesn't look like anyone is trying to take advantage of that
currently.

Here's your patch:

powerpc: Remove unnecessary condition when sanity-checking WIMG bits

It is okay for both _PAGE_GUARDED and _PAGE_COHERENT (G and M) to be set
in the same pte.  In fact, even if that were not the case, there doesn't
seem to be any place where G is set without also setting I (_PAGE_NO_CACHE),
so the test for I is sufficient.

Signed-off-by: Dave Kleikamp <shaggy@linux.vnet.ibm.com>

diff --git a/arch/powerpc/platforms/cell/beat_htab.c b/arch/powerpc/platforms/cell/beat_htab.c
index 81467ff..2e67bd8 100644
--- a/arch/powerpc/platforms/cell/beat_htab.c
+++ b/arch/powerpc/platforms/cell/beat_htab.c
@@ -112,7 +112,7 @@ static long beat_lpar_hpte_insert(unsigned long hpte_group,
 	if (!(vflags & HPTE_V_BOLTED))
 		DBG_LOW(" hpte_v=%016lx, hpte_r=%016lx\n", hpte_v, hpte_r);
 
-	if (rflags & (_PAGE_GUARDED|_PAGE_NO_CACHE))
+	if (rflags & _PAGE_NO_CACHE)
 		hpte_r &= ~_PAGE_COHERENT;
 
 	spin_lock(&beat_htab_lock);
@@ -334,7 +334,7 @@ static long beat_lpar_hpte_insert_v3(unsigned long hpte_group,
 	if (!(vflags & HPTE_V_BOLTED))
 		DBG_LOW(" hpte_v=%016lx, hpte_r=%016lx\n", hpte_v, hpte_r);
 
-	if (rflags & (_PAGE_GUARDED|_PAGE_NO_CACHE))
+	if (rflags & _PAGE_NO_CACHE)
 		hpte_r &= ~_PAGE_COHERENT;
 
 	/* insert into not-volted entry */
diff --git a/arch/powerpc/platforms/pseries/lpar.c b/arch/powerpc/platforms/pseries/lpar.c
index 38b5927..52a80e5 100644
--- a/arch/powerpc/platforms/pseries/lpar.c
+++ b/arch/powerpc/platforms/pseries/lpar.c
@@ -305,8 +305,7 @@ static long pSeries_lpar_hpte_insert(unsigned long hpte_group,
 	flags = 0;
 
 	/* Make pHyp happy */
-	if ((rflags & _PAGE_GUARDED) ||
-	    ((rflags & _PAGE_NO_CACHE) & !(rflags & _PAGE_WRITETHRU)))
+	if ((rflags & _PAGE_NO_CACHE) & !(rflags & _PAGE_WRITETHRU))
 		hpte_r &= ~_PAGE_COHERENT;
 
 	lpar_rc = plpar_pte_enter(flags, hpte_group, hpte_v, hpte_r, &slot);

-- 
David Kleikamp
IBM Linux Technology Center
