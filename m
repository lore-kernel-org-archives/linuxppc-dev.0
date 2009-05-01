Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 7EA40DDE00
	for <linuxppc-dev@ozlabs.org>; Sat,  2 May 2009 06:14:20 +1000 (EST)
Subject: Re: Should ppc32 use CONFIG_HIGHPTE or not?
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Dave Hansen <dave@linux.vnet.ibm.com>
In-Reply-To: <1241203023.29485.218.camel@nimitz>
References: <1241203023.29485.218.camel@nimitz>
Content-Type: text/plain
Date: Sat, 02 May 2009 06:14:07 +1000
Message-Id: <1241208847.1781.6.camel@pasglop>
Mime-Version: 1.0
Cc: linuxppc-dev <linuxppc-dev@ozlabs.org>, Paul Mackerras <paulus@samba.org>,
	Kumar Gala <galak@gate.crashing.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Fri, 2009-05-01 at 11:37 -0700, Dave Hansen wrote:

 .../...

> So, it looks like ppc32 never actually allocates highmem pte pages, but
> it *does* go to the trouble of at least trying to kmap_atomic() them.
> Should we just give ppc32 unconditional direct-mapped ptes?  Or, should
> we remove that #ifdef and let it allocate them in highmem when it can
> since we also have the code to support that?

We actually noticed that recently :-)

We implemented HIGHPTE support a long time ago, and then somebody
disabled HIGHPTE for both x86 and powerpc on the ground that it wasn't
reliable, I don't remember off hand who, I think it was in the 2.5.x
timeframe, and while it got re-enabled on x86 it never was on powerpc
(maybe because we never noticed it was disabled in the first place ;-)

Now, recently, some changes went in that could possibly be problematic
with HIGHPTE, at least I have a vague recollection of that, I think
Kumar was involved... Kumar, was this fixed ?

So depending on that, maybe we could revive the option ... or just
get rid of that HIGHPTE support and be done with it.

Cheers,
Ben.
