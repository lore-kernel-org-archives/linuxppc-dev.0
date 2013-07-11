Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client did not present a certificate)
 by ozlabs.org (Postfix) with ESMTPS id AD4ED2C02F1
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 11 Jul 2013 22:37:22 +1000 (EST)
Message-ID: <1373546233.19894.85.camel@pasglop>
Subject: Re: [PATCH 8/8] KVM: PPC: Add hugepage support for IOMMU in-kernel
 handling
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Alexander Graf <agraf@suse.de>
Date: Thu, 11 Jul 2013 22:37:13 +1000
In-Reply-To: <902F79B9-BB81-40A0-865D-94E7108DAC5E@suse.de>
References: <1373123227-22969-1-git-send-email-aik@ozlabs.ru>
 <1373123227-22969-9-git-send-email-aik@ozlabs.ru>
 <51DC4923.5010501@suse.de> <51DE7377.1060503@ozlabs.ru>
 <902F79B9-BB81-40A0-865D-94E7108DAC5E@suse.de>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Cc: kvm@vger.kernel.org, Alexey Kardashevskiy <aik@ozlabs.ru>,
 linux-kernel@vger.kernel.org, kvm-ppc@vger.kernel.org,
 Alex Williamson <alex.williamson@redhat.com>,
 Paul Mackerras <paulus@samba.org>, linuxppc-dev@lists.ozlabs.org,
 David Gibson <david@gibson.dropbear.id.au>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Thu, 2013-07-11 at 11:52 +0200, Alexander Graf wrote:
> > Where exactly (it is rather SPAPR_TCE_IOMMU but does not really
> matter)?
> > Select it on KVM_BOOK3S_64? CONFIG_KVM_BOOK3S_64_HV?
> > CONFIG_KVM_BOOK3S_64_PR? PPC_BOOK3S_64?
> 
> I'd say the most logical choice would be to check the Makefile and see
> when it gets compiled. For those cases we want it enabled.

What *what* gets compiled ? You know our Makefile, it's crap :-)

We enable built-in things when CONFIG_KVM=m (which means you cannot take
a kernel build with CONFIG_KVM not set, enable CONFIG_KVM=m, and just
build the module, it won't work).

We could use KVM_BOOK3S_64 maybe ?

> > I am trying to imagine a configuration where we really do not want
> > IOMMU_API. Ben mentioned PPC32 and embedded PPC64 and that's it so
> any of
> > BOOK3S (KVM_BOOK3S_64 is the best) should be fine, no?
> 
> book3s_32 doesn't want this, but any book3s_64 implementation could
> potentially use it, yes. That's pretty much what the Makefile tells
> you too :).

Not really no. But that would do. You could have give a more useful
answer in the first place though rather than stringing him along.

Cheers,
Ben.
