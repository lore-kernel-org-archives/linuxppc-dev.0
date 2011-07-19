Return-Path: <a.p.zijlstra@chello.nl>
Received: from casper.infradead.org (casper.infradead.org
	[IPv6:2001:770:15f::2])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id F17BAB6F77
	for <linuxppc-dev@lists.ozlabs.org>;
	Tue, 19 Jul 2011 20:22:08 +1000 (EST)
Subject: Re: [regression] 3.0-rc boot failure -- bisected to cd4ea6ae3982
From: Peter Zijlstra <a.p.zijlstra@chello.nl>
To: Anton Blanchard <anton@samba.org>
In-Reply-To: <20110719144451.79bc69ab@kryten>
References: <20110707102107.GA16666@in.ibm.com>
	<1310036375.3282.509.camel@twins> <20110714103418.7ef25b68@kryten>
	<20110714143521.5fe4fab6@kryten> <1310649379.2586.273.camel@twins>
	<20110715104547.29c3c509@kryten> <1311024956.2309.22.camel@laptop>
	<20110719144451.79bc69ab@kryten>
Content-Type: text/plain; charset="UTF-8"
Date: Tue, 19 Jul 2011 12:21:34 +0200
Message-ID: <1311070894.13765.180.camel@twins>
Mime-Version: 1.0
Cc: mahesh@linux.vnet.ibm.com, linuxppc-dev@lists.ozlabs.org,
	linux-kernel@vger.kernel.org, mingo@elte.hu, torvalds@linux-foundation.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Tue, 2011-07-19 at 14:44 +1000, Anton Blanchard wrote:
>=20
> Our node distances are a bit arbitrary (I make them up based on
> information given to us in the device tree). In terms of memory we have
> a maximum of three levels. To give some gross estimates, on chip memory
> might be 30GB/sec, on node memory 10-15GB/sec and off node memory
> 5GB/sec.
>=20
> The only thing we tweak with node distances is to make sure we go into
> node reclaim before going off node:
>=20
> /*
>  * Before going off node we want the VM to try and reclaim from the local
>  * node. It does this if the remote distance is larger than RECLAIM_DISTA=
NCE.
>  * With the default REMOTE_DISTANCE of 20 and the default RECLAIM_DISTANC=
E of
>  * 20, we never reclaim and go off node straight away.
>  *
>  * To fix this we choose a smaller value of RECLAIM_DISTANCE.
>  */
> #define RECLAIM_DISTANCE 10

> node distances:
> node   0   1   2   3   4   5   6   7   8   9  10  11  12  13  14  15  16 =
 17  18  19  20  21  22  23  24  25  26  27  28  29  30  31=20
>   0:  10  20  20  20  40  40  40  40  40  40  40  40  40  40  40  40  40 =
 40  40  40  40  40  40  40  40  40  40  40   0   0   0   0=20
>   1:  20  10  20  20  40  40  40  40  40  40  40  40  40  40  40  40  40 =
 40  40  40  40  40  40  40  40  40  40  40   0   0   0   0=20
>   2:  20  20  10  20  40  40  40  40  40  40  40  40  40  40  40  40  40 =
 40  40  40  40  40  40  40  40  40  40  40   0   0   0   0=20
>   3:  20  20  20  10  40  40  40  40  40  40  40  40  40  40  40  40  40 =
 40  40  40  40  40  40  40  40  40  40  40   0   0   0   0=20
>   4:  40  40  40  40  10  20  20  20  40  40  40  40  40  40  40  40  40 =
 40  40  40  40  40  40  40  40  40  40  40   0   0   0   0=20
>   5:  40  40  40  40  20  10  20  20  40  40  40  40  40  40  40  40  40 =
 40  40  40  40  40  40  40  40  40  40  40   0   0   0   0=20
>   6:  40  40  40  40  20  20  10  20  40  40  40  40  40  40  40  40  40 =
 40  40  40  40  40  40  40  40  40  40  40   0   0   0   0=20
>   7:  40  40  40  40  20  20  20  10  40  40  40  40  40  40  40  40  40 =
 40  40  40  40  40  40  40  40  40  40  40   0   0   0   0=20
>   8:  40  40  40  40  40  40  40  40  10  20  20  20  40  40  40  40  40 =
 40  40  40  40  40  40  40  40  40  40  40   0   0   0   0=20
>   9:  40  40  40  40  40  40  40  40  20  10  20  20  40  40  40  40  40 =
 40  40  40  40  40  40  40  40  40  40  40   0   0   0   0=20
>  10:  40  40  40  40  40  40  40  40  20  20  10  20  40  40  40  40  40 =
 40  40  40  40  40  40  40  40  40  40  40   0   0   0   0=20
>  11:  40  40  40  40  40  40  40  40  20  20  20  10  40  40  40  40  40 =
 40  40  40  40  40  40  40  40  40  40  40   0   0   0   0=20
>  12:  40  40  40  40  40  40  40  40  40  40  40  40  10  20  20  20  40 =
 40  40  40  40  40  40  40  40  40  40  40   0   0   0   0=20
>  13:  40  40  40  40  40  40  40  40  40  40  40  40  20  10  20  20  40 =
 40  40  40  40  40  40  40  40  40  40  40   0   0   0   0=20
>  14:  40  40  40  40  40  40  40  40  40  40  40  40  20  20  10  20  40 =
 40  40  40  40  40  40  40  40  40  40  40   0   0   0   0=20
>  15:  40  40  40  40  40  40  40  40  40  40  40  40  20  20  20  10  40 =
 40  40  40  40  40  40  40  40  40  40  40   0   0   0   0=20
>  16:  40  40  40  40  40  40  40  40  40  40  40  40  40  40  40  40  10 =
 20  20  20  40  40  40  40  40  40  40  40   0   0   0   0=20
>  17:  40  40  40  40  40  40  40  40  40  40  40  40  40  40  40  40  20 =
 10  20  20  40  40  40  40  40  40  40  40   0   0   0   0=20
>  18:  40  40  40  40  40  40  40  40  40  40  40  40  40  40  40  40  20 =
 20  10  20  40  40  40  40  40  40  40  40   0   0   0   0=20
>  19:  40  40  40  40  40  40  40  40  40  40  40  40  40  40  40  40  20 =
 20  20  10  40  40  40  40  40  40  40  40   0   0   0   0=20
>  20:  40  40  40  40  40  40  40  40  40  40  40  40  40  40  40  40  40 =
 40  40  40  10  20  20  20  40  40  40  40   0   0   0   0=20
>  21:  40  40  40  40  40  40  40  40  40  40  40  40  40  40  40  40  40 =
 40  40  40  20  10  20  20  40  40  40  40   0   0   0   0=20
>  22:  40  40  40  40  40  40  40  40  40  40  40  40  40  40  40  40  40 =
 40  40  40  20  20  10  20  40  40  40  40   0   0   0   0=20
>  23:  40  40  40  40  40  40  40  40  40  40  40  40  40  40  40  40  40 =
 40  40  40  20  20  20  10  40  40  40  40   0   0   0   0=20
>  24:   0   0   0   0   0   0   0   0   0   0   0   0   0   0   0   0   0 =
  0   0   0   0   0   0   0   0   0   0   0   0   0   0   0=20
>  25:   0   0   0   0   0   0   0   0   0   0   0   0   0   0   0   0   0 =
  0   0   0   0   0   0   0   0   0   0   0   0   0   0   0=20
>  26:   0   0   0   0   0   0   0   0   0   0   0   0   0   0   0   0   0 =
  0   0   0   0   0   0   0   0   0   0   0   0   0   0   0=20
>  27:   0   0   0   0   0   0   0   0   0   0   0   0   0   0   0   0   0 =
  0   0   0   0   0   0   0   0   0   0   0   0   0   0   0=20
>  28:  40  40  40  40  40  40  40  40  40  40  40  40  40  40  40  40  40 =
 40  40  40  40  40  40  40  10  20  20  20   0   0   0   0=20
>  29:  40  40  40  40  40  40  40  40  40  40  40  40  40  40  40  40  40 =
 40  40  40  40  40  40  40  20  10  20  20   0   0   0   0=20
>  30:  40  40  40  40  40  40  40  40  40  40  40  40  40  40  40  40  40 =
 40  40  40  40  40  40  40  20  20  10  20   0   0   0   0=20
>  31:  40  40  40  40  40  40  40  40  40  40  40  40  40  40  40  40  40 =
 40  40  40  40  40  40  40  20  20  20  10   0   0   0   0=20


That looks very strange indeed.. up to node 23 there is the normal
symmetric matrix with all the trace elements on 10 (as we would expect
for local access), and some 4x4 sub-matrix stacked around the trace with
20, suggesting a single hop distance, and the rest on 40 being
out-there.

But row 24-27 and column 28-31 are way weird, how can that ever be?
Aren't the inter-connects symmetric and thus mandating a fully symmetric
matrix? That is, how can traffic from node 23 (row) to node 28 (column)
have inf bandwidth (0) yet traffic from node 28 (row) to node 23
(column) have a multi-hop distance of 40.

So the idea I had to generate numa sched domains from the node distance
( http://marc.info/?l=3Dlinux-kernel&m=3D130218515520540 ), would that stil=
l
work for you? [it does assume a symmetric matrix ]
