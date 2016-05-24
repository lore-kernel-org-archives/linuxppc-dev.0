Return-Path: <paulus@ozlabs.org>
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3rDyj04MxxzDqKX
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 25 May 2016 13:40:20 +1000 (AEST)
Date: Wed, 25 May 2016 08:21:56 +1000
From: Paul Mackerras <paulus@ozlabs.org>
To: Gabriel Paubert <paubert@iram.es>
Cc: Christophe Leroy <christophe.leroy@c-s.fr>,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Michael Ellerman <mpe@ellerman.id.au>,
 Scott Wood <oss@buserror.net>, linuxppc-dev@lists.ozlabs.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH] powerpc: inline current_stack_pointer()
Message-ID: <20160524222156.GA7963@fergus.ozlabs.ibm.com>
References: <20160523084602.53F771A239A@localhost.localdomain>
 <20160523171738.GA15830@visitor2.iram.es>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20160523171738.GA15830@visitor2.iram.es>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Mon, May 23, 2016 at 07:17:38PM +0200, Gabriel Paubert wrote:
> On Mon, May 23, 2016 at 10:46:02AM +0200, Christophe Leroy wrote:
> > current_stack_pointeur() is a single instruction function. it
> > It is not worth breaking the execution flow with a bl/blr for a
> > single instruction
> 
> Are you sure that the result is always the same? 
> 
> Calling an external function prevents the compiler from considering the
> caller of of current_stack_pointer a leaf function, which certainly 
> does not help the compiler, but in a leaf function the compiler is free 
> not to establish a new frame.
> 
> If the compiler decides to establishes a new frame (typically with 
> "stwu r1,-frame_size(r1)"), *r1 is the previous stack pointer, or
> the caller's stack pointer, or the current function frame pointer if
> I remember correctly the ABI definitions. 
> 
> However, if the compiler decides that it can get away without a frame
> for the function, *r1 is the stack pointer of the caller's caller.
> 
> Depending on the application, this may or may not be important.

Right.  I think I wrote the original current_stack_pointer()
implementation, and that I deliberately didn't make it an inline
so that the caller would have to establish its own stack frame,
and thus its stack pointer value would be a well-defined thing.

Paul.
