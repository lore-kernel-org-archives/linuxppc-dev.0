Return-Path: <segher@gate.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3rGGJm3BkSzDqYC
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 27 May 2016 16:27:20 +1000 (AEST)
Date: Fri, 27 May 2016 01:26:53 -0500
From: Segher Boessenkool <segher@kernel.crashing.org>
To: Christophe Leroy <christophe.leroy@c-s.fr>
Cc: Anton Blanchard <anton@samba.org>,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Michael Ellerman <mpe@ellerman.id.au>,
 Paul Mackerras <paulus@samba.org>, acsawdey@linux.vnet.ibm.com,
 linuxppc-dev@lists.ozlabs.org
Subject: Re: [PATCH 2/2] powerpc: Align hot loops of some string functions
Message-ID: <20160527062653.GC4267@gate.crashing.org>
References: <20160526083813.0f96a454@kryten> <20160526083955.3f7deda4@kryten>
 <14a46745-dd1e-2963-1c1a-7daafa5aed4b@c-s.fr>
 <20160526193728.GA883@gate.crashing.org>
 <91429364-b0f4-89c2-dc92-1cc40970d3e3@c-s.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <91429364-b0f4-89c2-dc92-1cc40970d3e3@c-s.fr>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Fri, May 27, 2016 at 07:45:18AM +0200, Christophe Leroy wrote:
> >>Wouldn't it be better to add nops before the function entry in order to
> >>get the hot loop aligned, instead of adding nops in the middle of the
> >>function ?
> >Why would that be better?  The nops are executed once per function call
> >in either case, there are the same number of nops in either case, and
> >on most CPUs nops aren't actually executed anyway (they are decoded and
> >the thrown away).
> >
> The idea was to not execute them:
> 
> |.balign 16 nop nop _GLOBAL(strcpy) addi	r5,r3,-1 addi	r4,r4,-1 1: 
> lbzu r0,1(r4) cmpwi	0,r0,0 stbu	r0,1(r5) bne	1b blr |

That performs _worse_ on most modern CPUs (the first decode will decode
less, so instructions are available for execution later).  That's why
functions are aligned in the first place!


Segher
