Return-Path: <iamjoonsoo.kim@lge.com>
Received: from lgeamrelo04.lge.com (lgeamrelo04.lge.com [156.147.1.127])
 by lists.ozlabs.org (Postfix) with ESMTP id A5EF51A005E
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 17 Jun 2014 11:29:35 +1000 (EST)
Date: Tue, 17 Jun 2014 10:33:50 +0900
From: Joonsoo Kim <iamjoonsoo.kim@lge.com>
To: Minchan Kim <minchan@kernel.org>
Subject: Re: [PATCH v3 -next 1/9] DMA, CMA: fix possible memory leak
Message-ID: <20140617013349.GB6825@js1304-P5Q-DELUXE>
References: <1402897251-23639-1-git-send-email-iamjoonsoo.kim@lge.com>
 <1402897251-23639-2-git-send-email-iamjoonsoo.kim@lge.com>
 <20140616062719.GA18790@bbox>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20140616062719.GA18790@bbox>
Cc: kvm-ppc@vger.kernel.org, Russell King - ARM Linux <linux@arm.linux.org.uk>,
 kvm@vger.kernel.org, Gleb Natapov <gleb@kernel.org>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Alexander Graf <agraf@suse.de>, Michal Nazarewicz <mina86@mina86.com>,
 linux-kernel@vger.kernel.org, linux-mm@kvack.org,
 Paul Mackerras <paulus@samba.org>,
 "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Andrew Morton <akpm@linux-foundation.org>,
 Zhang Yanfei <zhangyanfei@cn.fujitsu.com>, linuxppc-dev@lists.ozlabs.org,
 linux-arm-kernel@lists.infradead.org,
 Marek Szyprowski <m.szyprowski@samsung.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Mon, Jun 16, 2014 at 03:27:19PM +0900, Minchan Kim wrote:
> Hi, Joonsoo
> 
> On Mon, Jun 16, 2014 at 02:40:43PM +0900, Joonsoo Kim wrote:
> > We should free memory for bitmap when we find zone mis-match,
> > otherwise this memory will leak.
> > 
> > Additionally, I copy code comment from PPC KVM's CMA code to inform
> > why we need to check zone mis-match.
> > 
> > * Note
> > Minchan suggested to add a tag for the stable, but, I don't do it,
> > because I found this possibility during code-review and, IMO,
> > this patch isn't suitable for stable tree.
> 
> Nice idea to put the comment in here. Thanks Joonsoo.
> 
> It seems you obey "It must fix a real bug that bothers people"
> on Documentation/stable_kernel_rules.txt but it's a really obvious
> bug and hard to get a report from people because limited user and
> hard to detect small such small memory leak.
> 
> In my experince, Andrew perfered stable marking for such a obvious
> problem but simple fix like this but not sure so let's pass the decision
> to him and will learn a lesson from him and will follow the decision
> from now on.

Yes, I intended to pass the decision to others. :)

> 
> Thanks.
> 
> Acked-by: Minchan Kim <minchan@kernel.org>

Thanks.
