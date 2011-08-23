Return-Path: <davem@davemloft.net>
Received: from shards.monkeyblade.net (shards.monkeyblade.net [198.137.202.13])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id C7DFFB6F97
	for <linuxppc-dev@lists.ozlabs.org>;
	Tue, 23 Aug 2011 14:07:18 +1000 (EST)
Date: Mon, 22 Aug 2011 21:02:55 -0700 (PDT)
Message-Id: <20110822.210255.1902105215409964106.davem@davemloft.net>
To: lacombar@gmail.com
Subject: Re: linux-next: boot test failure (net tree)
From: David Miller <davem@davemloft.net>
In-Reply-To: <CACqU3MW4BnucRt3gxPrKPDvWEjaVuxRF1VOPWk5hTRfneyANkg@mail.gmail.com>
References: <20110823114129.ceb18da164bf7df3c145941b@canb.auug.org.au>
	<20110822.191348.2099822249437201579.davem@davemloft.net>
	<CACqU3MW4BnucRt3gxPrKPDvWEjaVuxRF1VOPWk5hTRfneyANkg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Cc: sfr@canb.auug.org.au, mikey@neuling.org, linux-kbuild@vger.kernel.org,
	netdev@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
	linux-kernel@vger.kernel.org, linux-next@vger.kernel.org,
	paulus@samba.org, jeffrey.t.kirsher@intel.com,
	akpm@linux-foundation.org, torvalds@linux-foundation.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

From: Arnaud Lacombe <lacombar@gmail.com>
Date: Mon, 22 Aug 2011 23:50:02 -0400

> Are you implying we need some kind of way to migrate config ?

The issue is that the dependencies for every single ethernet driver
have changed.  Some dependencies have been dropped (f.e. NETDEV_10000
and some have been added (f.e. ETHERNET, NET_VENDOR_****)

So right now an automated (non-prompted, default to no on all new
options) run on an existing config results in all ethernet drivers
getting disabled because the new dependencies don't get enabled.

This wouldn't be so bad if it was just one or two drivers, but in
this case it's every single ethernet driver which will have and hit
this problem.
