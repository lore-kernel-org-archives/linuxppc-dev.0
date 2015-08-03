Return-Path: <mpe@ellerman.id.au>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 8A2D81A0631
 for <linuxppc-dev@lists.ozlabs.org>; Mon,  3 Aug 2015 10:43:25 +1000 (AEST)
Message-ID: <1438562604.8863.1.camel@ellerman.id.au>
Subject: Re: [PATCH] cxl: Fix ambiguous else warnings
From: Michael Ellerman <mpe@ellerman.id.au>
To: Daniel Axtens <dja@axtens.net>
Cc: Andreas Schwab <schwab@linux-m68k.org>, Thomas Huth <thuth@redhat.com>,
 linuxppc-dev@ozlabs.org, mikey@neuling.org, imunsie@au.ibm.com
Date: Mon, 03 Aug 2015 10:43:24 +1000
In-Reply-To: <1438562207.31010.14.camel@axtens.net>
References: <1438324508-30341-1-git-send-email-dja__13473.5064967119$1438324749$gmane$org@axtens.net>
 <87wpxg3cvv.fsf@igel.home> <1438562207.31010.14.camel@axtens.net>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Mon, 2015-08-03 at 10:36 +1000, Daniel Axtens wrote:
> Hi Andreas,
> 
> On Fri, 2015-07-31 at 11:16 +0200, Andreas Schwab wrote:
> > Daniel Axtens <dja@axtens.net> writes:
> > 
> > > Every time I build cxl I see the following warnings:
> > >
> > > /scratch/dja/linux-capi/drivers/misc/cxl/pci.c: In function ‘sanitise_afu_regs’:
> > > /scratch/dja/linux-capi/drivers/misc/cxl/pci.c:712:6: warning: suggest explicit braces to avoid ambiguous ‘else’ [-Wparentheses]
> > >    if (reg & CXL_PSL_DSISR_TRANS)
> > >       ^
> > > /scratch/dja/linux-capi/drivers/misc/cxl/irq.c: In function ‘fail_psl_irq’:
> > > /scratch/dja/linux-capi/drivers/misc/cxl/irq.c:184:5: warning: suggest explicit braces to avoid ambiguous ‘else’ [-Wparentheses]
> > >   if (irq_info->dsisr & CXL_PSL_DSISR_TRANS)
> > >      ^
> > 
> > Why are they ambigous?  Why doesn't cxl_p2n_write(afu, CXL_PSL_TFC_An,
> > CXL_PSL_TFC_An_AE) expand to a proper statement?
> > 
> > #define cxl_p2n_write(afu, reg, val) \
> > 	out_be64(_cxl_p2n_addr(afu, reg), val)
> > 
> 
> I realised that I started seeing this when I was working on my EEH
> patches, which change the definition to:
> 
> #define cxl_p2n_write(afu, reg, val) \
> 	if (cxl_adapter_link_ok(afu->adapter)) \
> 		out_be64(_cxl_p2n_addr(afu, reg), val)

This should be a static inline, not a #define.

cheers
