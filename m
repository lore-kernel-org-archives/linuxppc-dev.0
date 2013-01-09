Return-Path: <akpm@linux-foundation.org>
Received: from mail.linuxfoundation.org (mail.linuxfoundation.org
 [140.211.169.12]) by ozlabs.org (Postfix) with ESMTP id 900EA2C00DA
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 10 Jan 2013 10:11:43 +1100 (EST)
Date: Wed, 9 Jan 2013 15:11:40 -0800
From: Andrew Morton <akpm@linux-foundation.org>
To: Tang Chen <tangchen@cn.fujitsu.com>
Subject: Re: [PATCH v6 02/15] memory-hotplug: check whether all memory
 blocks are offlined or not when removing memory
Message-Id: <20130109151140.76982b9e.akpm@linux-foundation.org>
In-Reply-To: <1357723959-5416-3-git-send-email-tangchen@cn.fujitsu.com>
References: <1357723959-5416-1-git-send-email-tangchen@cn.fujitsu.com>
 <1357723959-5416-3-git-send-email-tangchen@cn.fujitsu.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Cc: linux-ia64@vger.kernel.org, linux-sh@vger.kernel.org, linux-mm@kvack.org,
 paulus@samba.org, hpa@zytor.com, sparclinux@vger.kernel.org, cl@linux.com,
 linux-s390@vger.kernel.org, x86@kernel.org, linux-acpi@vger.kernel.org,
 isimatu.yasuaki@jp.fujitsu.com, linfeng@cn.fujitsu.com, mgorman@suse.de,
 kosaki.motohiro@jp.fujitsu.com, rientjes@google.com, len.brown@intel.com,
 wency@cn.fujitsu.com, cmetcalf@tilera.com, glommer@parallels.com,
 wujianguo@huawei.com, yinghai@kernel.org, laijs@cn.fujitsu.com,
 linux-kernel@vger.kernel.org, minchan.kim@gmail.com,
 linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Wed, 9 Jan 2013 17:32:26 +0800
Tang Chen <tangchen@cn.fujitsu.com> wrote:

> We remove the memory like this:
> 1. lock memory hotplug
> 2. offline a memory block
> 3. unlock memory hotplug
> 4. repeat 1-3 to offline all memory blocks
> 5. lock memory hotplug
> 6. remove memory(TODO)
> 7. unlock memory hotplug
> 
> All memory blocks must be offlined before removing memory. But we don't hold
> the lock in the whole operation. So we should check whether all memory blocks
> are offlined before step6. Otherwise, kernel maybe panicked.

Well, the obvious question is: why don't we hold lock_memory_hotplug()
for all of steps 1-4?  Please send the reasons for this in a form which
I can paste into the changelog.


Actually, I wonder if doing this would fix a race in the current
remove_memory() repeat: loop.  That code does a
find_memory_block_hinted() followed by offline_memory_block(), but
afaict find_memory_block_hinted() only does a get_device().  Is the
get_device() sufficiently strong to prevent problems if another thread
concurrently offlines or otherwise alters this memory_block's state?
