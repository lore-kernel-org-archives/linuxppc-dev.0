Return-Path: <paulus@ozlabs.org>
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3r9xGB18NszDqCH
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 20 May 2016 15:25:06 +1000 (AEST)
Date: Fri, 20 May 2016 15:25:03 +1000
From: Paul Mackerras <paulus@ozlabs.org>
To: "Shreyas B. Prabhu" <shreyas@linux.vnet.ibm.com>
Cc: mpe@ellerman.id.au, linuxppc-dev@lists.ozlabs.org,
 linux-kernel@vger.kernel.org, mikey@neuling.org
Subject: Re: [PATCH v2 7/9] powerpc/powernv: Add platform support for stop
 instruction
Message-ID: <20160520052503.GB27460@oak.ozlabs.ibm.com>
References: <1462263878-25237-1-git-send-email-shreyas@linux.vnet.ibm.com>
 <1462263878-25237-8-git-send-email-shreyas@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1462263878-25237-8-git-send-email-shreyas@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Tue, May 03, 2016 at 01:54:36PM +0530, Shreyas B. Prabhu wrote:
> POWER ISA v3 defines a new idle processor core mechanism. In summary,
>  a) new instruction named stop is added. This instruction replaces
> 	instructions like nap, sleep, rvwinkle.
>  b) new per thread SPR named PSSCR is added which controls the behavior
> 	of stop instruction.
> 
> PSSCR has following key fields
> 	Bits 0:3  - Power-Saving Level Status. This field indicates the lowest
> 	power-saving state the thread entered since stop instruction was last
> 	executed.
> 
> 	Bit 42 - Enable State Loss
> 	0 - No state is lost irrespective of other fields
> 	1 - Allows state loss
> 
> 	Bits 44:47 - Power-Saving Level Limit
> 	This limits the power-saving level that can be entered into.
> 
> 	Bits 60:63 - Requested Level
> 	Used to specify which power-saving level must be entered on executing
> 	stop instruction
> 
> This patch adds support for stop instruction and PSSCR handling.

I notice that you have duplicated a whole lot of assembly code
relating to synchronizing between threads going into and out of
power-saving modes, saving/restoring SPRs, resyncing the timebase, and
so on.

Two questions arise:

- Are we really going to have to do all of that in the same way for
  POWER9 as we did for POWER8?  You even copied over a comment about
  the fastsleep workaround, which I really hope we won't have to do on
  POWER9.  Also, on POWER9, the threads are much more independent, so
  I was not expecting that there would still be shared registers.

- If we do have to do all that, could we use the same code as on
  POWER8 rather than having another copy of all that code?

Paul.
