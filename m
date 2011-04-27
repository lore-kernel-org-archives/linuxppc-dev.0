Return-Path: <David.Laight@ACULAB.COM>
Received: from mx0.aculab.com (mx0.aculab.com [213.249.233.131])
	by ozlabs.org (Postfix) with SMTP id 4D191B6F0A
	for <linuxppc-dev@lists.ozlabs.org>;
	Wed, 27 Apr 2011 23:05:16 +1000 (EST)
Received: from mx0.aculab.com ([127.0.0.1])
	by localhost (mx0.aculab.com [127.0.0.1]) (amavisd-new,
	port 10024) with SMTP
	id 29763-04 for <linuxppc-dev@lists.ozlabs.org>;
	Wed, 27 Apr 2011 14:05:11 +0100 (BST)
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Subject: RE: [PATCH V4] POWER: perf_event: Skip updating kernel counters if
	register value shrinks
Date: Wed, 27 Apr 2011 14:04:25 +0100
Message-ID: <AE90C24D6B3A694183C094C60CF0A2F6D8AD05@saturn3.aculab.com>
In-Reply-To: <20110427125930.GB2936@mgebm.net>
From: "David Laight" <David.Laight@ACULAB.COM>
To: "Eric B Munson" <emunson@mgebm.net>
Cc: a.p.zijlstra@chello.nl, linux-kernel@vger.kernel.org, paulus@samba.org,
	anton@samba.org, acme@ghostprotocols.net, mingo@elte.hu,
	linuxppc-dev@lists.ozlabs.org, stable@kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

=20
> On Wed, 27 Apr 2011, David Laight wrote:
>=20
> > > But it isn't, and it doesn't have trouble with 2^32 - 1. =20
> >=20
> > what about:
> > prev =3D 0x00000001
> > val  =3D 0xffffffff
>=20
> Result is 0xfffffffe and we are fine.

'delta' will be 0xfffffffe, but you need the function to
return zero - since the underlying counter has decremented
by 2. But 'prev > val' is false so the counter will
be increased by 2^32-2.

	David
