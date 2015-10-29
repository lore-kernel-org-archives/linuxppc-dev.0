Return-Path: <BATV+0025e96819a5a6961c09+4449+infradead.org+hch@bombadil.srs.infradead.org>
Received: from bombadil.infradead.org (bombadil.infradead.org
 [IPv6:2001:1868:205::9])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 66A981A0B5F
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 29 Oct 2015 22:55:51 +1100 (AEDT)
Date: Thu, 29 Oct 2015 04:55:36 -0700
From: Christoph Hellwig <hch@infradead.org>
To: "Busch, Keith" <keith.busch@intel.com>
Cc: David Miller <davem@davemloft.net>, aik@ozlabs.ru, mpe@ellerman.id.au,
 nacc@linux.vnet.ibm.com, linux-kernel@vger.kernel.org,
 linux-nvme@lists.infradead.org, hch@infradead.org, paulus@samba.org,
 benh@kernel.crashing.org, sparclinux@vger.kernel.org,
 willy@linux.intel.com, linuxppc-dev@lists.ozlabs.org,
 david@gibson.dropbear.id.au
Subject: Re: [PATCH 0/5 v3] Fix NVMe driver support on Power with 32-bit DMA
Message-ID: <20151029115536.GA28090@infradead.org>
References: <20151026.182746.1323901353520152838.davem@davemloft.net>
 <20151027222010.GD7716@linux.vnet.ibm.com>
 <20151027223643.GA25332@localhost.localdomain>
 <20151027.175443.140992924519172506.davem@davemloft.net>
 <20151028135922.GA27909@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20151028135922.GA27909@localhost.localdomain>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Wed, Oct 28, 2015 at 01:59:23PM +0000, Busch, Keith wrote:
> The "new" interface for all the other architectures is the same as the
> old one we've been using for the last 5 years.
> 
> I welcome x86 maintainer feedback to confirm virtual and DMA addresses
> have the same offset at 4k alignment, but I have to insist we don't
> break my currently working hardware to force their attention.

We had a quick cht about this issue and I think we simply should
default to a NVMe controler page size of 4k everywhere as that's the
safe default.  This is also what we do for RDMA Memory reigstrations and
it works fine there for SRP and iSER.
