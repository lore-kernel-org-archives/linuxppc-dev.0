Return-Path: <npiggin@gmail.com>
Received: from mail-pg0-x244.google.com (mail-pg0-x244.google.com
 [IPv6:2607:f8b0:400e:c05::244])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3wthr1613TzDrHb
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 22 Jun 2017 23:14:25 +1000 (AEST)
Received: by mail-pg0-x244.google.com with SMTP id u62so2403402pgb.0
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 22 Jun 2017 06:14:25 -0700 (PDT)
Date: Thu, 22 Jun 2017 23:14:11 +1000
From: Nicholas Piggin <npiggin@gmail.com>
To: Michael Ellerman <mpe@ellerman.id.au>
Cc: "Naveen N. Rao" <naveen.n.rao@linux.vnet.ibm.com>, Ananth N
 Mavinakayanahalli <ananth@linux.vnet.ibm.com>, Masami Hiramatsu
 <mhiramat@kernel.org>, linuxppc-dev@lists.ozlabs.org
Subject: Re: [PATCH v3 4/6] powerpc/64s: Un-blacklist system_call() from
 kprobes
Message-ID: <20170622231411.75ef990b@roar.ozlabs.ibm.com>
In-Reply-To: <8737ass29e.fsf@concordia.ellerman.id.au>
References: <cover.1498069502.git.naveen.n.rao@linux.vnet.ibm.com>
 <d13eccaed4be643409abed29565dbdd8c7d5af6a.1498069502.git.naveen.n.rao@linux.vnet.ibm.com>
 <20170622134112.4bd32543@roar.ozlabs.ibm.com>
 <8737ass29e.fsf@concordia.ellerman.id.au>
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

On Thu, 22 Jun 2017 21:14:21 +1000
Michael Ellerman <mpe@ellerman.id.au> wrote:

> Nicholas Piggin <npiggin@gmail.com> writes:
> 
> > On Thu, 22 Jun 2017 00:08:40 +0530
> > "Naveen N. Rao" <naveen.n.rao@linux.vnet.ibm.com> wrote:
> >  
> >> It is actually safe to probe system_call() in entry_64.S, but only till
> >> we unset MSR_RI. To allow this, add a new symbol system_call_exit()
> >> after the mtmsrd and blacklist that. Though the mtmsrd instruction
> >> itself is now whitelisted, we won't be allowed to probe on it as we
> >> don't allow probing on rfi and mtmsr instructions (checked for in
> >> arch_prepare_kprobe()).  
> >
> > Can you add a little comment to say probes aren't allowed, and it's
> > located after the mtmsr in order to avoid contaminating traces?
> >
> > Also I wonder if a slightly different name would be more instructive?
> > I don't normally care, but the system_call_common code isn't trivial
> > to follow. system_call_exit might give the impression that it is the
> > entire exit path (which would pair with system_call for entry).  
> 
> It is the entire path in the happy case isn't it? I'm not sure I know
> what you mean.

Oh, yes you're right, I thought it was moved down further.

Thanks,
Nick
