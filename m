Return-Path: <David.Laight@ACULAB.COM>
Received: from mx0.aculab.com (mx0.aculab.com [213.249.233.131])
	by ozlabs.org (Postfix) with SMTP id 44D8FB6F72
	for <linuxppc-dev@lists.ozlabs.org>;
	Fri,  8 Apr 2011 18:39:19 +1000 (EST)
Received: from mx0.aculab.com ([127.0.0.1])
	by localhost (mx0.aculab.com [127.0.0.1]) (amavisd-new,
	port 10024) with SMTP
	id 14978-04 for <linuxppc-dev@lists.ozlabs.org>;
	Fri,  8 Apr 2011 09:39:12 +0100 (BST)
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Subject: RE: [PATCH V3] POWER: perf_event: Skip updating kernel counters
	ifregister value shrinks
Date: Fri, 8 Apr 2011 09:38:49 +0100
Message-ID: <AE90C24D6B3A694183C094C60CF0A2F6D8ACE8@saturn3.aculab.com>
From: "David Laight" <David.Laight@ACULAB.COM>
To: <linuxppc-dev@lists.ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

=20
> +	u64 delta =3D 0;
...
> +	if (((prev & 0x80000000) && !(val & 0x80000000)) || (val >
prev))
> +		delta =3D (val - prev) & 0xfffffffful;
> +
> +	return delta;

The above is incorrect modulo arithmetic.

It is probably intended to do:
    s32 delta =3D val - prev;
    return delta < 0 ? 0 : delta;
which will just ignore the fact that some counts are rolled back.

More accurate would be:
    static u64 val64;
    u32 val =3D read_perf_count();
    s32 delta =3D val - val_64;
    if (delta < 0)
        return;
    val64 +=3D delta;
Which will not double count for rolled back events.
(The low bits of val64 should always match the actual counter.)

	David
