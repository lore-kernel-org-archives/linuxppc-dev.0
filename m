Return-Path: <ak@linux.intel.com>
Received: from mga03.intel.com (mga03.intel.com [143.182.124.21])
 by ozlabs.org (Postfix) with ESMTP id 3A0A22C008C
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 14 Aug 2012 02:27:56 +1000 (EST)
Date: Mon, 13 Aug 2012 09:27:53 -0700
From: Andi Kleen <ak@linux.intel.com>
To: "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
Subject: Re: [PATCH v2 4/6] x86: Add clear_page_nocache
Message-ID: <20120813162753.GM2644@tassilo.jf.intel.com>
References: <1344524583-1096-1-git-send-email-kirill.shutemov@linux.intel.com>
 <1344524583-1096-5-git-send-email-kirill.shutemov@linux.intel.com>
 <5023F1BC0200007800093EF0@nat28.tlf.novell.com>
 <20120813114334.GA21855@otc-wbsnb-06>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20120813114334.GA21855@otc-wbsnb-06>
Cc: Andrea Arcangeli <aarcange@redhat.com>, linux-mips@linux-mips.org,
 "H. Peter Anvin" <hpa@zytor.com>, Alex Shi <alex.shu@intel.com>,
 Robert Richter <robert.richter@amd.com>, linuxppc-dev@lists.ozlabs.org,
 x86@kernel.org, Hugh Dickins <hughd@google.com>, linux-kernel@vger.kernel.org,
 Andy Lutomirski <luto@amacapital.net>, linux-mm@kvack.org,
 linux-sh@vger.kernel.org, Ingo Molnar <mingo@redhat.com>,
 Mel Gorman <mgorman@suse.de>, Jan Beulich <JBeulich@suse.com>,
 Johannes Weiner <hannes@cmpxchg.org>, sparclinux@vger.kernel.org,
 Thomas Gleixner <tglx@linutronix.de>, Tim Chen <tim.c.chen@linux.intel.com>,
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

> Moving 64 bytes per cycle is faster on Sandy Bridge, but slower on
> Westmere. Any preference? ;)

You have to be careful with these benchmarks.

- You need to make sure the data is cache cold, cache hot is misleading.
- The numbers can change if you have multiple CPUs doing this in parallel.

-Andi
