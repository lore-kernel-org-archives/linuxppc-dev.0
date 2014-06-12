Return-Path: <iamjoonsoo.kim@lge.com>
Received: from lgemrelse6q.lge.com (LGEMRELSE6Q.lge.com [156.147.1.121])
 by lists.ozlabs.org (Postfix) with ESMTP id C34741A02CA
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 12 Jun 2014 17:52:42 +1000 (EST)
Date: Thu, 12 Jun 2014 16:56:38 +0900
From: Joonsoo Kim <iamjoonsoo.kim@lge.com>
To: Minchan Kim <minchan@kernel.org>
Subject: Re: [PATCH v2 10/10] mm, cma: use spinlock instead of mutex
Message-ID: <20140612075638.GD20199@js1304-P5Q-DELUXE>
References: <1402543307-29800-1-git-send-email-iamjoonsoo.kim@lge.com>
 <1402543307-29800-11-git-send-email-iamjoonsoo.kim@lge.com>
 <20140612074029.GB12663@bbox>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20140612074029.GB12663@bbox>
Cc: kvm-ppc@vger.kernel.org, Russell King - ARM Linux <linux@arm.linux.org.uk>,
 kvm@vger.kernel.org, Gleb Natapov <gleb@kernel.org>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Alexander Graf <agraf@suse.de>, Michal Nazarewicz <mina86@mina86.com>,
 linux-kernel@vger.kernel.org, linux-mm@kvack.org,
 Paul Mackerras <paulus@samba.org>,
 "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Andrew Morton <akpm@linux-foundation.org>,
 linuxppc-dev@lists.ozlabs.org, linux-arm-kernel@lists.infradead.org,
 Marek Szyprowski <m.szyprowski@samsung.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Thu, Jun 12, 2014 at 04:40:29PM +0900, Minchan Kim wrote:
> On Thu, Jun 12, 2014 at 12:21:47PM +0900, Joonsoo Kim wrote:
> > Currently, we should take the mutex for manipulating bitmap.
> > This job may be really simple and short so we don't need to sleep
> > if contended. So I change it to spinlock.
> 
> I'm not sure it would be good always.
> Maybe you remember we discussed about similar stuff about bitmap
> searching in vmap friend internally, which was really painful
> when it was fragmented. So, at least we need number if you really want
> and I hope the number from ARM machine most popular platform for CMA
> at the moment.

Good Point!! Agreed. I will drop this one in next spin and re-submit
in separate patchset after some testing.

Thanks.
