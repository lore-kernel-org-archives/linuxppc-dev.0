Return-Path: <hpa@zytor.com>
Received: from terminus.zytor.com (terminus.zytor.com [IPv6:2001:1868:205::10])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client did not present a certificate)
 by ozlabs.org (Postfix) with ESMTPS id 0D2382C0103
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 10 Aug 2012 01:35:18 +1000 (EST)
Message-ID: <5023D60F.7010009@zytor.com>
Date: Thu, 09 Aug 2012 08:23:59 -0700
From: "H. Peter Anvin" <hpa@zytor.com>
MIME-Version: 1.0
To: "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
Subject: Re: [PATCH v2 4/6] x86: Add clear_page_nocache
References: <1344524583-1096-1-git-send-email-kirill.shutemov@linux.intel.com>
 <1344524583-1096-5-git-send-email-kirill.shutemov@linux.intel.com>
In-Reply-To: <1344524583-1096-5-git-send-email-kirill.shutemov@linux.intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Cc: Andrea Arcangeli <aarcange@redhat.com>, linux-mips@linux-mips.org,
 Andi Kleen <ak@linux.intel.com>, Alex Shi <alex.shu@intel.com>,
 Robert Richter <robert.richter@amd.com>, linuxppc-dev@lists.ozlabs.org,
 x86@kernel.org, Hugh Dickins <hughd@google.com>, linux-kernel@vger.kernel.org,
 Jan Beulich <jbeulich@novell.com>, Andy Lutomirski <luto@amacapital.net>,
 linux-mm@kvack.org, linux-sh@vger.kernel.org, Ingo Molnar <mingo@redhat.com>,
 Mel Gorman <mgorman@suse.de>, Johannes Weiner <hannes@cmpxchg.org>,
 sparclinux@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>,
 Tim Chen <tim.c.chen@linux.intel.com>,
 Andrew Morton <akpm@linux-foundation.org>,
 KAMEZAWA Hiroyuki <kamezawa.hiroyu@jp.fujitsu.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 08/09/2012 08:03 AM, Kirill A. Shutemov wrote:
> From: Andi Kleen <ak@linux.intel.com>
>
> Add a cache avoiding version of clear_page. Straight forward integer variant
> of the existing 64bit clear_page, for both 32bit and 64bit.
>
> Also add the necessary glue for highmem including a layer that non cache
> coherent architectures that use the virtual address for flushing can
> hook in. This is not needed on x86 of course.
>
> If an architecture wants to provide cache avoiding version of clear_page
> it should to define ARCH_HAS_USER_NOCACHE to 1 and implement
> clear_page_nocache() and clear_user_highpage_nocache().
>

Compile failure:

/home/hpa/kernel/tip.x86-mm/arch/x86/mm/fault.c: In function 
‘clear_user_highpage_nocache’:
/home/hpa/kernel/tip.x86-mm/arch/x86/mm/fault.c:1215:30: error: 
‘KM_USER0’ undeclared (first use in this function)
/home/hpa/kernel/tip.x86-mm/arch/x86/mm/fault.c:1215:30: note: each 
undeclared identifier is reported only once for each function it appears in
/home/hpa/kernel/tip.x86-mm/arch/x86/mm/fault.c:1215:2: error: too many 
arguments to function ‘kmap_atomic’
In file included from 
/home/hpa/kernel/tip.x86-mm/include/linux/pagemap.h:10:0,
                  from 
/home/hpa/kernel/tip.x86-mm/include/linux/mempolicy.h:70,
                  from 
/home/hpa/kernel/tip.x86-mm/include/linux/hugetlb.h:15,
                  from /home/hpa/kernel/tip.x86-mm/arch/x86/mm/fault.c:14:
/home/hpa/kernel/tip.x86-mm/include/linux/highmem.h:66:21: note: 
declared here
make[4]: *** [arch/x86/mm/fault.o] Error 1
make[3]: *** [arch/x86/mm] Error 2
make[2]: *** [arch/x86] Error 2
make[1]: *** [sub-make] Error 2
make[1]: Leaving directory `/home/hpa/kernel/tip.x86-mm'

This happens on *all* my test configurations, including both x86-64 and 
i386 allyesconfig.  I suspect your patchset base is stale.

	-hpa

-- 
H. Peter Anvin, Intel Open Source Technology Center
I work for Intel.  I don't speak on their behalf.
