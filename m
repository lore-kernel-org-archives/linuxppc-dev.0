Return-Path: <JBeulich@suse.com>
Received: from nat28.tlf.novell.com (nat28.tlf.novell.com [130.57.49.28])
 by ozlabs.org (Postfix) with ESMTP id B62202C0085
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 13 Aug 2012 22:03:06 +1000 (EST)
Message-Id: <502909110200007800094719@nat28.tlf.novell.com>
Date: Mon, 13 Aug 2012 13:02:57 +0100
From: "Jan Beulich" <JBeulich@suse.com>
To: "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
Subject: Re: [PATCH v2 4/6] x86: Add clear_page_nocache
References: <1344524583-1096-1-git-send-email-kirill.shutemov@linux.intel.com>
 <1344524583-1096-5-git-send-email-kirill.shutemov@linux.intel.com>
 <5023F1BC0200007800093EF0@nat28.tlf.novell.com>
 <20120813114334.GA21855@otc-wbsnb-06>
In-Reply-To: <20120813114334.GA21855@otc-wbsnb-06>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Cc: Andrea Arcangeli <aarcange@redhat.com>, linux-mips@linux-mips.org,
 Andi Kleen <ak@linux.intel.com>, "H. Peter Anvin" <hpa@zytor.com>,
 Alex Shi <alex.shu@intel.com>, Robert Richter <robert.richter@amd.com>,
 linuxppc-dev@lists.ozlabs.org, x86@kernel.org, Hugh Dickins <hughd@google.com>,
 linux-kernel@vger.kernel.org, Andy Lutomirski <luto@amacapital.net>,
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

>>> On 13.08.12 at 13:43, "Kirill A. Shutemov" <kirill.shutemov@linux.intel=
.com> wrote:
> On Thu, Aug 09, 2012 at 04:22:04PM +0100, Jan Beulich wrote:
>> >>> On 09.08.12 at 17:03, "Kirill A. Shutemov" <kirill.shutemov@linux.in=
tel.com>  wrote:
>=20
> ...
>=20
>> > ---
>> >  arch/x86/include/asm/page.h          |    2 ++
>> >  arch/x86/include/asm/string_32.h     |    5 +++++
>> >  arch/x86/include/asm/string_64.h     |    5 +++++
>> >  arch/x86/lib/Makefile                |    1 +
>> >  arch/x86/lib/clear_page_nocache_32.S |   30 +++++++++++++++++++++++++=
+++++
>> >  arch/x86/lib/clear_page_nocache_64.S |   29 +++++++++++++++++++++++++=
++++
>>=20
>> Couldn't this more reasonably go into clear_page_{32,64}.S?
>=20
> We don't have clear_page_32.S.

Sure, but you're introducing a file anyway. Fold the new code into
the existing file for 64-bit, and create a new, similarly named one
for 32-bit.

>> >+	xorl   %eax,%eax
>> >+	movl   $4096/64,%ecx
>> >+	.p2align 4
>> >+.Lloop:
>> >+	decl	%ecx
>> >+#define PUT(x) movnti %eax,x*8(%edi) ; movnti %eax,x*8+4(%edi)
>>=20
>> Is doing twice as much unrolling as on 64-bit really worth it?
>=20
> Moving 64 bytes per cycle is faster on Sandy Bridge, but slower on
> Westmere. Any preference? ;)

If it's not a clear win, I'd favor the 8-stores-per-cycle variant,
matching x86-64.

Jan
