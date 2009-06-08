Return-Path: <sachinp@in.ibm.com>
Received: from ozlabs.org (ozlabs.org [203.10.76.45])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mx.ozlabs.org",
	Issuer "CA Cert Signing Authority" (verified OK))
	by bilbo.ozlabs.org (Postfix) with ESMTPS id B25F1B70AC
	for <linuxppc-dev@lists.ozlabs.org>;
	Mon,  8 Jun 2009 22:12:21 +1000 (EST)
Received: from e23smtp06.au.ibm.com (e23smtp06.au.ibm.com [202.81.31.148])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e23smtp06.au.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id 4BE7BDDD04
	for <linuxppc-dev@ozlabs.org>; Mon,  8 Jun 2009 22:12:20 +1000 (EST)
Received: from d23relay02.au.ibm.com (d23relay02.au.ibm.com [202.81.31.244])
	by e23smtp06.au.ibm.com (8.13.1/8.13.1) with ESMTP id n58CCFmT027845
	for <linuxppc-dev@ozlabs.org>; Mon, 8 Jun 2009 22:12:15 +1000
Received: from d23av02.au.ibm.com (d23av02.au.ibm.com [9.190.235.138])
	by d23relay02.au.ibm.com (8.13.8/8.13.8/NCO v9.2) with ESMTP id
	n58CCJQC663594
	for <linuxppc-dev@ozlabs.org>; Mon, 8 Jun 2009 22:12:19 +1000
Received: from d23av02.au.ibm.com (loopback [127.0.0.1])
	by d23av02.au.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id
	n58CCJOT026795
	for <linuxppc-dev@ozlabs.org>; Mon, 8 Jun 2009 22:12:19 +1000
Message-ID: <4A2D001E.5060802@in.ibm.com>
Date: Mon, 08 Jun 2009 17:42:14 +0530
From: Sachin Sant <sachinp@in.ibm.com>
MIME-Version: 1.0
To: Pekka J Enberg <penberg@cs.helsinki.fi>
Subject: Re: [Powerpc/SLQB] Next June 06 : BUG during scsi initialization
References: <20090511161442.3e9d9cb9.sfr@canb.auug.org.au>
	<4A081002.4050802@in.ibm.com> <4A2909E8.6000507@in.ibm.com>
	<Pine.LNX.4.64.0906071105030.11309@melkki.cs.Helsinki.FI>
In-Reply-To: <Pine.LNX.4.64.0906071105030.11309@melkki.cs.Helsinki.FI>
Content-Type: multipart/mixed; boundary="------------090001070505070502010009"
Cc: Nick Piggin <npiggin@suse.de>, Stephen Rothwell <sfr@canb.auug.org.au>,
	linux-next@vger.kernel.org, linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

This is a multi-part message in MIME format.
--------------090001070505070502010009
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

Pekka J Enberg wrote:
> Hi Sachin,
>
> On Fri, 5 Jun 2009, Sachin Sant wrote:
>   
>> I can still recreate this bug on a Power 6 hardware with today's next tree.
>> I can recreate this problem at will.
>> Let me know if i can help in debugging this problem.
>>     
>
> Can you please reproduce the issue with this debugging patch applied and 
> post the result?
I had some trouble collecting debug o/p with this patch. Because of the
number of printk's the machine was crawling during boot. It was difficult
to read/collect the o/p. So i inserted a hack as follows such that
slab_alloc_page prints only during the failure.(modprobe scsi-driver)

+ if (strcmp(current->comm, "modprobe"))
+	printk(KERN_INFO "%s: cpu=%d, cache_cpu=%p, cache_list=%p\n", __func__, cpu, c, l);

Attached here is the boot log. Let me know if i can provide any other
information.

Thanks
-Sachin

-- 

---------------------------------
Sachin Sant
IBM Linux Technology Center
India Systems and Technology Labs
Bangalore, India
---------------------------------


--------------090001070505070502010009
Content-Type: text/plain;
 name="boot-log"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="boot-log"

00
alloc_kmem_cache_nodes: cache=ext2_xattr, node=2
alloc_kmem_cache_nodes: cache=ext2_xattr, node=3
__slab_alloc_page: nid=2, cache_node=c0000000008c4300, cache_list=c0000000008c4300
__slab_alloc_page: nid=2, cache_node=c0000000008c4300, cache_list=c0000000008c4300
alloc_kmem_cache_nodes: cache=ext2_inode_cache, node=2
alloc_kmem_cache_nodes: cache=ext2_inode_cache, node=3
__slab_alloc_page: nid=2, cache_node=c0000000008c4300, cache_list=c0000000008c4300
__slab_alloc_page: nid=2, cache_node=c0000000008c4300, cache_list=c0000000008c4300
alloc_kmem_cache_nodes: cache=ext4_system_zone, node=2
alloc_kmem_cache_nodes: cache=ext4_system_zone, node=3
__slab_alloc_page: nid=2, cache_node=c0000000008c4300, cache_list=c0000000008c4300
__slab_alloc_page: nid=2, cache_node=c0000000008c4300, cache_list=c0000000008c4300
alloc_kmem_cache_nodes: cache=ext4_prealloc_space, node=2
alloc_kmem_cache_nodes: cache=ext4_prealloc_space, node=3
__slab_alloc_page: nid=2, cache_node=c0000000008c4300, cache_list=c0000000008c4300
__slab_alloc_page: nid=2, cache_node=c0000000008c4300, cache_list=c0000000008c4300
alloc_kmem_cache_nodes: cache=ext4_alloc_context, node=2
alloc_kmem_cache_nodes: cache=ext4_alloc_context, node=3
__slab_alloc_page: nid=2, cache_node=c0000000008c4300, cache_list=c0000000008c4300
__slab_alloc_page: nid=2, cache_node=c0000000008c4300, cache_list=c0000000008c4300
alloc_kmem_cache_nodes: cache=ext4_free_block_extents, node=2
alloc_kmem_cache_nodes: cache=ext4_free_block_extents, node=3
__slab_alloc_page: nid=2, cache_node=c0000000008c4300, cache_list=c0000000008c4300
__slab_alloc_page: nid=2, cache_node=c0000000008c4300, cache_list=c0000000008c4300
alloc_kmem_cache_nodes: cache=ext4_xattr, node=2
alloc_kmem_cache_nodes: cache=ext4_xattr, node=3
__slab_alloc_page: nid=2, cache_node=c0000000008c4300, cache_list=c0000000008c4300
__slab_alloc_page: nid=2, cache_node=c0000000008c4300, cache_list=c0000000008c4300
alloc_kmem_cache_nodes: cache=ext4_inode_cache, node=2
alloc_kmem_cache_nodes: cache=ext4_inode_cache, node=3
__slab_alloc_page: nid=2, cache_node=c0000000008c4300, cache_list=c0000000008c4300
__slab_alloc_page: nid=2, cache_node=c0000000008c4300, cache_list=c0000000008c4300
alloc_kmem_cache_nodes: cache=revoke_record, node=2
alloc_kmem_cache_nodes: cache=revoke_record, node=3
__slab_alloc_page: nid=2, cache_node=c0000000008c4300, cache_list=c0000000008c4300
__slab_alloc_page: nid=2, cache_node=c0000000008c4300, cache_list=c0000000008c4300
alloc_kmem_cache_nodes: cache=revoke_table, node=2
alloc_kmem_cache_nodes: cache=revoke_table, node=3
__slab_alloc_page: nid=2, cache_node=c0000000008c4300, cache_list=c0000000008c4300
__slab_alloc_page: nid=2, cache_node=c0000000008c4300, cache_list=c0000000008c4300
alloc_kmem_cache_nodes: cache=journal_head, node=2
alloc_kmem_cache_nodes: cache=journal_head, node=3
__slab_alloc_page: nid=2, cache_node=c0000000008c4300, cache_list=c0000000008c4300
__slab_alloc_page: nid=2, cache_node=c0000000008c4300, cache_list=c0000000008c4300
alloc_kmem_cache_nodes: cache=journal_handle, node=2
alloc_kmem_cache_nodes: cache=journal_handle, node=3
__slab_alloc_page: nid=2, cache_node=c0000000008c4300, cache_list=c0000000008c4300
__slab_alloc_page: nid=2, cache_node=c0000000008c4300, cache_list=c0000000008c4300
alloc_kmem_cache_nodes: cache=jbd2_revoke_record, node=2
alloc_kmem_cache_nodes: cache=jbd2_revoke_record, node=3
__slab_alloc_page: nid=2, cache_node=c0000000008c4300, cache_list=c0000000008c4300
__slab_alloc_page: nid=2, cache_node=c0000000008c4300, cache_list=c0000000008c4300
alloc_kmem_cache_nodes: cache=jbd2_revoke_table, node=2
alloc_kmem_cache_nodes: cache=jbd2_revoke_table, node=3
__slab_alloc_page: nid=2, cache_node=c0000000008c4300, cache_list=c0000000008c4300
__slab_alloc_page: nid=2, cache_node=c0000000008c4300, cache_list=c0000000008c4300
alloc_kmem_cache_nodes: cache=jbd2_journal_head, node=2
alloc_kmem_cache_nodes: cache=jbd2_journal_head, node=3
__slab_alloc_page: nid=2, cache_node=c0000000008c4300, cache_list=c0000000008c4300
__slab_alloc_page: nid=2, cache_node=c0000000008c4300, cache_list=c0000000008c4300
alloc_kmem_cache_nodes: cache=jbd2_journal_handle, node=2
alloc_kmem_cache_nodes: cache=jbd2_journal_handle, node=3
__slab_alloc_page: nid=2, cache_node=c0000000008c4300, cache_list=c0000000008c4300
__slab_alloc_page: nid=2, cache_node=c0000000008c4300, cache_list=c0000000008c4300
__slab_alloc_page: nid=2, cache_node=c0000000de011800, cache_list=c0000000de011800
__slab_alloc_page: nid=2, cache_node=c0000000de011800, cache_list=c0000000de011800
__slab_alloc_page: nid=2, cache_node=c0000000de011800, cache_list=c0000000de011800
__slab_alloc_page: nid=2, cache_node=c0000000de011800, cache_list=c0000000de011800
__slab_alloc_page: nid=2, cache_node=c0000000de011800, cache_list=c0000000de011800
__slab_alloc_page: nid=2, cache_node=c0000000de011800, cache_list=c0000000de011800
alloc_kmem_cache_nodes: cache=hugetlbfs_inode_cache, node=2
alloc_kmem_cache_nodes: cache=hugetlbfs_inode_cache, node=3
__slab_alloc_page: nid=2, cache_node=c0000000008c4300, cache_list=c0000000008c4300
__slab_alloc_page: nid=2, cache_node=c0000000008c4300, cache_list=c0000000008c4300
__slab_alloc_page: nid=2, cache_node=c0000000de011800, cache_list=c0000000de011800
__slab_alloc_page: nid=2, cache_node=c0000000de011800, cache_list=c0000000de011800
__slab_alloc_page: nid=2, cache_node=c0000000dbc7b780, cache_list=c0000000dbc7b780
alloc_kmem_cache_nodes: cache=minix_inode_cache, node=2
alloc_kmem_cache_nodes: cache=minix_inode_cache, node=3
__slab_alloc_page: nid=2, cache_node=c0000000008c4300, cache_list=c0000000008c4300
__slab_alloc_page: nid=2, cache_node=c0000000008c4300, cache_list=c0000000008c4300
alloc_kmem_cache_nodes: cache=fat_cache, node=2
alloc_kmem_cache_nodes: cache=fat_cache, node=3
__slab_alloc_page: nid=2, cache_node=c0000000008c4300, cache_list=c0000000008c4300
__slab_alloc_page: nid=2, cache_node=c0000000008c4300, cache_list=c0000000008c4300
alloc_kmem_cache_nodes: cache=fat_inode_cache, node=2
alloc_kmem_cache_nodes: cache=fat_inode_cache, node=3
__slab_alloc_page: nid=2, cache_node=c0000000008c4300, cache_list=c0000000008c4300
__slab_alloc_page: nid=2, cache_node=c0000000008c4300, cache_list=c0000000008c4300
alloc_kmem_cache_nodes: cache=isofs_inode_cache, node=2
alloc_kmem_cache_nodes: cache=isofs_inode_cache, node=3
__slab_alloc_page: nid=2, cache_node=c0000000008c4300, cache_list=c0000000008c4300
__slab_alloc_page: nid=2, cache_node=c0000000008c4300, cache_list=c0000000008c4300
__slab_alloc_page: nid=2, cache_node=c0000000de011200, cache_list=c0000000de011200
__slab_alloc_page: nid=2, cache_node=c0000000de011800, cache_list=c0000000de011800
__slab_alloc_page: nid=2, cache_node=c0000000de010000, cache_list=c0000000de010000
alloc_kmem_cache_nodes: cache=btrfs_inode_cache, node=2
alloc_kmem_cache_nodes: cache=btrfs_inode_cache, node=3
__slab_alloc_page: nid=2, cache_node=c0000000008c4300, cache_list=c0000000008c4300
__slab_alloc_page: nid=2, cache_00
00
00


__slab_alloc_page: nid=2, cache_node=c0000000de01e700, cache_list=c0000000de01e700
__slab_alloc_page: nid=2, cache_node=c0000000de012a00, cache_list=c0000000de012a00
__slab_alloc_page: nid=2, cache_node=c0000000de01e700, cache_list=c0000000de01e700
__slab_alloc_page: nid=2, cache_node=c0000000de012400, cache_list=c0000000de012400
__slab_alloc_page: nid=2, cache_node=c0000000de01e700, cache_list=c0000000de01e700
__slab_alloc_page: nid=2, cache_node=c0000000de012a00, cache_list=c0000000de012a00
ehea: eth0: Jumbo frames are disabled
ehea: eth0 -> logical port id #2
__slab_alloc_page: nid=2, cache_node=c0000000de01e700, cache_list=c0000000de01e700
__slab_alloc_page: nid=2, cache_node=c0000000de012400, cache_list=c0000000de012400
__slab_alloc_page: nid=2, cache_node=c0000000de01e700, cache_list=c0000000de01e700
__slab_alloc_page: nid=2, cache_node=c0000000de012400, cache_list=c0000000de012400
__slab_alloc_page: nid=2, cache_node=c0000000de01e700, cache_list=c0000000de01e700
__slab_alloc_page: nid=2, cache_node=c0000000de012400, cache_list=c0000000de012400
ehci_hcd: USB 2.0 'Enhanced' Host Controller (EHCI) Driver
__slab_alloc_page: nid=2, cache_node=c0000000de01e700, cache_list=c0000000de01e700
__slab_alloc_page: nid=2, cache_node=c0000000de012400, cache_list=c0000000de012400
__slab_alloc_page: nid=2, cache_node=c0000000de01e700, cache_list=c0000000de01e700
__slab_alloc_page: nid=2, cache_node=c0000000de012400, cache_list=c0000000de012400
ohci_hcd: USB 1.1 'Open' Host Controller (OHCI) Driver
__slab_alloc_page: nid=2, cache_node=c0000000de01e700, cache_list=c0000000de01e700
__slab_alloc_page: nid=2, cache_node=c0000000de012400, cache_list=c0000000de012400
__slab_alloc_page: nid=2, cache_node=c0000000de01e700, cache_list=c0000000de01e700
__slab_alloc_page: nid=2, cache_node=c0000000de012400, cache_list=c0000000de012400
__slab_alloc_page: nid=2, cache_node=c0000000de01e700, cache_list=c0000000de01e700
__slab_alloc_page: nid=2, cache_node=c0000000de012400, cache_list=c0000000de012400
__slab_alloc_page: nid=2, cache_node=c0000000de01e700, cache_list=c0000000de01e700
__slab_alloc_page: nid=2, cache_node=c0000000de012400, cache_list=c0000000de012400
mice: PS/2 mouse device common for all mice
__slab_alloc_page: nid=2, cache_node=c0000000de01e700, cache_list=c0000000de01e700
__slab_alloc_page: nid=2, cache_node=c0000000de012400, cache_list=c0000000de012400
__slab_alloc_page: nid=2, cache_node=c0000000de01e700, cache_list=c0000000de01e700
__slab_alloc_page: nid=2, cache_node=c0000000de012400, cache_list=c0000000de012400
__slab_alloc_page: nid=2, cache_node=c0000000de011800, cache_list=c0000000de011800
__slab_alloc_page: nid=2, cache_node=c0000000de011800, cache_list=c0000000de011800
__slab_alloc_page: nid=2, cache_node=c0000000de019f00, cache_list=c0000000de019f00
__slab_alloc_page: nid=2, cache_node=c0000000de019900, cache_list=c0000000de019900
__slab_alloc_page: nid=2, cache_node=c0000000de019c00, cache_list=c0000000de019c00
__slab_alloc_page: nid=2, cache_node=c0000000de011200, cache_list=c0000000de011200
__slab_alloc_page: nid=2, cache_node=c0000000de01db00, cache_list=c0000000de01db00
__slab_alloc_page: nid=2, cache_node=c0000000de01a200, cache_list=c0000000de01a200
__slab_alloc_page: nid=2, cache_node=c0000000de01a500, cache_list=c0000000de01a500
__slab_alloc_page: nid=2, cache_node=c0000000de018d00, cache_list=c0000000de018d00
__slab_alloc_page: nid=2, cache_node=c0000000de01e700, cache_list=c0000000de01e700
__slab_alloc_page: nid=2, cache_node=c0000000de012400, cache_list=c0000000de012400
__slab_alloc_page: nid=2, cache_node=c0000000de01e700, cache_list=c0000000de01e700
__slab_alloc_page: nid=2, cache_node=c0000000de012400, cache_list=c0000000de012400
EDAC MC: Ver: 2.1.0 Jun  8 2009
__slab_alloc_page: nid=2, cache_node=c0000000de01e700, cache_list=c0000000de01e700
__slab_alloc_page: nid=2, cache_node=c0000000de012400, cache_list=c0000000de012400
__slab_alloc_page: nid=2, cache_node=c0000000de01e700, cache_list=c0000000de01e700
__slab_alloc_page: nid=2, cache_node=c0000000de012400, cache_list=c0000000de012400
__slab_alloc_page: nid=2, cache_node=c0000000de011800, cache_list=c0000000de011800
__slab_alloc_page: nid=2, cache_node=c0000000de011800, cache_list=c0000000de011800
__slab_alloc_page: nid=2, cache_node=c0000000de019f00, cache_list=c0000000de019f00
__slab_alloc_page: nid=2, cache_node=c0000000de019900, cache_list=c0000000de019900
__slab_alloc_page: nid=2, cache_node=c0000000de019c00, cache_list=c0000000de019c00
__slab_alloc_page: nid=2, cache_node=c0000000de011200, cache_list=c0000000de011200
__slab_alloc_page: nid=2, cache_node=c0000000de01db00, cache_list=c0000000de01db00
__slab_alloc_page: nid=2, cache_node=c0000000de01a200, cache_list=c0000000de01a200
__slab_alloc_page: nid=2, cache_node=c0000000de01a500, cache_list=c0000000de01a500
__slab_alloc_page: nid=2, cache_00
00


__slab_alloc_page: nid=2, cache_node=c0000000de01b100, cache_list=c0000000de01b100
__slab_alloc_page: nid=2, cache_node=c0000000de01b100, cache_list=c0000000de01b100
__slab_alloc_page: nid=2, cache_node=c0000000de01b100, cache_list=c0000000de01b100
__slab_alloc_page: nid=2, cache_node=c0000000de019600, cache_list=c0000000de019600
__slab_alloc_page: nid=2, cache_node=c0000000de01ba00, cache_list=c0000000de01ba00
__slab_alloc_page: nid=2, cache_node=c0000000de01c300, cache_list=c0000000de01c300
__slab_alloc_page: nid=2, cache_node=c0000000de01b100, cache_list=c0000000de01b100
__slab_alloc_page: nid=2, cache_node=c0000000de01b100, cache_list=c0000000de01b100
__slab_alloc_page: nid=2, cache_node=c0000000de01b100, cache_list=c0000000de01b100
__slab_alloc_page: nid=2, cache_node=c0000000de019600, cache_list=c0000000de019600
__slab_alloc_page: nid=2, cache_node=c0000000de01ba00, cache_list=c0000000de01ba00
__slab_alloc_page: nid=2, cache_node=c0000000de000
00
00
doing fast boot
__slab_alloc_page: nid=2, cache_node=c0000000de01ba00, cache_list=c0000000de01ba00
__slab_alloc_page: nid=2, cache_node=c0000000de01ba00, cache_list=c0000000de01ba00
__slab_alloc_page: nid=2, cache_node=c0000000de01bd00, cache_list=c0000000de01bd00
__slab_alloc_page: nid=2, cache_node=c0000000de01ba00, cache_list=c0000000de01ba00
__slab_alloc_page: nid=2, cache_node=c0000000de01bd00, cache_list=c0000000de01bd00
__slab_alloc_page: nid=2, cache_node=c0000000de01ba00, cache_list=c0000000de01ba00
__slab_alloc_page: nid=2, cache_node=c0000000de01bd00, cache_list=c0000000de01bd00
__slab_alloc_page: nid=2, cache_node=c0000000de01ba00, cache_list=c0000000de01ba00
__slab_alloc_page: nid=2, cache_node=c0000000de01bd00, cache_list=c0000000de01bd00
__slab_alloc_page: nid=2, cache_node=c0000000de01ba00, cache_list=c0000000de01ba00
__slab_alloc_page: nid=2, cache_node=c0000000de01ba00, cache_list=c0000000de01ba00
__slab_alloc_page: nid=2, cache_node=c0000000de0__slab_alloc_page: nid=2, cache_node=c0000000de01ba00, cache_list=c0000000de01ba00
__slab_alloc_page: nid=2, cache_node=c0000000de01ba00, cache_list=c0000000de01ba00
__slab_alloc_page: nid=2, cache_node=c0000000de01bd00, cache_list=c0000000de01bd00
__slab_alloc_page: nid=2, cache_node=c0000000de01ba00, cache_list=c0000000de01ba00
__slab_alloc_page: nid=2, cache_node=c0000000de01ba00, cache_list=c0000000de01ba00
__slab_alloc_page: nid=2, cache_node=c0000000de01c300, cache_list=c0000000de01c300
__slab_alloc_page: nid=2, cache_node=c0000000de01ba00, cache_list=c0000000de01ba00
__slab_alloc_page: nid=2, cache_node=c0000000de01c300, cache_list=c0000000de01c300
__slab_alloc_page: nid=2, cache_node=c0000000de01bd00, cache_list=c0000000de01bd00
__slab_alloc_page: nid=2, cache_node=c0000000de01c000, cache_list=c0000000de01c000
__slab_alloc_page: nid=2, cache_node=c0000000de01ba00, cache_list=c0000000de01ba00
__slab_alloc_page: nid=2, cache_node=c0000000de000
00
00
__slab_alloc_page: nid=2, cache_node=c0000000de01c300, cache_list=c0000000de01c300
__slab_alloc_page: nid=2, cache_node=c0000000de01bd00, cache_list=c0000000de01bd00
__slab_alloc_page: nid=2, cache_node=c0000000de01ba00, cache_list=c0000000de01ba00
__slab_alloc_page: nid=2, cache_node=c0000000de01bd00, cache_list=c0000000de01bd00
__slab_alloc_page: nid=2, cache_node=c0000000de01ba00, cache_list=c0000000de01ba00
__slab_alloc_page: nid=2, cache_node=c0000000de01c300, cache_list=c0000000de01c300
__slab_alloc_page: nid=2, cache_node=c0000000de01bd00, cache_list=c0000000de01bd00
__slab_alloc_page: nid=2, cache_node=c0000000de01ba00, cache_list=c0000000de01ba00
__slab_alloc_page: nid=2, cache_node=c0000000de01bd00, cache_list=c0000000de01bd00
__slab_alloc_page: nid=2, cache_node=c0000000de01ba00, cache_list=c0000000de01ba00
__slab_alloc_page: nid=2, cache_node=c0000000de01c300, cache_list=c0000000de01c300
__slab_alloc_page: nid=2, cache_node=c0000000de01bd00, cache_lis__slab_alloc_page: nid=2, cache_node=c0000000de01ba00, cache_list=c0000000de01ba00
__slab_alloc_page: nid=2, cache_node=c0000000de01c300, cache_list=c0000000de01c300
__slab_alloc_page: nid=2, cache_node=c0000000de01bd00, cache_list=c0000000de01bd00
__slab_alloc_page: nid=2, cache_node=c0000000de01b100, cache_list=c0000000de01b100
__slab_alloc_page: nid=2, cache_node=c0000000de01b100, cache_list=c0000000de01b100
__slab_alloc_page: nid=2, cache_node=c0000000de019600, cache_list=c0000000de019600
__slab_alloc_page: nid=2, cache_node=c0000000de01ba00, cache_list=c0000000de01ba00
__slab_alloc_page: nid=2, cache_node=c0000000de01c300, cache_list=c0000000de01c300
__slab_alloc_page: nid=2, cache_node=c0000000de01bd00, cache_list=c0000000de01bd00
__slab_alloc_page: nid=2, cache_node=c0000000de01ba00, cache_list=c0000000de01ba00
__slab_alloc_page: nid=2, cache_node=c0000000de01bd00, cache_list=c0000000de01bd00
__slab_alloc_page: nid=2, cache_node=c0000000de000
00
00
__slab_alloc_page: nid=2, cache_node=c0000000de01ba00, cache_list=c0000000de01ba00
__slab_alloc_page: nid=2, cache_node=c0000000de01c300, cache_list=c0000000de01c300
__slab_alloc_page: nid=2, cache_node=c0000000de01b100, cache_list=c0000000de01b100
__slab_alloc_page: nid=2, cache_node=c0000000de01b100, cache_list=c0000000de01b100
__slab_alloc_page: nid=2, cache_node=c0000000de01b100, cache_list=c0000000de01b100
__slab_alloc_page: nid=2, cache_node=c0000000de019600, cache_list=c0000000de019600
__slab_alloc_page: nid=2, cache_node=c0000000de01ba00, cache_list=c0000000de01ba00
__slab_alloc_page: nid=2, cache_node=c0000000de01c300, cache_list=c0000000de01c300
__slab_alloc_page: nid=2, cache_node=c0000000de01b100, cache_list=c0000000de01b100
__slab_alloc_page: nid=2, cache_node=c0000000de01b100, cache_list=c0000000de01b100
__slab_alloc_page: nid=2, cache_node=c0000000de019600, cache_list=c0000000de019600
__slab_alloc_page: nid=2, cache_node=c0000000de01ba00, cache_lis__slab_alloc_page: nid=2, cache_node=c0000000de01ba00, cache_list=c0000000de01ba00
__slab_alloc_page: nid=2, cache_node=c0000000de01c300, cache_list=c0000000de01c300
__slab_alloc_page: nid=2, cache_node=c0000000de01bd00, cache_list=c0000000de01bd00
__slab_alloc_page: nid=2, cache_node=c0000000de01ba00, cache_list=c0000000de01ba00
__slab_alloc_page: nid=2, cache_node=c0000000de01bd00, cache_list=c0000000de01bd00
__slab_alloc_page: nid=2, cache_node=c0000000de01ba00, cache_list=c0000000de01ba00
__slab_alloc_page: nid=2, cache_node=c0000000de01c300, cache_list=c0000000de01c300
__slab_alloc_page: nid=2, cache_node=c0000000de01bd00, cache_list=c0000000de01bd00
__slab_alloc_page: nid=2, cache_node=c0000000de01ba00, cache_list=c0000000de01ba00
__slab_alloc_page: nid=2, cache_node=c0000000de01bd00, cache_list=c0000000de01bd00
__slab_alloc_page: nid=2, cache_node=c0000000de01ba00, cache_list=c0000000de01ba00
__slab_alloc_page: nid=2, cache_node=c0000000de000
00
00
__slab_alloc_page: nid=2, cache_node=c0000000de01bd00, cache_list=c0000000de01bd00
__slab_alloc_page: nid=2, cache_node=c0000000de01ba00, cache_list=c0000000de01ba00
__slab_alloc_page: nid=2, cache_node=c0000000de01c300, cache_list=c0000000de01c300
__slab_alloc_page: nid=2, cache_node=c0000000de01bd00, cache_list=c0000000de01bd00
__slab_alloc_page: nid=2, cache_node=c0000000de01ba00, cache_list=c0000000de01ba00
__slab_alloc_page: nid=2, cache_node=c0000000de01bd00, cache_list=c0000000de01bd00
__slab_alloc_page: nid=2, cache_node=c0000000de01ba00, cache_list=c0000000de01ba00
__slab_alloc_page: nid=2, cache_node=c0000000de01c300, cache_list=c0000000de01c300
__slab_alloc_page: nid=2, cache_node=c0000000de01bd00, cache_list=c0000000de01bd00
__slab_alloc_page: nid=2, cache_node=c0000000de01ba00, cache_list=c0000000de01ba00
__slab_alloc_page: nid=2, cache_node=c0000000de01bd00, cache_list=c0000000de01bd00
__slab_alloc_page: nid=2, cache_node=c0000000de01ba00, cache_lisBUG: spinlock bad magic on CPU#1, modprobe/62
 lock: c0000000008c4280, .magic: 7dcc61f0, .owner:  || status == __GCONV_INCOMPLETE_INPUT || status == __GCONV_FULL_OUTPUT/724596736, .owner_cpu: 4095
Call Trace:
[c0000000c7da36d0] [c0000000000116e0] .show_stack+0x6c/0x16c (unreliable)
[c0000000c7da3780] [c000000000365bcc] .spin_bug+0xb0/0xd4
[c0000000c7da3810] [c000000000365e94] ._raw_spin_lock+0x48/0x184
[c0000000c7da38b0] [c0000000005de4f8] ._spin_lock+0x10/0x24
[c0000000c7da3920] [c000000000141240] .__slab_alloc_page+0x410/0x4b4
[c0000000c7da39e0] [c000000000142804] .kmem_cache_alloc+0x13c/0x21c
[c0000000c7da3aa0] [c0000000001431dc] .kmem_cache_create+0x294/0x2a8
[c0000000c7da3b90] [d000000000ea1438] .scsi_init_queue+0x38/0x170 [scsi_mod]
[c0000000c7da3c20] [d000000000ea1334] .init_scsi+0x1c/0xe8 [scsi_mod]
[c0000000c7da3ca0] [c0000000000092c0] .do_one_initcall+0x80/0x19c
[c0000000c7da3d90] [c0000000000c09c8] .SyS_init_module+0xe0/0x244
[c0000000c7da3e30] [c000000000008534] syscall_exit+0x0/0x40
BUG: spinlock lockup on CPU#1, modprobe/62, c0000000008c4280
Call Trace:
[c0000000c7da3760] [c0000000000116e0] .show_stack+0x6c/0x16c (unreliable)
[c0000000c7da3810] [c000000000365f88] ._raw_spin_lock+0x13c/0x184
[c0000000c7da38b0] [c0000000005de4f8] ._spin_lock+0x10/0x24
[c0000000c7da3920] [c000000000141240] .__slab_alloc_page+0x410/0x4b4
[c0000000c7da39e0] [c000000000142804] .kmem_cache_alloc+0x13c/0x21c
[c0000000c7da3aa0] [c0000000001431dc] .kmem_cache_create+0x294/0x2a8
[c0000000c7da3b90] [d000000000ea1438] .scsi_init_queue+0x38/0x170 [scsi_mod]
[c0000000c7da3c20] [d000000000ea1334] .init_scsi+0x1c/0xe8 [scsi_mod]
[c0000000c7da3ca0] [c0000000000092c0] .do_one_initcall+0x80/0x19c
[c0000000c7da3d90] [c0000000000c09c8] .SyS_init_module+0xe0/0x244
[c0000000c7da3e30] [c000000000008534] syscall_exit+0x0/0x40




--------------090001070505070502010009--
