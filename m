Return-Path: <prashantsmailcenter@gmail.com>
Received: from mail-ey0-f179.google.com (mail-ey0-f179.google.com
 [209.85.215.179]) (using TLSv1 with cipher RC4-SHA (128/128 bits))
 (Client CN "smtp.gmail.com", Issuer "Google Internet Authority" (verified OK))
 by ozlabs.org (Postfix) with ESMTPS id 9B911B6F7D
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 30 Nov 2011 00:21:13 +1100 (EST)
Received: by eaai13 with SMTP id i13so3053377eaa.38
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 29 Nov 2011 05:21:07 -0800 (PST)
MIME-Version: 1.0
Date: Tue, 29 Nov 2011 18:51:07 +0530
Message-ID: <CAD6p20evHeESH1UwpB4rg8NTxndAtQW9C1S1bpJWFLmS-rOu5w@mail.gmail.com>
Subject: lmb_alloc() and page memory overlap
From: Prashant Bhole <prashantsmailcenter@gmail.com>
To: linuxppc-dev <linuxppc-dev@lists.ozlabs.org>
Content-Type: text/plain; charset=ISO-8859-1
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Hi,
I am using custom 460ex board with kernel version 2.6.30.
I noticed that page_alloc() is returning a page whose memory
is already allocated by lmb_alloc() while unflattening the device
tree. As per my knowledge the memory allocated by lmb_alloc()
should be reserved till the end, right?

Some more explanation of what I observed:

unflatten_device_tree() allocates memory, which will be used
for "struct node" objects in the device tree. I obtained base
address of allocated memory in "unsigned long base_mem"

Now I executed the following code after the kernel booted properly.

---------------------------------------------------------------
extern unsigned long mem; // lmb_alloc() memory
struct page *test_page = virt_to_page(mem);
struct page *new_page = NULL;

while(1)
{
    new_page = NULL;
    new_page = alloc_page(GFP_KERNEL);
    if(!new_page)
    {
        printk("Allocation failed\n");
        while(1);
    }
    if(test_page == new_page)
    {
         printk("Memory already allocated by lmb_alloc\n");
         while(1);
    }
}
---------------------------------------------------------------

After many page allocations, I always hit the condition (test_page == new_page).
Am I doing anything wrong here?
Has anybody faced this kind of problem before?


I also noticed that lmb_dump_all() shows 2 regions overlapping (last two):

LMB configuration:
 rmo_size    = 0x30000000
 memory.size = 0x30000000
 memory.cnt  = 0x1
 memory[0x0]    0x0000000000000000 - 0x000000002fffffff, 0x30000000 bytes
 reserved.cnt  = 0x6
 reserved[0x0]  0x0000000000000000 - 0x00000000006bffff, 0x6c0000 bytes
 reserved[0x1]  0x0000000000ffa000 - 0x0000000000ffcfff, 0x3000 bytes
 reserved[0x2]  0x000000002fdd0000 - 0x000000002fddffff, 0x10000 bytes
 reserved[0x3]  0x000000002fde4000 - 0x000000002fde9fff, 0x6000 bytes
 reserved[0x4]  0x000000002fdeb060 - 0x000000002ffff768, 0x214709 bytes
 reserved[0x5]  0x000000002fdee000 - 0x000000002ffff769, 0x21176a bytes


Thanks,
Prashant
