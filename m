Return-Path: <mpe@ellerman.id.au>
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id A1A731A0E61
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 20 Apr 2015 17:38:41 +1000 (AEST)
Message-ID: <1429515520.12716.3.camel@ellerman.id.au>
Subject: Re: Fwd: Re: sparc64: Build failure due to commit f1600e549b94
 (sparc: Make sparc64 use scalable lib/iommu-common.c functions)
From: Michael Ellerman <mpe@ellerman.id.au>
To: Guenter Roeck <linux@roeck-us.net>
Date: Mon, 20 Apr 2015 17:38:40 +1000
In-Reply-To: <55348BE1.4010305@roeck-us.net>
References: <20150419183625.GA18901@oracle.com>
 <1429498885.28239.4.camel@ellerman.id.au> <55348BE1.4010305@roeck-us.net>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Cc: aik@au1.ibm.com, Sowmini Varadhan <sowmini.varadhan@oracle.com>,
 anton@au1.ibm.com, linux-kernel@vger.kernel.org, paulus@samba.org,
 sparclinux@vger.kernel.org, linuxppc-dev@lists.ozlabs.org, davem@davemloft.net
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Sun, 2015-04-19 at 22:17 -0700, Guenter Roeck wrote:
> Hi Michael,

Hi Guenter,

> On 04/19/2015 08:01 PM, Michael Ellerman wrote:
> 
> > Someone needs to be doing s390/alpha builds with that enabled anyway, because
> > otherwise a clash between generic code and s390/alpha won't be caught.
> >
> > Or if that's too hard we can rename the powerpc version, but it seems silly to
> > rename a powerpc variable to deal with a debug option that is only useful for
> > s390/alpha.
> 
> The debug option is intended for all _other_ architectures, to ensure that
> changes made for those don't break alpha/s390 builds. alpha/s390 have
> ARCH_NEEDS_WEAK_PER_CPU and don't need the debug option.

But that can't actually work. If you introduce a percpu variable in generic
code that has the same name as a variable in the s390/alpha code, the only way
you can detect that is by building for s390/alpha.

Sure it might catch two variables in generic code that have the same name, but
that will get caught as soon as someone does a s390/alpha build anyway - which
is at least every night for linux-next.

More likely it catches cases like this, which is variables in code that will
never build for s390/alpha. So it just seems like a PITA to me.

> Sowmini's patch would change the variable name in the lib/ code. But that was
> not the question here. The question was if the powerpc code could be changed
> to use the generic iommu code instead of using the powerpc specific code.

Not for this merge window sorry, we need to test it properly.

cheers
