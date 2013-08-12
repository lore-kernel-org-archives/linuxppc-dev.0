Return-Path: <wladislav.kw@gmail.com>
Received: from mail-wi0-x235.google.com (mail-wi0-x235.google.com
 [IPv6:2a00:1450:400c:c05::235])
 (using TLSv1 with cipher ECDHE-RSA-RC4-SHA (128/128 bits))
 (Client CN "smtp.gmail.com", Issuer "Google Internet Authority" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id E94BF2C00EC
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 12 Aug 2013 21:08:35 +1000 (EST)
Received: by mail-wi0-f181.google.com with SMTP id en1so1538955wid.14
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 12 Aug 2013 04:08:26 -0700 (PDT)
Message-ID: <5208C1CD.3040601@gmail.com>
Date: Mon, 12 Aug 2013 13:06:53 +0200
From: Wladislav Wiebe <wladislav.kw@gmail.com>
MIME-Version: 1.0
To: Aaro Koskinen <aaro.koskinen@iki.fi>
Subject: Re: mm/slab: ppc: ubi: kmalloc_slab WARNING / PPC + UBI driver
References: <51F8F827.6020108@gmail.com>
 <20130731173434.GA27470@blackmetal.musicnaut.iki.fi>
In-Reply-To: <20130731173434.GA27470@blackmetal.musicnaut.iki.fi>
Content-Type: text/plain; charset=ISO-8859-1
Cc: dedekind1@gmail.com, dwmw2@infradead.org, penberg@kernel.org,
 linux-mm@kvack.org, linux-mtd@lists.infradead.org, cl@linux.com,
 linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Hi guys,

we got the real root cause of the allocation issue:

Subject: [PATCH 1/1] of: fdt: fix memory initialization for expanded DT

Already existing property flags are filled wrong for properties created from
initial FDT. This could cause problems if this DYNAMIC device-tree functions
are used later, i.e. properties are attached/detached/replaced. Simply dumping
flags from the running system show, that some initial static (not allocated via
kzmalloc()) nodes are marked as dynamic.

I putted some debug extensions to property_proc_show(..) :
..
+       if (OF_IS_DYNAMIC(pp))
+               pr_err("DEBUG: xxx : OF_IS_DYNAMIC\n");
+       if (OF_IS_DETACHED(pp))
+               pr_err("DEBUG: xxx : OF_IS_DETACHED\n");

when you operate on the nodes (e.g.: ~$ cat /proc/device-tree/*some_node*) you
will see that those flags are filled wrong, basically in most cases it will dump
a DYNAMIC or DETACHED status, which is in not true.
(BTW. this OF_IS_DETACHED is a own define for debug purposes which which just
make a test_bit(OF_DETACHED, &x->_flags)

If nodes are dynamic kernel is allowed to kfree() them. But it will crash
attempting to do so on the nodes from FDT -- they are not allocated via
kzmalloc().

Signed-off-by: Wladislav Wiebe <wladislav.kw@gmail.com>
---
 drivers/of/fdt.c |    2 ++
 1 files changed, 2 insertions(+), 0 deletions(-)

diff --git a/drivers/of/fdt.c b/drivers/of/fdt.c
index 6bb7cf2..b10ba00 100644
--- a/drivers/of/fdt.c
+++ b/drivers/of/fdt.c
@@ -392,6 +392,8 @@ static void __unflatten_device_tree(struct boot_param_header *blob,
 	mem = (unsigned long)
 		dt_alloc(size + 4, __alignof__(struct device_node));

+	memset((void *)mem, 0, size);
+
 	((__be32 *)mem)[size / 4] = cpu_to_be32(0xdeadbeef);

 	pr_debug("  unflattening %lx...\n", mem);
-- 1.7.1

This is committed to the mainline - hope it comes in soon.

Thanks & BR,
Wladislav Wiebe


On 31/07/13 19:34, Aaro Koskinen wrote:
> Hi,
> 
> On Wed, Jul 31, 2013 at 01:42:31PM +0200, Wladislav Wiebe wrote:
>> DEBUG: xxx kmalloc_slab, requested 'size' = 8388608, KMALLOC_MAX_SIZE = 4194304
> [...]
>> [ccd3be60] [c0099fd4] kmalloc_slab+0x48/0xe8 (unreliable)
>> [ccd3be70] [c00ae650] __kmalloc+0x20/0x1b4
>> [ccd3be90] [c00d46f4] seq_read+0x2a4/0x540
>> [ccd3bee0] [c00fe09c] proc_reg_read+0x5c/0x90
>> [ccd3bef0] [c00b4e1c] vfs_read+0xa4/0x150
>> [ccd3bf10] [c00b500c] SyS_read+0x4c/0x84
>> [ccd3bf40] [c000be80] ret_from_syscall+0x0/0x3c
> 
> It seems some procfs file is trying to dump 8 MB at a single go. You
> need to fix that to return data in smaller chunks. What file is it?
> 
> A.
> 
