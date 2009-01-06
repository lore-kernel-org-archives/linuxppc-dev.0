Return-Path: <ntl@pobox.com>
Received: from sasl.smtp.pobox.com (a-sasl-fastnet.sasl.smtp.pobox.com
	[207.106.133.19]) by ozlabs.org (Postfix) with ESMTP id 8E78F474EF
	for <linuxppc-dev@ozlabs.org>; Wed,  7 Jan 2009 08:25:38 +1100 (EST)
Received: from localhost.localdomain (unknown [127.0.0.1])
	by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTP id
	75AB48D293
	for <linuxppc-dev@ozlabs.org>; Tue,  6 Jan 2009 16:25:34 -0500 (EST)
Received: from thinkcentre (unknown [67.9.156.46]) by
	a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTPA id 12ECD8D291
	for <linuxppc-dev@ozlabs.org>; Tue,  6 Jan 2009 16:25:33 -0500 (EST)
Date: Tue, 6 Jan 2009 15:25:33 -0600
From: Nathan Lynch <ntl@pobox.com>
To: linuxppc-dev@ozlabs.org
Subject: Re: [PATCH/RFC] sysfs cache code rewrite
Message-ID: <20090106212533.GB7376@localdomain>
References: <20081224045554.GA6958@localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20081224045554.GA6958@localdomain>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Please unsubscribe me from... wait, that's not what I meant to say.

Any thoughts or questions on this one?  I posted this right before the
holidays so my feelings aren't hurt by the lack of response (yet!)

To summarize why I think this should go in 2.6.29:
- Userspace will now be able to determine the true cache topology
  (the current code doesn't tell you which caches are shared between
  CPUs).
- More complete information will be presented on systems that use
  [di]-cache-block-size properties instead of [di]-cache-line-size. 
- While overall LOC has increased, the documentation is better, and the
  functions are much shorter and less complex.


Nathan Lynch wrote:
> The current code for providing processor cache information in sysfs
> has the following deficiencies:
> - several complex functions that are hard to understand
> - implicit recursion (cache_desc_release -> kobject_put -> cache_desc_release)
> - explicit recursion (create_cache_index_info)
> - use of two per-cpu arrays when one would suffice
> - duplication of work on systems where CPUs share cache
> 
> Also, when I looked at implementing support for a shared_cpu_map
> attribute, it was pretty much impossible to handle hotplug without
> checking every single online CPU's cache_desc list and fixing things
> up... not that this is a hot path, but it would have introduced
> O(n^2)-ish behavior during boot.  Addressing this involved rethinking
> the core data structures used, which didn't lend itself to an
> incremental approach.
> 
> This implementation maintains a "forest" (potentially more than one
> tree) of cache objects which reflects the system's cache topology.
> Cache objects are instantiated as needed as CPUs come online.  A
> per-cpu array is used mainly for sysfs-related bookkeeping; the
> objects in the array just point to the appropriate points in the
> forest.
> 
> This maintains compatibility with the existing code and includes some
> enhancements:
> - Implement the shared_cpu_map attribute, which is essential for
>   enabling userspace to discover the system's overall cache topology.
> - Use cache-block-size properties if cache-line-size is not available.
> 
> I chose to place this implementation in a new file since it would have
> roughly doubled the size of sysfs.c, which is already kind of messy.
> 
> Signed-off-by: Nathan Lynch <ntl@pobox.com>
> ---
>  arch/powerpc/kernel/Makefile    |    2 +-
>  arch/powerpc/kernel/cacheinfo.c |  837 +++++++++++++++++++++++++++++++++++++++
>  arch/powerpc/kernel/cacheinfo.h |    8 +
>  arch/powerpc/kernel/sysfs.c     |  300 +--------------
>  4 files changed, 850 insertions(+), 297 deletions(-)
>  create mode 100644 arch/powerpc/kernel/cacheinfo.c
>  create mode 100644 arch/powerpc/kernel/cacheinfo.h
> 
> I've tested this on various ppc64 systems, making sure that the cache
> attributes' output remain unchanged, as well as running cpu hotplug
> stress tests while concurrently accessing the cpu sysfs hierarchy.
> 
