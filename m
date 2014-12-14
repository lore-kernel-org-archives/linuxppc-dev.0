Return-Path: <michael@ozlabs.org>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 543761A020A
 for <linuxppc-dev@lists.ozlabs.org>; Sun, 14 Dec 2014 21:05:59 +1100 (AEDT)
In-Reply-To: <1418151413-6141-2-git-send-email-shreyas@linux.vnet.ibm.com>
To: "Shreyas B. Prabhu" <shreyas@linux.vnet.ibm.com>,
 linux-kernel@vger.kernel.org
From: Michael Ellerman <mpe@ellerman.id.au>
Subject: Re: [v4, 1/4] powerpc: powernv: Switch off MMU before entering
 nap/sleep/rvwinkle mode
Message-Id: <20141214100559.278C71400EA@ozlabs.org>
Date: Sun, 14 Dec 2014 21:05:59 +1100 (AEDT)
Cc: "Shreyas B. Prabhu" <shreyas@linux.vnet.ibm.com>,
 linuxppc-dev@lists.ozlabs.org, Paul Mackerras <paulus@samba.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Tue, 2014-09-12 at 18:56:50 UTC, "Shreyas B. Prabhu" wrote:
> From: Paul Mackerras <paulus@samba.org>
> 
> Currently, when going idle, we set the flag indicating that we are in
> nap mode (paca->kvm_hstate.hwthread_state) and then execute the nap
> (or sleep or rvwinkle) instruction, all with the MMU on.  This is bad
> for two reasons: (a) the architecture specifies that those instructions
> must be executed with the MMU off, and in fact with only the SF, HV, ME
> and possibly RI bits set, and (b) this introduces a race, because as
> soon as we set the flag, another thread can switch the MMU to a guest
> context.  If the race is lost, this thread will typically start looping
> on relocation-on ISIs at 0xc...4400.
> 
> This fixes it by setting the MSR as required by the architecture before
> setting the flag or executing the nap/sleep/rvwinkle instruction.
> 
> [ shreyas@linux.vnet.ibm.com: Edited to handle LE ]
> Signed-off-by: Paul Mackerras <paulus@samba.org>
> Signed-off-by: Shreyas B. Prabhu <shreyas@linux.vnet.ibm.com>
> Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>
> Cc: Michael Ellerman <mpe@ellerman.id.au>
> Cc: linuxppc-dev@lists.ozlabs.org

I'm going to CC this to stable unless anyone objects. It's not something people
are likely to hit, but the result is fairly catastrophic.

cheers
