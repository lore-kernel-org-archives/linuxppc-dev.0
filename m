Return-Path: <ckrinke@istor.com>
Received: from stork.inside.istor.com (stork.istor.com [12.170.66.34])
	(using TLSv1 with cipher RC4-SHA (128/128 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 1C862DDF36
	for <linuxppc-embedded@ozlabs.org>;
	Tue,  6 Mar 2007 02:02:45 +1100 (EST)
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Subject: RE: Endianness versus too many byte swaps??
Date: Mon, 5 Mar 2007 07:02:43 -0800
Message-ID: <9F3F0A752CAEBE4FA7E906CC2FBFF57C06A184@MERCURY.inside.istor.com>
From: "Charles Krinke" <ckrinke@istor.com>
To: "Fillod Stephane" <stephane.fillod@thomson.net>,
	<linuxppc-embedded@ozlabs.org>
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>



You do understand that readl is in fact a call to in_le32() on ppc
(cf. include/asm-ppc/io.h).
=20
The question now is, what endianness you would like in that register?

Regards
--=20
Stephane

Dear Stephane:

Your point is well made. I can see that readl is in fact a call to
in_le32. Maybe there is a more basic problem here.=20

If I change the call to readl to a call to in_be32, things make sense
again. So, maybe I don't quite understand the endianness setup of this
Linux project.

I am told that we are running this ppc in big endian, so would this mean
that readl & writel should actually be resolving to in_be32/out_be32
respectively? Is there some other setup that may be wrong?


Charles
