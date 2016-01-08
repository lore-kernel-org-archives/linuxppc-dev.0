Return-Path: <imunsie@au1.ibm.com>
Received: from e23smtp06.au.ibm.com (e23smtp06.au.ibm.com [202.81.31.148])
 (using TLSv1 with cipher CAMELLIA256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4515F1A0050
 for <linuxppc-dev@lists.ozlabs.org>; Fri,  8 Jan 2016 12:32:57 +1100 (AEDT)
Received: from localhost
 by e23smtp06.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <imunsie@au1.ibm.com>;
 Fri, 8 Jan 2016 11:32:55 +1000
Received: from d23relay07.au.ibm.com (d23relay07.au.ibm.com [9.190.26.37])
 by d23dlp01.au.ibm.com (Postfix) with ESMTP id 323F62CE8054
 for <linuxppc-dev@lists.ozlabs.org>; Fri,  8 Jan 2016 12:32:53 +1100 (EST)
Received: from d23av04.au.ibm.com (d23av04.au.ibm.com [9.190.235.139])
 by d23relay07.au.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 u081WknH28901604
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 8 Jan 2016 12:32:55 +1100
Received: from d23av04.au.ibm.com (localhost [127.0.0.1])
 by d23av04.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 u081WJsD030493
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 8 Jan 2016 12:32:20 +1100
Content-Type: text/plain; charset=UTF-8
From: Ian Munsie <imunsie@au1.ibm.com>
To: Brian Norris <computersforpeace@gmail.com>
Cc: Daniel Axtens <dja@axtens.net>, Arnd Bergmann <arnd@arndb.de>,
 linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
 Michael Ellerman <mpe@ellerman.id.au>, Michael Neuling <mikey@neuling.org>,
 Anton Blanchard <anton@au1.ibm.com>,
 linux-kernel <linux-kernel@vger.kernel.org>, Michal Marek <mmarek@suse.com>
Subject: Re: Build failure: -Wno-unused-const-variable DNE on old GCC
In-reply-to: <20160107230225.GA126548@google.com>
References: <20160107185406.GA65420@google.com> <10821353.mAlCTdTQBC@wuerfel>
 <87oacx6m14.fsf@gamma.ozlabs.ibm.com> <20160107230225.GA126548@google.com>
Date: Fri, 08 Jan 2016 12:31:54 +1100
Message-Id: <1452216163-sup-7558@delenn.ozlabs.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Excerpts from Brian Norris's message of 2016-01-08 10:02:25 +1100:
> >  - It forces cxl developers to a higher standard. cxl has already had
> >    more than it's fair share of incredibly difficult to debug issues,
> >    so any way we can reduce the risk of errors going in makes our lives
> >    (and our end-users lives) better.
> 
> One problem with this point: not all warnings are under the purview of
> cxl developers. For instance, if I turn up warning verbosity (W=1), then
> the *header* files start producing plenty of warnings. Should this break
> the build? Your code didn't change, and you can't fix those errors.

That's a good point, but the specific warnings that we suppressed in the
new compiler are in drivers/misc/cxl/cxl.h, which is an internal header
that should only ever be included by the cxl driver. We do have some
headers elsewhere which are included by other drivers, the generic ppc
architecture code and userspace, but these are all warning free and
won't be affected by the -Werror when included from elsewhere.

> That is a real use case for me daily: I turn the warning verbosity up on
> my compile tests, then (smart)diff the build logs before and after
> new patches. That way, I can see what new warnings (even potentially
> false positive ones) are introduced. I can't do that if every random
> developer wants to stick -Werror in their Makefile.

Makes sense.

> I think there are plenty of reasons to either remove -Werror, or make it
> configurable. Some of them are detailed above.
>
> Maybe you can gate the -Werror on CONFIG_PPC_WERROR, just like the rest
> of PowerPC?

Agreed.

@Daniel - since you added the -Werror do you want to do this, or shall
I?

Cheers,
-Ian
