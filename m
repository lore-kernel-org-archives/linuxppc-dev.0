Return-Path: <srs0=nndc=ky=gmail.com=npiggin@ozlabs.org>
Received: from ozlabs.org (bilbo.ozlabs.org [203.11.71.1])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 41m9yS3pWszDqBy
 for <linuxppc-dev@lists.ozlabs.org>; Thu,  9 Aug 2018 11:43:44 +1000 (AEST)
Received: from ozlabs.org (bilbo.ozlabs.org [203.11.71.1])
 by bilbo.ozlabs.org (Postfix) with ESMTP id 41m9yS334Yz8tBY
 for <linuxppc-dev@lists.ozlabs.org>; Thu,  9 Aug 2018 11:43:44 +1000 (AEST)
Received: from mail-pg1-x544.google.com (mail-pg1-x544.google.com
 [IPv6:2607:f8b0:4864:20::544])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id 41m9yR1wDVz9s4c
 for <linuxppc-dev@ozlabs.org>; Thu,  9 Aug 2018 11:43:42 +1000 (AEST)
Received: by mail-pg1-x544.google.com with SMTP id k3-v6so1941674pgq.5
 for <linuxppc-dev@ozlabs.org>; Wed, 08 Aug 2018 18:43:42 -0700 (PDT)
Date: Thu, 9 Aug 2018 11:43:30 +1000
From: Nicholas Piggin <npiggin@gmail.com>
To: Michael Ellerman <mpe@ellerman.id.au>
Cc: Mahesh J Salgaonkar <mahesh@linux.vnet.ibm.com>, linuxppc-dev
 <linuxppc-dev@ozlabs.org>, "Aneesh Kumar K.V"
 <aneesh.kumar@linux.vnet.ibm.com>, Michal Suchanek <msuchanek@suse.com>,
 Ananth Narayan <ananth@in.ibm.com>, Laurent Dufour
 <ldufour@linux.vnet.ibm.com>
Subject: Re: [PATCH v7 8/9] powerpc/mce: Add sysctl control for recovery
 action on MCE.
Message-ID: <20180809114330.7cad9866@roar.ozlabs.ibm.com>
In-Reply-To: <87o9ecaovz.fsf@concordia.ellerman.id.au>
References: <153365127532.14256.1965469477086140841.stgit@jupiter.in.ibm.com>
 <153365146712.14256.11869543914717297278.stgit@jupiter.in.ibm.com>
 <87o9ecaovz.fsf@concordia.ellerman.id.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Thu, 09 Aug 2018 00:56:00 +1000
Michael Ellerman <mpe@ellerman.id.au> wrote:

> Mahesh J Salgaonkar <mahesh@linux.vnet.ibm.com> writes:
> > From: Mahesh Salgaonkar <mahesh@linux.vnet.ibm.com>
> >
> > Introduce recovery action for recovered memory errors (MCEs). There are
> > soft memory errors like SLB Multihit, which can be a result of a bad
> > hardware OR software BUG. Kernel can easily recover from these soft errors
> > by flushing SLB contents. After the recovery kernel can still continue to
> > function without any issue. But in some scenario's we may keep getting
> > these soft errors until the root cause is fixed. To be able to analyze and
> > find the root cause, best way is to gather enough data and system state at
> > the time of MCE. Hence this patch introduces a sysctl knob where user can
> > decide either to continue after recovery or panic the kernel to capture the
> > dump.  
> 
> I'm not convinced we want this.
> 
> As we've discovered it's often not possible to reconstruct what happened
> based on a dump anyway.
> 
> The key thing you need is the content of the SLB and that's not included
> in a dump.
> 
> So I think we should dump the SLB content when we get the MCE (which
> this series does) and any other useful info, and then if we can recover
> we should.

Yeah it's a lot of knobs that administrators can hardly be expected to
tune. Hypervisor or firmware should really eventually make the MCE
unrecoverable if we aren't making progress.

That said, x86 has a bunch of options, and for debugging a rare crash
or specialised installations it might be useful. But we should follow
the normal format, /proc/sys/kernel/panic_on_mce.

Thanks,
Nick
