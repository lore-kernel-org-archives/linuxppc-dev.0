Return-Path: <ego@linux.vnet.ibm.com>
Received: from e33.co.us.ibm.com (e33.co.us.ibm.com [32.97.110.151])
 (using TLSv1.2 with cipher CAMELLIA256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3rF0bZ6kZHzDqRn
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 25 May 2016 15:05:46 +1000 (AEST)
Received: from localhost
 by e33.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <ego@linux.vnet.ibm.com>;
 Tue, 24 May 2016 23:05:44 -0600
Date: Wed, 25 May 2016 10:35:36 +0530
From: Gautham R Shenoy <ego@linux.vnet.ibm.com>
To: "Shreyas B. Prabhu" <shreyas@linux.vnet.ibm.com>
Cc: mpe@ellerman.id.au, linuxppc-dev@lists.ozlabs.org, paulus@ozlabs.org,
 linux-kernel@vger.kernel.org, mikey@neuling.org,
 ego@linux.vnet.ibm.com, maddy@linux.vnet.ibm.com
Subject: Re: [PATCH v4 08/10] powerpc/powernv: Add platform support for stop
 instruction
Message-ID: <20160525050536.GA16463@in.ibm.com>
Reply-To: ego@linux.vnet.ibm.com
References: <1464095714-48772-1-git-send-email-shreyas@linux.vnet.ibm.com>
 <1464095714-48772-9-git-send-email-shreyas@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1464095714-48772-9-git-send-email-shreyas@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Hi Shreyas,

On Tue, May 24, 2016 at 06:45:12PM +0530, Shreyas B. Prabhu wrote:
> POWER ISA v3 defines a new idle processor core mechanism. In summary,
>  a) new instruction named stop is added. This instruction replaces
> 	instructions like nap, sleep, rvwinkle.
>  b) new per thread SPR named Processor Stop Status and Control Register
> 	(PSSCR) is added which controls the behavior of stop instruction.
> 
> PSSCR layout:
> ----------------------------------------------------------
> | PLS | /// | SD | ESL | EC | PSLL | /// | TR | MTL | RL |
> ----------------------------------------------------------
> 0      4     41   42    43   44     48    54   56    60
> 
> PSSCR key fields:
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

This version looks good to me.

Reviewed-by: Gautham R. Shenoy <ego@linux.vnet.ibm.com>

--
Thanks and Regards
gautham.
