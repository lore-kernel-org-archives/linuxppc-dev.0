Return-Path: <segher@gate.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3sFWxc6DMXzDr5c
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 19 Aug 2016 02:38:28 +1000 (AEST)
Date: Thu, 18 Aug 2016 11:34:31 -0500
From: Segher Boessenkool <segher@kernel.crashing.org>
To: Christophe Leroy <christophe.leroy@c-s.fr>
Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Paul Mackerras <paulus@samba.org>,
 Michael Ellerman <mpe@ellerman.id.au>, Scott Wood <oss@buserror.net>,
 linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] powerpc/8xx: use SPRN_EIE and SPRN_EID to enable/disable
 interrupts
Message-ID: <20160818163431.GB24467@gate.crashing.org>
References: <20160818155602.DAD601A2459@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20160818155602.DAD601A2459@localhost.localdomain>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Thu, Aug 18, 2016 at 05:56:02PM +0200, Christophe Leroy wrote:
> The 8xx has two special registers called EID (External Interrupt
> Disable) and EIE (External Interrupt Enable) for clearing/setting
> EE in MSR. It avoids the three instructions set mfmsr/ori/mtmsr or
> mfmsr/rlwinm/mtmsr.

All 8xx?  What other models?  (5xx for example).

> +/* Special MSR manipulation registers */
> +#define SPRN_EIE	80	/* External interrupt enable (EE=1, RI=1) */
> +#define SPRN_EID	81	/* External interrupt disable (EE=0, RI=1) */
> +#define SPRN_NRI	81	/* Non Recoverable interrupt (EE=0, RI=0) */

This is wrong (NRI is 82).  Don't write code you cannot test / don't submit
code you haven't tested?  :-)


Segher
