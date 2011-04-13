Return-Path: <David.Laight@ACULAB.COM>
Received: from mx0.aculab.com (mx0.aculab.com [213.249.233.131])
	by ozlabs.org (Postfix) with SMTP id 6CBD6B6F5A
	for <linuxppc-dev@lists.ozlabs.org>;
	Thu, 14 Apr 2011 01:00:20 +1000 (EST)
Received: from mx0.aculab.com ([127.0.0.1])
	by localhost (mx0.aculab.com [127.0.0.1]) (amavisd-new,
	port 10024) with SMTP
	id 03986-08 for <linuxppc-dev@lists.ozlabs.org>;
	Wed, 13 Apr 2011 16:00:14 +0100 (BST)
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Subject: Re: [PATCH] powerpc: align DTL buffer to AMS boundary
Date: Wed, 13 Apr 2011 15:59:44 +0100
Message-ID: <AE90C24D6B3A694183C094C60CF0A2F6D8ACF4@saturn3.aculab.com>
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

> From:=20
> linuxppc-dev-bounces+david.laight=3Daculab.com@lists.ozlabs.org=20
> [mailto:linuxppc-dev-bounces+david.laight=3Daculab.com@lists.ozl
> abs.org] On Behalf Of Nishanth Aravamudan
> Sent: 13 April 2011 15:53
> To: Ben Herrenschmidt
> Cc: linuxppc-dev@ozlabs.org; Paul Mackerras; Anton Blanchard
> Subject: [PATCH] powerpc: align DTL buffer to AMS boundary
>=20
> PAPR specifies that DTL buffers can not cross AMS environments (aka
CMO
> in the PAPR) and can not cross a memory entitlement granule boundary
> (4k)....

How big is the buffer being allocated?
If it is much less than 4k then it might be worth allocating
a buffer of the correct size, and only if that crosses a 4k boundary
allocate the larger buffer.

Also, if the buffer is ever freed, the actual base address is needed
for the free.

	David
