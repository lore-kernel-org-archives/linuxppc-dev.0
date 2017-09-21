Return-Path: <npiggin@gmail.com>
Received: from mail-pg0-x22f.google.com (mail-pg0-x22f.google.com
 [IPv6:2607:f8b0:400e:c05::22f])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3xybgP0DmkzDqT0
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 21 Sep 2017 22:35:44 +1000 (AEST)
Received: by mail-pg0-x22f.google.com with SMTP id p5so3433446pgn.7
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 21 Sep 2017 05:35:44 -0700 (PDT)
Date: Thu, 21 Sep 2017 22:33:30 +1000
From: Nicholas Piggin <npiggin@gmail.com>
To: Michael Ellerman <mpe@ellerman.id.au>
Cc: linuxppc-dev@lists.ozlabs.org
Subject: Re: [PATCH 0/5] More NMI IPI enablement work
Message-ID: <20170921223330.63f36695@roar.ozlabs.ibm.com>
In-Reply-To: <87vakcb93h.fsf@concordia.ellerman.id.au>
References: <20170918082706.6485-1-npiggin@gmail.com>
 <87vakcb93h.fsf@concordia.ellerman.id.au>
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

On Thu, 21 Sep 2017 21:10:42 +1000
Michael Ellerman <mpe@ellerman.id.au> wrote:

> Nicholas Piggin <npiggin@gmail.com> writes:
> 
> > Hi,
> >
> > Here is the NMI IPI enablement for powernv, which requires
> > supported firmware and hardware:
> >
> > https://lists.ozlabs.org/pipermail/skiboot/2017-September/009111.html
> >
> > And some preceeding patches that fix issues I ran into when
> > testing it.  
> 
> Are any of these critical such that I should pick them up for 4.14 or
> earlier?

Good point, yes. The hardlockup watchdog now does SMP cross-checking,
so it can blow up when you stay in xmon for about 10 seconds since the
new watchdog was merged. We want patches 3-4 for that.

Patch 1 is not really required, I only ran into it when I tried making
smp_send_stop use the NMI IPI, which we are not doing just yet. That
being said, the watchdog code is new, so probably doesn't hurt to put
in 4.14.

Patch 3 makes all-cpus backtraces a bit more concise. Less critical.

The system reset stuff I guess we'll want to backport for distros, so
4.14 might be reasonable not sure.

Actually patch 5 before you merge it I should remove the DD1
workaround too because we're not supporting that in OPAL anymore.

Thanks,
Nick
