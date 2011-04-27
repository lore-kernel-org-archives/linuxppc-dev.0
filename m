Return-Path: <David.Laight@ACULAB.COM>
Received: from mx0.aculab.com (mx0.aculab.com [213.249.233.131])
	by ozlabs.org (Postfix) with SMTP id DD270B6EF3
	for <linuxppc-dev@lists.ozlabs.org>;
	Wed, 27 Apr 2011 22:43:21 +1000 (EST)
Received: from mx0.aculab.com ([127.0.0.1])
	by localhost (mx0.aculab.com [127.0.0.1]) (amavisd-new,
	port 10024) with SMTP
	id 25408-03 for <linuxppc-dev@lists.ozlabs.org>;
	Wed, 27 Apr 2011 13:43:16 +0100 (BST)
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Subject: RE: [PATCH V4] POWER: perf_event: Skip updating kernel counters if
	register value shrinks
Date: Wed, 27 Apr 2011 13:42:30 +0100
Message-ID: <AE90C24D6B3A694183C094C60CF0A2F6D8AD04@saturn3.aculab.com>
In-Reply-To: <20110427121902.GA2936@mgebm.net>
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
> +	if (prev > val && (prev - val) < 256)
> +		delta =3D 0;
> +
> +	return delta;

Also, 'prev' is a true 64bit value, but 'val' is only ever 32bits.
So once the 64bit 'prev' exceeds 2^32+256 both 'prev > val'
and 'prev - val' are true regardless of the value of 'val'.
This will lead to jumps in the value ....

	David
