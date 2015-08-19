Return-Path: <michael@ozlabs.org>
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 5480D1A0E13
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 20 Aug 2015 09:14:17 +1000 (AEST)
In-Reply-To: <1437633836-5051-1-git-send-email-imunsie@au.ibm.com>
To: Ian Munsie <imunsie@au1.ibm.com>
From: Michael Ellerman <mpe@ellerman.id.au>
Cc: Matt Ochs <mrochs@us.ibm.com>, linuxppc-dev <linuxppc-dev@ozlabs.org>,
 mikey <mikey@neuling.org>, linux-kernel <linux-kernel@vger.kernel.org>,
 Ian Munsie <imunsie@au1.ibm.com>
Subject: Re: cxl: Add alternate MMIO error handling
Message-Id: <20150819231416.858091409B7@ozlabs.org>
Date: Thu, 20 Aug 2015 09:14:16 +1000 (AEST)
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Thu, 2015-23-07 at 06:43:56 UTC, Ian Munsie wrote:
> From: Ian Munsie <imunsie@au1.ibm.com>
> 
> userspace programs using cxl currently have to use two strategies for
> dealing with MMIO errors simultaneously. They have to check every read
> for a return of all Fs in case the adapter has gone away and the kernel
> has not yet noticed, and they have to deal with SIGBUS in case the
> kernel has already noticed, invalidated the mapping and marked the
> context as failed.
> 
> In order to simplify things, this patch adds an alternative approach
> where the kernel will return a page filled with Fs instead of delivering
> a SIGBUS. This allows userspace to only need to deal with one of these
> two error paths, and is intended for use in libraries that use cxl
> transparently and may not be able to safely install a signal handler.
> 
> This approach will only work if certain constraints are met. Namely, if
> the application is both reading and writing to an address in the problem
> state area it cannot assume that a non-FF read is OK, as it may just be
> reading out a value it has previously written. Further - since only one
> page is used per context a write to a given offset would be visible when
> reading the same offset from a different page in the mapping (this only
> applies within a single context, not between contexts).
> 
> An application could deal with this by e.g. making sure it also reads
> from a read-only offset after any reads to a read/write offset.
> 
> Due to these constraints, this functionality must be explicitly
> requested by userspace when starting the context by passing in the
> CXL_START_WORK_ERR_FF flag.
> 
> Signed-off-by: Ian Munsie <imunsie@au1.ibm.com>
> Acked-by: Michael Neuling <mikey@neuling.org>

Applied to powerpc next, thanks.

https://git.kernel.org/powerpc/c/d9232a3da8683cd9c985

cheers
