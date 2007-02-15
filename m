Return-Path: <arnd@arndb.de>
From: Arnd Bergmann <arnd@arndb.de>
To: Carl Love <cel@us.ibm.com>
Subject: Re: [Cbe-oss-dev] [RFC,
	PATCH] CELL Oprofile SPU profiling =?iso-8859-15?q?updated=09patch?=
Date: Thu, 15 Feb 2007 22:03:59 +0100
References: <1171497138.23691.8.camel@dyn9047021078.beaverton.ibm.com>
	<200702151537.51202.arnd@arndb.de>
	<1171570918.31179.36.camel@dyn9047021078.beaverton.ibm.com>
In-Reply-To: <1171570918.31179.36.camel@dyn9047021078.beaverton.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-15"
Message-Id: <200702152203.59902.arnd@arndb.de>
Cc: linuxppc-dev@ozlabs.org, cbe-oss-dev@ozlabs.org,
	oprofile-list@lists.sourceforge.net, linux-kernel@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Thursday 15 February 2007 21:21, Carl Love wrote:

> I have done some quick measurements. =A0The above method limits the loop
> to at most 2^16 iterations. =A0Based on running the algorithm in user
> space, it takes about 3ms of computation time to do the loop 2^16 times.
>=20
> At the vary least, we need to put the resched in say every 10,000
> iterations which would be about every 0.5ms. =A0Should we do a resched
> more often? =A0

Yes, just to be on the safe side, I'd suggest to do it every 1000
iterations.
=20
> Additionally we could up the size of the table to 512 which would reduce
> the maximum time to about 1.5ms. =A0What do people think about increasing
> the table size?

No, that won't help too much. I'd say 256 or 128 entries is the most
we should have.

> As for using a logarithmic spacing of the precomputed values, this
> approach means that the space between the precomputed values at the high
> end would be much larger then 2^14, assuming 256 precomputed values.
> That means it could take much longer then 3ms to get the needed LFSR
> value for a large N. =A0By evenly spacing the precomputed values, we can
> ensure that for all N it will take less then 3ms to get the value.
> Personally, I am more comfortable with a hard limit on the compute time
> then a variable time that could get much bigger then the 1ms threshold
> that Arnd wants for resched. =A0Any thoughts?

When using precomputed values on a logarithmic scale, I'd recommend
just rounding to the closest value and accepting the relative inaccuracy,
instead of using the precomputed value as the base and then calculating
from there.

	Arnd <><
