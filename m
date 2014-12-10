Return-Path: <naveen.n.rao@linux.vnet.ibm.com>
Received: from e28smtp09.in.ibm.com (e28smtp09.in.ibm.com [122.248.162.9])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id AED991A01EB
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 10 Dec 2014 21:27:14 +1100 (AEDT)
Received: from /spool/local
 by e28smtp09.in.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <naveen.n.rao@linux.vnet.ibm.com>;
 Wed, 10 Dec 2014 15:57:12 +0530
Received: from d28relay03.in.ibm.com (d28relay03.in.ibm.com [9.184.220.60])
 by d28dlp02.in.ibm.com (Postfix) with ESMTP id 571113940068
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 10 Dec 2014 15:57:09 +0530 (IST)
Received: from d28av05.in.ibm.com (d28av05.in.ibm.com [9.184.220.67])
 by d28relay03.in.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 sBAATG4N51773676
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 10 Dec 2014 15:59:16 +0530
Received: from d28av05.in.ibm.com (localhost [127.0.0.1])
 by d28av05.in.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 sBAAR7Bk005655
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 10 Dec 2014 15:57:08 +0530
Date: Wed, 10 Dec 2014 15:56:34 +0530
From: "Naveen N. Rao" <naveen.n.rao@linux.vnet.ibm.com>
To: Michael Ellerman <mpe@ellerman.id.au>
Subject: Re: [RFC PATCH 1/8] kprobes: Fix kallsyms lookup across powerpc
 ABIv1 and ABIv2
Message-ID: <20141210102634.GA16045@naverao1-tp.in.ibm.com>
References: <cover.1418146300.git.naveen.n.rao@linux.vnet.ibm.com>
 <7a96a9c262a818112955da93f8ff1ada1bfe5c59.1418146300.git.naveen.n.rao@linux.vnet.ibm.com>
 <1418204242.9279.4.camel@ellerman.id.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1418204242.9279.4.camel@ellerman.id.au>
Cc: linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org,
 acme@kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 2014/12/10 08:37PM, Michael Ellerman wrote:
> On Tue, 2014-12-09 at 23:03 +0530, Naveen N. Rao wrote:
> > Currently, all non-dot symbols are being treated as function descriptors
> > in ABIv1. This is incorrect and is resulting in perf probe not working:
> 
> I don't understand that first sentence. With ABIv1 non-dot symbols *are*
> function descriptors?

Not always. '_text' is an example of a symbol that is not a function 
descriptor. However, most functions have a dot variant constituting the 
actual entry point and a non-dot variant constituting the function 
descriptor.

> 
> >   # perf probe do_fork
> >   Added new event:
> >   Failed to write event: Invalid argument
> >     Error: Failed to add events.
> >   # dmesg | tail -1
> >   [192268.073063] Could not insert probe at _text+768432: -22
> > 
> > _text is being resolved incorrectly and is resulting in the above error.
> > Fix this by changing how we lookup symbol addresses on ppc64. We first
> > check for the dot variant of a symbol and look at the non-dot variant
> > only if that fails. In this manner, we avoid having to look at the
> > function descriptor.
> 
> I'm not clear that ppc_local_function_entry() makes sense. On ABIv2 you return
> the local entry point, which is fine. But on ABIv1 you just return the
> unmodified address, which will be the descriptor if you actually passed it a
> function pointer. I think you're assuming that you're passed the text address,
> but if that's the case the function is badly named at least.
> 
> I also don't understand why we need to ever guess which ABI we're using. We
> know which ABI we're built with, so there should be no guess work required.
> 
> So at the very least this needs much more explanation.
> 
> But to be honest I'm not clear why it even needs a kernel change, don't we just
> need perf to understand dot symbols?

The problem in this case is in the kernel. perf probe is now basing all 
probe addresses on _text and writes, for example, "p:probe/do_fork 
_text+768432" to /sys/kernel/debug/tracing/kprobe_events.

This ends up in kprobe_lookup_name() for resolving address of _text, 
which invokes ppc_function_entry(), which ends up thinking _text is a 
function descriptor.

Even though we know we are compiled for ABIv1, there is no easy way to 
identify if a given symbol is the actual entry point or if it is a 
function descriptor. To address this, my approach is to always check for 
a dot symbol first and if that exists, we know we have the actual 
function entry. If not, we know this isn't a function descriptor (since 
there is no related dot symbol).

I agree that the function is named badly though. The real problem is 
that kprobe_lookup_name is a macro and I can't have a #ifdef to call 
ppc_function_entry() only for ABIv2.

Thoughts? Suggestions?

Thanks,
Naveen
