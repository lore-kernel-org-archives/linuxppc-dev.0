Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3rzHlP6bdtzDrDv
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 26 Jul 2016 22:40:17 +1000 (AEST)
Message-ID: <1469535674.5978.73.camel@kernel.crashing.org>
Subject: Re: [RFC PATCH 0/9]powerpc: "paca->soft_enabled" based local atomic
 operation implementation
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Madhavan Srinivasan <maddy@linux.vnet.ibm.com>, mpe@ellerman.id.au,
 anton@samba.org, paulus@samba.org
Cc: linuxppc-dev@lists.ozlabs.org
Date: Tue, 26 Jul 2016 22:21:14 +1000
In-Reply-To: <1469458342-26233-1-git-send-email-maddy@linux.vnet.ibm.com>
References: <1469458342-26233-1-git-send-email-maddy@linux.vnet.ibm.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Mon, 2016-07-25 at 20:22 +0530, Madhavan Srinivasan wrote:
> But this patchset uses Benjamin Herrenschmidt suggestion of using
> arch_local_irq_disable_var() to soft_disable interrupts (including PMIs).
> After finishing the "op", arch_local_irq_restore() called and correspondingly
> interrupts are replayed if any occured.

I am not fan of "var", we probably want "level".

Also be careful, you might be already soft-disabled at level 1, you
must restore to level 1, not level 0 in that case. Might want to
actually return the level in "flags" and restore that.

Cheers,
Ben.
