Return-Path: <keith.busch@intel.com>
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
 by lists.ozlabs.org (Postfix) with ESMTP id D67311A0BBB
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 29 Oct 2015 00:59:30 +1100 (AEDT)
Date: Wed, 28 Oct 2015 13:59:23 +0000
From: "Busch, Keith" <keith.busch@intel.com>
To: David Miller <davem@davemloft.net>
Cc: nacc@linux.vnet.ibm.com, willy@linux.intel.com,
 benh@kernel.crashing.org, paulus@samba.org, mpe@ellerman.id.au,
 aik@ozlabs.ru, david@gibson.dropbear.id.au, hch@infradead.org,
 linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org,
 linuxppc-dev@lists.ozlabs.org, sparclinux@vger.kernel.org
Subject: Re: [PATCH 0/5 v3] Fix NVMe driver support on Power with 32-bit DMA
Message-ID: <20151028135922.GA27909@localhost.localdomain>
References: <20151026.182746.1323901353520152838.davem@davemloft.net>
 <20151027222010.GD7716@linux.vnet.ibm.com>
 <20151027223643.GA25332@localhost.localdomain>
 <20151027.175443.140992924519172506.davem@davemloft.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20151027.175443.140992924519172506.davem@davemloft.net>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Tue, Oct 27, 2015 at 05:54:43PM -0700, David Miller wrote:
> From: "Busch, Keith" <keith.busch@intel.com>
> Date: Tue, 27 Oct 2015 22:36:43 +0000
> 
> > If you're suggesting to compile-time break architectures that currently
> > work just fine with NVMe, let me stop you right there.
> 
> Silently "working" without the architecture maintainer having to explicity
> look at the new interface and make sure his platform is implementing it
> properly is an extremely bad practice.

It won't work if it's wrong. It'll BUG_ON, and I'll be assigned to help
fix it, like what's happened here (on a private bugzilla).

The "new" interface for all the other architectures is the same as the
old one we've been using for the last 5 years.

I welcome x86 maintainer feedback to confirm virtual and DMA addresses
have the same offset at 4k alignment, but I have to insist we don't
break my currently working hardware to force their attention.
