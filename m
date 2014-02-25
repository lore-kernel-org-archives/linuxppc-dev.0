Return-Path: <alistair@popple.id.au>
Received: from ipmail06.adl2.internode.on.net (ipmail06.adl2.internode.on.net
 [IPv6:2001:44b8:8060:ff02:300:1:2:6])
 by ozlabs.org (Postfix) with ESMTP id DC67F2C00B9
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 25 Feb 2014 16:55:01 +1100 (EST)
From: Alistair Popple <alistair@popple.id.au>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: Re: [PATCH 7/7] powerpc: Added PCI MSI support using the HSTA module
Date: Tue, 25 Feb 2014 16:54:58 +1100
Message-ID: <1541869.UgdfUgWYNB@mexican>
In-Reply-To: <1393015286.6771.110.camel@pasglop>
References: <1392964293-13687-1-git-send-email-alistair@popple.id.au>
 <1574137.lzDhNaVqIe@wuerfel> <1393015286.6771.110.camel@pasglop>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Cc: devicetree@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
 linux-kernel@vger.kernel.org, Arnd Bergmann <arnd@arndb.de>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Sat, 22 Feb 2014 07:41:26 Benjamin Herrenschmidt wrote:
> On Fri, 2014-02-21 at 15:33 +0100, Arnd Bergmann wrote:

[...]

> 
> Should we (provided it's possible in HW) create two ranges instead ? One
> covering RAM and one covering MSIs ? To avoid stray DMAs whacking random
> HW registers in the chip ...
> 

The thought occurred to me but I figured if we had stray DMAs then they could 
already whack random bits of system memory which would likely break your 
system anyway so I wasn't sure how much we'd gain. I guess whacking random HW 
registers is arguably a bit worse though.

I did a bit of digging into the HW documentation and it looks like it _may_ be 
possible to create a second range that would limit access to a subset of HW 
registers, although there doesn't seem to be much flexibility. Personally I'm 
not sure it justifies the work, but I'm happy to look into it a bit more if 
you feel it's important?

- Alistair
