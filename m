Return-Path: <elendil@planet.nl>
Received: from ozlabs.org (ozlabs.org [203.10.76.45])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mx.ozlabs.org",
	Issuer "CA Cert Signing Authority" (verified OK))
	by bilbo.ozlabs.org (Postfix) with ESMTPS id EBCC3B7243
	for <linuxppc-dev@lists.ozlabs.org>;
	Sun, 21 Jun 2009 07:08:56 +1000 (EST)
Received: from CPSMTPM-EML104.kpnxchange.com (cpsmtpm-eml104.kpnxchange.com
	[195.121.3.8]) by ozlabs.org (Postfix) with ESMTP id 3A9C3DDD1B
	for <linuxppc-dev@ozlabs.org>; Sun, 21 Jun 2009 07:08:55 +1000 (EST)
From: Frans Pop <elendil@planet.nl>
To: Sean MacLennan <smaclennan@pikatech.com>
Subject: Re: Badness on the Warp
Date: Sat, 20 Jun 2009 22:56:45 +0200
References: <20090620154824.72b5cd50@lappy.seanm.ca>
In-reply-To: <20090620154824.72b5cd50@lappy.seanm.ca>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Message-Id: <200906202256.46073.elendil@planet.nl>
Cc: linuxppc-dev@ozlabs.org, linux-kernel@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

> The git bisect returned:
>
> =A0 871fa90791a6f83dd8e2e489feb9534a8c02088d is first bad commit
>
> That is it, no more info.... strange. git show 8714...088d gives:
>
> Merge: 7702667... 79f52b7...
> Author: Linus Torvalds <torvalds@linux-foundation.org>
> Date: =A0 Thu Jun 11 11:27:09 2009 -0700
>
> The Warp has jfs disabled, so I don't know why it would affect us,
> especially this realy in the boot!

The fact that your bisect ended at a merge essentially means that it is=20
invalid. As a merge does not introduce any actual change (unless it=20
includes changes to resolve conflicts), it normally cannot be the cause=20
of a regression.

So either you made a mistake when marking a commit as good or bad during=20
the bisect, or the "badness" does not trigger reliably, resulting in you=20
incorrectly marking a bad commit as good.

My suggestion would be to run the bisection again from the start.

Cheers,
=46JP
