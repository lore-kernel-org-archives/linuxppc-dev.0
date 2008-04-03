Return-Path: <yhlu.kernel.send@gmail.com>
Received: from wf-out-1314.google.com (wf-out-1314.google.com [209.85.200.172])
	by ozlabs.org (Postfix) with ESMTP id 4459ADDE11
	for <linuxppc-dev@ozlabs.org>; Thu,  3 Apr 2008 12:27:20 +1100 (EST)
Received: by wf-out-1314.google.com with SMTP id 25so2874440wfa.15
	for <linuxppc-dev@ozlabs.org>; Wed, 02 Apr 2008 18:27:19 -0700 (PDT)
To: Andrew Morton <akpm@linux-foundation.org>,
 Ingo Molnar <mingo@elte.hu>
Subject: [PATCH] mm: make mem_map allocation continuous v2.
Date: Wed, 2 Apr 2008 18:30:24 -0700
References: <200804021525.48799.yhlu.kernel@gmail.com>
	<20080402155247.5e746be7.akpm@linux-foundation.org>
	<86802c440804021744m7c6e3d94vcb6af3ebcaa71b5b@mail.gmail.com>
In-Reply-To: <86802c440804021744m7c6e3d94vcb6af3ebcaa71b5b@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Message-Id: <200804021830.24563.yhlu.kernel@gmail.com>
From: Yinghai Lu <yhlu.kernel.send@gmail.com>
Cc: kernel list <linux-kernel@vger.kernel.org>,
	Kamalesh Babulal <kamalesh@linux.vnet.ibm.com>,
	linuxppc-dev@ozlabs.org, Badari Pulavarty <pbadari@us.ibm.com>,
	Balbir Singh <balbir@linux.vnet.ibm.com>
Reply-To: yhlu.kernel@gmail.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


vmemmap allocation current got
 [ffffe20000000000-ffffe200001fffff] PMD ->ffff810001400000 on node 0
 [ffffe20000200000-ffffe200003fffff] PMD ->ffff810001800000 on node 0
 [ffffe20000400000-ffffe200005fffff] PMD ->ffff810001c00000 on node 0
 [ffffe20000600000-ffffe200007fffff] PMD ->ffff810002000000 on node 0
 [ffffe20000800000-ffffe200009fffff] PMD ->ffff810002400000 on node 0
...

there is 2M hole between them.

the rootcause is that usemap (24 bytes) will be allocated after every 2M
mem_map. and it will push next vmemmap (2M) to next align (2M).

solution:
try to allocate mem_map continously.

after patch, will get
 [ffffe20000000000-ffffe200001fffff] PMD ->ffff810001400000 on node 0
 [ffffe20000200000-ffffe200003fffff] PMD ->ffff810001600000 on node 0
 [ffffe20000400000-ffffe200005fffff] PMD ->ffff810001800000 on node 0
 [ffffe20000600000-ffffe200007fffff] PMD ->ffff810001a00000 on node 0
 [ffffe20000800000-ffffe200009fffff] PMD ->ffff810001c00000 on node 0
...
and usemap will share in page because of they are allocated continuously too.
sparse_early_usemap_alloc: usemap = ffff810024e00000 size = 24
sparse_early_usemap_alloc: usemap = ffff810024e00080 size = 24
sparse_early_usemap_alloc: usemap = ffff810024e00100 size = 24
sparse_early_usemap_alloc: usemap = ffff810024e00180 size = 24
...

so we make the bootmem allocation more compact and use less memory for usemap.

for power pc
Badari Pulavarty <pbadari@us.ibm.com> wrote:

>  You have to call sparse_init_one_section() on each pmap and usemap
>  as we allocate - since valid_section() depends on it (which is needed
>  by vmemmap_populate() to check if the section is populated or not).
>  On ppc, we need to call htab_bolted_mapping() on each section and
>  we need to skip existing sections.

so try to allocate usemap at first altogether.

v2 replace:
	[PATCH] mm: make mem_map allocation continuous.
	[PATCH] mm: allocate section_map for sparse_init
	[PATCH] mm: allocate usemap at first instead of mem_map in sparse_init

Signed-off-by: Yinghai Lu <yhlu.kernel@gmail.com>

diff --git a/mm/sparse.c b/mm/sparse.c
index f6a43c0..2881222 100644
--- a/mm/sparse.c
+++ b/mm/sparse.c
@@ -294,22 +294,48 @@ void __init sparse_init(void)
 	unsigned long pnum;
 	struct page *map;
 	unsigned long *usemap;
+	unsigned long **usemap_map;
+	int size;
+
+	/*
+	 * map is using big page (aka 2M in x86 64 bit)
+	 * usemap is less one page (aka 24 bytes)
+	 * so alloc 2M (with 2M align) and 24 bytes in turn will
+	 * make next 2M slip to one more 2M later.
+	 * then in big system, the memory will have a lot of holes...
+	 * here try to allocate 2M pages continously.
+	 *
+	 * powerpc need to call sparse_init_one_section right after each
+	 * sparse_early_mem_map_alloc, so allocate usemap_map at first.
+	 */
+	size = sizeof(unsigned long *) * NR_MEM_SECTIONS;
+	usemap_map = alloc_bootmem(size);
+	if (!usemap_map)
+		panic("can not allocate usemap_map\n");
 
 	for (pnum = 0; pnum < NR_MEM_SECTIONS; pnum++) {
 		if (!present_section_nr(pnum))
 			continue;
+		usemap_map[pnum] = sparse_early_usemap_alloc(pnum);
+	}
 
-		map = sparse_early_mem_map_alloc(pnum);
-		if (!map)
+	for (pnum = 0; pnum < NR_MEM_SECTIONS; pnum++) {
+		if (!present_section_nr(pnum))
 			continue;
 
-		usemap = sparse_early_usemap_alloc(pnum);
+		usemap = usemap_map[pnum];
 		if (!usemap)
 			continue;
 
+		map = sparse_early_mem_map_alloc(pnum);
+		if (!map)
+			continue;
+
 		sparse_init_one_section(__nr_to_section(pnum), pnum, map,
 								usemap);
 	}
+
+	free_bootmem(__pa(usemap_map), size);
 }
 
 #ifdef CONFIG_MEMORY_HOTPLUG
