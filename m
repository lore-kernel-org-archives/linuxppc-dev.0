Return-Path: <michael@ozlabs.org>
Received: from ozlabs.org (bilbo.ozlabs.org [203.11.71.1])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 40Ln4T16bPzF1R7
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 12 Apr 2018 00:49:29 +1000 (AEST)
In-Reply-To: <20180329062337.29437-1-khandual@linux.vnet.ibm.com>
To: Anshuman Khandual <khandual@linux.vnet.ibm.com>,
 linuxppc-dev@lists.ozlabs.org
From: Michael Ellerman <patch-notifications@ellerman.id.au>
Subject: Re: [V2] powerpc/fscr: Enable interrupts earlier before calling
 get_user()
Message-Id: <40Ln4T02ZMz9s3B@ozlabs.org>
Date: Thu, 12 Apr 2018 00:49:28 +1000 (AEST)
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Thu, 2018-03-29 at 06:23:37 UTC, Anshuman Khandual wrote:
> The function get_user() can sleep while trying to fetch instruction
> from user address space and causes the following warning from the
> scheduler.
> 
> BUG: sleeping function called from invalid context
> 
> Though interrupts get enabled back but it happens bit later after
> get_user() is called. This change moves enabling these interrupts
> earlier covering the function get_user(). While at this, lets check
> for kernel mode and crash as this interrupt should not have been
> triggered from the kernel context.
> 
> Signed-off-by: Anshuman Khandual <khandual@linux.vnet.ibm.com>

Applied to powerpc fixes, thanks.

https://git.kernel.org/powerpc/c/709b973c844c0b4d115ac3a227a2e5

cheers
