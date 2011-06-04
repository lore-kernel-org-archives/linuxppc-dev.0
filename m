Return-Path: <bounces@nabble.com>
Received: from sam.nabble.com (sam.nabble.com [216.139.236.26])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 15C3AB6FCA
	for <linuxppc-dev@ozlabs.org>; Sat,  4 Jun 2011 21:13:57 +1000 (EST)
Received: from isper.nabble.com ([192.168.236.156])
	by sam.nabble.com with esmtp (Exim 4.72)
	(envelope-from <bounces@nabble.com>) id 1QSong-0003ZF-Ng
	for linuxppc-dev@ozlabs.org; Sat, 04 Jun 2011 04:13:52 -0700
Message-ID: <31771757.post@talk.nabble.com>
Date: Sat, 4 Jun 2011 04:13:52 -0700 (PDT)
From: ps2k <ps2kumar@yahoo.com>
To: linuxppc-dev@ozlabs.org
Subject: debugging kernel oops
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


Hi All,
I'm new to linux development. We are often seeing kernel oops and failure to
handle paging requests. Any idea how to debug these issues. We have a NAND
flash. I don't know how paging works on an embedded device with flash
memories and not sure why is it needed.

Any help would be greatly appreciated.

Thanks
psk


Jun  1 23:30:01 sbc kernel: [53181.318784] Call Trace:
Jun  1 23:30:01 sbc kernel: [53181.318793] [caab5c50] [c0008114]
show_stack+0x4c/0x1ac (unreliable)
Jun  1 23:30:01 sbc kernel: [53181.318828] [caab5c90] [c0045b4c]
__schedule_bug+0x64/0x78
Jun  1 23:30:01 sbc kernel: [53181.318852] [caab5ca0] [c027d774]
schedule+0x320/0x340
Jun  1 23:30:01 sbc kernel: [53181.318870] [caab5ce0] [c0045d94]
__cond_resched+0x24/0x50
Jun  1 23:30:01 sbc kernel: [53181.318888] [caab5cf0] [c027dd90]
cond_resched+0x50/0x58
Jun  1 23:30:01 sbc kernel: [53181.318906] [caab5d00] [c007bb50]
generic_file_buffered_write+0x1ac/0x67c
Jun  1 23:30:01 sbc kernel: [53181.318934] [caab5d90] [c007c2a8]
__generic_file_aio_write_nolock+0x288/0x50c
Jun  1 23:30:01 sbc kernel: [53181.318954] [caab5e00] [c007c594]
generic_file_aio_write+0x68/0xf8
Jun  1 23:30:01 sbc kernel: [53181.318974] [caab5e30] [c00a0c14]
do_sync_write+0xc4/0x138
Jun  1 23:30:01 sbc kernel: [53181.319000] [caab5ef0] [c00a15bc]
vfs_write+0xb4/0x108
Jun  1 23:30:01 sbc kernel: [53181.319018] [caab5f10] [c00a1ba8]
sys_write+0x4c/0x90
Jun  1 23:30:01 sbc kernel: [53181.319036] [caab5f40] [c00101b8]
ret_from_syscall+0x0/0x38
Jun  1 23:30:01 sbc kernel: [53181.319062] --- Exception: c01 at 0xfe506c4
Jun  1 23:30:01 sbc kernel: [53181.319076]     LR = 0x10072040
Jun  1 23:30:01 sbc kernel: [53181.375060] Page fault in user mode
within_atomic() = 1 mm = d4cee5a0
Jun  1 23:30:01 sbc kernel: [53181.375091] NIP = fe51434  MSR = 2000f932
Jun  1 23:30:01 sbc kernel: [53181.375105] Oops: Weird page fault, sig: 11
[#1]
Jun  1 23:30:01 sbc kernel: [53181.375113] PREEMPT MPC836x RDK
Jun  1 23:30:01 sbc kernel: [53181.375123] Modules linked in:
Jun  1 23:30:01 sbc kernel: [53181.375134] NIP: 0fe51434 LR: 1006ce70 CTR:
0fe51434
Jun  1 23:30:01 sbc kernel: [53181.375148] REGS: caab5f50 TRAP: 0401   Not
tainted  (2.6.24-sbc-2.0.2.7131)
Jun  1 23:30:01 sbc kernel: [53181.375159] MSR: 2000f932 <EE,PR,FP,ME,IR,DR> 
CR: 48000442  XER: 00000000
Jun  1 23:30:01 sbc kernel: [53181.375188] TASK = d4cf0430[8646] 'cp'
THREAD: caab4000
Jun  1 23:30:01 sbc kernel: [53181.375246] NIP [0fe51434] 0xfe51434
Jun  1 23:30:01 sbc kernel: [53181.375260] LR [1006ce70] 0x1006ce70
Jun  1 23:30:01 sbc kernel: [53181.375271] Call Trace:
Jun  1 23:30:01 sbc kernel: [53181.375354] Call Trace:
Jun  1 23:30:01 sbc kernel: [53181.375362] [caab5c10] [c0008114]
show_stack+0x4c/0x1ac (unreliable)
Jun  1 23:30:01 sbc kernel: [53181.375394] [caab5c50] [c0045b4c]
__schedule_bug+0x64/0x78
Jun  1 23:30:01 sbc kernel: [53181.375417] [caab5c60] [c027d774]
schedule+0x320/0x340
Jun  1 23:30:01 sbc kernel: [53181.375435] [caab5ca0] [c0045d94]
__cond_resched+0x24/0x50
Jun  1 23:30:01 sbc kernel: [53181.375453] [caab5cb0] [c027dd90]
cond_resched+0x50/0x58
Jun  1 23:30:01 sbc kernel: [53181.375471] [caab5cc0] [c008a7d8]
unmap_vmas+0x5c4/0x5f4
Jun  1 23:30:01 sbc kernel: [53181.375493] [caab5d40] [c008e574]
exit_mmap+0x74/0x11c
Jun  1 23:30:01 sbc kernel: [53181.375513] [caab5d70] [c0048914]
mmput+0x50/0x108
Jun  1 23:30:01 sbc kernel: [53181.375532] [caab5d80] [c004d034]
exit_mm+0xa8/0x110
Jun  1 23:30:01 sbc kernel: [53181.375553] [caab5da0] [c004ecb8]
do_exit+0x13c/0x7bc
Jun  1 23:30:01 sbc kernel: [53181.375571] [caab5de0] [c000e160]
kernel_bad_stack+0x0/0x4c
Jun  1 23:30:01 sbc kernel: [53181.375593] [caab5e10] [c0013120]
do_page_fault+0xb8/0x4e4
Jun  1 23:30:01 sbc kernel: [53181.375611] [caab5f40] [c00105e8]
handle_page_fault+0xc/0x80
Jun  1 23:30:01 sbc kernel: [53181.375632] --- Exception: 401 at 0xfe51434
Jun  1 23:30:01 sbc kernel: [53181.375645]     LR = 0x1006ce70
Jun  2 01:30:01 sbc kernel: [ 6381.530572] Unable to handle kernel paging
request for data at address 0xe1054000
Jun  2 01:30:01 sbc kernel: [ 6381.531024] Faulting instruction address:
0xc0149954
Jun  2 01:30:01 sbc kernel: [ 6381.531303] Oops: Kernel access of bad area,
sig: 11 [#1]
Jun  2 01:30:01 sbc kernel: [ 6381.531320] PREEMPT MPC836x RDK
Jun  2 01:30:01 sbc kernel: [ 6381.531329] Modules linked in:
Jun  2 01:30:01 sbc kernel: [ 6381.531340] NIP: c0149954 LR: c014990c CTR:
00000018
Jun  2 01:30:01 sbc kernel: [ 6381.531354] REGS: d21cdb10 TRAP: 0300   Not
tainted  (2.6.24-sbc-2.0.2.7131)
Jun  2 01:30:01 sbc kernel: [ 6381.531365] MSR: 00009032 <EE,ME,IR,DR>  CR:
48044448  XER: 20000000
Jun  2 01:30:01 sbc kernel: [ 6381.531388] DAR: e1054000, DSISR: 20000000
Jun  2 01:30:01 sbc kernel: [ 6381.531398] TASK = d8610450[1994] 'cp'
THREAD: d21cc000
Jun  2 01:30:01 sbc kernel: [ 6381.531507] NIP [c0149954]
deflate_fast+0x144/0x34c
Jun  2 01:30:01 sbc kernel: [ 6381.531534] LR [c014990c]
deflate_fast+0xfc/0x34c
Jun  2 01:30:01 sbc kernel: [ 6381.531548] Call Trace:
Jun  2 01:30:01 sbc kernel: [ 6381.531556] [d21cdbc0] [c0149ab8]
deflate_fast+0x2a8/0x34c (unreliable)
Jun  2 01:30:01 sbc kernel: [ 6381.531576] [d21cdbe0] [c0149e38]
zlib_deflate+0x110/0x334
Jun  2 01:30:01 sbc kernel: [ 6381.531593] [d21cdc00] [c012567c]
jffs2_zlib_compress+0xf8/0x1c4
Jun  2 01:30:01 sbc kernel: [ 6381.531620] [d21cdc30] [c0114ba4]
jffs2_compress+0xdc/0x1f0
Jun  2 01:30:01 sbc kernel: [ 6381.531637] [d21cdc60] [c011bfd0]
jffs2_write_inode_range+0xb0/0x34c
Jun  2 01:30:01 sbc kernel: [ 6381.531655] [d21cdcc0] [c0116580]
jffs2_write_end+0xd8/0x23c
Jun  2 01:30:01 sbc kernel: [ 6381.531672] [d21cdd00] [c007bb40]
generic_file_buffered_write+0x19c/0x67c
Jun  2 01:30:01 sbc kernel: [ 6381.531699] [d21cdd90] [c007c2a8]
__generic_file_aio_write_nolock+0x288/0x50c
Jun  2 01:30:01 sbc kernel: [ 6381.531719] [d21cde00] [c007c594]
generic_file_aio_write+0x68/0xf8
Jun  2 01:30:01 sbc kernel: [ 6381.531738] [d21cde30] [c00a0c14]
do_sync_write+0xc4/0x138
Jun  2 01:30:01 sbc kernel: [ 6381.531762] [d21cdef0] [c00a15bc]
vfs_write+0xb4/0x108
Jun  2 01:30:01 sbc kernel: [ 6381.531779] [d21cdf10] [c00a1ba8]
sys_write+0x4c/0x90
Jun  2 01:30:01 sbc kernel: [ 6381.531795] [d21cdf40] [c00101b8]
ret_from_syscall+0x0/0x38
Jun  2 01:30:01 sbc kernel: [ 6381.531820] --- Exception: c01 at 0xfe506c4
Jun  2 01:30:01 sbc kernel: [ 6381.531833]     LR = 0x10072040
Jun  2 01:30:01 sbc kernel: [ 6381.531841] Instruction dump:
Jun  2 01:30:01 sbc kernel: [ 6381.531850] 419d0148 2b890002 409d0140
380bffff 901f0058 813f0064 817f0030 39090001
Jun  2 01:30:01 sbc kernel: [ 6381.531874] 815f0050 911f0064 7d685a14
813f0040 <880b0002> 7d295030 817f004c 7c004a78



-- 
View this message in context: http://old.nabble.com/debugging-kernel-oops-tp31771757p31771757.html
Sent from the linuxppc-dev mailing list archive at Nabble.com.
