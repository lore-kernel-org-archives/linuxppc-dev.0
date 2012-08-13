Return-Path: <bp@alien8.de>
Received: from mail.skyhub.de (mail.skyhub.de [IPv6:2a01:4f8:120:8448::d00d])
 by ozlabs.org (Postfix) with ESMTP id C9FAA2C008B
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 14 Aug 2012 03:12:05 +1000 (EST)
Date: Mon, 13 Aug 2012 19:04:02 +0200
From: Borislav Petkov <bp@alien8.de>
To: "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
Subject: Re: [PATCH v2 4/6] x86: Add clear_page_nocache
Message-ID: <20120813170402.GB15530@x1.osrc.amd.com>
References: <1344524583-1096-1-git-send-email-kirill.shutemov@linux.intel.com>
 <1344524583-1096-5-git-send-email-kirill.shutemov@linux.intel.com>
 <5023F1BC0200007800093EF0@nat28.tlf.novell.com>
 <20120813114334.GA21855@otc-wbsnb-06>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
In-Reply-To: <20120813114334.GA21855@otc-wbsnb-06>
Cc: linux-mips@linux-mips.org, linux-sh@vger.kernel.org, linux-mm@kvack.org,
 Jan Beulich <JBeulich@suse.com>, "H. Peter Anvin" <hpa@zytor.com>,
 sparclinux@vger.kernel.org, Andrea Arcangeli <aarcange@redhat.com>,
 Andi Kleen <ak@linux.intel.com>, Robert Richter <robert.richter@amd.com>,
 x86@kernel.org, Hugh Dickins <hughd@google.com>,
 Ingo Molnar <mingo@redhat.com>, Mel Gorman <mgorman@suse.de>,
 Alex Shi <alex.shu@intel.com>, Thomas Gleixner <tglx@linutronix.de>,
 KAMEZAWA Hiroyuki <kamezawa.hiroyu@jp.fujitsu.com>,
 Tim Chen <tim.c.chen@linux.intel.com>, linux-kernel@vger.kernel.org,
 Andy Lutomirski <luto@amacapital.net>, Johannes Weiner <hannes@cmpxchg.org>,
 Andrew Morton <akpm@linux-foundation.org>, linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Mon, Aug 13, 2012 at 02:43:34PM +0300, Kirill A. Shutemov wrote:
> $ cat test.c
> #include <stdio.h>
> #include <sys/mman.h>
> 
> #define SIZE 1024*1024*1024
> 
> void clear_page_nocache_sse2(void *page) __attribute__((regparm(1)));
> 
> int main(int argc, char** argv)
> {
>         char *p;
>         unsigned long i, j;
> 
>         p = mmap(NULL, SIZE, PROT_WRITE|PROT_READ,
>                         MAP_PRIVATE|MAP_ANONYMOUS|MAP_POPULATE, -1, 0);
>         for(j = 0; j < 100; j++) {
>                 for(i = 0; i < SIZE; i += 4096) {
>                         clear_page_nocache_sse2(p + i);
>                 }
>         }
> 
>         return 0;
> }
> $ cat clear_page_nocache_unroll32.S
> .globl clear_page_nocache_sse2
> .align 4,0x90
> clear_page_nocache_sse2:
> .cfi_startproc
>         mov    %eax,%edx
>         xorl   %eax,%eax
>         movl   $4096/32,%ecx
>         .p2align 4
> .Lloop_sse2:
>         decl    %ecx
> #define PUT(x) movnti %eax,x*4(%edx)
>         PUT(0)
>         PUT(1)
>         PUT(2)
>         PUT(3)
>         PUT(4)
>         PUT(5)
>         PUT(6)
>         PUT(7)
> #undef PUT
>         lea     32(%edx),%edx
>         jnz     .Lloop_sse2
>         nop
>         ret
> .cfi_endproc
> .type clear_page_nocache_sse2, @function
> .size clear_page_nocache_sse2, .-clear_page_nocache_sse2
> $ cat clear_page_nocache_unroll64.S
> .globl clear_page_nocache_sse2
> .align 4,0x90
> clear_page_nocache_sse2:
> .cfi_startproc
>         mov    %eax,%edx

This must still be the 32-bit version becaue it segfaults here. Here's
why:

mmap above gives a ptr which, on 64-bit, is larger than 32-bit, i.e. it
looks like 0x7fffxxxxx000, i.e. starting from top of userspace.

Now, the mov above truncates that ptr and the thing segfaults.

Doing s/edx/rdx/g fixes it though.

Thanks.

-- 
Regards/Gruss,
Boris.
