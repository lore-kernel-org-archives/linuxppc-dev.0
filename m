Return-Path: <michael@ozlabs.org>
Received: from ozlabs.org (bilbo.ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3ymzm51W7vzDrKt
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 29 Nov 2017 23:06:45 +1100 (AEDT)
In-Reply-To: <20171128025304.30574-1-vaibhav@linux.vnet.ibm.com>
To: Vaibhav Jain <vaibhav@linux.vnet.ibm.com>, linuxppc-dev@lists.ozlabs.org,
 Sukadev Bhattiprolu <sukadev@linux.vnet.ibm.com>,
 Christophe Lombard <christophe_lombard@fr.ibm.com>,
 Philippe Bergheaud <philippe.bergheaud@fr.ibm.com>
From: Michael Ellerman <patch-notifications@ellerman.id.au>
Cc: Andrew Donnellan <andrew.donnellan@au1.ibm.com>,
 Alastair D'Silva <alastair@linux.ibm.com>,
 Vaibhav Jain <vaibhav@linux.vnet.ibm.com>,
 Frederic Barrat <fbarrat@linux.vnet.ibm.com>
Subject: Re: [v4] powerpc: Avoid signed to unsigned conversion in
 set_thread_tidr()
Message-Id: <3ymzm473ltz9t2Z@ozlabs.org>
Date: Wed, 29 Nov 2017 23:06:44 +1100 (AEDT)
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Tue, 2017-11-28 at 02:53:04 UTC, Vaibhav Jain wrote:
> There is an unsafe signed to unsigned conversion in set_thread_tidr()
> that may cause an error value to be assigned to SPRN_TIDR register and
> used as thread-id.
> 
> The issue happens as assign_thread_tidr() returns an int and
> thread.tidr is an unsigned-long. So a negative error code returned
> from assign_thread_tidr() will fail the error check and gets assigned
> as tidr as a large positive value.
> 
> To fix this the patch assigns the return value of assign_thread_tidr()
> to a temporary int and assigns it to thread.tidr iff its '> 0'.
> 
> The patch shouldn't impact the calling convention of set_thread_tidr()
> i.e all -ve return-values are error codes and a return value of '0'
> indicates success.
> 
> Fixes: ec233ede4c86("powerpc: Add support for setting SPRN_TIDR")
> Signed-off-by: Vaibhav Jain <vaibhav@linux.vnet.ibm.com>
> Reviewed-by: Christophe Lombard clombard@linux.vnet.ibm.com

Applied to powerpc fixes, thanks.

https://git.kernel.org/powerpc/c/aca7573fde95152378361cba734996

cheers
