Return-Path: <arnd@arndb.de>
Received: from moutng.kundenserver.de (moutng.kundenserver.de
	[212.227.126.177]) by ozlabs.org (Postfix) with ESMTP id 1895B67D37
	for <linuxppc-dev@ozlabs.org>; Wed,  8 Nov 2006 20:28:45 +1100 (EST)
From: Arnd Bergmann <arnd@arndb.de>
To: linuxppc-dev@ozlabs.org,
 michael@ellerman.id.au
Subject: Re: [PATCH] powerpc: force 4k update_flash block and list sizes
Date: Wed, 8 Nov 2006 10:28:31 +0100
References: <1162943615.13499.15.camel@sinatra.austin.ibm.com>
	<1162960202.14254.3.camel@sinatra.austin.ibm.com>
	<1162960860.20271.13.camel@localhost.localdomain>
In-Reply-To: <1162960860.20271.13.camel@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-15"
Message-Id: <200611081028.32038.arnd@arndb.de>
Cc: Paul Mackerras <paulus@samba.org>, Michael Neuling <mikey@neuling.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Wednesday 08 November 2006 05:41, Michael Ellerman wrote:
> Just being picky .. but why did you decide to use the slab cache? Does
> it make the code neater? I would have thought you could guarantee 4k
> alignment some other way, and it seems slightly odd to use the slab
> cache for something you only do once ..

There are not so many allocators available. kmalloc does not guarantee
alignment beyond a few bytes and the buddy allocator and vmalloc don't
give you allocations smaller than PAGE_SIZE.

The ehca people had the same problem, and I could imagine there are
others with similar issues. How about adding a special slab allocator
architecture-wide that gives out aligned 4k chunks independent of
page size?

	Arnd <>z
