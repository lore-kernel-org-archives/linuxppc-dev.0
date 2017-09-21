Return-Path: <michael@ozlabs.org>
Received: from ozlabs.org (bilbo.ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3xyKGW6TQ3zDqXn
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 21 Sep 2017 11:46:43 +1000 (AEST)
In-Reply-To: <20170915100821.7254-1-naveen.n.rao@linux.vnet.ibm.com>
To: "Naveen N. Rao" <naveen.n.rao@linux.vnet.ibm.com>
From: Michael Ellerman <patch-notifications@ellerman.id.au>
Cc: Anju T Sudhakar <anju@linux.vnet.ibm.com>, linuxppc-dev@lists.ozlabs.org
Subject: Re: powerpc/kprobes: Update optprobes to use emulate_update_regs()
Message-Id: <3xyKGW4mR8z9sNr@ozlabs.org>
Date: Thu, 21 Sep 2017 11:46:43 +1000 (AEST)
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Fri, 2017-09-15 at 10:08:21 UTC, "Naveen N. Rao" wrote:
> Optprobes depended on an updated regs->nip from analyse_instr() to
> identify the location to branch back from the optprobes trampoline.
> However, since commit 3cdfcbfd32b9d ("powerpc: Change analyse_instr so
> it doesn't modify *regs"), analyse_instr() doesn't update the registers
> anymore.  Due to this, we end up branching back from the optprobes
> trampoline to the same branch into the trampoline resulting in a loop.
> 
> Fix this by calling out to emulate_update_regs() before using the nip.
> Additionally, explicitly compare the return value from analyse_instr()
> to 1, rather than just checking for !0 so as to guard against any
> future changes to analyse_instr() that may result in -1 being returned
> in more scenarios.
> 
> Fixes: 3cdfcbfd32b9d ("powerpc: Change analyse_instr so it doesn't modify *regs")
> Signed-off-by: Naveen N. Rao <naveen.n.rao@linux.vnet.ibm.com>

Applied to powerpc fixes, thanks.

https://git.kernel.org/powerpc/c/8afafa6fba7809c0785018b77c95b1

cheers
