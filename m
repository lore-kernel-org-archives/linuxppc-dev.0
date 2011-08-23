Return-Path: <davem@davemloft.net>
Received: from shards.monkeyblade.net (shards.monkeyblade.net [198.137.202.13])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 4E32FB6F65
	for <linuxppc-dev@lists.ozlabs.org>;
	Tue, 23 Aug 2011 12:18:28 +1000 (EST)
Date: Mon, 22 Aug 2011 19:13:48 -0700 (PDT)
Message-Id: <20110822.191348.2099822249437201579.davem@davemloft.net>
To: sfr@canb.auug.org.au
Subject: Re: linux-next: boot test failure (net tree)
From: David Miller <davem@davemloft.net>
In-Reply-To: <20110823114129.ceb18da164bf7df3c145941b@canb.auug.org.au>
References: <20110822113032.15087c2e190e2b0c3ee7dfb8@canb.auug.org.au>
	<20110823114011.a059aea0138b75bfa7eed1ce@canb.auug.org.au>
	<20110823114129.ceb18da164bf7df3c145941b@canb.auug.org.au>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Cc: mikey@neuling.org, netdev@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
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

From: Stephen Rothwell <sfr@canb.auug.org.au>
Date: Tue, 23 Aug 2011 11:41:29 +1000

> On Tue, 23 Aug 2011 11:40:11 +1000 Stephen Rothwell <sfr@canb.auug.org.au> wrote:
>>
>> On Mon, 22 Aug 2011 11:30:32 +1000 Stephen Rothwell <sfr@canb.auug.org.au> wrote:
>> >
>> > Here's what I am applying as a merge fixup to the net tree today so that
>> > my ppc64_defconfig builds actually build more or less the same set of
>> > drivers as before this rearrangement.
>> 
>> And this today:
> 
> And this:

I'm starting to get uncomfortable with this whole situation, and I
feel more and more that these new kconfig guards are not tenable.

Changing defconfig files might fix the "automated test boot with
defconfig" case but it won't fix the case of someone trying to
automate a build and boot using a different, existing, config file.
It ought to work too, and I do know people really do this.

And just the fact that we would have to merge all of these defconfig changes
through the networking tree is evidence of how it's really not reasonable
to be doing things this way.

Jeff, I think we need to revert the dependencies back to what they were
before the drivers/net moves.  Could you prepare a patch which does that?
