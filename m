Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id E0AD51A0035
 for <linuxppc-dev@lists.ozlabs.org>; Sat,  3 Oct 2015 07:37:42 +1000 (AEST)
Message-ID: <1443821709.27295.20.camel@kernel.crashing.org>
Subject: Re: [PATCH 0/5 v2] Fix NVMe driver support on Power with 32-bit DMA
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Nishanth Aravamudan <nacc@linux.vnet.ibm.com>
Cc: Matthew Wilcox <willy@linux.intel.com>, Keith Busch
 <keith.busch@intel.com>, Paul Mackerras <paulus@samba.org>, Michael
 Ellerman <mpe@ellerman.id.au>, Alexey Kardashevskiy <aik@ozlabs.ru>, David
 Gibson <david@gibson.dropbear.id.au>, Christoph Hellwig
 <hch@infradead.org>, linux-nvme@lists.infradead.org,
 linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
Date: Sat, 03 Oct 2015 07:35:09 +1000
In-Reply-To: <20151002210435.GM8040@linux.vnet.ibm.com>
References: <20151002171606.GA41011@linux.vnet.ibm.com>
 <20151002200953.GB40695@linux.vnet.ibm.com>
 <1443819066.27295.19.camel@kernel.crashing.org>
 <20151002210435.GM8040@linux.vnet.ibm.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Fri, 2015-10-02 at 14:04 -0700, Nishanth Aravamudan wrote:
> Right, I did start with your advice and tried that approach, but it
> turned out I was wrong about the actual issue at the time. The problem
> for NVMe isn't actually the starting address alignment (which it can
> handle not being aligned to the device's page size). It doesn't handle
> (addr + len % dev_page_size != 0). That is, it's really a length
> alignment issue.
> 
> It seems incredibly device specific to have a an API into the DMA code
> to request an end alignment -- no other device seems to have this
> issue/design. If you think that's better, I can fiddle with that
> instead.
> 
> Sorry, I should have called this out better as an alternative
> consideration.

Nah it's fine. Ok. Also adding the alignment requirement to the API
would have been a much more complex patch since it would have had to
be implemented for all archs.

I think your current solution is fine.

Cheers,
Ben.
