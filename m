Return-Path: <michael@ozlabs.org>
Received: from ozlabs.org (bilbo.ozlabs.org [203.11.71.1])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 41Zg3B2ggPzDqyZ
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 24 Jul 2018 23:59:50 +1000 (AEST)
In-Reply-To: <1528336675-10879-2-git-send-email-wei.guo.simon@gmail.com>
To: wei.guo.simon@gmail.com, linuxppc-dev@lists.ozlabs.org
From: Michael Ellerman <patch-notifications@ellerman.id.au>
Cc: "Naveen N.  Rao" <naveen.n.rao@linux.vnet.ibm.com>,
 Simon Guo <wei.guo.simon@gmail.com>, Cyril Bur <cyrilbur@gmail.com>
Subject: Re: [v8,
 1/5] powerpc/64: Align bytes before fall back to .Lshort in powerpc64
 memcmp()
Message-Id: <41Zg395wSgz9s4Z@ozlabs.org>
Date: Tue, 24 Jul 2018 23:59:49 +1000 (AEST)
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Thu, 2018-06-07 at 01:57:51 UTC, wei.guo.simon@gmail.com wrote:
> From: Simon Guo <wei.guo.simon@gmail.com>
> 
> Currently memcmp() 64bytes version in powerpc will fall back to .Lshort
> (compare per byte mode) if either src or dst address is not 8 bytes aligned.
> It can be opmitized in 2 situations:
> 
> 1) if both addresses are with the same offset with 8 bytes boundary:
> memcmp() can compare the unaligned bytes within 8 bytes boundary firstly
> and then compare the rest 8-bytes-aligned content with .Llong mode.
> 
> 2)  If src/dst addrs are not with the same offset of 8 bytes boundary:
> memcmp() can align src addr with 8 bytes, increment dst addr accordingly,
>  then load src with aligned mode and load dst with unaligned mode.
> 
> This patch optmizes memcmp() behavior in the above 2 situations.
> 
> Tested with both little/big endian. Performance result below is based on
> little endian.
> 
> Following is the test result with src/dst having the same offset case:
> (a similar result was observed when src/dst having different offset):
> (1) 256 bytes
> Test with the existing tools/testing/selftests/powerpc/stringloops/memcmp:
> - without patch
> 	29.773018302 seconds time elapsed                                          ( +- 0.09% )
> - with patch
> 	16.485568173 seconds time elapsed                                          ( +-  0.02% )
> 		-> There is ~+80% percent improvement
> 
> (2) 32 bytes
> To observe performance impact on < 32 bytes, modify
> tools/testing/selftests/powerpc/stringloops/memcmp.c with following:
> -------
>  #include <string.h>
>  #include "utils.h"
> 
> -#define SIZE 256
> +#define SIZE 32
>  #define ITERATIONS 10000
> 
>  int test_memcmp(const void *s1, const void *s2, size_t n);
> --------
> 
> - Without patch
> 	0.244746482 seconds time elapsed                                          ( +-  0.36%)
> - with patch
> 	0.215069477 seconds time elapsed                                          ( +-  0.51%)
> 		-> There is ～+13% improvement
> 
> (3) 0~8 bytes
> To observe <8 bytes performance impact, modify
> tools/testing/selftests/powerpc/stringloops/memcmp.c with following:
> -------
>  #include <string.h>
>  #include "utils.h"
> 
> -#define SIZE 256
> -#define ITERATIONS 10000
> +#define SIZE 8
> +#define ITERATIONS 1000000
> 
>  int test_memcmp(const void *s1, const void *s2, size_t n);
> -------
> - Without patch
>        1.845642503 seconds time elapsed                                          ( +- 0.12% )
> - With patch
>        1.849767135 seconds time elapsed                                          ( +- 0.26% )
> 		-> They are nearly the same. (-0.2%)
> 
> Signed-off-by: Simon Guo <wei.guo.simon@gmail.com>

Series applied to powerpc next, thanks.

https://git.kernel.org/powerpc/c/2d9ee327adce5f6becea2dd51d282a

cheers
