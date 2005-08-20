Return-Path: <linville@tuxdriver.com>
Received: from ra.tuxdriver.com (ra.tuxdriver.com [24.172.12.4])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id C978167F88
	for <linuxppc-dev@ozlabs.org>; Sun, 21 Aug 2005 04:12:12 +1000 (EST)
Date: Sat, 20 Aug 2005 14:08:28 -0400
From: "John W. Linville" <linville@tuxdriver.com>
To: Stephen Williams <steve@icarus.com>
Message-ID: <20050820180825.GG2736@tuxdriver.com>
References: <4305F7FE.7040709@icarus.com> <1124499963.5197.99.camel@gaston>
	<4307536E.4070800@icarus.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <4307536E.4070800@icarus.com>
Cc: linuxppc-dev@ozlabs.org
Subject: Re: How to map memory uncached on PPC.
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Sat, Aug 20, 2005 at 08:59:42AM -0700, Stephen Williams wrote:
> Benjamin Herrenschmidt wrote:

> >A simple experiment you can do is limit the memory used by the kernel
> >(booting with mem=xxxx) and then use mmap of /dev/mem to map the
> >remaining memory like if it was an IO device, uncached. With that, you
> >get a quick hack solution to validate the performance benefit at least.
> 
> I did an even simpler experiment: I commented out the pci_map_single,
> which on a PPC only has the effect of calling invalidate_dcache_range
> and returning the virt_to_bus of the address. Obviously, the cache
> is still enabled for the processor, and the image data may get
> corrupted, but this was a performance test, not a solution.

If your purpose is to evaluate performance, doesn't having the cache
enabled limit the usefulness of your test?  For example if your cache
uses a write-back policy then your test will probably outperform the
actual uncached accesses.  YMMV, I suppose...

John
-- 
John W. Linville
linville@tuxdriver.com
