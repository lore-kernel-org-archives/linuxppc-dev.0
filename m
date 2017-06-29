Return-Path: <michael@ozlabs.org>
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3wyzKM0XPFzDr4R
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 29 Jun 2017 22:21:11 +1000 (AEST)
In-Reply-To: <20170615015316.17070-1-mikey@neuling.org>
To: Michael Neuling <mikey@neuling.org>
From: Michael Ellerman <patch-notifications@ellerman.id.au>
Cc: mikey@neuling.org, linuxppc-dev@lists.ozlabs.org
Subject: Re: powerpc: Fix /proc/cpuinfo revision for POWER9 DD2
Message-Id: <3wyzKM03L9z9s8H@ozlabs.org>
Date: Thu, 29 Jun 2017 22:21:10 +1000 (AEST)
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Thu, 2017-06-15 at 01:53:16 UTC, Michael Neuling wrote:
> The P9 PVR bits 12-15 don't indicate a revision but instead different
> chip configurations.  From BookIV we have:
>    Bits      Configuration
>     0 :    Scale out 12 cores
>     1 :    Scale out 24 cores
>     2 :    Scale up  12 cores
>     3 :    Scale up  24 cores
> 
> DD1 doesn't use this but DD2 does. Linux will mostly use the "Scale
> out 24 core" configuration (ie. SMT4 not SMT8) which results in a PVR
> of 0x004e1200. The reported revision in /proc/cpuinfo is hence
> reported incorrectly as "18.0".
> 
> This patch fixes this to mask off only the relevant bits for the major
> revision (ie. bits 8-11) for POWER9.
> 
> Signed-off-by: Michael Neuling <mikey@neuling.org>

Applied to powerpc next, thanks.

https://git.kernel.org/powerpc/c/64ebb9a208c6e66316329a6d910181

cheers
