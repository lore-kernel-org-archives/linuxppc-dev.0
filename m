Return-Path: <nacc@linux.vnet.ibm.com>
Received: from e17.ny.us.ibm.com (e17.ny.us.ibm.com [129.33.205.207])
 (using TLSv1 with cipher CAMELLIA256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id F34121A0013
 for <linuxppc-dev@lists.ozlabs.org>; Sat,  3 Oct 2015 07:51:22 +1000 (AEST)
Received: from localhost
 by e17.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <nacc@linux.vnet.ibm.com>;
 Fri, 2 Oct 2015 17:51:20 -0400
Received: from b01cxnp23033.gho.pok.ibm.com (b01cxnp23033.gho.pok.ibm.com
 [9.57.198.28])
 by d01dlp03.pok.ibm.com (Postfix) with ESMTP id 205F3C90105
 for <linuxppc-dev@lists.ozlabs.org>; Fri,  2 Oct 2015 17:36:16 -0400 (EDT)
Received: from d01av03.pok.ibm.com (d01av03.pok.ibm.com [9.56.224.217])
 by b01cxnp23033.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 t92Lm4RC64159954
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 2 Oct 2015 21:48:04 GMT
Received: from d01av03.pok.ibm.com (localhost [127.0.0.1])
 by d01av03.pok.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 t92Lm1UO021974
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 2 Oct 2015 17:48:03 -0400
Date: Fri, 2 Oct 2015 14:48:00 -0700
From: Nishanth Aravamudan <nacc@linux.vnet.ibm.com>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: Matthew Wilcox <willy@linux.intel.com>,
 Keith Busch <keith.busch@intel.com>, Paul Mackerras <paulus@samba.org>,
 Michael Ellerman <mpe@ellerman.id.au>,
 Alexey Kardashevskiy <aik@ozlabs.ru>,
 David Gibson <david@gibson.dropbear.id.au>,
 Christoph Hellwig <hch@infradead.org>, linux-nvme@lists.infradead.org,
 linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
Subject: Re: [PATCH 0/5 v2] Fix NVMe driver support on Power with 32-bit DMA
Message-ID: <20151002214800.GN8040@linux.vnet.ibm.com>
References: <20151002171606.GA41011@linux.vnet.ibm.com>
 <20151002200953.GB40695@linux.vnet.ibm.com>
 <1443819066.27295.19.camel@kernel.crashing.org>
 <20151002210435.GM8040@linux.vnet.ibm.com>
 <1443821709.27295.20.camel@kernel.crashing.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1443821709.27295.20.camel@kernel.crashing.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 03.10.2015 [07:35:09 +1000], Benjamin Herrenschmidt wrote:
> On Fri, 2015-10-02 at 14:04 -0700, Nishanth Aravamudan wrote:
> > Right, I did start with your advice and tried that approach, but it
> > turned out I was wrong about the actual issue at the time. The problem
> > for NVMe isn't actually the starting address alignment (which it can
> > handle not being aligned to the device's page size). It doesn't handle
> > (addr + len % dev_page_size != 0). That is, it's really a length
> > alignment issue.
> > 
> > It seems incredibly device specific to have a an API into the DMA code
> > to request an end alignment -- no other device seems to have this
> > issue/design. If you think that's better, I can fiddle with that
> > instead.
> > 
> > Sorry, I should have called this out better as an alternative
> > consideration.
> 
> Nah it's fine. Ok. Also adding the alignment requirement to the API
> would have been a much more complex patch since it would have had to
> be implemented for all archs.
> 
> I think your current solution is fine.

Great, thanks. Also, while it's possible an alignment API would be more
performant...we're already not using DDW on Power in this case,
performance is not a primary concern. We want to simply be
functional/correct in this configuration.

-Nish
