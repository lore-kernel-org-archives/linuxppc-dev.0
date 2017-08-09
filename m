Return-Path: <mpe@ellerman.id.au>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3xSBrJ6fCpzDrCt
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  9 Aug 2017 23:26:56 +1000 (AEST)
From: Michael Ellerman <mpe@ellerman.id.au>
To: Matt Brown <matthew.brown.dev@gmail.com>, linuxppc-dev@lists.ozlabs.org
Cc: dja@axtens.net
Subject: Re: [v6 1/2] raid6/altivec: Add vpermxor implementation for raid6 Q
 syndrome
In-Reply-To: <20170804034233.13628-1-matthew.brown.dev@gmail.com>
References: <20170804034233.13628-1-matthew.brown.dev@gmail.com>
Date: Wed, 09 Aug 2017 23:26:56 +1000
Message-ID: <87h8xgna73.fsf@concordia.ellerman.id.au>
MIME-Version: 1.0
Content-Type: text/plain
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Matt Brown <matthew.brown.dev@gmail.com> writes:

> This patch uses the vpermxor instruction to optimise the raid6 Q syndrome.
> This instruction was made available with POWER8, ISA version 2.07.
> It allows for both vperm and vxor instructions to be done in a single
> instruction. This has been tested for correctness on a ppc64le vm with a
> basic RAID6 setup containing 5 drives.
>
> The performance benchmarks are from the raid6test in the /lib/raid6/test
> directory. These results are from an IBM Firestone machine with ppc64le
> architecture. The benchmark results show a 35% speed increase over the best
> existing algorithm for powerpc (altivec). The raid6test has also been run
> on a big-endian ppc64 vm to ensure it also works for big-endian
> architectures.
>
> Performance benchmarks:
> 		raid6: altivecx4 gen() 18773 MB/s
> 		raid6: altivecx8 gen() 19438 MB/s
>
> 		raid6: vpermxor4 gen() 25112 MB/s
> 		raid6: vpermxor8 gen() 26279 MB/s
>
> Signed-off-by: Matt Brown <matthew.brown.dev@gmail.com>
> Reviewed-by: Daniel Axtens <dja@axtens.net>
> ---
> v6:
> 	- added vpermxor files to .gitignore
> 	- fixup whitespace
> 	- added vpermxor objs to test/Makefile
> v5:
> 	- moved altivec.uc fix into other patch in series
> ---
>  include/linux/raid/pq.h |   4 ++
>  lib/raid6/.gitignore    |   1 +
>  lib/raid6/Makefile      |  27 ++++++++++++-
>  lib/raid6/algos.c       |   4 ++
>  lib/raid6/test/Makefile |  17 +++++++-
>  lib/raid6/vpermxor.uc   | 104 ++++++++++++++++++++++++++++++++++++++++++++++++
>  6 files changed, 154 insertions(+), 3 deletions(-)
>  create mode 100644 lib/raid6/vpermxor.uc

This version at least is not Cc'ed to any of the folks that
get_maintainers.pl identifies for these files:

$ ./scripts/get_maintainer.pl -f lib/raid6
shli@fb.com
gayatri.kammela@intel.com
fenghua.yu@intel.com
megha.dey@linux.intel.com
schwidefsky@de.ibm.com
anup.patel@broadcom.com
linux-kernel@vger.kernel.org


This seems like mostly a list of random folks who've touched this code,
but maybe some of them would have comments?

cheers
