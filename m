Return-Path: <keith.busch@intel.com>
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
 by lists.ozlabs.org (Postfix) with ESMTP id 222B51A0CD4
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 31 Oct 2015 08:48:51 +1100 (AEDT)
Date: Fri, 30 Oct 2015 21:48:48 +0000
From: Keith Busch <keith.busch@intel.com>
To: Nishanth Aravamudan <nacc@linux.vnet.ibm.com>
Cc: Christoph Hellwig <hch@infradead.org>, aik@ozlabs.ru,
 linux-kernel@vger.kernel.org, linux-nvme@lists.infradead.org,
 paulus@samba.org, sparclinux@vger.kernel.org, willy@linux.intel.com,
 linuxppc-dev@lists.ozlabs.org, David Miller <davem@davemloft.net>,
 david@gibson.dropbear.id.au
Subject: Re: [PATCH 1/1 v3] drivers/nvme: default to 4k device page size
Message-ID: <20151030214848.GC13904@localhost.localdomain>
References: <20151026.182746.1323901353520152838.davem@davemloft.net>
 <20151027222010.GD7716@linux.vnet.ibm.com>
 <20151027223643.GA25332@localhost.localdomain>
 <20151027.175443.140992924519172506.davem@davemloft.net>
 <20151028135922.GA27909@localhost.localdomain>
 <20151029115536.GA28090@infradead.org>
 <20151029155701.GJ7716@linux.vnet.ibm.com>
 <20151029172043.GA8343@localhost.localdomain>
 <20151030213511.GK7716@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20151030213511.GK7716@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Fri, Oct 30, 2015 at 02:35:11PM -0700, Nishanth Aravamudan wrote:
> Given that it's 4K just about everywhere by default (and sort of
> implicitly expected to be, I guess), I think I'd prefer we default to
> 4K. That should mitigate the performance impact (I'll ask our IO team to
> do some runs, but since this impacts functionality on some hardware, I
> don't think it's too relevant for now). Unless there are NVMe devcies
> with a MPSMAX < 4K? 

Right, I assumed MPSMIN was always 4k for the same reason you mentioned,
but you can hard code it like you've done in your patch.

The spec defines MPSMAX such that it's impossible to find a device
with MPSMAX < 4k.
