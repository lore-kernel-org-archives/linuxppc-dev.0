Return-Path: <davem@davemloft.net>
Received: from sunset.davemloft.net (dsl027-180-168.sfo1.dsl.speakeasy.net
	[216.27.180.168]) (using TLSv1 with cipher AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 8BF48679F3
	for <linuxppc-dev@ozlabs.org>; Thu, 11 May 2006 10:11:37 +1000 (EST)
Date: Wed, 10 May 2006 17:11:27 -0700 (PDT)
Message-Id: <20060510.171127.42619262.davem@davemloft.net>
To: paulus@samba.org
Subject: Re: [RFC/PATCH] Make powerpc64 use __thread for per-cpu variables
From: "David S. Miller" <davem@davemloft.net>
In-Reply-To: <17506.31456.68099.57515@cargo.ozlabs.ibm.com>
References: <20060510154702.GA28938@twiddle.net>
	<17506.29128.591758.502430@cargo.ozlabs.ibm.com>
	<17506.31456.68099.57515@cargo.ozlabs.ibm.com>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Cc: linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org,
	linuxppc-dev@ozlabs.org, amodra@bigpond.net, rth@twiddle.net, t@twiddle.net
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

From: Paul Mackerras <paulus@samba.org>
Date: Thu, 11 May 2006 09:44:32 +1000

> That means we lose the possible optimization of combining the addi
> into a following load or store.  Bah.  However, I guess it's still
> better than what we do at the moment.

If you have to hide the operation so deeply like this, maybe you can
do something similar to sparc64, by explicitly doing the per-cpu fixed
register and offsets, and still get the single instruction relocs that
powerpc can do for up to 64K by doing something like:

	&per_cpu_blah - &per_cpu_base

to calculate the offset.
