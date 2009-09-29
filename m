Return-Path: <hollisb@us.ibm.com>
Received: from e33.co.us.ibm.com (e33.co.us.ibm.com [32.97.110.151])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e33.co.us.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id A7DD6B7BDD
	for <linuxppc-dev@lists.ozlabs.org>;
	Wed, 30 Sep 2009 09:39:39 +1000 (EST)
Received: from d03relay04.boulder.ibm.com (d03relay04.boulder.ibm.com
	[9.17.195.106])
	by e33.co.us.ibm.com (8.14.3/8.13.1) with ESMTP id n8TNbK4k002711
	for <linuxppc-dev@lists.ozlabs.org>; Tue, 29 Sep 2009 17:37:20 -0600
Received: from d03av03.boulder.ibm.com (d03av03.boulder.ibm.com [9.17.195.169])
	by d03relay04.boulder.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
	n8TNdaIJ196840
	for <linuxppc-dev@lists.ozlabs.org>; Tue, 29 Sep 2009 17:39:36 -0600
Received: from d03av03.boulder.ibm.com (loopback [127.0.0.1])
	by d03av03.boulder.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id
	n8TNdZgu018258
	for <linuxppc-dev@lists.ozlabs.org>; Tue, 29 Sep 2009 17:39:35 -0600
Subject: Re: linux-next: tree build failure
From: Hollis Blanchard <hollisb@us.ibm.com>
To: Jan Beulich <jbeulich@novell.com>
In-Reply-To: <4AC1E15502000078000516B5@vpn.id2.novell.com>
References: <4AC1E15502000078000516B5@vpn.id2.novell.com>
Content-Type: text/plain
Date: Tue, 29 Sep 2009 16:39:32 -0700
Message-Id: <1254267572.15622.1621.camel@slab.beaverton.ibm.com>
Mime-Version: 1.0
Cc: sfr@canb.auug.org.au, linux-kernel@vger.kernel.org, kvm-ppc@vger.kernel.org,
	linux-next@vger.kernel.org, akpm@linux-foundation.org,
	linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Tue, 2009-09-29 at 10:28 +0100, Jan Beulich wrote:
> >>> Hollis Blanchard  09/29/09 2:00 AM >>>
> >First, I think there is a real bug here, and the code should read like
> >this (to match the comment):
> >    /* type has to be known at build time for optimization */
> >-    BUILD_BUG_ON(__builtin_constant_p(type));
> >+    BUILD_BUG_ON(!__builtin_constant_p(type));
> >
> >However, I get the same build error *both* ways, i.e.
> >__builtin_constant_p(type) evaluates to both 0 and 1? Either that, or
> >the new BUILD_BUG_ON() macro isn't working...
> 
> No, at this point of the compilation process it's neither zero nor one,
> it's simply considered non-constant by the compiler at that stage
> (this builtin is used for optimization, not during parsing, and the
> error gets generated when the body of the function gets parsed,
> not when code gets generated from it).

I think I see what you're saying. Do you have a fix to suggest?

-- 
Hollis Blanchard
IBM Linux Technology Center
