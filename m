Return-Path: <simon.jeons@gmail.com>
Received: from mail-ia0-x236.google.com (mail-ia0-x236.google.com
 [IPv6:2607:f8b0:4001:c02::236])
 (using TLSv1 with cipher ECDHE-RSA-RC4-SHA (128/128 bits))
 (Client CN "smtp.gmail.com", Issuer "Google Internet Authority" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 8B4CB2C007B
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 23 Jan 2013 23:29:46 +1100 (EST)
Received: by mail-ia0-f182.google.com with SMTP id w33so3983794iag.27
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 23 Jan 2013 04:29:42 -0800 (PST)
Message-ID: <1358944171.3351.1.camel@kernel>
Subject: Re: [PATCH Bug fix 0/5] Bug fix for physical memory hot-remove.
From: Simon Jeons <simon.jeons@gmail.com>
To: Tang Chen <tangchen@cn.fujitsu.com>
Date: Wed, 23 Jan 2013 06:29:31 -0600
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

Hi Tang,

I remember your big physical memory hot-remove patchset has already
merged by Andrew, but where I can find it? Could you give me git tree 
address?

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
> 
> --
> To unsubscribe, send a message with 'unsubscribe linux-mm' in
> the body to majordomo@kvack.org.  For more info on Linux MM,
> see: http://www.linux-mm.org/ .
> Don't email: <a href=mailto:"dont@kvack.org"> email@kvack.org </a>
