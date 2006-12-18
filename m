Return-Path: <haveblue@us.ibm.com>
Subject: Re: [PATCH] Fix sparsemem on Cell
From: Dave Hansen <haveblue@us.ibm.com>
To: Arnd Bergmann <arnd@arndb.de>
In-Reply-To: <200612182354.47685.arnd@arndb.de>
References: <20061215165335.61D9F775@localhost.localdomain>
	<20061215114536.dc5c93af.akpm@osdl.org>
	<20061216170353.2dfa27b1.kamezawa.hiroyu@jp.fujitsu.com>
	<200612182354.47685.arnd@arndb.de>
Content-Type: text/plain
Date: Mon, 18 Dec 2006 15:16:20 -0800
Message-Id: <1166483780.8648.26.camel@localhost.localdomain>
Mime-Version: 1.0
Cc: Andrew Morton <akpm@osdl.org>, mkravetz@us.ibm.com, linux-mm@kvack.org,
	linux-kernel@vger.kernel.org, hch@infradead.org,
	linuxppc-dev@ozlabs.org, paulus@samba.org, kmannth@us.ibm.com,
	gone@us.ibm.com, cbe-oss-dev@ozlabs.org,
	KAMEZAWA Hiroyuki <kamezawa.hiroyu@jp.fujitsu.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Mon, 2006-12-18 at 23:54 +0100, Arnd Bergmann wrote:
>  #ifndef __HAVE_ARCH_MEMMAP_INIT
>  #define memmap_init(size, nid, zone, start_pfn) \
> -	memmap_init_zone((size), (nid), (zone), (start_pfn))
> +	memmap_init_zone((size), (nid), (zone), (start_pfn), 1)
>  #endif

This is what I was thinking of.  Sometimes I find these kinds of calls a
bit annoying:

	foo(0, 1, 1, 0, 99, 22)

It only takes a minute to look up what all of the numbers do, but that
is one minute too many. :)

How about an enum, or a pair of #defines?

enum context
{
        EARLY,
        HOTPLUG
};
extern void memmap_init_zone(unsigned long, int, unsigned long, unsigned long,
                                enum call_context);
...

So, the call I quoted above would become:

	memmap_init_zone((size), (nid), (zone), (start_pfn), EARLY)

-- Dave
