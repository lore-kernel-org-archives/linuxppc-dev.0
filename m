Return-Path: <sfr@canb.auug.org.au>
Received: from ozlabs.org (ozlabs.org [203.10.76.45])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mx.ozlabs.org",
	Issuer "CA Cert Signing Authority" (verified OK))
	by bilbo.ozlabs.org (Postfix) with ESMTPS id 8D2D7B7B7F
	for <linuxppc-dev@lists.ozlabs.org>;
	Fri, 21 Aug 2009 13:56:46 +1000 (EST)
Received: from smtps.tip.net.au (chilli.pcug.org.au [203.10.76.44])
	by ozlabs.org (Postfix) with ESMTP id 7D2CEDDD04
	for <linuxppc-dev@ozlabs.org>; Fri, 21 Aug 2009 13:56:46 +1000 (EST)
Date: Fri, 21 Aug 2009 13:56:44 +1000
From: Stephen Rothwell <sfr@canb.auug.org.au>
To: Dave Airlie <airlied@linux.ie>
Subject: linux-next: manual merge of the agp tree with the powerpc tree
Message-Id: <20090821135644.3f817b82.sfr@canb.auug.org.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Cc: David Woodhouse <David.Woodhouse@intel.com>, linux-kernel@vger.kernel.org,
	Michel =?UTF-8?B?RMOkbnplcg==?= <daenzer@vmware.com>,
	linuxppc-dev@ozlabs.org, linux-next@vger.kernel.org,
	Paul Mackerras <paulus@samba.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Hi Dave,

Today's linux-next merge of the agp tree got a conflict in
drivers/char/agp/uninorth-agp.c between commit uninorth_create_gatt_table
("agp/uninorth: Simplify cache flushing") from the powerpc tree and
commit 6a12235c7d2d75c7d94b9afcaaecd422ff845ce0 ("agp: kill phys_to_gart
() and gart_to_phys()") from the agp tree.

Just context changes.  I fixed it up (see below) and can carry the fix as
necessary.
-- 
Cheers,
Stephen Rothwell                    sfr@canb.auug.org.au

diff --cc drivers/char/agp/uninorth-agp.c
index bba29ab,4317a55..0000000
--- a/drivers/char/agp/uninorth-agp.c
+++ b/drivers/char/agp/uninorth-agp.c
@@@ -424,28 -424,14 +424,28 @@@ static int uninorth_create_gatt_table(s
  	if (table == NULL)
  		return -ENOMEM;
  
 +	pages = kmalloc((1 << page_order) * sizeof(struct page*), GFP_KERNEL);
 +	if (pages == NULL)
 +		goto enomem;
 +
  	table_end = table + ((PAGE_SIZE * (1 << page_order)) - 1);
  
 -	for (page = virt_to_page(table); page <= virt_to_page(table_end); page++)
 +	for (page = virt_to_page(table), i = 0; page <= virt_to_page(table_end);
 +	     page++, i++) {
  		SetPageReserved(page);
 +		pages[i] = page;
 +	}
  
  	bridge->gatt_table_real = (u32 *) table;
 -	bridge->gatt_table = (u32 *)table;
 +	/* Need to clear out any dirty data still sitting in caches */
 +	flush_dcache_range((unsigned long)table,
 +			   (unsigned long)(table_end + PAGE_SIZE));
 +	bridge->gatt_table = vmap(pages, (1 << page_order), 0, PAGE_KERNEL_NCG);
 +
 +	if (bridge->gatt_table == NULL)
 +		goto enomem;
 +
- 	bridge->gatt_bus_addr = virt_to_gart(table);
+ 	bridge->gatt_bus_addr = virt_to_phys(table);
  
  	for (i = 0; i < num_entries; i++)
  		bridge->gatt_table[i] = 0;
