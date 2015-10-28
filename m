Return-Path: <nacc@linux.vnet.ibm.com>
Received: from e34.co.us.ibm.com (e34.co.us.ibm.com [32.97.110.152])
 (using TLSv1 with cipher CAMELLIA256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 50A841A0F10
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 28 Oct 2015 13:30:37 +1100 (AEDT)
Received: from localhost
 by e34.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <nacc@linux.vnet.ibm.com>;
 Tue, 27 Oct 2015 20:30:34 -0600
Received: from b03cxnp08025.gho.boulder.ibm.com
 (b03cxnp08025.gho.boulder.ibm.com [9.17.130.17])
 by d03dlp02.boulder.ibm.com (Postfix) with ESMTP id 7ADA33E4003B
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 27 Oct 2015 20:30:32 -0600 (MDT)
Received: from d03av04.boulder.ibm.com (d03av04.boulder.ibm.com [9.17.195.170])
 by b03cxnp08025.gho.boulder.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 t9S2T8vj65405032
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 27 Oct 2015 19:29:08 -0700
Received: from d03av04.boulder.ibm.com (loopback [127.0.0.1])
 by d03av04.boulder.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 t9S2UU6a001144
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 27 Oct 2015 20:30:31 -0600
Date: Tue, 27 Oct 2015 19:30:28 -0700
From: Nishanth Aravamudan <nacc@linux.vnet.ibm.com>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: Alexey Kardashevskiy <aik@ozlabs.ru>,
 Michael Ellerman <mpe@ellerman.id.au>,
 Matthew Wilcox <willy@linux.intel.com>,
 Keith Busch <keith.busch@intel.com>, Paul Mackerras <paulus@samba.org>,
 David Gibson <david@gibson.dropbear.id.au>,
 Christoph Hellwig <hch@infradead.org>,
 "David S. Miller" <davem@davemloft.net>,
 linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org,
 linuxppc-dev@lists.ozlabs.org, sparclinux@vger.kernel.org
Subject: Re: [PATCH 2/7 v2] powerpc/dma-mapping: override dma_get_page_shift
Message-ID: <20151028023028.GI7716@linux.vnet.ibm.com>
References: <20151023205420.GA10197@linux.vnet.ibm.com>
 <20151023205718.GC10197@linux.vnet.ibm.com>
 <562F1368.1030204@ozlabs.ru>
 <20151027222706.GF7716@linux.vnet.ibm.com>
 <56301E24.1060304@ozlabs.ru>
 <20151028015451.GH7716@linux.vnet.ibm.com>
 <1445998805.1856.24.camel@kernel.crashing.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1445998805.1856.24.camel@kernel.crashing.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 28.10.2015 [11:20:05 +0900], Benjamin Herrenschmidt wrote:
> On Tue, 2015-10-27 at 18:54 -0700, Nishanth Aravamudan wrote:
> > 
> > In "bypass" mode, what TCE size is used? Is it guaranteed to be 4K?
> 
> None :-) The TCEs are completely bypassed. You get a N:M linear mapping
> of all memory starting at 1<<59 PCI side.

Err, duh, sorry! Ok, so in that case, DMA page shift is PAGE_SHIFT,
then?

-Nish
