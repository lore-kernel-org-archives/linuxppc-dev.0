Return-Path: <michael@ozlabs.org>
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3spfzw1lSTzDrLx
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  5 Oct 2016 13:36:28 +1100 (AEDT)
In-Reply-To: <1475523362-4419-1-git-send-email-fbarrat@linux.vnet.ibm.com>
To: Frederic Barrat <fbarrat@linux.vnet.ibm.com>, imunsie@au1.ibm.com,
 linuxppc-dev@lists.ozlabs.org
From: Michael Ellerman <patch-notifications@ellerman.id.au>
Subject: Re: cxl: Flush PSL cache before resetting the adapter
Message-Id: <3spfzw0BJTz9sCZ@ozlabs.org>
Date: Wed,  5 Oct 2016 13:36:27 +1100 (AEDT)
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Mon, 2016-03-10 at 19:36:02 UTC, Frederic Barrat wrote:
> If the capi link is going down while the PSL owns a dirty cache line,
> any access from the host for that data could lead to an Unrecoverable
> Error.
> So when resetting the capi adapter through sysfs, make sure the PSL
> cache is flushed. It won't help if there are any active Process
> Elements on the card, as the cache would likely get new dirty cache
> lines immediately, but if resetting an idle adapter, it should avoid
> any bad surprises from data left over from terminated Process Elements.
> 
> Signed-off-by: Frederic Barrat <fbarrat@linux.vnet.ibm.com>
> Reviewed-by: Andrew Donnellan <andrew.donnellan@au1.ibm.com>
> Acked-by: Ian Munsie <imunsie@au1.ibm.com>

Applied to powerpc next, thanks.

https://git.kernel.org/powerpc/c/aaa2245ed836824f21f8e42e0ab63b

cheers
