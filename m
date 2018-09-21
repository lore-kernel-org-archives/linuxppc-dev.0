Return-Path: <michael@ozlabs.org>
Received: from ozlabs.org (bilbo.ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 42GsbK1VxszF3QS
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 21 Sep 2018 21:59:41 +1000 (AEST)
In-Reply-To: <20180920043858.28773-1-bauerman@linux.ibm.com>
To: Thiago Jung Bauermann <bauerman@linux.ibm.com>,
 linuxppc-dev@lists.ozlabs.org
From: Michael Ellerman <patch-notifications@ellerman.id.au>
Cc: Ram Pai <linuxram@us.ibm.com>, linux-kernel@vger.kernel.org,
 Thiago Jung Bauermann <bauerman@linux.ibm.com>
Subject: Re: powerpc/pkeys: Fix reading of ibm, processor-storage-keys property
Message-Id: <42GsbJ6bPwz9sC7@ozlabs.org>
Date: Fri, 21 Sep 2018 21:59:40 +1000 (AEST)
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Thu, 2018-09-20 at 04:38:58 UTC, Thiago Jung Bauermann wrote:
> scan_pkey_feature() uses of_property_read_u32_array() to read the
> ibm,processor-storage-keys property and calls be32_to_cpu() on the
> value it gets. The problem is that of_property_read_u32_array() already
> returns the value converted to the CPU byte order.
> 
> The value of pkeys_total ends up more or less sane because there's a min()
> call in pkey_initialize() which reduces pkeys_total to 32. So in practice
> the kernel ignores the fact that the hypervisor reserved one key for
> itself (the device tree advertises 31 keys in my test VM).
> 
> This is wrong, but the effect in practice is that when a process tries to
> allocate the 32nd key, it gets an -EINVAL error instead of -ENOSPC which
> would indicate that there aren't any keys available
> 
> Fixes: cf43d3b26452 ("powerpc: Enable pkey subsystem")
> Signed-off-by: Thiago Jung Bauermann <bauerman@linux.ibm.com>

Applied to powerpc fixes, thanks.

https://git.kernel.org/powerpc/c/c716a25b9b70084e1144f77423f5ae

cheers
