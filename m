Return-Path: <hollisb@us.ibm.com>
Received: from e31.co.us.ibm.com (e31.co.us.ibm.com [32.97.110.149])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e31.co.us.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id 078C3B7BE0
	for <linuxppc-dev@lists.ozlabs.org>;
	Sat,  3 Oct 2009 01:48:56 +1000 (EST)
Received: from d03relay02.boulder.ibm.com (d03relay02.boulder.ibm.com
	[9.17.195.227])
	by e31.co.us.ibm.com (8.14.3/8.13.1) with ESMTP id n92FgTvQ029405
	for <linuxppc-dev@lists.ozlabs.org>; Fri, 2 Oct 2009 09:42:29 -0600
Received: from d03av03.boulder.ibm.com (d03av03.boulder.ibm.com [9.17.195.169])
	by d03relay02.boulder.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
	n92FmfqW258738
	for <linuxppc-dev@lists.ozlabs.org>; Fri, 2 Oct 2009 09:48:43 -0600
Received: from d03av03.boulder.ibm.com (loopback [127.0.0.1])
	by d03av03.boulder.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id
	n92FmeZW025754
	for <linuxppc-dev@lists.ozlabs.org>; Fri, 2 Oct 2009 09:48:40 -0600
Subject: Re: linux-next: tree build failure
From: Hollis Blanchard <hollisb@us.ibm.com>
To: Jan Beulich <JBeulich@novell.com>
In-Reply-To: <4AC318450200007800017355@vpn.id2.novell.com>
References: <4AC1E15502000078000516B5@vpn.id2.novell.com>
	<1254267572.15622.1621.camel@slab.beaverton.ibm.com>
	<4AC318450200007800017355@vpn.id2.novell.com>
Content-Type: text/plain
Date: Fri, 02 Oct 2009 08:48:36 -0700
Message-Id: <1254498517.3839.17.camel@slab.beaverton.ibm.com>
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

On Wed, 2009-09-30 at 07:35 +0100, Jan Beulich wrote:
> >>> Hollis Blanchard <hollisb@us.ibm.com> 30.09.09 01:39 >>>
> >On Tue, 2009-09-29 at 10:28 +0100, Jan Beulich wrote:
> >> >>> Hollis Blanchard  09/29/09 2:00 AM >>>
> >> >First, I think there is a real bug here, and the code should read like
> >> >this (to match the comment):
> >> >    /* type has to be known at build time for optimization */
> >> >-    BUILD_BUG_ON(__builtin_constant_p(type));
> >> >+    BUILD_BUG_ON(!__builtin_constant_p(type));
> >> >
> >> >However, I get the same build error *both* ways, i.e.
> >> >__builtin_constant_p(type) evaluates to both 0 and 1? Either that, or
> >> >the new BUILD_BUG_ON() macro isn't working...
> >> 
> >> No, at this point of the compilation process it's neither zero nor one,
> >> it's simply considered non-constant by the compiler at that stage
> >> (this builtin is used for optimization, not during parsing, and the
> >> error gets generated when the body of the function gets parsed,
> >> not when code gets generated from it).
> >
> >I think I see what you're saying. Do you have a fix to suggest?
> 
> The one Rusty suggested the other day may help here. I don't like it
> as a drop-in replacement for BUILD_BUG_ON() though (due to it
> deferring the error generated to the linking stage), I'd rather view
> this as an improvement to MAYBE_BUILD_BUG_ON() (which should
> then be used here).

Can you be more specific?

I have no idea what Rusty suggested where. I can't even guess what
MAYBE_BUILD_BUG_ON() is supposed to do (sounds like a terrible name).

All I know is that this used to build...

-- 
Hollis Blanchard
IBM Linux Technology Center
