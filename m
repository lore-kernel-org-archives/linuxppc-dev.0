Return-Path: <paulus@ozlabs.org>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3yMlVm6fJ9zDqty
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 26 Oct 2017 09:41:36 +1100 (AEDT)
Date: Thu, 26 Oct 2017 09:41:32 +1100
From: Paul Mackerras <paulus@ozlabs.org>
To: Nicholas Piggin <npiggin@au1.ibm.com>
Cc: Michael Ellerman <michael@ellerman.id.au>, linuxppc-dev@ozlabs.org,
 Markus Trippelsdorf <markus@trippelsdorf.de>
Subject: Re: [PATCH] powerpc: Fix check for copy/paste instructions in
 alignment handler
Message-ID: <20171025224132.GA31641@fergus.ozlabs.ibm.com>
References: <OFF18C8ACF.135B0A8D-ON002581C4.002803F5@notes.na.collabserv.com>
 <20171026012237.0320e540@roar.ozlabs.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20171026012237.0320e540@roar.ozlabs.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Thu, Oct 26, 2017 at 01:22:37AM +1000, Nicholas Piggin wrote:
> On Wed, 25 Oct 2017 18:16:53 +1100
> Paul Mackerras <paulus@ozlabs.org> wrote:
> 
> > Commit 07d2a628bc00 ("powerpc/64s: Avoid cpabort in context switch
> > when possible", 2017-06-09) changed the definition of PPC_INST_COPY
> > and in so doing inadvertently broke the check for copy/paste
> > instructions in the alignment fault handler.  The check currently
> > matches no instructions.
> > 
> > This fixes it by ANDing both sides of the comparison with the mask.
> 
> Thanks for fixing it. Any reason not to change the mask to 0xfc2006fe
> to include the 'last' bit that is now mandatory?

What does real hardware do if you execute the instruction without that
bit set?  Does it take the alignment interrupt, or does it take an
illegal instruction interrupt (i.e. HEAI)?  We need to catch all the
variants that take an alignment interrupt.  If P9 hardware takes a
HEAI when that bit isn't set, then I'm fine with changing the mask.

Paul.
