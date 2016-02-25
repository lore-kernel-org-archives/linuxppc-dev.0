Return-Path: <duwe@lst.de>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 7C2D01A00A5
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 26 Feb 2016 01:02:07 +1100 (AEDT)
Received: from newverein.lst.de (verein.lst.de [213.95.11.211])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id 13F3F140324
 for <linuxppc-dev@ozlabs.org>; Fri, 26 Feb 2016 01:02:07 +1100 (AEDT)
Date: Thu, 25 Feb 2016 15:02:04 +0100
From: Torsten Duwe <duwe@lst.de>
To: Balbir Singh <bsingharora@gmail.com>
Cc: Michael Ellerman <mpe@ellerman.id.au>, linuxppc-dev@ozlabs.org,
 linux-kernel@vger.kernel.org, rostedt@goodmis.org,
 kamalesh@linux.vnet.ibm.com, pmladek@suse.com, jeyu@redhat.com,
 jkosina@suse.cz, live-patching@vger.kernel.org, mbenes@suse.cz
Subject: Re: [PATCH 05/12] powerpc/ftrace: ftrace_graph_caller() needs to
 save/restore toc
Message-ID: <20160225140204.GG21932@lst.de>
References: <1456324115-21144-1-git-send-email-mpe@ellerman.id.au>
 <1456324115-21144-5-git-send-email-mpe@ellerman.id.au>
 <56CE4B2E.7070505@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <56CE4B2E.7070505@gmail.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Thu, Feb 25, 2016 at 11:30:38AM +1100, Balbir Singh wrote:
> On 25/02/16 01:28, Michael Ellerman wrote:
> > Signed-off-by: Michael Ellerman <mpe@ellerman.id.au>
> > ---
> >  arch/powerpc/kernel/entry_64.S | 8 ++++++++
> >  1 file changed, 8 insertions(+)
> >

Ah, -mprofile-kernel, DYNAMIC_FTRACE but without REGS.
Hadn't considered that, thanks!

> >
> > diff --git a/arch/powerpc/kernel/entry_64.S b/arch/powerpc/kernel/entry_64.S
> > index 2a7313cfbc7d..9e77a2c8f218 100644
> > --- a/arch/powerpc/kernel/entry_64.S
> > +++ b/arch/powerpc/kernel/entry_64.S
> > @@ -1237,6 +1237,11 @@ _GLOBAL(ftrace_graph_caller)
> >  	std	r5, 64(r1)
> >  	std	r4, 56(r1)
> >  	std	r3, 48(r1)
> > +
> > +	/* Save callee's TOC in the ABI compliant location */
> > +	std	r2, 24(r1)
> R2_STACK_OFFSET for readability?

I have encountered LRSAVE vs. PPC_LR_STKOFF and
STK_GOT vs. R2_STACK_OFFSET, some usable in assembler source, some in C.

> > +	ld	r2, PACATOC(r13)	/* get kernel TOC in r2 */
> > +
> >  	mfctr	r4		/* ftrace_caller has moved local addr here */
> >  	std	r4, 40(r1)
> >  	mflr	r3		/* ftrace_caller has restored LR from stack */
> > @@ -1262,6 +1267,9 @@ _GLOBAL(ftrace_graph_caller)
> >  	ld	r4, 56(r1)
> >  	ld	r3, 48(r1)
> >  
> > +	/* Restore callee's TOC */
> > +	ld	r2, 24(r1)
> > +
> >  	addi	r1, r1, 112
> >  	mflr	r0
> >  	std	r0, LRSAVE(r1)
> 
> Reviewed-by: Balbir Singh <bsingharora@gmail.com>

Reviewed-by: Torsten Duwe <duwe@suse.de>

	Torsten
