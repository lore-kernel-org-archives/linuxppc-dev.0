Return-Path: <kniht@linux.vnet.ibm.com>
Received: from e32.co.us.ibm.com (e32.co.us.ibm.com [32.97.110.150])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e32.co.us.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id D318DDDE02
	for <linuxppc-dev@ozlabs.org>; Wed,  3 Sep 2008 08:16:03 +1000 (EST)
Received: from d03relay02.boulder.ibm.com (d03relay02.boulder.ibm.com
	[9.17.195.227])
	by e32.co.us.ibm.com (8.13.8/8.13.8) with ESMTP id m82M8jDF017793
	for <linuxppc-dev@ozlabs.org>; Tue, 2 Sep 2008 18:08:45 -0400
Received: from d03av01.boulder.ibm.com (d03av01.boulder.ibm.com [9.17.195.167])
	by d03relay02.boulder.ibm.com (8.13.8/8.13.8/NCO v9.0) with ESMTP id
	m82MG0tI223108
	for <linuxppc-dev@ozlabs.org>; Tue, 2 Sep 2008 16:16:00 -0600
Received: from d03av01.boulder.ibm.com (loopback [127.0.0.1])
	by d03av01.boulder.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id
	m82MFxwr003649
	for <linuxppc-dev@ozlabs.org>; Tue, 2 Sep 2008 16:16:00 -0600
Message-ID: <48BDBB2D.3050401@linux.vnet.ibm.com>
Date: Tue, 02 Sep 2008 17:16:13 -0500
From: Jon Tollefson <kniht@linux.vnet.ibm.com>
MIME-Version: 1.0
To: benh@kernel.crashing.org
Subject: Re: [Libhugetlbfs-devel] Buglet in 16G page handling
References: <20080902050510.GB12965@yookeroo.seuss>
	<20080902124442.GD29766@csn.ul.ie>
	<1220389507.13010.147.camel@pasglop>
In-Reply-To: <1220389507.13010.147.camel@pasglop>
Content-Type: text/plain; charset=ISO-8859-1
Cc: Mel Gorman <mel@csn.ul.ie>, linuxppc-dev@ozlabs.org,
	libhugetlbfs-devel@lists.sourceforge.net
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Benjamin Herrenschmidt wrote:
>> Actually, Jon has been hitting an occasional pagetable lock related
>> problem. The last theory was that it might be some sort of race but it's
>> vaguely possible that this is the issue. Jon?
>>     
>
> All hugetlbfs ops should be covered by the big PTL except walking... Can
> we have more info about the problem ?
>
> Cheers,
> Ben.
>   

I hit this when running the complete libhugetlbfs test suite (make
check) with base page at 4K and default huge page size at 16G.  It is on
the last test (shm-getraw) when it hits it.  Just running that test
alone has not caused it for me - only when I have run all the tests and
it gets to this one.  Also it doesn't happen every time.  I have tried
to reproduce as well with a 64K base page but haven't seen it happen there.

BUG: spinlock bad magic on CPU#2, shm-getraw/10359
 lock: f00000000de6e158, .magic: 00000000, .owner: <none>/-1, .owner_cpu: 0
Call Trace:
[c000000285d9b420] [c0000000000110b0] .show_stack+0x78/0x190 (unreliable)
[c000000285d9b4d0] [c0000000000111e8] .dump_stack+0x20/0x34
[c000000285d9b550] [c000000000295d94] .spin_bug+0xb8/0xe0
[c000000285d9b5f0] [c0000000002962d8] ._raw_spin_lock+0x4c/0x1a0
[c000000285d9b690] [c000000000510c60] ._spin_lock+0x5c/0x7c
[c000000285d9b720] [c0000000000d809c] .handle_mm_fault+0x2f0/0x9ac
[c000000285d9b810] [c000000000513688] .do_page_fault+0x444/0x62c
[c000000285d9b950] [c000000000005230] handle_page_fault+0x20/0x5c
--- Exception: 301 at .__clear_user+0x38/0x7c
    LR = .read_zero+0xb0/0x1a8
[c000000285d9bc40] [c0000000002e19e0] .read_zero+0x80/0x1a8 (unreliable)
[c000000285d9bcf0] [c000000000102c00] .vfs_read+0xe0/0x1c8
[c000000285d9bd90] [c00000000010332c] .sys_read+0x54/0x98
[c000000285d9be30] [c0000000000086d4] syscall_exit+0x0/0x40
BUG: spinlock lockup on CPU#2, shm-getraw/10359, f00000000de6e158
Call Trace:
[c000000285d9b4c0] [c0000000000110b0] .show_stack+0x78/0x190 (unreliable)
[c000000285d9b570] [c0000000000111e8] .dump_stack+0x20/0x34
[c000000285d9b5f0] [c0000000002963ec] ._raw_spin_lock+0x160/0x1a0
[c000000285d9b690] [c000000000510c60] ._spin_lock+0x5c/0x7c
[c000000285d9b720] [c0000000000d809c] .handle_mm_fault+0x2f0/0x9ac
[c000000285d9b810] [c000000000513688] .do_page_fault+0x444/0x62c
[c000000285d9b950] [c000000000005230] handle_page_fault+0x20/0x5c
--- Exception: 301 at .__clear_user+0x38/0x7c
    LR = .read_zero+0xb0/0x1a8
[c000000285d9bc40] [c0000000002e19e0] .read_zero+0x80/0x1a8 (unreliable)
[c000000285d9bcf0] [c000000000102c00] .vfs_read+0xe0/0x1c8
[c000000285d9bd90] [c00000000010332c] .sys_read+0x54/0x98
[c000000285d9be30] [c0000000000086d4] syscall_exit+0x0/0x40
BUG: soft lockup - CPU#2 stuck for 61s! [shm-getraw:10359]
Modules linked in: autofs4 binfmt_misc dm_mirror dm_log dm_multipath parport ibmvscsic uhci_hcd ohci_hcd ehci_hcd
irq event stamp: 1423661
hardirqs last  enabled at (1423661): [<c00000000008d954>] .trace_hardirqs_on+0x1c/0x30
hardirqs last disabled at (1423660): [<c00000000008af60>] .trace_hardirqs_off+0x1c/0x30
softirqs last  enabled at (1422710): [<c000000000064f6c>] .__do_softirq+0x19c/0x1c4
softirqs last disabled at (1422705): [<c00000000002943c>] .call_do_softirq+0x14/0x24
NIP: c00000000002569c LR: c0000000002963ac CTR: 8000000000f7cdec
REGS: c000000285d9b330 TRAP: 0901   Not tainted  (2.6.27-rc4-pseries)
MSR: 8000000000009032 <EE,ME,IR,DR>  CR: 88000284  XER: 00000002
TASK = c000000285f18000[10359] 'shm-getraw' THREAD: c000000285d98000 CPU: 2
GPR00: 0000000080000002 c000000285d9b5b0 c0000000008924e0 0000000000000001 
GPR04: c000000285f18000 0000000000000070 0000000000000000 0000000000000002 
GPR08: 0000000000000000 0003c3c66e8adf66 0000000000000002 0000000000000010 
GPR12: 00000000000b4cbd c0000000008d4700 
NIP [c00000000002569c] .__delay+0x10/0x38
LR [c0000000002963ac] ._raw_spin_lock+0x120/0x1a0
Call Trace:
[c000000285d9b5b0] [c000000285d9b690] 0xc000000285d9b690 (unreliable)
[c000000285d9b5f0] [c000000000296378] ._raw_spin_lock+0xec/0x1a0
[c000000285d9b690] [c000000000510c60] ._spin_lock+0x5c/0x7c
[c000000285d9b720] [c0000000000d809c] .handle_mm_fault+0x2f0/0x9ac
[c000000285d9b810] [c000000000513688] .do_page_fault+0x444/0x62c
[c000000285d9b950] [c000000000005230] handle_page_fault+0x20/0x5c
--- Exception: 301 at .__clear_user+0x38/0x7c
    LR = .read_zero+0xb0/0x1a8
[c000000285d9bc40] [c0000000002e19e0] .read_zero+0x80/0x1a8 (unreliable)
[c000000285d9bcf0] [c000000000102c00] .vfs_read+0xe0/0x1c8
[c000000285d9bd90] [c00000000010332c] .sys_read+0x54/0x98
[c000000285d9be30] [c0000000000086d4] syscall_exit+0x0/0x40
Instruction dump:
eb41ffd0 eb61ffd8 eb81ffe0 7c0803a6 eba1ffe8 ebc1fff0 ebe1fff8 4e800020 
fbe1fff8 f821ffc1 7c3f0b78 7d2c42e6 <48000008> 7c210b78 7c0c42e6 7c090050 


[root]# addr2line c0000000000d809c -e /boot/vmlinux.rc4-pseries 
/root/src/linux-2.6-rc4/mm/memory.c:2381
[root]# addr2line c000000000513688 -e /boot/vmlinux.rc4-pseries 
/root/src/linux-2.6-rc4/arch/powerpc/mm/fault.c:313
[root]# addr2line c00000000010332c -e /boot/vmlinux.rc4-pseries 
/root/src/linux-2.6-rc4/fs/read_write.c:334
[root]# addr2line c000000000102c00 -e /boot/vmlinux.rc4-pseries 
/root/src/linux-2.6-rc4/fs/read_write.c:257


I have sometimes inserted an strace64 at the point where the test cases are started and then will see
output like the following when it hits the above point.

...
open("/dev/full", O_RDONLY)             = 3
shmget(0x2, 34359738368, IPC_CREAT|SHM_HUGETLB|0600) = 294912
shmat(294912, 0, SHM_RND)               = 0x3f800000000
read(3, "\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0"..., 17179869184) = 2147479552

---
