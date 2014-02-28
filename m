Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id 979EC2C009A
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 28 Feb 2014 18:46:44 +1100 (EST)
Message-ID: <1393573588.22449.4.camel@pasglop>
Subject: Re: [RFC PATCH] powerpc: allow allyesconfig to build more
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Michael Neuling <mikey@neuling.org>
Date: Fri, 28 Feb 2014 18:46:28 +1100
In-Reply-To: <5087.1393560369@ale.ozlabs.ibm.com>
References: <20140227171719.01d7de4be01559dd02968f7c@canb.auug.org.au>
 <5087.1393560369@ale.ozlabs.ibm.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Cc: Stephen Rothwell <sfr@canb.auug.org.au>,
 ppc-dev <linuxppc-dev@lists.ozlabs.org>, paulus@samba.org,
 Mahesh Salgaonkar <mahesh@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Fri, 2014-02-28 at 15:06 +1100, Michael Neuling wrote:
> Stephen Rothwell <sfr@canb.auug.org.au> wrote:
> 
> > Fixes this build error:
> > 
> > arch/powerpc/kernel/exceptions-64s.S: Assembler messages:
> > arch/powerpc/kernel/exceptions-64s.S:1312: Error: attempt to move .org backwards
> > 
> > Signed-off-by: Stephen Rothwell <sfr@canb.auug.org.au>
> 
> Builds and boots for me
> 
> Acked-off-by: Michael Neuling <mikey@neuling.org>
> 

And breaks at least one of my configs (the g5 one) with a relocation
problem in head_64.o (which is why I had modified the original patch to
be less aggressive iirc).

We end up moving things too far away from a conditional branch, I
think the masked_*interrupt stuff. We need to shuffle things a bit
more to get that to work.

Cheers,
Ben.
