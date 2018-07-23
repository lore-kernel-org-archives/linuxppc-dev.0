Return-Path: <michael@ozlabs.org>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 41Z4h41sxRzF07t
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 24 Jul 2018 01:11:16 +1000 (AEST)
In-Reply-To: <20180704152833.2288-1-vaibhav@linux.ibm.com>
To: Vaibhav Jain <vaibhav@linux.ibm.com>, linuxppc-dev@lists.ozlabs.org,
 Frederic Barrat <fbarrat@linux.ibm.com>,
 Andrew Donnellan <andrew.donnellan@au1.ibm.com>,
 Dan Carpenter <dan.carpenter@oracle.com>
From: Michael Ellerman <patch-notifications@ellerman.id.au>
Cc: Philippe Bergheaud <philippe.bergheaud@fr.ibm.com>,
 Vaibhav Jain <vaibhav@linux.ibm.com>,
 Alastair D'Silva <alastair@linux.ibm.com>,
 Christophe Lombard <christophe_lombard@fr.ibm.com>, stable@vger.kernel.org
Subject: Re: cxl: Fix wrong comparison in cxl_adapter_context_get()
Message-Id: <41Z4h41040z9s0R@ozlabs.org>
Date: Tue, 24 Jul 2018 01:11:16 +1000 (AEST)
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Wed, 2018-07-04 at 15:28:33 UTC, Vaibhav Jain wrote:
> Function atomic_inc_unless_negative() returns a bool to indicate
> success/failure. However cxl_adapter_context_get() wrongly compares
> the return value against '>=0' which will always be true. The patch
> fixes this comparison to '==0' there by also fixing this compile time
> warning:
> 
> 	drivers/misc/cxl/main.c:290 cxl_adapter_context_get()
> 	warn: 'atomic_inc_unless_negative(&adapter->contexts_num)' is unsigned
> 
> Cc: stable@vger.kernel.org
> Fixes: 70b565bbdb91 ("cxl: Prevent adapter reset if an active context exists")
> Reported-by: Dan Carpenter <dan.carpenter@oracle.com>
> Signed-off-by: Vaibhav Jain <vaibhav@linux.ibm.com>
> Acked-by: Andrew Donnellan <andrew.donnellan@au1.ibm.com>
> Acked-by: Frederic Barrat <fbarrat@linux.vnet.ibm.com>

Applied to powerpc next, thanks.

https://git.kernel.org/powerpc/c/ef6cb5f1a048fdf91ccee6d63d2bfa

cheers
