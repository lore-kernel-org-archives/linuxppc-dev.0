Return-Path: <mpe@ellerman.id.au>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 255B41A0052
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 20 Apr 2015 13:01:26 +1000 (AEST)
Message-ID: <1429498885.28239.4.camel@ellerman.id.au>
Subject: Re: Fwd: Re: sparc64: Build failure due to commit f1600e549b94
 (sparc: Make sparc64 use scalable lib/iommu-common.c functions)
From: Michael Ellerman <mpe@ellerman.id.au>
To: Sowmini Varadhan <sowmini.varadhan@oracle.com>
Date: Mon, 20 Apr 2015 13:01:25 +1000
In-Reply-To: <20150419183625.GA18901@oracle.com>
References: <20150419183625.GA18901@oracle.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Cc: aik@au1.ibm.com, anton@au1.ibm.com, linux-kernel@vger.kernel.org,
 paulus@samba.org, sparclinux@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
 davem@davemloft.net, linux@roeck-us.net
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Sun, 2015-04-19 at 14:36 -0400, Sowmini Varadhan wrote:
> > On (04/19/15 14:09), David Miller wrote:
> >
> > > On (04/18/15 21:23), Guenter Roeck wrote:
> > >> lib/built-in.o:(.discard+0x1): multiple definition of
> > >> `__pcpu_unique_iommu_pool_hash'
> > >> arch/powerpc/kernel/built-in.o:(.discard+0x18): first defined here
> > >> .. I get a similar failure in the
> > >> powerpc:allmodconfig build
>     :
> > 
> > Maybe ping the powerpc folks becuase if they can do a quick
> > conversion, this change isn't necessary.
> 
> linuxppc-dev,
> 
> The disussion above [http://www.spinics.net/lists/sparclinux/msg13835.html]
> is in reference to the issue that Guenter Roeck
> identified. The problem is that we have a 
>   static DEFINE_PER_CPU(unsigned int, iommu_pool_hash);

It's static ..

>   if CONFIG_DEBUG_FORCE_WEAK_PER_CPU is configured, which is the case here.
>   The marked line above shows that __pcpu_unique_iommu_pool_hash is declared as
>   global variable"

OK, so why doesn't CONFIG_DEBUG_FORCE_WEAK_PER_CPU depend on s390 and/or alpha?

Someone needs to be doing s390/alpha builds with that enabled anyway, because
otherwise a clash between generic code and s390/alpha won't be caught.

Or if that's too hard we can rename the powerpc version, but it seems silly to
rename a powerpc variable to deal with a debug option that is only useful for
s390/alpha.

cheers
