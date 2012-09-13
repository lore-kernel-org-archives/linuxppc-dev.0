Return-Path: <akpm@linux-foundation.org>
Received: from mail.linuxfoundation.org (mail.linuxfoundation.org
 [140.211.169.12]) by ozlabs.org (Postfix) with ESMTP id 206982C007D
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 14 Sep 2012 09:05:09 +1000 (EST)
Date: Thu, 13 Sep 2012 16:05:06 -0700
From: Andrew Morton <akpm@linux-foundation.org>
To: "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
Subject: Re: [PATCH v4 0/8] Avoid cache trashing on clearing huge/gigantic page
Message-Id: <20120913160506.d394392a.akpm@linux-foundation.org>
In-Reply-To: <1345470757-12005-1-git-send-email-kirill.shutemov@linux.intel.com>
References: <1345470757-12005-1-git-send-email-kirill.shutemov@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Cc: Andrea Arcangeli <aarcange@redhat.com>, linux-mips@linux-mips.org,
 Andi Kleen <ak@linux.intel.com>, Alex Shi <alex.shu@intel.com>,
 Robert Richter <robert.richter@amd.com>, linuxppc-dev@lists.ozlabs.org,
 x86@kernel.org, Hugh Dickins <hughd@google.com>, linux-kernel@vger.kernel.org,
 Jan Beulich <jbeulich@novell.com>, Andy Lutomirski <luto@amacapital.net>,
 Johannes Weiner <hannes@cmpxchg.org>, linux-mm@kvack.org,
 linux-sh@vger.kernel.org, Ingo Molnar <mingo@redhat.com>,
 Mel Gorman <mgorman@suse.de>, "H. Peter Anvin" <hpa@zytor.com>,
 sparclinux@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>,
 Tim Chen <tim.c.chen@linux.intel.com>,
 KAMEZAWA Hiroyuki <kamezawa.hiroyu@jp.fujitsu.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Mon, 20 Aug 2012 16:52:29 +0300
"Kirill A. Shutemov" <kirill.shutemov@linux.intel.com> wrote:

> Clearing a 2MB huge page will typically blow away several levels of CPU
> caches.  To avoid this only cache clear the 4K area around the fault
> address and use a cache avoiding clears for the rest of the 2MB area.
> 
> This patchset implements cache avoiding version of clear_page only for
> x86. If an architecture wants to provide cache avoiding version of
> clear_page it should to define ARCH_HAS_USER_NOCACHE to 1 and implement
> clear_page_nocache() and clear_user_highpage_nocache().

Patchset looks nice to me, but the changelogs are terribly short of
performance measurements.  For this sort of change I do think it is
important that pretty exhaustive testing be performed, and that the
results (or a readable summary of them) be shown.  And that testing
should be designed to probe for slowdowns, not just the speedups!
