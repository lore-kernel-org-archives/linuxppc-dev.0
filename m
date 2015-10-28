Return-Path: <nacc@linux.vnet.ibm.com>
Received: from e18.ny.us.ibm.com (e18.ny.us.ibm.com [129.33.205.208])
 (using TLSv1 with cipher CAMELLIA256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id B73C61A041D
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 28 Oct 2015 12:53:04 +1100 (AEDT)
Received: from localhost
 by e18.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <nacc@linux.vnet.ibm.com>;
 Tue, 27 Oct 2015 21:53:01 -0400
Received: from b01cxnp23033.gho.pok.ibm.com (b01cxnp23033.gho.pok.ibm.com
 [9.57.198.28])
 by d01dlp02.pok.ibm.com (Postfix) with ESMTP id 869B46E8047
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 27 Oct 2015 21:41:10 -0400 (EDT)
Received: from d01av03.pok.ibm.com (d01av03.pok.ibm.com [9.56.224.217])
 by b01cxnp23033.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 t9S1qxOh64421934
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 28 Oct 2015 01:52:59 GMT
Received: from d01av03.pok.ibm.com (localhost [127.0.0.1])
 by d01av03.pok.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 t9S1quIA023870
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 27 Oct 2015 21:52:59 -0400
Date: Tue, 27 Oct 2015 18:52:55 -0700
From: Nishanth Aravamudan <nacc@linux.vnet.ibm.com>
To: David Miller <davem@davemloft.net>
Cc: willy@linux.intel.com, keith.busch@intel.com, benh@kernel.crashing.org,
 paulus@samba.org, mpe@ellerman.id.au, aik@ozlabs.ru,
 david@gibson.dropbear.id.au, hch@infradead.org,
 linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org,
 linuxppc-dev@lists.ozlabs.org, sparclinux@vger.kernel.org
Subject: Re: [PATCH 0/5 v3] Fix NVMe driver support on Power with 32-bit DMA
Message-ID: <20151028015255.GG7716@linux.vnet.ibm.com>
References: <20151023205420.GA10197@linux.vnet.ibm.com>
 <20151026.182746.1323901353520152838.davem@davemloft.net>
 <20151027222010.GD7716@linux.vnet.ibm.com>
 <20151027.175322.247163553940004154.davem@davemloft.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20151027.175322.247163553940004154.davem@davemloft.net>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 27.10.2015 [17:53:22 -0700], David Miller wrote:
> From: Nishanth Aravamudan <nacc@linux.vnet.ibm.com>
> Date: Tue, 27 Oct 2015 15:20:10 -0700
> 
> > Well, looks like I should spin up a v4 anyways for the powerpc changes.
> > So, to make sure I understand your point, should I make the generic
> > dma_get_page_shift a compile-error kind of thing? It will only fail on
> > architectures that actually build the NVME driver (as the only caller).
> > But I'm not sure how exactly to achieve that, if you could give a bit
> > more detail I'd appreciate it!
> 
> Yes, I am basically suggesting to simply not provide a default at all.

For my own edification -- what is the way that gets resolved? I guess I
mean it seems like linux-next would cease to compile because of my new
series. Would my patches just get kicked out of -next for introducing
that (or even via the 0-day notifications), or should I put something
into the commit message indicating it is an API introduction?

Sorry for the tentativeness, I have not introduce a cross-architecture
API like this before.

Thanks,
Nish

> 
