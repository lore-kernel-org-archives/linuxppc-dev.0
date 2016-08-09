Return-Path: <michael@ozlabs.org>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3s7sRw4n1szDqdw
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  9 Aug 2016 21:26:36 +1000 (AEST)
In-Reply-To: <1469684381-22354-1-git-send-email-andrew.donnellan@au1.ibm.com>
To: Andrew Donnellan <andrew.donnellan@au1.ibm.com>,
 linuxppc-dev@lists.ozlabs.org
From: Michael Ellerman <patch-notifications@ellerman.id.au>
Cc: huyn@mellanox.com, imunsie@au1.ibm.com, fbarrat@linux.vnet.ibm.com
Subject: Re: cxl: fix NULL dereference in cxl_context_init() on PowerVM guests
Message-Id: <3s7sRw317hz9t1L@ozlabs.org>
Date: Tue,  9 Aug 2016 21:26:36 +1000 (AEST)
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Thu, 2016-28-07 at 05:39:41 UTC, Andrew Donnellan wrote:
> Commit f67a6722d650 ("cxl: Workaround PE=0 hardware limitation in Mellanox
> CX4") added a "min_pe" field to struct cxl_service_layer_ops, to allow us
> to work around a Mellanox CX-4 hardware limitation.
> 
> When allocating the PE number in cxl_context_init(), we read from
> ctx->afu->adapter->native->sl_ops->min_pe to get the minimum PE number.
> Unsurprisingly, in a PowerVM guest ctx->afu->adapter->native is NULL, and
> guests don't have a cxl_service_layer_ops struct anywhere.
> 
> Move min_pe from struct cxl_service_layer_ops to struct cxl so it's
> accessible in both native and PowerVM environments. For the Mellanox CX-4,
> set the min_pe value in set_sl_ops().
> 
> Fixes: f67a6722d650 ("cxl: Workaround PE=0 hardware limitation in Mellanox CX4")
> Reported-by: Frederic Barrat <fbarrat@linux.vnet.ibm.com>
> Signed-off-by: Andrew Donnellan <andrew.donnellan@au1.ibm.com>
> Acked-by: Ian Munsie <imunsie@au1.ibm.com>
> Reviewed-by: Frederic Barrat <fbarrat@linux.vnet.ibm.com>

Applied to powerpc fixes, thanks.

https://git.kernel.org/powerpc/c/164793379ad3b7ef5fc5a28260

cheers
