Return-Path: <satyam.sharma@gmail.com>
Received: from wx-out-0506.google.com (wx-out-0506.google.com [66.249.82.235])
	by ozlabs.org (Postfix) with ESMTP id 4A3F3DDEAB
	for <linuxppc-dev@ozlabs.org>; Tue, 15 May 2007 10:17:36 +1000 (EST)
Received: by wx-out-0506.google.com with SMTP id s19so1773935wxc
	for <linuxppc-dev@ozlabs.org>; Mon, 14 May 2007 17:17:35 -0700 (PDT)
Message-ID: <a781481a0705141717v2669805aoa590bfd54da7856b@mail.gmail.com>
Date: Tue, 15 May 2007 05:47:34 +0530
From: "Satyam Sharma" <satyam.sharma@gmail.com>
To: "Kumar Gala" <galak@kernel.crashing.org>
Subject: Re: [PATCH 1/2] kbuild: Add "Section mismatch" warning whitelist for
	powerpc
In-Reply-To: <3DF58590-DFD9-4665-8C47-33F407AAD1E7@kernel.crashing.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
References: <46483FAC.60503@freescale.com>
	<20070514110636.GB10143@uranus.ravnborg.org>
	<3DF58590-DFD9-4665-8C47-33F407AAD1E7@kernel.crashing.org>
Cc: Andrew Morton <akpm@osdl.org>, Sam Ravnborg <sam@ravnborg.org>,
	Linux Kernel <linux-kernel@vger.kernel.org>,
	linuxppc-dev@ozlabs.org, Li Yang <leoli@freescale.com>,
	Linus <torvalds@linux-foundation.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Hi,

On 5/14/07, Kumar Gala <galak@kernel.crashing.org> wrote:
>
> On May 14, 2007, at 6:06 AM, Sam Ravnborg wrote:
>
> > On Mon, May 14, 2007 at 06:53:32PM +0800, Li Yang wrote:
> >> This patch fixes the following "Section mismatch" warnings when
> >> build powerpc platforms.
> >>
> >> -------------
> >> WARNING: arch/powerpc/mm/built-in.o - Section mismatch: reference to
> >> .init.text:early_get_page from .text between
> >> 'pte_alloc_one_kernel' (at
> >> offset 0xc68) and 'pte_alloc_one'
> >> WARNING: mm/built-in.o - Section mismatch: reference to
> >> .init.text:set_up_list3s from .text between
> >> 'kmem_cache_create' (at offset
> >> 0x20300) and 'cache_reap'
> >> -------------
>
> This warnings should be handled by __init_refok instead.

Actually, once __init_refok comes in, would we need any other
whitelisting mechanism at all? I think the exception patterns in
secref_whitelist() and those two other whitelisting functions
(init_section_ref_ok and exit_section_ref_ok) could all be
subsumed and made redundant if / when __init_refok is used
in the actual sources.

Satyam
