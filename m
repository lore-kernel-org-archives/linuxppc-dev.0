Return-Path: <npiggin@gmail.com>
Received: from mail-pa0-x242.google.com (mail-pa0-x242.google.com
 [IPv6:2607:f8b0:400e:c03::242])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3ssq2x1NclzDrL1
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 10 Oct 2016 16:50:00 +1100 (AEDT)
Received: by mail-pa0-x242.google.com with SMTP id hh10so6483541pac.0
 for <linuxppc-dev@lists.ozlabs.org>; Sun, 09 Oct 2016 22:50:00 -0700 (PDT)
Date: Mon, 10 Oct 2016 16:49:53 +1100
From: Nicholas Piggin <npiggin@gmail.com>
To: Guenter Roeck <linux@roeck-us.net>
Cc: Michael Ellerman <mpe@ellerman.id.au>, linux-kernel@vger.kernel.org,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 linuxppc-dev@lists.ozlabs.org
Subject: Re: ppc64 qemu test failure since commit f9aa67142 ("powerpc/64s:
 Consolidate Alignment 0x600 interrupt")
Message-ID: <20161010164953.5f37e6e4@roar.ozlabs.ibm.com>
In-Reply-To: <20161009152121.GA13188@roeck-us.net>
References: <20161009152121.GA13188@roeck-us.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Sun, 9 Oct 2016 08:21:21 -0700
Guenter Roeck <linux@roeck-us.net> wrote:

> Nicholas,
> 
> some of my qemu tests for ppc64 started failing on mainline (and -next).
> You can find a test log at
> http://kerneltests.org/builders/qemu-ppc64-master/builds/580/steps/qemubuildcommand/logs/stdio
> 
> The scripts to run the test are available at
> https://github.com/groeck/linux-build-test/tree/master/rootfs/ppc64
> 
> Bisect points to commit f9aa67142ef26 ("powerpc/64s: Consolidate Alignment 0x600
> interrupt"). Bisect log is attached.
> 
> Since I don't have the means to run the code on a real system, I have no idea
> if the problem is caused by qemu or by the code. It is interesting, though, that
> only the 'mac99' tests are affected.
> 
> Please let me know if there is anything I can do to help tracking down the
> problem.

Thanks for this. That patch just moves a small amount of code, so it's likely
that it's caused something to get placed out of range of its caller, or the
linker started generating a stub for some reason. I can't immediately see the
problem, but it could be specific to your exact toolchain.

Something that might help, would you be able to put the compiled vmlinux binaries
from before/after the bad patch somewhere I can grab them?

Thanks,
Nick
