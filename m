Return-Path: <segher@gate.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id A82C11A01FC
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 29 Nov 2014 02:57:44 +1100 (AEDT)
Date: Fri, 28 Nov 2014 09:57:20 -0600
From: Segher Boessenkool <segher@kernel.crashing.org>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: Re: [RFC PATCH 1/2]powerpc: foundation code to handle CR5 for local_t
Message-ID: <20141128155720.GA28943@gate.crashing.org>
References: <1417090721-25298-1-git-send-email-maddy@linux.vnet.ibm.com>
 <1417090721-25298-2-git-send-email-maddy@linux.vnet.ibm.com>
 <20141127165650.GA28278@gate.crashing.org>
 <1417139935.2852.19.camel@kernel.crashing.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1417139935.2852.19.camel@kernel.crashing.org>
Cc: linuxppc-dev@lists.ozlabs.org, rusty@rustcorp.com.au,
 Madhavan Srinivasan <maddy@linux.vnet.ibm.com>, paulus@samba.org,
 anton@samba.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Fri, Nov 28, 2014 at 12:58:55PM +1100, Benjamin Herrenschmidt wrote:
> > Have you tested this with (upcoming) GCC 5.0?  GCC now uses CR5,
> > and it likes to use it very much, it might be more convenient to
> > use e.g. CR1 (which is allocated almost last, only before CR0).
> 
> We use CR1 all over the place in your asm code. Any other suggestion ?
> 
> What's the damage of -ffixed-cr5 on gcc5 ? won't it just use CR4 or 6
> instead ?

Oh, it will work fine.  Not using CR5 would be more convenient so that
the register allocation for most code would not change when you use or
not use -ffixed-cr5, making code easier to read.  But your point about
asm code already using the other CR fields makes CR5 a better choice
actually, because people avoided it (because the compiler did) :-)


Segher
