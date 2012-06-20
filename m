Return-Path: <mikey@neuling.org>
From: Michael Neuling <mikey@neuling.org>
To: benh@kernel.crashing.org, Jimi Xenidis <jimix@pobox.com>
Subject: [PATCH] powerpc: fix uninitialised error in numa.c
In-reply-to: <27235.1340171166@neuling.org>
References: <20741.1340165867@neuling.org>
 <20120620053808.GD11330@thor.bakeyournoodle.com>
 <27235.1340171166@neuling.org>
Date: Wed, 20 Jun 2012 16:01:45 +1000
Message-ID: <29100.1340172105@neuling.org>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

chroma_defconfig currently gives me this with gcc 4.6:
  arch/powerpc/mm/numa.c:638:13: error: 'dm' may be used uninitialized in this function [-Werror=uninitialized]

It's a bogus warning/error since of_get_drconf_memory() only writes it
anyway.

Signed-off-by: Michael Neuling <mikey@neuling.org>
cc: stable@kernel.org
---
> > >  static void __init parse_drconf_memory(struct device_node *memory)
> > >  {
> > > -	const u32 *dm, *usm;
> > > +	const u32 *dm = NULL, *usm;
> > 
> > Woot bikeshed!  I think that's what the uninitialized_var() macro is for.
> 
> Doesn't work here.  Produces the same error.

My bad.. I was using it wrong

Still affects 3.4 and 3.3 stable.

diff --git a/arch/powerpc/mm/numa.c b/arch/powerpc/mm/numa.c
index 5ca3a15..7c28589 100644
--- a/arch/powerpc/mm/numa.c
+++ b/arch/powerpc/mm/numa.c
@@ -637,7 +637,7 @@ static inline int __init read_usm_ranges(const u32 **usm)
  */
 static void __init parse_drconf_memory(struct device_node *memory)
 {
-	const u32 *dm, *usm;
+	const u32 *uninitialized_var(dm), *usm;
 	unsigned int n, rc, ranges, is_kexec_kdump = 0;
 	unsigned long lmb_size, base, size, sz;
 	int nid;
