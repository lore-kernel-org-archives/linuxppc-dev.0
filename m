Return-Path: <David.Laight@ACULAB.COM>
Received: from mx0.aculab.com (mx0.aculab.com [213.249.233.131])
	by ozlabs.org (Postfix) with SMTP id A4107B70E8
	for <linuxppc-dev@lists.ozlabs.org>;
	Tue,  7 Dec 2010 20:01:58 +1100 (EST)
Received: from mx0.aculab.com ([127.0.0.1])
	by localhost (mx0.aculab.com [127.0.0.1]) (amavisd-new,
	port 10024) with SMTP
	id 07673-01 for <linuxppc-dev@lists.ozlabs.org>;
	Tue,  7 Dec 2010 09:01:47 +0000 (GMT)
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Subject: RE: MPC831x (and others?) NAND erase performance improvements
Date: Tue, 7 Dec 2010 09:00:33 -0000
Message-ID: <AE90C24D6B3A694183C094C60CF0A2F6D8ABEB@saturn3.aculab.com>
In-Reply-To: <20101207031554.GA12731@postdiluvian.org>
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
> The problem cropped up when there was a lot of traffic to the NAND
> (Samsung K9WAGU08U1B-PIB0), with the NAND being on the LBC along with
> a video chip that needed constant and prompt attention.
>=20
> What I would see is that, as the writes happened, the erases would
> wind up batched and issued all at once, such that frequently 400-700
> erases were issued in rapid succession with a 1ms LBC BUSY cycle per
> erase.

Are those just the reads of the status register polling to
determine when the sector erase has completed ?
In which case a software delay beteen the reads might work.

Writes probably also have to be polled, but the individual
writes happen faster.

It is possible that an uncached read of another memory area
will stall the cpu long enough to allow another LBC master in.
One every few writes might be enough.
I had to do something similar on rather different hardware ...

	David
