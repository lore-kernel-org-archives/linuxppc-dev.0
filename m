Return-Path: <michael@ozlabs.org>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 41Qft44gmtzF35P
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 11 Jul 2018 23:24:12 +1000 (AEST)
In-Reply-To: <20180618121436.20479-1-fbarrat@linux.ibm.com>
To: Frederic Barrat <fbarrat@linux.ibm.com>, andrew.donnellan@au1.ibm.com,
 alastair@d-silva.org, linuxppc-dev@lists.ozlabs.org
From: Michael Ellerman <patch-notifications@ellerman.id.au>
Cc: clombard@linux.ibm.com, vaibhav@linux.ibm.com
Subject: Re: ocxl: Fix page fault handler in case of fault on dying process
Message-Id: <41Qft404HLzB4MY@ozlabs.org>
Date: Wed, 11 Jul 2018 23:24:10 +1000 (AEST)
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Mon, 2018-06-18 at 12:14:36 UTC, Frederic Barrat wrote:
> If a process exits without doing proper cleanup, there's a window
> where an opencapi device can try to access the memory of the dying
> process and may trigger a page fault. That's an expected scenario and
> the ocxl driver holds a reference on the mm_struct of the process
> until the opencapi device is notified of the process exiting.
> However, if mm_users is already at 0, i.e. the address space of the
> process has already been destroyed, the driver shouldn't try resolving
> the page fault, as it will fail, but it can also try accessing already
> freed data.
> 
> It is fixed by only calling the bottom half of the page fault handler
> if mm_users is greater than 0 and get a reference on mm_users instead
> of mm_count. Otherwise, we can safely return a translation fault to
> the device, as its associated memory context is being removed. The
> opencapi device will be properly cleaned up shortly after when closing
> the file descriptors.
> 
> Fixes: 5ef3166e8a32 ("ocxl: Driver code for 'generic' opencapi devices")
> Cc: stable@vger.kernel.org # v4.16+
> Signed-off-by: Frederic Barrat <fbarrat@linux.ibm.com>
> Reviewed-By: Alastair D'Silva <alastair@d-silva.org>
> Acked-by: Andrew Donnellan <andrew.donnellan@au1.ibm.com>

Applied to powerpc next, thanks.

https://git.kernel.org/powerpc/c/d497ebf5fb3a026c0817f8c96cde57

cheers
