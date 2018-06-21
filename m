Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 41B2rY19GDzF12T
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 21 Jun 2018 10:39:08 +1000 (AEST)
Message-ID: <c03e5e63fb64d2bf503bb2e00101bf352e396ceb.camel@kernel.crashing.org>
Subject: Re: [PATCH] arch: powerpc: pci-common: fix wrong return value check
 on phd_id
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Michael Ellerman <mpe@ellerman.id.au>, Daniel Walker <danielwa@cisco.com>,
 "Guilherme G. Piccoli" <guilherme@gpiccoli.net>
Cc: Andrew Morton <akpm@linux-foundation.org>, xe-kernel@external.cisco.com,
 linux-kernel@vger.kernel.org, Paul Mackerras <paulus@samba.org>,
 linuxppc-dev@lists.ozlabs.org, Mauro Rodrigues
 <maurosr@linux.vnet.ibm.com>, linux-pci@vger.kernel.org
Date: Thu, 21 Jun 2018 10:38:46 +1000
In-Reply-To: <87in6dvv89.fsf@concordia.ellerman.id.au>
References: <20180618165706.42679-1-danielwa@cisco.com>
 <CALJn8nPbTy3Ne2a7L71c2YZ06Ccr2j0zs6TdptfRc7O-N9u=Yg@mail.gmail.com>
 <c56f43f5-7902-f7c8-20e1-955ad064c4d0@cisco.com>
 <CALJn8nM+S7STs+_MTje1qVCpa6MvnROS2+b5_GDz2wYs8etapA@mail.gmail.com>
 <6d321d8a-432d-d41d-cc08-144764d644b2@cisco.com>
 <87in6dvv89.fsf@concordia.ellerman.id.au>
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

On Thu, 2018-06-21 at 10:28 +1000, Michael Ellerman wrote:
> 
> That's true, though I think yours is the first report we've had of
> problems.
> 
> The old behaviour relied on device tree ordering in nearly all cases, so
> you basically get whatever order your firmware happened to flatten the
> device tree in.
> 
> That tends to be consistent on a single system or with a single firmware
> version, but it's not stable in general. If your firmware changes, or
> you kexec then the ordering can change.
> 
> So I'd definitely prefer we didn't go back to that behaviour, because
> it's basically "random order".
> 
> If there's anything you can do on your end to cope with the ne

I think the numbering change has to be coped with. However:

The main issue I see is that it somewhat hard wires that "reg"
is a 64-bit property with the "interesting" bits in the bottom,
and that "interesting" part somewhat happens to fit in 16-bits.

It would have been better to get the full address out of reg (using the
appropriate size specified in the parent #address-cells) and hash it.

Cheers,
Ben.
