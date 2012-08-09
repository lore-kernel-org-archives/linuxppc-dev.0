Return-Path: <JBeulich@suse.com>
Received: from nat28.tlf.novell.com (nat28.tlf.novell.com [130.57.49.28])
 by ozlabs.org (Postfix) with ESMTP id 549282C06B2
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 10 Aug 2012 01:28:59 +1000 (EST)
Message-Id: <5023F3580200007800093F2C@nat28.tlf.novell.com>
Date: Thu, 09 Aug 2012 16:28:56 +0100
From: "Jan Beulich" <JBeulich@suse.com>
To: "Andi Kleen" <ak@linux.intel.com>,
 "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
Subject: Re: [PATCH v2 6/6] x86: switch the 64bit uncached page clear
 to SSE/AVX v2
References: <1344524583-1096-1-git-send-email-kirill.shutemov@linux.intel.com>
 <1344524583-1096-7-git-send-email-kirill.shutemov@linux.intel.com>
In-Reply-To: <1344524583-1096-7-git-send-email-kirill.shutemov@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Cc: Andrea Arcangeli <aarcange@redhat.com>, linux-mips@linux-mips.org,
 "H. Peter Anvin" <hpa@zytor.com>, Alex Shi <alex.shu@intel.com>,
 Robert Richter <robert.richter@amd.com>, linuxppc-dev@lists.ozlabs.org,
 x86@kernel.org, Hugh Dickins <hughd@google.com>, linux-kernel@vger.kernel.org,
 Andy Lutomirski <luto@amacapital.net>, linux-mm@kvack.org,
 linux-sh@vger.kernel.org, Ingo Molnar <mingo@redhat.com>,
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

>>> On 09.08.12 at 17:03, "Kirill A. Shutemov" <kirill.shutemov@linux.intel=
.com> wrote:
>  ENTRY(clear_page_nocache)
>  	CFI_STARTPROC
> -	xorl   %eax,%eax
> -	movl   $4096/64,%ecx
> +	push   %rdi
> +	call   kernel_fpu_begin
> +	pop    %rdi

You use CFI annotations elsewhere, so why don't you use
pushq_cfi/popq_cfi here?

Jan
