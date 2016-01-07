Return-Path: <computersforpeace@gmail.com>
Received: from mail-pf0-x22b.google.com (mail-pf0-x22b.google.com
 [IPv6:2607:f8b0:400e:c00::22b])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id CF2421A031E
 for <linuxppc-dev@lists.ozlabs.org>; Fri,  8 Jan 2016 10:02:30 +1100 (AEDT)
Received: by mail-pf0-x22b.google.com with SMTP id n128so230832pfn.3
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 07 Jan 2016 15:02:30 -0800 (PST)
Date: Thu, 7 Jan 2016 15:02:25 -0800
From: Brian Norris <computersforpeace@gmail.com>
To: Daniel Axtens <dja@axtens.net>
Cc: Arnd Bergmann <arnd@arndb.de>, linuxppc-dev@lists.ozlabs.org,
 Michael Ellerman <mpe@ellerman.id.au>, Michael Neuling <mikey@neuling.org>,
 Anton Blanchard <anton@au1.ibm.com>, linux-kernel@vger.kernel.org,
 Michal Marek <mmarek@suse.com>, Ian Munsie <imunsie@au1.ibm.com>
Subject: Re: Build failure: -Wno-unused-const-variable DNE on old GCC
Message-ID: <20160107230225.GA126548@google.com>
References: <20160107185406.GA65420@google.com> <10821353.mAlCTdTQBC@wuerfel>
 <87oacx6m14.fsf@gamma.ozlabs.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <87oacx6m14.fsf@gamma.ozlabs.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Fri, Jan 08, 2016 at 09:51:35AM +1100, Daniel Axtens wrote:
> 
> > Alternatively, remove the -Werror. We occasionally get people that add this
> > flag to a Makefile, but it tends to cause more trouble whenever a new
> > gcc version arrives.

^^ Your reasons below don't really address this point. No matter how
well you patch a later kernel release, you can't fix a problem in an
existing kernel release that is triggered by a new warning in a new
compiler. This shouldn't cause a build failure.

> Speaking up as the person who added -Werror to cxl, I'd really rather
> it stayed. There are a number of reasons I think this. Here's the first
> three that came to mind.
> 
>  - cxl is powerpc specific (and always will be for deep seated hardware
>    reasons), and is handled through the powerpc tree. arch/powerpc
>    compiles with -Werror, and as part of the powerpc ecosystem, cxl
>    should too.
> 
>  - It forces cxl developers to a higher standard. cxl has already had
>    more than it's fair share of incredibly difficult to debug issues,
>    so any way we can reduce the risk of errors going in makes our lives
>    (and our end-users lives) better.

One problem with this point: not all warnings are under the purview of
cxl developers. For instance, if I turn up warning verbosity (W=1), then
the *header* files start producing plenty of warnings. Should this break
the build? Your code didn't change, and you can't fix those errors.

That is a real use case for me daily: I turn the warning verbosity up on
my compile tests, then (smart)diff the build logs before and after
new patches. That way, I can see what new warnings (even potentially
false positive ones) are introduced. I can't do that if every random
developer wants to stick -Werror in their Makefile.

>  - I am (and I'm quite confident the other cxl people are) quite happy to
>    send patches to fix build-breaking issues such as this. Indeed, I
>    would have, except you sent it during the Australian night :)
> 
> If it's really super-duper important we can consider putting it behind a
> config guard, but I'd really rather not.

I think there are plenty of reasons to either remove -Werror, or make it
configurable. Some of them are detailed above.

Maybe you can gate the -Werror on CONFIG_PPC_WERROR, just like the rest
of PowerPC?

Brian
