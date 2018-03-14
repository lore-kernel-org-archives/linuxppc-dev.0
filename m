Return-Path: <michael@ozlabs.org>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 401RGD2CH3zDqjw
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 14 Mar 2018 20:27:48 +1100 (AEDT)
In-Reply-To: <20180215154924.22005-1-vaibhav@linux.vnet.ibm.com>
To: Vaibhav Jain <vaibhav@linux.vnet.ibm.com>, linuxppc-dev@lists.ozlabs.org,
 Frederic Barrat <fbarrat@linux.vnet.ibm.com>
From: Michael Ellerman <patch-notifications@ellerman.id.au>
Cc: Philippe Bergheaud <philippe.bergheaud@fr.ibm.com>,
 Alastair D'Silva <alastair@linux.ibm.com>,
 Vaibhav Jain <vaibhav@linux.vnet.ibm.com>,
 Andrew Donnellan <andrew.donnellan@au1.ibm.com>,
 Christophe Lombard <christophe_lombard@fr.ibm.com>
Subject: Re: [v2] cxl: Check if PSL data-cache is available before issue flush
 request
Message-Id: <401RGD0D76z9sVV@ozlabs.org>
Date: Wed, 14 Mar 2018 20:27:47 +1100 (AEDT)
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Thu, 2018-02-15 at 15:49:24 UTC, Vaibhav Jain wrote:
> PSL9D doesn't have a data-cache that needs to be flushed before
> resetting the card. However when cxl tries to flush data-cache on such
> a card, it times-out as PSL_Control register never indicates flush
> operation complete due to missing data-cache. This is usually
> indicated in the kernel logs with this message:
> 
> "WARNING: cache flush timed out"
> 
> To fix this the patch checks PSL_Debug register CDC-Field(BIT:27)
> which indicates the absence of a data-cache and sets a flag
> 'no_data_cache' in 'struct cxl_native' to indicate this. When
> cxl_data_cache_flush() is called it checks the flag and if set bails
> out early without requesting a data-cache flush operation to the PSL.
> 
> Signed-off-by: Vaibhav Jain <vaibhav@linux.vnet.ibm.com>
> Acked-by: Andrew Donnellan <andrew.donnellan@au1.ibm.com>
> Acked-by: Frederic Barrat <fbarrat@linux.vnet.ibm.com>

Applied to powerpc next, thanks.

https://git.kernel.org/powerpc/c/94322ed8e857e3b2a33cf75118051a

cheers
