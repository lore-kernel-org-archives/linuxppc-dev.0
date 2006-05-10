Return-Path: <davem@davemloft.net>
Received: from sunset.davemloft.net (dsl027-180-168.sfo1.dsl.speakeasy.net
	[216.27.180.168]) (using TLSv1 with cipher AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id E4010679EB
	for <linuxppc-dev@ozlabs.org>; Wed, 10 May 2006 16:40:00 +1000 (EST)
Date: Tue, 09 May 2006 23:39:58 -0700 (PDT)
Message-Id: <20060509.233958.73723993.davem@davemloft.net>
To: paulus@samba.org
Subject: Re: [RFC/PATCH] Make powerpc64 use __thread for per-cpu variables
From: "David S. Miller" <davem@davemloft.net>
In-Reply-To: <17505.34919.750295.170941@cargo.ozlabs.ibm.com>
References: <17505.26159.807484.477212@cargo.ozlabs.ibm.com>
	<20060510051649.GD1794@lixom.net>
	<17505.34919.750295.170941@cargo.ozlabs.ibm.com>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Cc: olof@lixom.net, linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org,
	linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

From: Paul Mackerras <paulus@samba.org>
Date: Wed, 10 May 2006 16:29:59 +1000

> I have moved current, smp_processor_id and a couple of other things to
> per-cpu variables, and that results in the kernel text being about 8k
> smaller than without any of these __thread patches.  Performance seems
> to be very slightly better but it's hard to be sure that the change is
> statistically significant, from the measurements I've done so far.

That first cache line of current_thread_info() should be so hot that
it's probably just fine to use current_thread_info()->task since
you're just doing a mask on a fixed register (r1) to implement that.
