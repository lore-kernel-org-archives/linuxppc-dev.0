Return-Path: <segher@gate.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4504B1A084F
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 12 Jun 2014 22:27:16 +1000 (EST)
Date: Thu, 12 Jun 2014 07:26:39 -0500
From: Segher Boessenkool <segher@kernel.crashing.org>
To: Gabriel Paubert <paubert@iram.es>
Subject: Re: power and percpu: Could we move the paca into the percpu area?
Message-ID: <20140612122639.GA17838@gate.crashing.org>
References: <alpine.DEB.2.10.1406111426480.10600@gentwo.org>
 <1402518131.14780.60.camel@pasglop> <20140611210351.GA7155@visitor2.iram.es>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20140611210351.GA7155@visitor2.iram.es>
Cc: Tejun Heo <htejun@gmail.com>, linuxppc-dev@lists.ozlabs.org,
 Christoph Lameter <cl@gentwo.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

> Actually, from gcc/config/rs6000.h:
> 
> /* 1 for registers that have pervasive standard uses
>    and are not available for the register allocator.

[snip]

> So cr5, which is number 73, is never used by gcc. 

Not available for RA is not the same thing at all as not used by GCC.
For example, GPR1 and XER[CA] are also fixed regs.

But, indeed, it does look like GCC doesn't use it.  It seems to me that
some ABI forbade userland (or non-libraries or whatever) from using it.
I'll see what I can find out.


Segher
