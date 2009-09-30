Return-Path: <JBeulich@novell.com>
Received: from vpn.id2.novell.com (vpn.id2.novell.com [195.33.99.129])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "emea1-mh.id2.novell.com", Issuer "APPS" (not verified))
	by ozlabs.org (Postfix) with ESMTPS id 693B9B7BF3
	for <linuxppc-dev@lists.ozlabs.org>;
	Wed, 30 Sep 2009 16:35:23 +1000 (EST)
Message-Id: <4AC318450200007800017355@vpn.id2.novell.com>
Date: Wed, 30 Sep 2009 07:35:17 +0100
From: "Jan Beulich" <JBeulich@novell.com>
To: "Hollis Blanchard" <hollisb@us.ibm.com>
Subject: Re: linux-next: tree build failure
References: <4AC1E15502000078000516B5@vpn.id2.novell.com>
	<1254267572.15622.1621.camel@slab.beaverton.ibm.com>
In-Reply-To: <1254267572.15622.1621.camel@slab.beaverton.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
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

>>> Hollis Blanchard <hollisb@us.ibm.com> 30.09.09 01:39 >>>
>On Tue, 2009-09-29 at 10:28 +0100, Jan Beulich wrote:
>> >>> Hollis Blanchard  09/29/09 2:00 AM >>>
>> >First, I think there is a real bug here, and the code should read like
>> >this (to match the comment):
>> >    /* type has to be known at build time for optimization */
>> >-    BUILD_BUG_ON(__builtin_constant_p(type));
>> >+    BUILD_BUG_ON(!__builtin_constant_p(type));
>> >
>> >However, I get the same build error *both* ways, i.e.
>> >__builtin_constant_p(type) evaluates to both 0 and 1? Either that, or
>> >the new BUILD_BUG_ON() macro isn't working...
>>=20
>> No, at this point of the compilation process it's neither zero nor one,
>> it's simply considered non-constant by the compiler at that stage
>> (this builtin is used for optimization, not during parsing, and the
>> error gets generated when the body of the function gets parsed,
>> not when code gets generated from it).
>
>I think I see what you're saying. Do you have a fix to suggest?

The one Rusty suggested the other day may help here. I don't like it
as a drop-in replacement for BUILD_BUG_ON() though (due to it
deferring the error generated to the linking stage), I'd rather view
this as an improvement to MAYBE_BUILD_BUG_ON() (which should
then be used here).

Jan
