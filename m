Return-Path: <grant.likely@secretlab.ca>
Received: from mail-pz0-f42.google.com (mail-pz0-f42.google.com
 [209.85.210.42])
 (using TLSv1 with cipher ECDHE-RSA-RC4-SHA (128/128 bits))
 (Client CN "smtp.gmail.com", Issuer "Google Internet Authority" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id A9314B707C
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 20 Apr 2012 04:22:38 +1000 (EST)
Received: by dang27 with SMTP id g27so12993784dan.15
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 19 Apr 2012 11:22:36 -0700 (PDT)
Sender: Grant Likely <glikely@secretlab.ca>
From: Grant Likely <grant.likely@secretlab.ca>
Subject: Re: [PATCH 1/2] powerpc/8xx: Fix NR_IRQ bugs and refactor 8xx
 interrupt controller
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
In-Reply-To: <1334617382.25353.14.camel@pasglop>
References: <1334607198-18694-1-git-send-email-grant.likely@secretlab.ca>
 <1334617382.25353.14.camel@pasglop>
Date: Thu, 19 Apr 2012 12:22:34 -0600
Message-Id: <20120419182234.352973E0700@localhost>
Cc: linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Tue, 17 Apr 2012 09:03:02 +1000, Benjamin Herrenschmidt <benh@kernel.crashing.org> wrote:
> On Mon, 2012-04-16 at 14:13 -0600, Grant Likely wrote:
> > The mpc8xx driver uses a reference to NR_IRQS that is buggy.  It uses
> > NR_IRQs for the array size of the ppc_cached_irq_mask bitmap, but
> > NR_IRQs could be smaller than the number of hardware irqs that
> > ppc_cached_irq_mask tracks.
> > 
> > Also, while fixing that problem, it became apparent that the interrupt
> > controller only supports 32 interrupt numbers, but it is written as if
> > it supports multiple register banks which is more complicated.
> > 
> > This patch pulls out the buggy reference to NR_IRQs and fixes the size
> > of the ppc_cached_irq_mask to match the number of HW irqs.  It also
> > drops the now-unnecessary code since ppc_cached_irq_mask is no longer
> > an array.
> 
> Can you rename ppc_cached_irq_mask while at it ? I think it was written
> that way because it was all copy/pasted from powermac/pic.c which -does-
> need it to be an array (and has the same bugs btw) :-) 

Done; and I think I fixed the pic.c bugs in patch 2.

g.
