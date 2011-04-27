Return-Path: <David.Laight@ACULAB.COM>
Received: from mx0.aculab.com (mx0.aculab.com [213.249.233.131])
	by ozlabs.org (Postfix) with SMTP id E45211007D8
	for <linuxppc-dev@lists.ozlabs.org>;
	Wed, 27 Apr 2011 23:14:16 +1000 (EST)
Received: from mx0.aculab.com ([127.0.0.1])
	by localhost (mx0.aculab.com [127.0.0.1]) (amavisd-new,
	port 10024) with SMTP
	id 03492-05 for <linuxppc-dev@lists.ozlabs.org>;
	Wed, 27 Apr 2011 14:14:11 +0100 (BST)
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Subject: RE: [PATCH V4] POWER: perf_event: Skip updating kernel counters if
	register value shrinks
Date: Wed, 27 Apr 2011 14:13:25 +0100
Message-ID: <AE90C24D6B3A694183C094C60CF0A2F6D8AD06@saturn3.aculab.com>
In-Reply-To: <20110427130822.GC2936@mgebm.net>
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
> prev and val are both 64 bit variables holding 32 bit numbers, we do
not
> accumulate in either, they are both replaced by values directly from
the
> registers.
> So prev > val will not always be true.

The code seems to be:
    prev =3D local64_read(&event->hw.prev_count);
    val =3D read_pmc(event->hw.idx);
    delta =3D check_and_compute_delta(prev, val);
    local64_add(delta, &event->count);
Which looks very much like 'prev' being a 64bit counter generated
from the 32bit pmc register.

	David
