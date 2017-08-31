Return-Path: <michael@ozlabs.org>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3xjgLn1F1WzDqSL
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 31 Aug 2017 21:36:33 +1000 (AEST)
In-Reply-To: <20170830101550.16821-2-fbarrat@linux.vnet.ibm.com>
To: Frederic Barrat <fbarrat@linux.vnet.ibm.com>, linuxppc-dev@lists.ozlabs.org,
 benh@kernel.crashing.org, andrew.donnellan@au1.ibm.com,
 clombard@linux.vnet.ibm.com, vaibhav@linux.vnet.ibm.com
From: Michael Ellerman <patch-notifications@ellerman.id.au>
Cc: alistair@popple.id.au
Subject: Re: [v2,2/3] cxl: Fix driver use count
Message-Id: <3xjgLm4Sn9z9t45@ozlabs.org>
Date: Thu, 31 Aug 2017 21:36:32 +1000 (AEST)
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Wed, 2017-08-30 at 10:15:49 UTC, Frederic Barrat wrote:
> cxl keeps a driver use count, which is used with the hash memory model
> on p8 to know when to upgrade local TLBIs to global and to trigger
> callbacks to manage the MMU for PSL8.
> 
> If a process opens a context and closes without attaching or fails the
> attachment, the driver use count is never decremented. As a
> consequence, TLB invalidations remain global, even if there are no
> active cxl contexts.
> 
> We should increment the driver use count when the process is attaching
> to the cxl adapter, and not on open. It's not needed before the
> adapter starts using the context and the use count is decremented on
> the detach path, so it makes more sense.
> 
> It affects only the user api. The kernel api is already doing The
> Right Thing.
> 
> Signed-off-by: Frederic Barrat <fbarrat@linux.vnet.ibm.com>
> Cc: stable@vger.kernel.org # v4.2+
> Fixes: 7bb5d91a4dda ("cxl: Rework context lifetimes")
> Acked-by: Andrew Donnellan <andrew.donnellan@au1.ibm.com>

Applied to powerpc next, thanks.

https://git.kernel.org/powerpc/c/197267d0356004a31c4d6b6336598f

cheers
