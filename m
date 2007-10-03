Return-Path: <kamezawa.hiroyu@jp.fujitsu.com>
Received: from fgwmail5.fujitsu.co.jp (fgwmail5.fujitsu.co.jp [192.51.44.35])
	by ozlabs.org (Postfix) with ESMTP id D2F8CDDEB6
	for <linuxppc-dev@ozlabs.org>; Thu,  4 Oct 2007 02:25:58 +1000 (EST)
Date: Thu, 4 Oct 2007 01:25:47 +0900
From: KAMEZAWA Hiroyuki <kamezawa.hiroyu@jp.fujitsu.com>
To: Badari Pulavarty <pbadari@us.ibm.com>
Subject: Re: [RFC] PPC64 Exporting memory information through /proc/iomem
Message-Id: <20071004012547.42c457b7.kamezawa.hiroyu@jp.fujitsu.com>
In-Reply-To: <1191425735.6106.76.camel@dyn9047017100.beaverton.ibm.com>
References: <1191346196.6106.20.camel@dyn9047017100.beaverton.ibm.com>
	<18178.52359.953289.638736@cargo.ozlabs.ibm.com>
	<1191366653.6106.68.camel@dyn9047017100.beaverton.ibm.com>
	<20071003101954.52308f22.kamezawa.hiroyu@jp.fujitsu.com>
	<1191425735.6106.76.camel@dyn9047017100.beaverton.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Cc: linuxppc-dev@ozlabs.org, anton@au1.ibm.com, paulus@samba.org,
	linux-mm@kvack.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Wed, 03 Oct 2007 08:35:35 -0700
Badari Pulavarty <pbadari@us.ibm.com> wrote:

> On Wed, 2007-10-03 at 10:19 +0900, KAMEZAWA Hiroyuki wrote:
> CONFIG_ARCH_HAS_VALID_MEMORY_RANGE. Then define own
> find_next_system_ram() (rename to is_valid_memory_range()) - which
> checks the given range is a valid memory range for memory-remove
> or not. What do you think ?
> 
My concern is...
Now, memory hot *add* makes use of resource(/proc/iomem) information for onlining
memory.(See add_memory()->register_memory_resource() in mm/memoryhotplug.c)
So, we'll have to consider changing it if we need.

Does PPC64 memory hot add registers new memory information to arch dependent
information list ? It seems ppc64 registers hot-added memory information from
*probe* file and registers it by add_memory()->register_memory_resource().

If you add all add/remove/walk system ram information in sane way, I have no
objection.

I like find_next_system_ram() because I used some amount of time to debug it ;)

Thanks,
-Kame
