Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id A7EAF1A025A
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 27 Mar 2015 10:51:59 +1100 (AEDT)
Message-ID: <1427413903.6468.151.camel@kernel.crashing.org>
Subject: Re: Generic IOMMU pooled allocator
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: David Miller <davem@davemloft.net>
Date: Fri, 27 Mar 2015 10:51:43 +1100
In-Reply-To: <20150326.160020.1865957868633778207.davem@davemloft.net>
References: <1427162890.4770.307.camel@kernel.crashing.org>
 <20150323.221508.1178754097347144400.davem@davemloft.net>
 <20150326004342.GB4925@oc0812247204.ltc.br.ibm.com>
 <20150326.160020.1865957868633778207.davem@davemloft.net>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Cc: aik@au1.ibm.com, aik@ozlabs.ru, sowmini.varadhan@oracle.com,
 anton@au1.ibm.com, paulus@samba.org, sparclinux@vger.kernel.org,
 linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Thu, 2015-03-26 at 16:00 -0700, David Miller wrote:
> From: cascardo@linux.vnet.ibm.com
> Date: Wed, 25 Mar 2015 21:43:42 -0300
> 
> > On Mon, Mar 23, 2015 at 10:15:08PM -0400, David Miller wrote:
> >> From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
> >> Date: Tue, 24 Mar 2015 13:08:10 +1100
> >> 
> >> > For the large pool, we don't keep a hint so we don't know it's
> >> > wrapped, in fact we purposefully don't use a hint to limit
> >> > fragmentation on it, but then, it should be used rarely enough that
> >> > flushing always is, I suspect, a good option.
> >> 
> >> I can't think of any use case where the largepool would be hit a lot
> >> at all.
> > 
> > Well, until recently, IOMMU_PAGE_SIZE was 4KiB on Power, so every time a
> > driver mapped a whole 64KiB page, it would hit the largepool.
> 
> We don't plan to ever use 64KB page size on sparc64, so I think we're
> safe there.
> 
> There are many reasons using 64KB pages is really stupid, what you
> see here with the IOMMU stuff is just one of many symptoms, but I bet
> your powerpc guys are kind of sick of hearing it by now... :-)

Lalalala :-)

Cheers,
Ben.
