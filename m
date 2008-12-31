Return-Path: <davem@davemloft.net>
Received: from sunset.davemloft.net (unknown [74.93.104.97])
	by ozlabs.org (Postfix) with ESMTP id 93A5DDDECF
	for <linuxppc-dev@ozlabs.org>; Wed, 31 Dec 2008 16:50:03 +1100 (EST)
Date: Tue, 30 Dec 2008 21:49:59 -0800 (PST)
Message-Id: <20081230.214959.141224132.davem@davemloft.net>
To: sfr@canb.auug.org.au
Subject: Re: [PATCH] ibmveth: use consistent types
From: David Miller <davem@davemloft.net>
In-Reply-To: <20081231140225.48b695ef.sfr@canb.auug.org.au>
References: <20081231140225.48b695ef.sfr@canb.auug.org.au>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Cc: netdev@vger.kernel.org, linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

From: Stephen Rothwell <sfr@canb.auug.org.au>
Date: Wed, 31 Dec 2008 14:02:25 +1100

> These variables are only used with an interface involving "unsigned
> long" and the macros are only used with these variables.  This change
> will prevent some warnings when we change u64 to "unsigned long long".
> 
> This code is only built for 64bit powerpc, so the transformation is
> really a noop.
> 
> Signed-off-by: Stephen Rothwell <sfr@canb.auug.org.au>

I'd prefer if the types were to remain 32-bit portable.

Doing things like this is just a problem waiting to happen,
either for the first person who actually finds a need and
a way to use this driver on 32-bit or the person who cut and
pastes this code into their driver which should work on both
32-bit and 64-bit.

Patch not applied.
