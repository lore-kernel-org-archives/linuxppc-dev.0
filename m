Return-Path: <smaclennan@pikatech.com>
Received: from yow.seanm.ca (toronto-hs-216-138-233-67.s-ip.magma.ca
	[216.138.233.67]) by ozlabs.org (Postfix) with SMTP id 4CE46B7BBE
	for <linuxppc-dev@ozlabs.org>; Fri,  4 Dec 2009 06:25:35 +1100 (EST)
Date: Thu, 3 Dec 2009 14:18:53 -0500
From: Sean MacLennan <smaclennan@pikatech.com>
To: linuxppc-dev <linuxppc-dev@ozlabs.org>
Subject: BUG: Bad page map in process
Message-ID: <20091203141853.3eafba47@lappy.seanm.ca>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

With 2.6.32 I sometimes get lots and lots of "Bad page map" errors as
shown below. I believe these started in 2.6.32-rc8 or possibly
2.6.32-rc7. Pika just switched to 2.6.31 so I have been concentrating
on that release, and not really testing the 2.6.32 stream.

I wish I could give more info, but I don't really even have the time to
write this email :( I am hoping somebody will have a eureka moment.

Cheers,
   Sean


[  147.410448] BUG: Bad page map in process udevd  pte:ffffffffffffffff pmd:cd883000
[  147.417989] addr:48003000 vm_flags:08000875 anon_vma:(null) mapping:cf4150ac index:3
[  147.425837] vma->vm_ops->fault: filemap_fault+0x0/0x410
[  147.431101] vma->vm_file->f_op->mmap: nfs_file_mmap+0x0/0x94
[  147.436795] Call Trace:
[  147.439268] [cf2dbd80] [c00065a4] show_stack+0x48/0x168 (unreliable)
[  147.445708] [cf2dbdb0] [c0064ac8] print_bad_pte+0x14c/0x204
[  147.451337] [cf2dbde0] [c0064cd4] vm_normal_page+0x90/0x98
[  147.456875] [cf2dbdf0] [c0064ee8] unmap_vmas+0x20c/0x638
[  147.462239] [cf2dbe80] [c0069194] exit_mmap+0xc8/0x170
[  147.467441] [cf2dbea0] [c001caa4] mmput+0x50/0xf4
[  147.472195] [cf2dbeb0] [c0020808] exit_mm+0x100/0x138
[  147.477299] [cf2dbee0] [c00211b0] do_exit+0xb0/0x580
[  147.482315] [cf2dbf20] [c00216c4] do_group_exit+0x44/0x9c
[  147.487766] [cf2dbf30] [c0021730] sys_exit_group+0x14/0x28
[  147.493308] [cf2dbf40] [c000dde4] ret_from_syscall+0x0/0x3c
