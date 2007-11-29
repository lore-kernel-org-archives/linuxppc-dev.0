Return-Path: <kamalesh@linux.vnet.ibm.com>
Received: from e28esmtp05.in.ibm.com (e28smtp05.in.ibm.com [59.145.155.5])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e28smtp05.in.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id 73472DDDEC
	for <linuxppc-dev@ozlabs.org>; Fri, 30 Nov 2007 01:36:42 +1100 (EST)
Received: from d28relay02.in.ibm.com (d28relay02.in.ibm.com [9.184.220.59])
	by e28esmtp05.in.ibm.com (8.13.1/8.13.1) with ESMTP id lATEaSM3023041
	for <linuxppc-dev@ozlabs.org>; Thu, 29 Nov 2007 20:06:28 +0530
Received: from d28av01.in.ibm.com (d28av01.in.ibm.com [9.184.220.63])
	by d28relay02.in.ibm.com (8.13.8/8.13.8/NCO v8.7) with ESMTP id
	lATEaSCa4571270
	for <linuxppc-dev@ozlabs.org>; Thu, 29 Nov 2007 20:06:28 +0530
Received: from d28av01.in.ibm.com (loopback [127.0.0.1])
	by d28av01.in.ibm.com (8.13.1/8.13.3) with ESMTP id lATEaRlC020768
	for <linuxppc-dev@ozlabs.org>; Thu, 29 Nov 2007 14:36:28 GMT
Message-ID: <474ECE6A.3010500@linux.vnet.ibm.com>
Date: Thu, 29 Nov 2007 20:06:26 +0530
From: Kamalesh Babulal <kamalesh@linux.vnet.ibm.com>
MIME-Version: 1.0
To: Jan Kara <jack@suse.cz>
Subject: Re: [BUG] 2.6.24-rc3-mm2 kernel bug on nfs & cifs mounted partitions
References: <20071128034140.648383f0.akpm@linux-foundation.org>
	<474E7F9E.9000601@linux.vnet.ibm.com>
	<20071129010906.772e0c15.akpm@linux-foundation.org>
	<474EA914.1060502@linux.vnet.ibm.com>
	<20071129121001.GD16558@duck.suse.cz>
In-Reply-To: <20071129121001.GD16558@duck.suse.cz>
Content-Type: text/plain; charset=ISO-8859-1
Cc: samba-technical@lists.samba.org, linux-kernel@vger.kernel.org,
	linuxppc-dev@ozlabs.org, nfs@lists.sourceforge.net,
	Andrew Morton <akpm@linux-foundation.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Jan Kara wrote:
> On Thu 29-11-07 17:27:08, Kamalesh Babulal wrote:
>> Andrew Morton wrote:
>>> On Thu, 29 Nov 2007 14:30:14 +0530 Kamalesh Babulal <kamalesh@linux.vnet.ibm.com> wrote:
>>>
>>>> Hi Andrew,
>>>>
>>>> While running file system stress on nfs and cifs mounted partitions, the machine
>>>> drops to xmon
>>>>
>>>> 1:mon> e
>>>> cpu 0x1: Vector: 300 (Data Access) at [c000000080a9f880]
>>>>     pc: c0000000001392c8: .inotify_inode_queue_event+0x50/0x158
>>>>     lr: c0000000001074d0: .vfs_link+0x204/0x298
>>>>     sp: c000000080a9fb00
>>>>    msr: 8000000000009032
>>>>    dar: 280 
>>>>  dsisr: 40010000
>>>>   current = 0xc0000000c8e6f670
>>>>   paca    = 0xc000000000512c00
>>>>     pid   = 2848, comm = fsstress
>>>> 1:mon> t
>>>> [c000000080a9fbd0] c0000000001074d0 .vfs_link+0x204/0x298
>>>> [c000000080a9fc70] c00000000010b6e0 .sys_linkat+0x134/0x1b4
>>>> [c000000080a9fe30] c00000000000872c syscall_exit+0x0/0x40
>>>> --- Exception: c00 (System Call) at 000000000ff1bdfc
>>>> SP (ffeaed10) is in userspace
>>>> 1:mon> r
>>>> R00 = c0000000001074d0   R16 = 0000000000000000
>>>> R01 = c000000080a9fb00   R17 = 0000000000000000
>>>> R02 = c00000000060c380   R18 = 0000000000000000
>>>> R03 = 0000000000000000   R19 = 0000000000000000
>>>> R04 = 0000000000000004   R20 = 0000000000000000
>>>> R05 = 0000000000000000   R21 = 0000000000000000
>>>> R06 = 0000000000000000   R22 = 0000000000000000
>>>> R07 = 0000000000000000   R23 = 0000000000000004
>>>> R08 = 0000000000000000   R24 = 0000000000000280
>>>> R09 = 0000000000000000   R25 = fffffffffffff000
>>>> R10 = 0000000000000001   R26 = c000000082827790
>>>> R11 = c0000000003963e8   R27 = c0000000828275a0
>>>> R12 = d000000000deec78   R28 = 0000000000000000
>>>> R13 = c000000000512c00   R29 = c00000007b18fcf0
>>>> R14 = 0000000000000000   R30 = c0000000005bc088
>>>> R15 = 0000000000000000   R31 = 0000000000000000
>>>> pc  = c0000000001392c8 .inotify_inode_queue_event+0x50/0x158
>>>> lr  = c0000000001074d0 .vfs_link+0x204/0x298
>>>> msr = 8000000000009032   cr  = 24000882
>>>> ctr = c0000000003963e8   xer = 0000000000000000   trap =  300 
>>>> dar = 0000000000000280   dsisr = 40010000
>>>>
>>>>
>>>> The gdb output shows 
>>>>
>>>> 0xc0000000001076d4 is in vfs_symlink (include/linux/fsnotify.h:108).
>>>> 103      * fsnotify_create - 'name' was linked in
>>>> 104      */  
>>>> 105     static inline void fsnotify_create(struct inode *inode, struct dentry *dentry)
>>>> 106     {   
>>>> 107             inode_dir_notify(inode, DN_CREATE);
>>>> 108             inotify_inode_queue_event(inode, IN_CREATE, 0, dentry->d_name.name,
>>>> 109                                       dentry->d_inode);
>>>> 110             audit_inode_child(dentry->d_name.name, dentry, inode);
>>>> 111     }   
>>>> 112
>>>>
>>> If it is reproducible can you please try reverting
>>> inotify-send-in_attrib-events-when-link-count-changes.patch?
>> Hi Andrew,
>>
>> reverting the patch inotify-send-in_attrib-events-when-link-count-changes.patch, the 
>> bug is not reproduced.
>   OK, thanks for testing. I was trying to reproduce the problem locally but
> without success so far - I guess it's either NFS or CIFS which makes the
> problem appear. I'll investigate more.
> 
> 									Honza

Hi Jan,

I was running file system stress parallely on NFS and CIFS mounted partitions.
  

-- 
Thanks & Regards,
Kamalesh Babulal,
Linux Technology Center,
IBM, ISTL.
