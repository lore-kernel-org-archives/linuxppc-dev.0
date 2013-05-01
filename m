Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client did not present a certificate)
 by ozlabs.org (Postfix) with ESMTPS id E12002C00BC
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  1 May 2013 18:08:15 +1000 (EST)
Message-ID: <1367395685.22115.19.camel@pasglop>
Subject: Re: [PATCH net-next] af_unix: fix a fatal race with bit fields
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: David Miller <davem@davemloft.net>
Date: Wed, 01 May 2013 18:08:05 +1000
In-Reply-To: <20130501.033650.703182794549888825.davem@davemloft.net>
References: <1367370761.11020.22.camel@edumazet-glaptop>
 <1367372393.22115.6.camel@pasglop>
 <20130501.033650.703182794549888825.davem@davemloft.net>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Cc: netdev@vger.kernel.org, linuxppc-dev@lists.ozlabs.org, paulus@samba.org,
 ambrose@google.com, eric.dumazet@gmail.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Wed, 2013-05-01 at 03:36 -0400, David Miller wrote:
> From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
> Date: Wed, 01 May 2013 11:39:53 +1000
> 
> > I'm not even completely certain bytes are safe to be honest, though
> > probably more than bitfields. I'll poke our compiler people.
> 
> Older Alpha only has 32-bit and 64-bit loads and stores, so byte sized
> accesses are not atomic, and therefore use racey read-modify-write
> sequences.

In this case it depends whether the compiler will "chose" the smaller
(32-bit) size which hopefully won't overlap with the atomic/lock
provided the latter is aligned... lots of if's here, makes me nervous...

At least the bytes seem to fix it for ppc64 so far...

It would make feel generally better if we could get gcc to guarantee us
to always use the smallest access size that encompass the whole bitfield
(or at least not go larger than int when the bitfield is defined as
unsigned int). This would take care of all the cases we haven't spotted
yet (hopefully).

For all intend and purposes those two fields are bits of an unsigned
int, why the heck would the compiler use a larger access size anyway ? I
seem to recall that we have other places where such an assumption is
made that ints are accessed atomically, and Linus stating in the past
that a compiler doing anything else was not worth bothering with. I
don't see why bitfields of such int would be an exception to that rule
(though again, this is probably not a rule stated in the standard ... oh
well).

/me goes have a glass of wine and not think about this until tomorrow.

Cheers,
Ben.
