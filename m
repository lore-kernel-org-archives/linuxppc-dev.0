Return-Path: <baijiaju1990@163.com>
Received: from mproxyhzb1.163.com (mproxyhzb1.163.com [123.58.178.201])
 by lists.ozlabs.org (Postfix) with ESMTP id 3ywjYD3BmWzDqhh
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 12 Dec 2017 12:54:07 +1100 (AEDT)
From: Jia-Ju Bai <baijiaju1990@163.com>
Subject: [BUG] drivers/tty/hvc: a possible sleep-in-atomic bug in
 xen_pv_console_init
To: gregkh@linuxfoundation.org, jslaby@suse.com, benh@kernel.crashing.org
Cc: linuxppc-dev@lists.ozlabs.org,
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Message-ID: <1e23a5cc-8dad-e7d5-ea2d-3acbc1f34c3e@163.com>
Date: Tue, 12 Dec 2017 09:35:52 +0800
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

According to drivers/tty/hvc/hvc_xen.c, the kernel module may sleep 
under a spinlock.
The function call path is:
xen_pv_console_init (acquire the spinlock)
   xencons_info_pv_init
     gfn_to_virt (gfn_to_pfn) --> may sleep

I do not find a good way to fix it, so I only report.
This possible bug is found by my static analysis tool (DSAC) and my code 
review.


Thanks,
Jia-Ju Bai
