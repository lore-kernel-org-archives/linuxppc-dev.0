Return-Path: <kirill@shutemov.name>
Received: from mail-wm0-x244.google.com (mail-wm0-x244.google.com
 [IPv6:2a00:1450:400c:c09::244])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3zlQKS4lpLzDrTR
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 20 Feb 2018 00:56:52 +1100 (AEDT)
Received: by mail-wm0-x244.google.com with SMTP id 191so8250832wmm.4
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 19 Feb 2018 05:56:52 -0800 (PST)
Date: Mon, 19 Feb 2018 16:56:46 +0300
From: "Kirill A. Shutemov" <kirill@shutemov.name>
To: Michal Hocko <mhocko@kernel.org>
Cc: Abdul Haleem <abdhalee@linux.vnet.ibm.com>,
 linuxppc-dev <linuxppc-dev@lists.ozlabs.org>, linux-mm@kvack.org,
 kirill.shutemov@linux.intel.com, mpe <mpe@ellerman.id.au>,
 Stephen Rothwell <sfr@canb.auug.org.au>,
 linux-kernel <linux-kernel@vger.kernel.org>,
 sachinp <sachinp@linux.vnet.ibm.com>
Subject: Re: [mainline][Memory off/on][83e3c48] kernel Oops with memory
 hot-unplug on ppc
Message-ID: <20180219135646.lsmxkbgdwrjdlwxy@node.shutemov.name>
References: <1517840664.647.17.camel@abdul.in.ibm.com>
 <20180219134735.GN21134@dhcp22.suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20180219134735.GN21134@dhcp22.suse.cz>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Mon, Feb 19, 2018 at 02:47:35PM +0100, Michal Hocko wrote:
> [CC Kirill - I have a vague recollection that there were some follow ups
>  for 83e3c48729d9 ("mm/sparsemem: Allocate mem_section at runtime for
>  CONFIG_SPARSEMEM_EXTREME=y"). Does any of them apply to this issue?]

All fixups are in v4.15.

> On Mon 05-02-18 19:54:24, Abdul Haleem wrote:
> > 
> > Greetings,
> > 
> > Kernel Oops seen when memory hot-unplug on powerpc mainline kernel.
> > 
> > Machine: Power6 PowerVM ppc64
> > Kernel: 4.15.0
> > Config: attached
> > gcc: 4.8.2
> > Test: Memory hot-unplug of a memory block
> > echo offline > /sys/devices/system/memory/memory<x>/state
> > 
> > The faulty instruction address points to the code path:
> > 
> > # gdb -batch vmlinux -ex 'list *(0xc000000000238330)'
> > 0xc000000000238330 is in get_pfnblock_flags_mask
> > (./include/linux/mmzone.h:1157).
> > 1152	#endif
> > 1153	
> > 1154	static inline struct mem_section *__nr_to_section(unsigned long nr)
> > 1155	{
> > 1156	#ifdef CONFIG_SPARSEMEM_EXTREME
> > 1157		if (!mem_section)
> > 1158			return NULL;
> > 1159	#endif
> > 1160		if (!mem_section[SECTION_NR_TO_ROOT(nr)])
> > 1161			return NULL;
> > 
> > 
> > The code was first introduced with commit( 83e3c48: mm/sparsemem:
> > Allocate mem_section at runtime for CONFIG_SPARSEMEM_EXTREME=y)

Any chance to bisect it?

Could you check if the commit just before 83e3c48729d9 is fine?

-- 
 Kirill A. Shutemov
