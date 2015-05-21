Return-Path: <mpe@ellerman.id.au>
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id C17A21A00B5
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 21 May 2015 13:53:50 +1000 (AEST)
Message-ID: <1432180430.7260.4.camel@ellerman.id.au>
Subject: Re: [PATCH V4 00/13] POWER DSCR fixes, improvements, docs and tests
From: Michael Ellerman <mpe@ellerman.id.au>
To: Anshuman Khandual <khandual@linux.vnet.ibm.com>
Cc: linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org,
 mikey@neuling.org, shuahkh@osg.samsung.com, anton@samba.org
Date: Thu, 21 May 2015 13:53:50 +1000
In-Reply-To: <1431946576-1009-1-git-send-email-khandual@linux.vnet.ibm.com>
References: <1431946576-1009-1-git-send-email-khandual@linux.vnet.ibm.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Mon, 2015-05-18 at 16:26 +0530, Anshuman Khandual wrote:
> 	This patch series has patches for POWER DSCR fixes, improvements,
> in code documentaion, kernel support user documentation and selftest based
> test cases. It has got five test cases which are derived from Anton's DSCR
> test bucket which can be listed as follows.
> 
> (1) http://ozlabs.org/~anton/junkcode/dscr_default_test.c
> (2) http://ozlabs.org/~anton/junkcode/dscr_explicit_test.c
> (3) http://ozlabs.org/~anton/junkcode/dscr_inherit_exec_test.c
> (4) http://ozlabs.org/~anton/junkcode/dscr_inherit_test.c
> (5) http://ozlabs.org/~anton/junkcode/user_dscr_test.c
> 
> NOTE1: Anton's original inherit exec test expected the child to have system
> default DSCR value instead of the inherited DSCR value from it's parent.
> But looks like thats not the case when we execute the test, it always
> inherits it's parent's DSCR value over the exec call as well. So I have
> changed the test program assuming its correct to have the inherited DSCR
> value in the fork/execed child program. Please let me know if thats not
> correct and I am missing something there.

The selftests still fail to build:

  cc -Wall -O2 -flto -Wall -Werror -DGIT_VERSION='"v4.0-rc1-13631-gdfcba4b"' -I/home/buildbot/buildbot/slave/selftests-ppc64-gcc-ubuntu-be/build/tools/testing/selftests/powerpc  -lpthread    dscr_default_test.c ../harness.c   -o dscr_default_test
  In file included from dscr_default_test.c:16:0:
  dscr.h: In function ‘get_default_dscr’:
  dscr.h:93:6: error: ignoring return value of ‘read’, declared with attribute warn_unused_result [-Werror=unused-result]
    read(fd, buf, sizeof(buf));
        ^
  dscr.h: In function ‘set_default_dscr’:
  dscr.h:112:7: error: ignoring return value of ‘write’, declared with attribute warn_unused_result [-Werror=unused-result]
    write(fd, buf, strlen(buf));
         ^
  cc1: all warnings being treated as errors
  make[1]: *** [dscr_default_test] Error 1


I'm happy for you to call perror() and exit(1) if either fail.

Please fix and resend.

cheers
