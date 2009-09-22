Return-Path: <Bernhard.Weirich@riedel.net>
Received: from dfallbackip1.mail.eu.uu.net (dhuumrelay1.dtm.ops.eu.uu.net
	[194.139.33.71])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 3E4D9B7B7C
	for <linuxppc-dev@lists.ozlabs.org>;
	Tue, 22 Sep 2009 19:40:03 +1000 (EST)
Received: from dhuumrelay1.dtm.ops.eu.uu.net (dfallbackip1.mail.eu.uu.net
	[195.129.12.192])
	by dfallbackip1.mail.eu.uu.net (8.14.1/8.14.1) with ESMTP id
	n8M864XN018530
	for <linuxppc-dev@lists.ozlabs.org>; Tue, 22 Sep 2009 08:06:04 GMT
Received: from mail.riedel.net (mail.riedel.net [213.70.193.150])
	by dhuumrelay1.dtm.ops.eu.uu.net (8.14.1/8.14.1) with ESMTP id
	n8M85wxO018473
	for <linuxppc-dev@lists.ozlabs.org>; Tue, 22 Sep 2009 08:05:58 GMT
From: "Weirich, Bernhard" <Bernhard.Weirich@riedel.net>
To: "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>
Date: Tue, 22 Sep 2009 10:05:55 +0200
Subject: [405EX] Bad page map in process ...
Message-ID: <CE92B8B581B4584FB8CA86B51EDE8AC5243C568B03@wupexchange.riedel.net>
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Hello,

I use mmap to map an IO address space to user space on a PPC405EX processor=
.

till kernel 2.6.29 this worked without problems, since 2.6.30. I get intimi=
dating error messages when I do the unmap, mmap works fine, though.

BUG: Bad page map in process deviceDaemon  pte:ffe3b45e pmd:0f11a400
addr:48271000 vm_flags:400844ff anon_vma:(null) mapping:cede3a18 index:ffff=
fe3b
vma->vm_ops->fault: ebm_alloc+0x700/0x708 [fpga_bus_m]
vma->vm_file->f_op->mmap: fpga_regs_ioctl+0x100/0x3e0 [fpga_bus_m]
Call Trace:
[cf1bbda0] [c0006e94] show_stack+0x40/0x15c (unreliable)
[cf1bbdd0] [c00776cc] print_bad_pte+0x12c/0x1e4
[cf1bbe00] [c0077820] vm_normal_page+0x9c/0xb4
[cf1bbe20] [c0078374] unmap_vmas+0x228/0x5f8
[cf1bbeb0] [c007c8b4] unmap_region+0x98/0x138
[cf1bbef0] [c007d9cc] do_munmap+0x280/0x304
[cf1bbf20] [c007da88] sys_munmap+0x38/0x5c
[cf1bbf40] [c000efa4] ret_from_syscall+0x0/0x3c

So far I found out that in mm/memory.c, function vm_normal_page, pfn is gre=
ater than highest_memmap_pfn, thus the error is triggered.
It is correct that pfn is higher than the end of physical ram, but it is in=
 a valid IO mapped region.
I guess the problem is that pte_special(pte) returns 0.
I realized that in the 2.6.29 kernel HAVE_PTE_SPECIAL was 0 and the !HAVE_P=
TE_SPECIAL case silently returned NULL before checking whether pfn < highes=
t_memmap_pfn.

In 2.6.30 HAVE_PTE_SPECIAL is 1 and pte_special(pte) returns 0 so the code =
jumps to the pfn < highest_memmap_pfn check. Thus I believe that the there =
is a problem with the pte_special flag.

I will investigate further but maybe someone with more knowledge about page=
 handling on ppc can help me here.

Bernhard WEIRICH
Software Development
