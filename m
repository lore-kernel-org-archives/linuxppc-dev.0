Return-Path: <mpe@ellerman.id.au>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id B9CB61A0DF0
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 23 Jan 2015 15:20:22 +1100 (AEDT)
Message-ID: <1421986821.24984.12.camel@ellerman.id.au>
Subject: Re: [PATCH v2 1/2] powerpc: Add helpers for LPCR PECE1 operations
From: Michael Ellerman <mpe@ellerman.id.au>
To: Shreyas B Prabhu <shreyas@linux.vnet.ibm.com>
Date: Fri, 23 Jan 2015 15:20:21 +1100
In-Reply-To: <54C1C411.2080703@linux.vnet.ibm.com>
References: <1421654727-31656-1-git-send-email-shreyas@linux.vnet.ibm.com>
 <1421982392.24984.9.camel@ellerman.id.au>
 <54C1C411.2080703@linux.vnet.ibm.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Cc: linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Fri, 2015-01-23 at 09:16 +0530, Shreyas B Prabhu wrote:
> 
> On Friday 23 January 2015 08:36 AM, Michael Ellerman wrote:
> > On Mon, 2015-01-19 at 13:35 +0530, Shreyas B. Prabhu wrote:
> >> PECE1 bit in LPCR is used to control whether decrementer can cause exit
> >> from powersaving states. PECE1 bit is cleared before entering fastsleep
> >> or deeper powersaving state and it is set on waking up. Since both
> >> cpuidle and cpu offline operations use these powersaving states, add
> >> helper functions to be used in both these places.
> > 
> > Thanks.
> > 
> > That isn't really much clearer than the original, so in the end I just merged
> > your original fix.
> > 
> > I'll think if there's a bigger consolidation we can do that makes it clearer.
>
> Helper could have been this :
> 
> #define   LPCR_CLEAR_PECE1	(mfspr(SPRN_LPCR) & ~(u64)LPCR_PECE1)
> 
> This perhaps would make it more clearer, but it will end up using additional mfspr here-
 
Yeah.

Maybe we just leave it open coded, I'll have a think about it.

cheers
