Return-Path: <hollisb@us.ibm.com>
Received: from e35.co.us.ibm.com (e35.co.us.ibm.com [32.97.110.153])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e35.co.us.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id 29196B7C06
	for <linuxppc-dev@lists.ozlabs.org>;
	Tue, 29 Sep 2009 10:00:22 +1000 (EST)
Received: from d03relay02.boulder.ibm.com (d03relay02.boulder.ibm.com
	[9.17.195.227])
	by e35.co.us.ibm.com (8.14.3/8.13.1) with ESMTP id n8SNntYs006643
	for <linuxppc-dev@lists.ozlabs.org>; Mon, 28 Sep 2009 17:49:55 -0600
Received: from d03av03.boulder.ibm.com (d03av03.boulder.ibm.com [9.17.195.169])
	by d03relay02.boulder.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
	n8T00DCF250502
	for <linuxppc-dev@lists.ozlabs.org>; Mon, 28 Sep 2009 18:00:13 -0600
Received: from d03av03.boulder.ibm.com (loopback [127.0.0.1])
	by d03av03.boulder.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id
	n8T00CHV031733
	for <linuxppc-dev@lists.ozlabs.org>; Mon, 28 Sep 2009 18:00:13 -0600
Subject: Re: linux-next: tree build failure
From: Hollis Blanchard <hollisb@us.ibm.com>
To: Stephen Rothwell <sfr@canb.auug.org.au>
In-Reply-To: <20090924152102.8d7d40cf.sfr@canb.auug.org.au>
References: <20090924152102.8d7d40cf.sfr@canb.auug.org.au>
Content-Type: text/plain
Date: Mon, 28 Sep 2009 17:00:09 -0700
Message-Id: <1254182409.15622.154.camel@slab.beaverton.ibm.com>
Mime-Version: 1.0
Cc: linux-kernel@vger.kernel.org, kvm-ppc@vger.kernel.org,
	linux-next@vger.kernel.org, Jan Beulich <JBeulich@novell.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	ppc-dev <linuxppc-dev@lists.ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Thu, 2009-09-24 at 15:21 +1000, Stephen Rothwell wrote:
> Hi all,
> 
> Today's linux-next build (powerpc ppc44x_defconfig) failed like this:
> 
> In file included from arch/powerpc/kvm/booke.c:31:
> arch/powerpc/kvm/timing.h: In function 'kvmppc_account_exit_stat':
> arch/powerpc/kvm/timing.h:51: error: bit-field '<anonymous>' width not an integer constant
> In file included from arch/powerpc/kvm/booke.h:26,
>                  from arch/powerpc/kvm/booke_emulate.c:23:
> arch/powerpc/kvm/timing.h: In function 'kvmppc_account_exit_stat':
> arch/powerpc/kvm/timing.h:51: error: bit-field '<anonymous>' width not an integer constant
> 
> Presumably caused by commit 8c87df457cb58fe75b9b893007917cf8095660a0
> ("BUILD_BUG_ON(): fix it and a couple of bogus uses of it").

First, I think there is a real bug here, and the code should read like
this (to match the comment):
 	/* type has to be known at build time for optimization */
-	BUILD_BUG_ON(__builtin_constant_p(type));
+	BUILD_BUG_ON(!__builtin_constant_p(type));

However, I get the same build error *both* ways, i.e.
__builtin_constant_p(type) evaluates to both 0 and 1? Either that, or
the new BUILD_BUG_ON() macro isn't working...

> I applied the following patch for today.  This inline function is
> only called from one place in one file ...

It's also called via kvmppc_account_exit() from a number of places.

-- 
Hollis Blanchard
IBM Linux Technology Center
