Return-Path: <toshi.kani@hp.com>
Received: from g1t0026.austin.hp.com (g1t0026.austin.hp.com [15.216.28.33])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client CN "smtp.hp.com",
 Issuer "VeriSign Class 3 Secure Server CA - G3" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 7D9062C0099
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 26 Jan 2013 05:29:45 +1100 (EST)
Message-ID: <1359137977.14145.417.camel@misato.fc.hp.com>
Subject: Re: [PATCH Bug fix 0/5] Bug fix for physical memory hot-remove.
From: Toshi Kani <toshi.kani@hp.com>
To: Tang Chen <tangchen@cn.fujitsu.com>
Date: Fri, 25 Jan 2013 11:19:37 -0700
In-Reply-To: <1358854984-6073-1-git-send-email-tangchen@cn.fujitsu.com>
References: <1358854984-6073-1-git-send-email-tangchen@cn.fujitsu.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Cc: linux-mm@kvack.org, paulus@samba.org, hpa@zytor.com, cl@linux.com,
 sfr@canb.auug.org.au, x86@kernel.org, linux-acpi@vger.kernel.org,
 isimatu.yasuaki@jp.fujitsu.com, linfeng@cn.fujitsu.com, mgorman@suse.de,
 kosaki.motohiro@jp.fujitsu.com, rientjes@google.com, len.brown@intel.com,
 jiang.liu@huawei.com, wency@cn.fujitsu.com, julian.calaby@gmail.com,
 glommer@parallels.com, wujianguo@huawei.com, yinghai@kernel.org,
 laijs@cn.fujitsu.com, linux-kernel@vger.kernel.org, minchan.kim@gmail.com,
 akpm@linux-foundation.org, linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Tue, 2013-01-22 at 19:42 +0800, Tang Chen wrote:
> Here are some bug fix patches for physical memory hot-remove. All these
> patches are based on the latest -mm tree.
> git://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.git akpm
> 
> And patch1 and patch3 are very important.
> patch1: free compound pages when freeing memmap, otherwise the kernel
>         will panic the next time memory is hot-added.
> patch3: the old way of freeing pagetable pages was wrong. We should never
>         split larger pages into small ones.
> 
> 
> Lai Jiangshan (1):
>   Bug-fix: mempolicy: fix is_valid_nodemask()
> 
> Tang Chen (3):
>   Bug fix: Do not split pages when freeing pagetable pages.
>   Bug fix: Fix section mismatch problem of
>     release_firmware_map_entry().
>   Bug fix: Fix the doc format in drivers/firmware/memmap.c
> 
> Wen Congyang (1):
>   Bug fix: consider compound pages when free memmap
> 
>  arch/x86/mm/init_64.c     |  148 ++++++++++++++-------------------------------
>  drivers/firmware/memmap.c |   16 +++---
>  mm/mempolicy.c            |   36 +++++++----
>  mm/sparse.c               |    2 +-
>  4 files changed, 77 insertions(+), 125 deletions(-)

This patchset fixed a blocker panic I was hitting in my memory hot-plug
testing.  Memory hotplug works fine with this patchset (for testing my
hotplug framework patchset :).  For the series:

Tested-by: Toshi Kani <toshi.kani@hp.com>

Thanks,
-Toshi
