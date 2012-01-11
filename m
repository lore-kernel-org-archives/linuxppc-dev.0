Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client did not present a certificate)
 by ozlabs.org (Postfix) with ESMTPS id 201E4B6EF1
 for <linuxppc-dev@ozlabs.org>; Wed, 11 Jan 2012 18:05:56 +1100 (EST)
Message-ID: <1326265535.23910.111.camel@pasglop>
Subject: Re: [PATCH] cpuidle: Default y for pseries
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Date: Wed, 11 Jan 2012 18:05:35 +1100
In-Reply-To: <CA+55aFycfYKFagVgckrEm3dAFHNZEvm0Hkw0UbH+XfKQu8Cvzg@mail.gmail.com>
References: <1326243935.23910.85.camel@pasglop>
 <CA+55aFycfYKFagVgckrEm3dAFHNZEvm0Hkw0UbH+XfKQu8Cvzg@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Cc: linuxppc-dev@ozlabs.org, Shaohua Li <shaohua.li@intel.com>,
 linux-pm@vger.kernel.org, Venkatesh Pallipadi <venkatesh.pallipadi@intel.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Tue, 2012-01-10 at 22:08 -0800, Linus Torvalds wrote:
> On Tue, Jan 10, 2012 at 5:05 PM, Benjamin Herrenschmidt
> <benh@kernel.crashing.org> wrote:
> >
> > Linus, do you want to just pick that up or should I put it into powerpc.git
> > and ask you to pull ? I will have 2 or 3 other fixes there later today,
> > but I wanted to make sure you were ok with the approach with this
> > specific one.
> 
> It doesn't seem to be all that different from the "default y if ACPI"
> case, so I guess it works ok.

It works for my case, that's tested, but ...

> That said, I wonder if the right approach wouldn't be
> 
>    default y if SUPPORT_CPU_IDLE
> 
> or something along those lines. And then both ACPI and PPC_PSERIES
> could just select that instead. Because I do hate having random
> board-level knowledge in something like this. I dunno.

I tend to agree, I wasn't too keen on touching ACPI related stuff I
suppose it shouldn't be hard :-) Btw, what about the change:

-	default ACPI
+	default y if ACPI

(To be honest I'm not sure what the first form does in details).

Oh, also, I just see that in drivers/acpi/Kconfig:

config ACPI_PROCESSOR
	tristate "Processor"
	select THERMAL
	select CPU_IDLE
	default y

Hrm... maybe I should just do the same in pseries and remove both the
"default" statements above, what do you think ?

On pSeries I'm keen to build that in rather than make it a module too
because you get no idle handling until it loads which can be
problematic. Built-in, it seems to be quite early in the link order (if
we can still trust that nowadays ...).

Cheers,
Ben.
