Return-Path: <mpe@ellerman.id.au>
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id E28B51A02AC
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 13 Jul 2015 15:41:16 +1000 (AEST)
Message-ID: <1436766076.15957.0.camel@ellerman.id.au>
Subject: Re: [PATCH V2] powerpc/irq: Enable some more exceptions in
 /proc/interrupts interface
From: Michael Ellerman <mpe@ellerman.id.au>
To: Anshuman Khandual <khandual@linux.vnet.ibm.com>
Cc: Michael Neuling <mikey@neuling.org>, linuxppc-dev@ozlabs.org, Anton
 Blanchard <anton@samba.org>
Date: Mon, 13 Jul 2015 15:41:16 +1000
In-Reply-To: <55A34B85.3090902@linux.vnet.ibm.com>
References: <1436435189-11152-1-git-send-email-khandual@linux.vnet.ibm.com>
 <1436512241.4895.2.camel@neuling.org> <55A34B85.3090902@linux.vnet.ibm.com>
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

On Mon, 2015-07-13 at 10:54 +0530, Anshuman Khandual wrote:
> On 07/10/2015 12:40 PM, Michael Neuling wrote:
> > What's the performance impact of this?  If you run this test with --fp,
> > --altivec or --vector what is the impact of adding this patch?
> > 
> > http://ozlabs.org/~anton/junkcode/context_switch2.c
> > 
> > eg 
> >   ./context_switch2 --fp 0 0 
> 
> Please find the results here which looks similar with or without
> the patch being applied.

No they don't look similar with or without.

> (A) Floating point context switches (context_switch2 --fp 0 0)

If you just sort them you see:

316478	after
316540	after
316650	after
318448	after
318904 before
320216 before
321206 before
321308 before
323460	after
324596 before


It looks like ~1% degradation. Please run the test more times (maybe 1000) and
see how the numbers look.

cheers
