Return-Path: <timur@freescale.com>
Received: from az33egw02.freescale.net (az33egw02.freescale.net
	[192.88.158.103])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "az33egw02.freescale.net",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id 1613DDE0A0
	for <linuxppc-dev@ozlabs.org>; Wed, 27 May 2009 03:06:09 +1000 (EST)
Message-ID: <4A1C20EA.5080603@freescale.com>
Date: Tue, 26 May 2009 12:03:38 -0500
From: Timur Tabi <timur@freescale.com>
MIME-Version: 1.0
To: Geoff Thorpe <Geoff.Thorpe@freescale.com>
Subject: Re: [PATCH 1/2 v8] powerpc: introduce macro spin_event_timeout()
References: <1242761199-17875-1-git-send-email-timur@freescale.com>	<1242761199-17875-2-git-send-email-timur@freescale.com>	<9e4733910905251046y5f7377f4y49ce72e775faef16@mail.gmail.com>
	<ed82fe3e0905252027y198e78ct821753acacb1bdb1@mail.gmail.com>
	<4A1C16DF.9090802@freescale.com>
In-Reply-To: <4A1C16DF.9090802@freescale.com>
Content-Type: text/plain; charset=ISO-8859-1
Cc: linuxppc-dev@ozlabs.org, smaclennan@pikatech.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Geoff Thorpe wrote:

> So from this user's perspective (FWIW), it would come as a surprise if
> the return value reflected the evaluated expression rather than what
> happened w.r.t. the spin/timeout.

It shouldn't come as a surprise because I've thoroughly documented the behavior.  I also think returning the actual value of the expression is better than a return code.  Remember, the primary purpose of this macro is to wait for a hardware register to change.  Contrast this to wait_event_xxx, which usually queries a variable.  Therefore, the hardware register may set multiple bits.  For instance, you could do this:

ret = spin_event_timeout(in_be32(x) & 0x14, ...);

if (ret & 0x10)
	do something here

if (ret & 0x04)
	do something else here

I think the ability to do this is more important than making the code as similar as possible to wait_event_xxx.

-- 
Timur Tabi
Linux kernel developer at Freescale
