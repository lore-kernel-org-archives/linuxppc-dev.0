Return-Path: <segher@gate.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3rDQ342NSDzDq5W
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 24 May 2016 16:09:04 +1000 (AEST)
Date: Tue, 24 May 2016 01:08:39 -0500
From: Segher Boessenkool <segher@kernel.crashing.org>
To: Christophe Leroy <christophe.leroy@c-s.fr>
Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Paul Mackerras <paulus@samba.org>,
 Michael Ellerman <mpe@ellerman.id.au>, Scott Wood <oss@buserror.net>,
 linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] powerpc: inline current_stack_pointer()
Message-ID: <20160524060839.GA6492@gate.crashing.org>
References: <20160523084602.53F771A239A@localhost.localdomain>
 <20160523202214.GB11583@gate.crashing.org>
 <61305e9e-ed63-6915-709c-dd8797ff1fba@c-s.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <61305e9e-ed63-6915-709c-dd8797ff1fba@c-s.fr>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Tue, May 24, 2016 at 07:39:59AM +0200, Christophe Leroy wrote:
> >>+static inline unsigned long current_stack_pointer(void)
> >>+{
> >>+	register unsigned long *ptr asm("r1");
> >>+
> >>+	return *ptr;
> >>+}
> >Register asm is only guaranteed to work as input to inline asm.  NAK.
> >
> Does it mean that the following declaration in 
> arch/powerpc/include/asm/paca.h is wrong too ?
> 
> register struct paca_struct *local_paca asm("r13");

That one is fine, because it is a global var.

https://gcc.gnu.org/onlinedocs/gcc/Explicit-Register-Variables.html


Segher
