Return-Path: <michael@ozlabs.org>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 7B3431A02DF
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 21 Oct 2015 22:41:43 +1100 (AEDT)
In-Reply-To: <1444276739-20372-2-git-send-email-gwshan@linux.vnet.ibm.com>
To: Gavin Shan <gwshan@linux.vnet.ibm.com>, linuxppc-dev@ozlabs.org
From: Michael Ellerman <mpe@ellerman.id.au>
Cc: Gavin Shan <gwshan@linux.vnet.ibm.com>
Subject: Re: [v2,1/8] powerpc/eeh: Don't unfreeze PHB PE after reset
Message-Id: <20151021114143.4E96614076E@ozlabs.org>
Date: Wed, 21 Oct 2015 22:41:43 +1100 (AEDT)
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Thu, 2015-08-10 at 03:58:52 UTC, Gavin Shan wrote:
> On PowerNV platform, the PE is kept in frozen state until the PE
> reset is completed to avoid recursive EEH error caused by MMIO
> access during the period of EEH reset. The PE's frozen state is
> cleared after BARs of PCI device included in the PE are restored
> and enabled. However, we needn't clear the frozen state for PHB PE
> explicitly at this point as there is no real PE for PHB PE. As the
> PHB PE is always binding with PE#0, we actually clear PE#0, which
> is wrong. It doesn't incur any problem though.
> 
> This checks if the PE is PHB PE and doesn't clear the frozen state
> if it is.
> 
> Signed-off-by: Gavin Shan <gwshan@linux.vnet.ibm.com>

Series applied to powerpc next, thanks.

https://git.kernel.org/powerpc/c/527d10ef3a315d3cb9dc098d

cheers
