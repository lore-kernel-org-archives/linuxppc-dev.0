Return-Path: <mpe@ellerman.id.au>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3wtf9V0DTYzDq8c
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 22 Jun 2017 21:14:22 +1000 (AEST)
From: Michael Ellerman <mpe@ellerman.id.au>
To: Nicholas Piggin <npiggin@gmail.com>,
 "Naveen N. Rao" <naveen.n.rao@linux.vnet.ibm.com>
Cc: Ananth N Mavinakayanahalli <ananth@linux.vnet.ibm.com>,
 Masami Hiramatsu <mhiramat@kernel.org>, linuxppc-dev@lists.ozlabs.org
Subject: Re: [PATCH v3 4/6] powerpc/64s: Un-blacklist system_call() from
 kprobes
In-Reply-To: <20170622134112.4bd32543@roar.ozlabs.ibm.com>
References: <cover.1498069502.git.naveen.n.rao@linux.vnet.ibm.com>
 <d13eccaed4be643409abed29565dbdd8c7d5af6a.1498069502.git.naveen.n.rao@linux.vnet.ibm.com>
 <20170622134112.4bd32543@roar.ozlabs.ibm.com>
Date: Thu, 22 Jun 2017 21:14:21 +1000
Message-ID: <8737ass29e.fsf@concordia.ellerman.id.au>
MIME-Version: 1.0
Content-Type: text/plain
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Nicholas Piggin <npiggin@gmail.com> writes:

> On Thu, 22 Jun 2017 00:08:40 +0530
> "Naveen N. Rao" <naveen.n.rao@linux.vnet.ibm.com> wrote:
>
>> It is actually safe to probe system_call() in entry_64.S, but only till
>> we unset MSR_RI. To allow this, add a new symbol system_call_exit()
>> after the mtmsrd and blacklist that. Though the mtmsrd instruction
>> itself is now whitelisted, we won't be allowed to probe on it as we
>> don't allow probing on rfi and mtmsr instructions (checked for in
>> arch_prepare_kprobe()).
>
> Can you add a little comment to say probes aren't allowed, and it's
> located after the mtmsr in order to avoid contaminating traces?
>
> Also I wonder if a slightly different name would be more instructive?
> I don't normally care, but the system_call_common code isn't trivial
> to follow. system_call_exit might give the impression that it is the
> entire exit path (which would pair with system_call for entry).

It is the entire path in the happy case isn't it? I'm not sure I know
what you mean.

> Perhaps system_call_exit_notrace? No that sucks too :(

A bit :D

If you're tracing etc. then you'll be in syscall_exit_work, isn't that
sufficient to differentiate the two?

cheers
