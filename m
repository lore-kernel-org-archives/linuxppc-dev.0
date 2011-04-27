Return-Path: <David.Laight@ACULAB.COM>
Received: from mx0.aculab.com (mx0.aculab.com [213.249.233.131])
	by ozlabs.org (Postfix) with SMTP id 15C511007D5
	for <linuxppc-dev@lists.ozlabs.org>;
	Wed, 27 Apr 2011 17:41:29 +1000 (EST)
Received: from mx0.aculab.com ([127.0.0.1])
	by localhost (mx0.aculab.com [127.0.0.1]) (amavisd-new,
	port 10024) with SMTP
	id 25723-01 for <linuxppc-dev@lists.ozlabs.org>;
	Wed, 27 Apr 2011 08:41:21 +0100 (BST)
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Subject: RE: [PATCH V4] POWER: perf_event: Skip updating kernel counters if
	register value shrinks
Date: Wed, 27 Apr 2011 08:40:36 +0100
Message-ID: <AE90C24D6B3A694183C094C60CF0A2F6D8ACFA@saturn3.aculab.com>
In-Reply-To: <1302891150-8121-1-git-send-email-emunson@mgebm.net>
From: "David Laight" <David.Laight@ACULAB.COM>
To: "Eric B Munson" <emunson@mgebm.net>,
	<benh@kernel.crashing.org>
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

I keep telling Eric that the code below is incorrect
modulo arithimetic...

> +static u64 check_and_compute_delta(u64 prev, u64 val)
> +{
> +	u64 delta =3D (val - prev) & 0xfffffffful;
> +
> +	/*
> +	 * POWER7 can roll back counter values, if the new value is
smaller
> +	 * than the previous value it will cause the delta and the
counter to
> +	 * have bogus values unless we rolled a counter over.  If a
coutner is
> +	 * rolled back, it will be smaller, but within 256, which is the
maximum
> +	 * number of events to rollback at once.  If we dectect a
rollback
> +	 * return 0.  This can lead to a small lack of precision in the
> +	 * counters.
> +	 */
> +	if (prev > val && (prev - val) < 256)
> +		delta =3D 0;
> +
> +	return delta;

The code should detect rollback by looking at the value of 'delta'
otherwise there are horrid end effects near 2^32-1.

For instance:
	u32 delta =3D val - prev;
	return delta & 0x80000000 ? 0 : delta;


   David
