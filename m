Return-Path: <greg@kroah.com>
Received: from out1-smtp.messagingengine.com (out1-smtp.messagingengine.com
 [66.111.4.25])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3y5tDK2bKnzDqhh
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  3 Oct 2017 19:56:00 +1100 (AEDT)
Date: Tue, 3 Oct 2017 10:56:06 +0200
From: Greg KH <greg@kroah.com>
To: Andrew Donnellan <andrew.donnellan@au1.ibm.com>
Cc: stable@vger.kernel.org, fbarrat@linux.vnet.ibm.com, mpe@ellerman.id.au,
 linuxppc-dev@lists.ozlabs.org
Subject: Re: [PATCH 4.4] cxl: Fix driver use count
Message-ID: <20171003085606.GF15659@kroah.com>
References: <20170927004317.9671-1-andrew.donnellan@au1.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20170927004317.9671-1-andrew.donnellan@au1.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Wed, Sep 27, 2017 at 10:43:17AM +1000, Andrew Donnellan wrote:
> From: Frederic Barrat <fbarrat@linux.vnet.ibm.com>
> 
> commit 197267d0356004a31c4d6b6336598f5dff3301e1 upstream.
> 
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
> Signed-off-by: Michael Ellerman <mpe@ellerman.id.au>
> [ajd: backport to stable v4.4 tree]
> Signed-off-by: Andrew Donnellan <andrew.donnellan@au1.ibm.com>

Thanks for this and the 4.9 backport.

greg k-h
