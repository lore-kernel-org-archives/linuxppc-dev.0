Return-Path: <mpe@ellerman.id.au>
Received: from ozlabs.org (bilbo.ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3xj5fg6QQGzDqXl
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 30 Aug 2017 23:18:19 +1000 (AEST)
From: Michael Ellerman <mpe@ellerman.id.au>
To: Frederic Barrat <fbarrat@linux.vnet.ibm.com>, linuxppc-dev@lists.ozlabs.org,
 benh@kernel.crashing.org, andrew.donnellan@au1.ibm.com,
 clombard@linux.vnet.ibm.com, vaibhav@linux.vnet.ibm.com
Cc: alistair@popple.id.au
Subject: Re: [PATCH v2 2/3] cxl: Fix driver use count
In-Reply-To: <20170830101550.16821-2-fbarrat@linux.vnet.ibm.com>
References: <20170830101550.16821-1-fbarrat@linux.vnet.ibm.com>
 <20170830101550.16821-2-fbarrat@linux.vnet.ibm.com>
Date: Wed, 30 Aug 2017 23:18:19 +1000
Message-ID: <87h8wp19es.fsf@concordia.ellerman.id.au>
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

Frederic Barrat <fbarrat@linux.vnet.ibm.com> writes:

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

I'll pick this up straight away, because it's a fix.

So you can drop this from the series.

cheers
