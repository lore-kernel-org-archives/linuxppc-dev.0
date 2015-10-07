Return-Path: <imunsie@au1.ibm.com>
Received: from e23smtp01.au.ibm.com (e23smtp01.au.ibm.com [202.81.31.143])
 (using TLSv1 with cipher CAMELLIA256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 104A21A01DF
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  7 Oct 2015 14:25:51 +1100 (AEDT)
Received: from /spool/local
 by e23smtp01.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <imunsie@au1.ibm.com>;
 Wed, 7 Oct 2015 13:25:49 +1000
Received: from d23relay08.au.ibm.com (d23relay08.au.ibm.com [9.185.71.33])
 by d23dlp03.au.ibm.com (Postfix) with ESMTP id 5CB41357804F
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  7 Oct 2015 14:25:46 +1100 (EST)
Received: from d23av01.au.ibm.com (d23av01.au.ibm.com [9.190.234.96])
 by d23relay08.au.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 t973PR2O852378
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 7 Oct 2015 14:25:35 +1100
Received: from d23av01.au.ibm.com (localhost [127.0.0.1])
 by d23av01.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 t973PD2Y012610
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 7 Oct 2015 14:25:14 +1100
Content-Type: text/plain; charset=UTF-8
From: Ian Munsie <imunsie@au1.ibm.com>
To: Michael Ellerman <mpe@ellerman.id.au>
Cc: Christophe Lombard <clombard@linux.vnet.ibm.com>,
 linuxppc-dev <linuxppc-dev@lists.ozlabs.org>
Subject: Re: [PATCH] cxl: Fix number of allocated pages in SPA
In-reply-to: <1444112342.16578.1.camel@ellerman.id.au>
References: <1443794485-30565-1-git-send-email-clombard@linux.vnet.ibm.com>
 <1444112342.16578.1.camel@ellerman.id.au>
Date: Wed, 07 Oct 2015 14:24:46 +1100
Message-Id: <1444187065-sup-7898@delenn.ozlabs.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Excerpts from Michael Ellerman's message of 2015-10-06 17:19:02 +1100:
> On Fri, 2015-10-02 at 16:01 +0200, Christophe Lombard wrote:
> > This moves the initialisation of the num_procs to before the SPA
> > allocation.
> 
> Why? What does it fix? I can't tell from the diff or the change log.

This will mean we only ever allocate a fixed number of pages for the
scheduled process area (which in itself looks like it has a minor bug as
it will start trying at two pages instead of one), which will limit us
to 958 processes with 2 x 64K pages. If we actually try to use more
processes than that we'd probably overrun the buffer and corrupt memory
or crash.

The only reason we haven't hit this out in the field so far is any AFUs
the requires at least three interrupts per process is already limited to
less processes than that anyway (e.g. min of 4 interrupts limits it to
509 processes, and all the AFUs I'm aware of require at least that many
interrupts), but we could hit it on an AFU that requires 0, 1 or 2
interrupts per process, or when using 4K pages.

This fix should go to stable.

@Christophe, can you resend with this info in the commit message?

Cheers,
-Ian
