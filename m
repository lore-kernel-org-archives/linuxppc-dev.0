Return-Path: <BlakesleeS@embeddedplanet.com>
Received: from tag-03.ashton-group.com (tag-03.ashton-group.com [66.94.86.90])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 7BE8767B21
	for <linuxppc-embedded@ozlabs.org>;
	Fri, 17 Jun 2005 00:03:59 +1000 (EST)
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Date: Thu, 16 Jun 2005 10:03:53 -0400
Message-ID: <1628E43D99629C46988BE46087A3FBB92859E1@ep-01.EmbeddedPlanet.local>
From: "Steven Blakeslee" <BlakesleeS@embeddedplanet.com>
To: "Schaefer-Hutter, Peter" <Peter.Schaefer-Hutter@tfk-racoms.com>,
	<linuxppc-embedded@ozlabs.org>
Subject: RE: 2.4.26 and MPC885 context switching time
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

> Therefore i wonder, if there are any known problems with the=20
> MMU on 8xx and 2.4.2x which might explain that?=20
>=20

I did some work on an 885 with Linux 2.4.22.  I found that when the
processor was running at 100MHz or higher Linux would die when
decompressing the ramdisk.  Below 100MHz it would run fine.  I came up
with a hacky fix because I mis-read an errata notice.  What I did was
set the ICTRL register to 0x00000001, this fixed the problem.  Basically
all this does is slow the processor down considerable.  The Linux you
have may be doing the same thing.  This could explain the performance
hit you are seeing.
