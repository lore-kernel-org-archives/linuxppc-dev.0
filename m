Return-Path: <zhong@linux.vnet.ibm.com>
Received: from e28smtp05.in.ibm.com (e28smtp05.in.ibm.com [122.248.162.5])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id 527C914008D
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 10 Apr 2014 18:25:40 +1000 (EST)
Received: from /spool/local
 by e28smtp05.in.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <zhong@linux.vnet.ibm.com>;
 Thu, 10 Apr 2014 13:55:37 +0530
Received: from d28relay01.in.ibm.com (d28relay01.in.ibm.com [9.184.220.58])
 by d28dlp03.in.ibm.com (Postfix) with ESMTP id E1F421258048
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 10 Apr 2014 13:58:09 +0530 (IST)
Received: from d28av02.in.ibm.com (d28av02.in.ibm.com [9.184.220.64])
 by d28relay01.in.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
 s3A8PQHF4325878
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 10 Apr 2014 13:55:27 +0530
Received: from d28av02.in.ibm.com (localhost [127.0.0.1])
 by d28av02.in.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 s3A8PXjm012026
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 10 Apr 2014 13:55:34 +0530
Message-ID: <1397118331.25199.89.camel@ThinkPad-T5421.cn.ibm.com>
Subject: [RFC PATCH v2 powerpc] Protect remove_memory() with device hotplug
 lock
From: Li Zhong <zhong@linux.vnet.ibm.com>
To: Nathan Fontenot <nfont@linux.vnet.ibm.com>
Date: Thu, 10 Apr 2014 16:25:31 +0800
In-Reply-To: <534571D0.2030700@linux.vnet.ibm.com>
References: <1397033686.25199.33.camel@ThinkPad-T5421.cn.ibm.com>
 <534571D0.2030700@linux.vnet.ibm.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Cc: PowerPC email list <linuxppc-dev@lists.ozlabs.org>,
 Paul Mackerras <paulus@samba.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

While testing memory hot-remove, I found following dead lock:

Process #1141 is drmgr, trying to remove some memory, i.e. memory499. 
It holds the memory_hotplug_mutex, and blocks when trying to remove file
"online" under dir memory499, in kernfs_drain(), at 
        wait_event(root->deactivate_waitq,
                   atomic_read(&kn->active) == KN_DEACTIVATED_BIAS);

Process #1120 is trying to online memory499 by 
   echo 1 > memory499/online

In .kernfs_fop_write, it uses kernfs_get_active() to increase
&kn->active, thus blocking process #1141. While itself is blocked later
when trying to acquire memory_hotplug_mutex, which is held by process
#1141. 

The backtrace of both processes are shown below:

# cat /proc/1120/stack 
[<c000000001b18600>] 0xc000000001b18600
[<c000000000015044>] .__switch_to+0x144/0x200
[<c000000000263ca4>] .online_pages+0x74/0x7b0
[<c00000000055b40c>] .memory_subsys_online+0x9c/0x150
[<c00000000053cbe8>] .device_online+0xb8/0x120
[<c00000000053cd04>] .online_store+0xb4/0xc0
[<c000000000538ce4>] .dev_attr_store+0x64/0xa0
[<c00000000030f4ec>] .sysfs_kf_write+0x7c/0xb0
[<c00000000030e574>] .kernfs_fop_write+0x154/0x1e0
[<c000000000268450>] .vfs_write+0xe0/0x260
[<c000000000269144>] .SyS_write+0x64/0x110
[<c000000000009ffc>] syscall_exit+0x0/0x7c


# cat /proc/1141/stack 
[<c000000001b18600>] 0xc000000001b18600
[<c000000000015044>] .__switch_to+0x144/0x200
[<c00000000030be14>] .__kernfs_remove+0x204/0x300
[<c00000000030d428>] .kernfs_remove_by_name_ns+0x68/0xf0
[<c00000000030fb38>] .sysfs_remove_file_ns+0x38/0x60
[<c000000000539354>] .device_remove_attrs+0x54/0xc0
[<c000000000539fd8>] .device_del+0x158/0x250
[<c00000000053a104>] .device_unregister+0x34/0xa0
[<c00000000055bc14>] .unregister_memory_section+0x164/0x170
[<c00000000024ee18>] .__remove_pages+0x108/0x4c0
[<c00000000004b590>] .arch_remove_memory+0x60/0xc0
[<c00000000026446c>] .remove_memory+0x8c/0xe0
[<c00000000007f9f4>] .pseries_remove_memblock+0xd4/0x160
[<c00000000007fcfc>] .pseries_memory_notifier+0x27c/0x290
[<c0000000008ae6cc>] .notifier_call_chain+0x8c/0x100
[<c0000000000d858c>] .__blocking_notifier_call_chain+0x6c/0xe0
[<c00000000071ddec>] .of_property_notify+0x7c/0xc0
[<c00000000071ed3c>] .of_update_property+0x3c/0x1b0
[<c0000000000756cc>] .ofdt_write+0x3dc/0x740
[<c0000000002f60fc>] .proc_reg_write+0xac/0x110
[<c000000000268450>] .vfs_write+0xe0/0x260
[<c000000000269144>] .SyS_write+0x64/0x110
[<c000000000009ffc>] syscall_exit+0x0/0x7c

This patch uses lock_device_hotplug() to protect remove_memory() called
in pseries_remove_memblock(), which is also stated before function
remove_memory():

 * NOTE: The caller must call lock_device_hotplug() to serialize hotplug
 * and online/offline operations before this call, as required by
 * try_offline_node().
 */     
void __ref remove_memory(int nid, u64 start, u64 size)

With this lock held, the other process(#1120 above) trying to online the
memory block will retry the system call when calling
lock_device_hotplug_sysfs(), and finally find No such device error. 

Signed-off-by: Li Zhong <zhong@linux.vnet.ibm.com>
---
 arch/powerpc/platforms/pseries/hotplug-memory.c | 10 ++++++----
 1 file changed, 6 insertions(+), 4 deletions(-)

diff --git a/arch/powerpc/platforms/pseries/hotplug-memory.c b/arch/powerpc/platforms/pseries/hotplug-memory.c
index 573b488..7f75c94 100644
--- a/arch/powerpc/platforms/pseries/hotplug-memory.c
+++ b/arch/powerpc/platforms/pseries/hotplug-memory.c
@@ -100,10 +100,10 @@ static int pseries_remove_memblock(unsigned long base, unsigned int memblock_siz
 
 	start_pfn = base >> PAGE_SHIFT;
 
-	if (!pfn_valid(start_pfn)) {
-		memblock_remove(base, memblock_size);
-		return 0;
-	}
+	lock_device_hotplug();
+
+	if (!pfn_valid(start_pfn))
+		goto out;
 
 	block_sz = memory_block_size_bytes();
 	sections_per_block = block_sz / MIN_MEMORY_BLOCK_SIZE;
@@ -114,8 +114,10 @@ static int pseries_remove_memblock(unsigned long base, unsigned int memblock_siz
 		base += MIN_MEMORY_BLOCK_SIZE;
 	}
 
+out:
 	/* Update memory regions for memory remove */
 	memblock_remove(base, memblock_size);
+	unlock_device_hotplug();
 	return 0;
 }
 
