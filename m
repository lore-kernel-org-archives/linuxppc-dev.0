Return-Path: <galak@kernel.crashing.org>
Received: from nommos.sslcatacombnetworking.com
	(nommos.sslcatacombnetworking.com [67.18.224.114])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id BD7C8DDD06
	for <linuxppc-dev@ozlabs.org>; Tue, 15 May 2007 06:11:15 +1000 (EST)
In-Reply-To: <20070514123046.d75cc170.akpm@linux-foundation.org>
References: <46483FAC.60503@freescale.com>
	<20070514110636.GB10143@uranus.ravnborg.org>
	<3DF58590-DFD9-4665-8C47-33F407AAD1E7@kernel.crashing.org>
	<20070514123046.d75cc170.akpm@linux-foundation.org>
Mime-Version: 1.0 (Apple Message framework v752.2)
Content-Type: text/plain; charset=US-ASCII; delsp=yes; format=flowed
Message-Id: <510243B4-E915-4E32-808F-F33CB32B7497@kernel.crashing.org>
From: Kumar Gala <galak@kernel.crashing.org>
Subject: Re: [PATCH 1/2] kbuild: Add "Section mismatch" warning whitelist for
	powerpc
Date: Mon, 14 May 2007 15:10:04 -0500
To: Andrew Morton <akpm@linux-foundation.org>
Cc: Sam Ravnborg <sam@ravnborg.org>,
	Linux Kernel <linux-kernel@vger.kernel.org>,
	ppc-dev list <linuxppc-dev@ozlabs.org>,
	Paul Mackerras <paulus@samba.org>, Li Yang <leoli@freescale.com>,
	Linus Torvalds <torvalds@linux-foundation.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


On May 14, 2007, at 2:30 PM, Andrew Morton wrote:

> On Mon, 14 May 2007 08:56:52 -0500
> Kumar Gala <galak@kernel.crashing.org> wrote:
>
>> On May 14, 2007, at 6:06 AM, Sam Ravnborg wrote:
>>
>>> On Mon, May 14, 2007 at 06:53:32PM +0800, Li Yang wrote:
>>>> This patch fixes the following "Section mismatch" warnings when
>>>> build powerpc platforms.
>>>>
>>>> -------------
>>>> WARNING: arch/powerpc/mm/built-in.o - Section mismatch:  
>>>> reference to
>>>> .init.text:early_get_page from .text between
>>>> 'pte_alloc_one_kernel' (at
>>>> offset 0xc68) and 'pte_alloc_one'
>>>> WARNING: mm/built-in.o - Section mismatch: reference to
>>>> .init.text:set_up_list3s from .text between
>>>> 'kmem_cache_create' (at offset
>>>> 0x20300) and 'cache_reap'
>>>> -------------
>>
>> This warnings should be handled by __init_refok instead.
>>
>
> Yes, I think so.
>
>>
>>>> Massive warnings represented by:
>>>> -------------
>>>> WARNING: arch/powerpc/kernel/built-in.o - Section mismatch:
>>>> reference to
>>>> .init.data:.got2 from prom_entry (offset 0x0)
>>>> WARNING: arch/powerpc/platforms/built-in.o - Section mismatch:
>>>> reference to
>>>> .init.text:mpc8313_rdb_probe from .machine.desc after
>>>> 'mach_mpc8313_rdb'
>>>> (at offset 0x4)
>>>> -------------
>>>>
>>>> Signed-off-by: Li Yang <leoli@freescale.com>
>>> Acked-by: Sam Ravnborg <sam@ravnborg.org>
>
> I always get confused when a git-tree-owner says "acked-by" against  
> a patch
> which falls within his tree's area.  An acked-by would mean "I'm OK  
> with
> the patch, please apply it".  But I'd have expected to see a "thanks,
> applied" instead.
>
> If it was "Andrew: please merge and send to Linus because it's  
> urgent and I
> can't be bothered setting up a git pull for it" then fine, but  
> please be
> explicit about that.

I'd prefer to handle the ppc specific bits through the powerpc.git  
since they are only warnings and we should be able to fix them up for  
the next 2.6.22-rc unless Linus is on a made dash to get 2.6.22 out  
faster than any previous release :)

- k
