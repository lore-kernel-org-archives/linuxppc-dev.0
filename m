Return-Path: <mpe@ellerman.id.au>
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3vS7yS0qStzDqHV
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 21 Feb 2017 16:16:32 +1100 (AEDT)
From: Michael Ellerman <mpe@ellerman.id.au>
To: "Guilherme G. Piccoli" <gpiccoli@linux.vnet.ibm.com>,
 linuxppc-dev@lists.ozlabs.org
Cc: benh@kernel.crashing.org, paulus@samba.org, npiggin@gmail.com,
 xinhui.pan@linux.vnet.ibm.com, gpiccoli@linux.vnet.ibm.com
Subject: Re: [PATCH 2/3] powerpc/xmon: drop the nobt option from xmon plus
 minor fixes
In-Reply-To: <1487290677-7200-3-git-send-email-gpiccoli@linux.vnet.ibm.com>
References: <1487290677-7200-1-git-send-email-gpiccoli@linux.vnet.ibm.com>
 <1487290677-7200-3-git-send-email-gpiccoli@linux.vnet.ibm.com>
Date: Tue, 21 Feb 2017 16:16:31 +1100
Message-ID: <87poicm8cw.fsf@concordia.ellerman.id.au>
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

"Guilherme G. Piccoli" <gpiccoli@linux.vnet.ibm.com> writes:
> Subject: Re: [PATCH 2/3] powerpc/xmon: drop the nobt option from xmon plus minor fixes

In future please use the same version number for all patches of a
series.

ie. This should include a v2, like the rest of the patches in the series.

It confuses the tools to have "v2 1/3" "2/3" "v2 3/3".

I realise that might seem a little odd when a patch is new to the
series, but the version is the version *of the series*, not the
individual patches.

For a new patch you can just add after the change log:

---
v2: New for v2 of the series.


For example.

> The xmon parameter nobt was added long time ago, by commit 26c8af5f01df
> ("[POWERPC] print backtrace when entering xmon"). The problem that time
> was that during a crash in a machine with USB keyboard, xmon wouldn't
> respond to commands from the keyboard, so printing the backtrace wouldn't
> be possible.
>
> Idea then was to show automatically the backtrace on xmon crash for the
> first time it's invoked (if it recovers, next time xmon won't show
> backtrace automatically). The nobt parameter was added _only_ to prevent
> this automatic trace show. Seems long time ago USB keyboards didn't work
> that well!
>
> We don't need it anymore, but the feature of auto showing the backtrace
> on first crash seems interesting (imagine a case of auto-reboot script),
> so this patch keeps the functionality, yet removes the nobt parameter.


I'm going to take this as-is, because I want to get it in for v4.11.

But I don't think we need the auto back trace logic at all. If anything
it's an anti-feature IMHO.

Imagine you're debugging a machine and you drop into xmon to check
something, then drop out again.

Then you go away and leave the box, and it crashes into xmon, but xmon
doesn't print a backtrace because you've already been in xmon. Usually
you can just get on the console and hit 't', but sometimes the machine
crashes so hard that xmon doesn't take input - in which case you now
have no backtrace. :sadface:

So I'll send a follow-up patch to remove the auto backtrace stuff
completely and see if anyone objects.

cheers
