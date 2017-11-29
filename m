Return-Path: <michael@ozlabs.org>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3ymzm44RmFzDrKt
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 29 Nov 2017 23:06:44 +1100 (AEDT)
In-Reply-To: <20171124083338.15283-2-vaibhav@linux.vnet.ibm.com>
To: Vaibhav Jain <vaibhav@linux.vnet.ibm.com>, linuxppc-dev@lists.ozlabs.org,
 Sukadev Bhattiprolu <sukadev@linux.vnet.ibm.com>,
 Christophe Lombard <christophe_lombard@fr.ibm.com>,
 Philippe Bergheaud <philippe.bergheaud@fr.ibm.com>
From: Michael Ellerman <patch-notifications@ellerman.id.au>
Cc: Frederic Barrat <fbarrat@linux.vnet.ibm.com>,
 Alastair D'Silva <alastair@linux.ibm.com>,
 Vaibhav Jain <vaibhav@linux.vnet.ibm.com>,
 Andrew Donnellan <andrew.donnellan@au1.ibm.com>
Subject: Re: [v2,2/2] powerpc: Do not assign thread.tidr if already assigned
Message-Id: <3ymzm43nF7z9t16@ozlabs.org>
Date: Wed, 29 Nov 2017 23:06:44 +1100 (AEDT)
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Fri, 2017-11-24 at 08:33:38 UTC, Vaibhav Jain wrote:
> If set_thread_tidr() is called twice for same task_struct then it will
> allocate a new tidr value to it leaving the previous value still
> dangling in the vas_thread_ida table.
> 
> To fix this the patch changes set_thread_tidr() to check if a tidr
> value is already assigned to the task_struct and if yes then returns
> the existing value from function instead of allocating a new one.
> 
> Fixes: ec233ede4c86("powerpc: Add support for setting SPRN_TIDR")
> Signed-off-by: Vaibhav Jain <vaibhav@linux.vnet.ibm.com>
> Reviewed-by: Andrew Donnellan <andrew.donnellan@au1.ibm.com>

Applied to powerpc fixes, thanks.

https://git.kernel.org/powerpc/c/7e4d4233260be0611c7fbdb2730c12

cheers
