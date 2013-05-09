Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client did not present a certificate)
 by ozlabs.org (Postfix) with ESMTPS id 9DC8D2C00F4
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 10 May 2013 08:01:53 +1000 (EST)
Message-ID: <1368136898.3715.12.camel@pasglop>
Subject: Re: [RFC][KVM][PATCH 1/1] kvm:ppc:booke-64: soft-disable interrupts
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: David Laight <David.Laight@ACULAB.COM>
Date: Fri, 10 May 2013 08:01:38 +1000
In-Reply-To: <AE90C24D6B3A694183C094C60CF0A2F6026B722F@saturn3.aculab.com>
References: <51885F49.6060605@windriver.com>
 (from tiejun.chen@windriver.com on Mon May 6 20:56:25 2013)
 <1367892390.3398.12@snotra>
 <300B73AA675FCE4A93EB4FC1D42459FF3F00D0@039-SN2MPN1-013.039d.mgd.msft.net>
 <6A3DF150A5B70D4F9B66A25E3F7C888D0700E64A@039-SN2MPN1-011.039d.mgd.msft.net>
 <518B7014.1090508@windriver.com> <1368103062.25488.193.camel@pasglop>
 <AE90C24D6B3A694183C094C60CF0A2F6026B722F@saturn3.aculab.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Cc: Wood Scott-B07421 <B07421@freescale.com>, kvm@vger.kernel.org,
 Caraman Mihai Claudiu-B02008 <B02008@freescale.com>, agraf@suse.de,
 kvm-ppc@vger.kernel.org, "tiejun.chen" <tiejun.chen@windriver.com>,
 Bhushan Bharat-R65777 <R65777@freescale.com>, linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Thu, 2013-05-09 at 14:28 +0100, David Laight wrote:
> That will happen if the IRQ goes away while the cpu is performing
> the IACK sequence.
> If the IRQ goes away while the cpu has interrupts masked then
> the cpu won't start the interrupt sequence and then try to
> read a vector when no interrupt is pending.

Right, and get a spurrious vector which shouldn't be a big deal.

We tend to call that a "short interrupt". There have been many other
cases of short interrupts in the past, for example on some MPICs, when
distribution is enabled, they occasionally shoot an interrupt to more
than one CPU at once :-)

Cheers,
Ben.
