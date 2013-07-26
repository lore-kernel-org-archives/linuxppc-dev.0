Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client did not present a certificate)
 by ozlabs.org (Postfix) with ESMTPS id 33B482C00F3
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 27 Jul 2013 08:26:50 +1000 (EST)
Message-ID: <1374877600.9200.28.camel@pasglop>
Subject: Re: [PATCH 4/4] kvm: powerpc: set cache coherency only for RAM pages
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Bhushan Bharat-R65777 <R65777@freescale.com>
Date: Sat, 27 Jul 2013 08:26:40 +1000
In-Reply-To: <6A3DF150A5B70D4F9B66A25E3F7C888D070E5761@039-SN2MPN1-013.039d.mgd.msft.net>
References: <1374817613-20169-1-git-send-email-Bharat.Bhushan@freescale.com>
 <1374817613-20169-4-git-send-email-Bharat.Bhushan@freescale.com>
 <1374827190.6142.124.camel@pasglop>
 <6CF0D65E-76B6-4CDD-BADC-44DCCC8CAFF6@suse.de>
 <6A3DF150A5B70D4F9B66A25E3F7C888D070E5761@039-SN2MPN1-013.039d.mgd.msft.net>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Cc: Wood Scott-B07421 <B07421@freescale.com>,
 "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>,
 Alexander Graf <agraf@suse.de>,
 "kvm-ppc@vger.kernel.org" <kvm-ppc@vger.kernel.org>,
 "kvm@vger.kernel.org" <kvm@vger.kernel.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Fri, 2013-07-26 at 15:03 +0000, Bhushan Bharat-R65777 wrote:
> Will not searching the Linux PTE is a overkill?

That's the best approach. Also we are searching it already to resolve
the page fault. That does mean we search twice but on the other hand
that also means it's hot in the cache.

Cheers,
Ben
