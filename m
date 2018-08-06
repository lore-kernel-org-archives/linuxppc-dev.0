Return-Path: <akpm@linux-foundation.org>
Received: from mail.linuxfoundation.org (mail.linuxfoundation.org
 [140.211.169.12])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 41ktJN0XD6zDqBx
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  7 Aug 2018 08:54:43 +1000 (AEST)
Date: Mon, 6 Aug 2018 15:54:40 -0700
From: Andrew Morton <akpm@linux-foundation.org>
To: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Dan Williams
 <dan.j.williams@intel.com>, Michael Ellerman <mpe@ellerman.id.au>,
 linuxppc-dev <linuxppc-dev@lists.ozlabs.org>
Subject: Re: Build regressions/improvements in v4.17-rc1
Message-Id: <20180806155440.9dcb271a3b075bd964aec60f@linux-foundation.org>
In-Reply-To: <CAMuHMdXxV1nWGWAAXSkBWm-9VWHVc57nhFLfQ4BijbKGh-vaUQ@mail.gmail.com>
References: <1523884165-17044-1-git-send-email-geert@linux-m68k.org>
 <CAMuHMdXxV1nWGWAAXSkBWm-9VWHVc57nhFLfQ4BijbKGh-vaUQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Mon, 6 Aug 2018 12:39:21 +0200 Geert Uytterhoeven <geert@linux-m68k.org> wrote:

> CC Dan, Michael, AKPM, powerpc
> 
> On Mon, Apr 16, 2018 at 3:10 PM Geert Uytterhoeven <geert@linux-m68k.org> wrote:
> > Below is the list of build error/warning regressions/improvements in
> > v4.17-rc1[1] compared to v4.16[2].
> 
> I'd like to point your attention to:
> 
> >   + warning: vmlinux.o(.text+0x376518): Section mismatch in reference from the function .devm_memremap_pages() to the function .meminit.text:.arch_add_memory():  => N/A
> >   + warning: vmlinux.o(.text+0x376d64): Section mismatch in reference from the function .devm_memremap_pages_release() to the function .meminit.text:.arch_remove_memory():  => N/A

hm.  Dan isn't around at present so we're on our own with this one.

x86 doesn't put arch_add_memory and arch_remove_memory into __meminit. 
x86 does

#ifdef CONFIG_MEMORY_HOTPLUG
int arch_add_memory(int nid, u64 start, u64 size, struct vmem_altmap *altmap,
		bool want_memblock)
{
	...


So I guess powerpc should do that as well?
