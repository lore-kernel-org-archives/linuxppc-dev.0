Return-Path: <Renaud.Barbier@ge.com>
Received: from ext-ch1gw-7.online-age.net (ext-ch1gw-7.online-age.net
	[64.37.194.15])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id F3F3F2BDF2
	for <linuxppc-embedded@ozlabs.org>;
	Sat,  4 Dec 2004 07:51:41 +1100 (EST)
Received: from int-ch1gw-5.online-age.net (int-ch1gw-5 [3.159.232.69])
	by ext-ch1gw-7.online-age.net (8.12.11/8.12.11/20050527-JWF) with ESMTP
	id iB3KtV1M026539
	for <linuxppc-embedded@ozlabs.org>; Fri, 3 Dec 2004 15:55:31 -0500
Received: from cinmlef05.e2k.ad.ge.com (localhost [127.0.0.1])
	by int-ch1gw-5.online-age.net (8.12.9/8.12.3/990426-RLH) with ESMTP id
	iB3KpWNg024110
	for <linuxppc-embedded@ozlabs.org>; Fri, 3 Dec 2004 15:51:32 -0500 (EST)
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Date: Fri, 3 Dec 2004 14:52:32 -0600
Message-ID: <45ABD2373C33C4459D42B40EC4F346F20482F947@FTWMLVEM03.e2k.ad.ge.com>
From: "Barbier, Renaud (GE Infrastructure)" <Renaud.Barbier@ge.com>
To: "Matt Porter" <mporter@kernel.crashing.org>
Cc: linuxppc-embedded@ozlabs.org
Subject: RE: 440GX MMU problem
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

actually, I just loaded linux at memory offset 0x10000000(above 256MB)
and in this case it is able to boot and use the full 512MB.
there maybe indeed something broken.

Originally, U-boot did not map the full 512MB but only 256MB.
I wonder if that could be a possible source of my problem.



-----Original Message-----
From: Matt Porter [mailto:mporter@kernel.crashing.org]
Sent: Friday, December 03, 2004 6:06 PM
To: Barbier, Renaud (GE Infrastructure)
Cc: linuxppc-embedded@ozlabs.org
Subject: Re: 440GX MMU problem


On Fri, Dec 03, 2004 at 06:12:31AM -0600, Barbier, Renaud (GE =
Infrastructure) wrote:
>=20
> I am using linux 2.4.26 on a 440GX with 512MB of SDRAM.
> >From U-boot I can see the whole memory.
> If I boot Linux, unless I set the boot parameter mem=3D256M (or less).
> it will not boot. Linux does not seem to go further than the =
MMU_setup.

Verified that the 440GX eval with 512MB works on both 2.4.26 and current
2.4. Works For Me(tm).
=20
> Any idea why it cannot use 512MB?

A broken board port would do it. If you deviate for any reason
from the stock kernel configuration you can shoot yourself in the
foot real fast. If you can provide some details on your custom
board and port, somebody may be able to help you.

-Matt
