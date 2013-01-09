Return-Path: <akpm@linux-foundation.org>
Received: from mail.linuxfoundation.org (mail.linuxfoundation.org
 [140.211.169.12]) by ozlabs.org (Postfix) with ESMTP id 0107A2C01C8
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 10 Jan 2013 10:33:27 +1100 (EST)
Date: Wed, 9 Jan 2013 15:33:24 -0800
From: Andrew Morton <akpm@linux-foundation.org>
To: Tang Chen <tangchen@cn.fujitsu.com>
Subject: Re: [PATCH v6 00/15] memory-hotplug: hot-remove physical memory
Message-Id: <20130109153324.bbd019b3.akpm@linux-foundation.org>
In-Reply-To: <1357723959-5416-1-git-send-email-tangchen@cn.fujitsu.com>
References: <1357723959-5416-1-git-send-email-tangchen@cn.fujitsu.com>
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

On Wed, 9 Jan 2013 17:32:24 +0800
Tang Chen <tangchen@cn.fujitsu.com> wrote:

> This patch-set aims to implement physical memory hot-removing.

As you were on th patch delivery path, all of these patches should have
your Signed-off-by:.  But some were missing it.  I fixed this in my
copy of the patches.


I suspect this patchset adds a significant amount of code which will
not be used if CONFIG_MEMORY_HOTPLUG=n.  "[PATCH v6 06/15]
memory-hotplug: implement register_page_bootmem_info_section of
sparse-vmemmap", for example.  This is not a good thing, so please go
through the patchset (in fact, go through all the memhotplug code) and
let's see if we can reduce the bloat for CONFIG_MEMORY_HOTPLUG=n
kernels.

This needn't be done immediately - it would be OK by me if you were to
defer this exercise until all the new memhotplug code is largely in
place.  But please, let's do it.
