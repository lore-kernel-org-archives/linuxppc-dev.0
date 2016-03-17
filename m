Return-Path: <imunsie@au1.ibm.com>
Received: from e23smtp09.au.ibm.com (e23smtp09.au.ibm.com [202.81.31.142])
 (using TLSv1.2 with cipher CAMELLIA256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3qQWM606ykzDqPm
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 17 Mar 2016 12:42:42 +1100 (AEDT)
Received: from localhost
 by e23smtp09.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <imunsie@au1.ibm.com>;
 Thu, 17 Mar 2016 11:42:40 +1000
Received: from d23relay06.au.ibm.com (d23relay06.au.ibm.com [9.185.63.219])
 by d23dlp03.au.ibm.com (Postfix) with ESMTP id 6CE543578056
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 17 Mar 2016 12:42:33 +1100 (EST)
Received: from d23av03.au.ibm.com (d23av03.au.ibm.com [9.190.234.97])
 by d23relay06.au.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 u2H1gKIJ3801480
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 17 Mar 2016 12:42:33 +1100
Received: from d23av03.au.ibm.com (localhost [127.0.0.1])
 by d23av03.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 u2H1futf024021
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 17 Mar 2016 12:41:56 +1100
Content-Type: text/plain; charset=UTF-8
From: Ian Munsie <imunsie@au1.ibm.com>
To: Michael Neuling <mikey@neuling.org>
Cc: Frederic Barrat <fbarrat@linux.vnet.ibm.com>,
 linuxppc-dev <linuxppc-dev@lists.ozlabs.org>
Subject: Re: [PATCH next] cxl: Allow PSL timebase to not sync
In-reply-to: <1458001649.12098.59.camel@neuling.org>
References: <1457983772-4206-1-git-send-email-fbarrat@linux.vnet.ibm.com>
 <1458001649.12098.59.camel@neuling.org>
Date: Thu, 17 Mar 2016 12:41:01 +1100
Message-Id: <1458177720-sup-8617@x230.ozlabs.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Excerpts from Michael Neuling's message of 2016-03-15 11:27:29 +1100:
> I'm not happy with doing this unless we add something which advertises
> that it's synced or not to userspace.

In my opinion this is probably unnecessary (but it's not a bad idea
either and I'm happy for that to be added). As far as I know, no one is
using timebase in an AFU today, or if they are it is on working cards
(if it wasn't someone would have complained by now).

This change is just to make it so that the affected cards will work at
all, since at the moment we treat the failure of this feature no one
uses as fatal.

If / when someone actually needs timebase, they will have to debug the
root cause of the problem anyway (if we haven't already), at which point
they will have a working card regardless of whether this patch is merged
or not.

If it turns out to be a software bug it is not unreasonable for them to
say that their afu is only supported by kernel or firmware "whatever
version we fix it in".

That said, a read-only attribute in sysfs to indicate whether the
timebase is synced or not would be fine and give them something they can
query if they care about it.

> The parameter is a bit of a PITA too, as it's a driver level config not
> card level.  You really want to turn it on/off based on the card, not
> the whole system.

I don't agree - userspace already needs to know what AFU they are
dealing with and therefore knows if the timebase is important or not. A
read-only attribute in sysfs would be enough to tell them this. We can
be fairly confident that there is no software that would need to be
changed to check this today since we had been failing the whole init so
it wouldn't have worked at all regardless.

We did have a software bug where the sync was sensitive to the kernel
config, but that has been fixed. If anyone was using timebase (and I
don't think anyone was) already and lucked out by testing on a kernel
config that was working this won't impact them either since those cards
will work either way now that issue has been fixed.

IMO, we should ditch the module parameter altogether and never treat
timebase sync failure as fatal, and leave that up to any applications
actually need it to check.

Cheers,
-Ian
