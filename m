Return-Path: <michael@ozlabs.org>
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3t105z0bTczDvcx
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 22 Oct 2016 09:02:31 +1100 (AEDT)
In-Reply-To: <1476437916-31010-1-git-send-email-vaibhav@linux.vnet.ibm.com>
To: Vaibhav Jain <vaibhav@linux.vnet.ibm.com>, linuxppc-dev@lists.ozlabs.org,
 Frederic Barrat <fbarrat@linux.vnet.ibm.com>
From: Michael Ellerman <patch-notifications@ellerman.id.au>
Cc: Philippe Bergheaud <philippe.bergheaud@fr.ibm.com>,
 Christophe Lombard <clombard@linux.vnet.ibm.com>,
 Vaibhav Jain <vaibhav@linux.vnet.ibm.com>, stable@vger.kernel.org,
 Ian Munsie <imunsie@au1.ibm.com>,
 Andrew Donnellan <andrew.donnellan@au1.ibm.com>, gkurz@linux.vnet.ibm.com
Subject: Re: [RESEND,
 v3] cxl: Prevent adapter reset if an active context exists
Message-Id: <3t105y6r6cz9svs@ozlabs.org>
Date: Sat, 22 Oct 2016 09:02:30 +1100 (AEDT)
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Fri, 2016-14-10 at 09:38:36 UTC, Vaibhav Jain wrote:
> This patch prevents resetting the cxl adapter via sysfs in presence of
> one or more active cxl_context on it. This protects against an
> unrecoverable error caused by PSL owning a dirty cache line even after
> reset and host tries to touch the same cache line. In case a force reset
> of the card is required irrespective of any active contexts, the int
> value -1 can be stored in the 'reset' sysfs attribute of the card.
> 
> The patch introduces a new atomic_t member named contexts_num inside
> struct cxl that holds the number of active context attached to the card
> , which is checked against '0' before proceeding with the reset. To
> prevent against a race condition where a context is activated just after
> reset check is performed, the contexts_num is atomically set to '-1'
> after reset-check to indicate that no more contexts can be activated on
> the card anymore.
> 
> Before activating a context we atomically test if contexts_num is
> non-negative and if so, increment its value by one. In case the value of
> contexts_num is negative then it indicates that the card is about to be
> reset and context activation is error-ed out at that point.
> 
> Cc: stable@vger.kernel.org
> Fixes: 62fa19d4 ("cxl: Add ability to reset the card")
> Acked-by: Frederic Barrat <fbarrat@linux.vnet.ibm.com>
> Reviewed-by: Andrew Donnellan <andrew.donnellan@au1.ibm.com>
> Signed-off-by: Vaibhav Jain <vaibhav@linux.vnet.ibm.com>

Applied to powerpc fixes, thanks.

https://git.kernel.org/powerpc/c/70b565bbdb911023373e035225ab10

cheers
