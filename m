Return-Path: <kas@shutemov.name>
Received: from shutemov.name (shutemov.name [176.9.204.213])
 by ozlabs.org (Postfix) with ESMTP id 931732C0093
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 17 Aug 2012 04:37:02 +1000 (EST)
Date: Thu, 16 Aug 2012 21:37:25 +0300
From: "Kirill A. Shutemov" <kirill@shutemov.name>
To: Andrea Arcangeli <aarcange@redhat.com>
Subject: Re: [PATCH v3 6/7] mm: make clear_huge_page cache clear only around
 the fault address
Message-ID: <20120816183725.GA30284@shutemov.name>
References: <1345130154-9602-1-git-send-email-kirill.shutemov@linux.intel.com>
 <1345130154-9602-7-git-send-email-kirill.shutemov@linux.intel.com>
 <20120816161647.GM11188@redhat.com>
 <20120816164356.GA30106@shutemov.name>
 <20120816182944.GN11188@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20120816182944.GN11188@redhat.com>
Cc: linux-mips@linux-mips.org, linux-sh@vger.kernel.org,
 Jan Beulich <jbeulich@novell.com>, linux-mm@kvack.org,
 "H. Peter Anvin" <hpa@zytor.com>, sparclinux@vger.kernel.org,
 Andi Kleen <ak@linux.intel.com>, Robert Richter <robert.richter@amd.com>,
 x86@kernel.org, Hugh Dickins <hughd@google.com>,
 Ingo Molnar <mingo@redhat.com>, Mel Gorman <mgorman@suse.de>,
 Alex Shi <alex.shu@intel.com>, Thomas Gleixner <tglx@linutronix.de>,
 KAMEZAWA Hiroyuki <kamezawa.hiroyu@jp.fujitsu.com>,
 Tim Chen <tim.c.chen@linux.intel.com>, linux-kernel@vger.kernel.org,
 Andy Lutomirski <luto@amacapital.net>, Johannes Weiner <hannes@cmpxchg.org>,
 Andrew Morton <akpm@linux-foundation.org>, linuxppc-dev@lists.ozlabs.org,
 "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Thu, Aug 16, 2012 at 08:29:44PM +0200, Andrea Arcangeli wrote:
> On Thu, Aug 16, 2012 at 07:43:56PM +0300, Kirill A. Shutemov wrote:
> > Hm.. I think with static_key we can avoid cache overhead here. I'll try.
> 
> Could you elaborate on the static_key? Is it some sort of self
> modifying code?

Runtime code patching. See Documentation/static-keys.txt. We can patch it
on sysctl.

> 
> > Thanks, for review. Could you take a look at huge zero page patchset? ;)
> 
> I've noticed that too, nice :). I'm checking some detail on the
> wrprotect fault behavior but I'll comment there.
> 
> --
> To unsubscribe, send a message with 'unsubscribe linux-mm' in
> the body to majordomo@kvack.org.  For more info on Linux MM,
> see: http://www.linux-mm.org/ .
> Don't email: <a href=mailto:"dont@kvack.org"> email@kvack.org </a>

-- 
 Kirill A. Shutemov
