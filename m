Return-Path: <danny@mailmij.org>
Received: from mail.mailmij.org (a83-68-2-133.adsl.cistron.nl [83.68.2.133])
	by ozlabs.org (Postfix) with ESMTP id A460967A2C
	for <linuxppc-dev@ozlabs.org>; Fri,  4 Feb 2005 10:38:59 +1100 (EST)
Received: from localhost (localhost [127.0.0.1])
	by mail.mailmij.org (Postfix) with ESMTP id 698D155ED
	for <linuxppc-dev@ozlabs.org>; Fri,  4 Feb 2005 00:14:33 +0100 (CET)
Date: Fri, 4 Feb 2005 00:14:33 +0100 (CET)
From: <danny@mailmij.org>
To: <linuxppc-dev@ozlabs.org>
Message-ID: <Pine.LNX.4.33.0502040007230.12107-100000@luna.ellen.dexterslabs.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Subject: sched while atomic
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


Latest 2.6.11rc* give me this interesting message at boot:
Mount-cache hash table entries: 512 (order: 0, 4096 bytes)
scheduling while atomic: swapper/0x00000002/0
Call trace:
 [c01c7580] schedule+0x640/0x6bc
 [c0004698] syscall_exit_work+0x120/0x124
 [c00a5414] proc_device_tree_init+0x7c/0x98
 [c02be9b4] proc_root_init+0x14c/0x158
 [c02a660c] start_kernel+0x178/0x1b0
 [00003a5c] 0x3a5c

Since it doesn't happen on x86, I first thought it was because of the ppc 
specific init of the device_tree, but commenting this out just lets it 
happen somewhere else. It seems schedule is called when it returns from a 
syscall, which seems normal behaviour to me, but the recent 
preempt_disable() in start_kernel makes the scheduler give these warnings.
So what's happening? 

Also, I think this is already know for a while:
/lib/modules/2.6.11-rc3/kernel/drivers/video/vga16fb.ko needs unknown 
symbol vgacon_remap_base

regards,

danny
