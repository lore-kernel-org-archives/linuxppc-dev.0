Return-Path: <timur@freescale.com>
Received: from az33egw02.freescale.net (az33egw02.freescale.net
	[192.88.158.103])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "az33egw02.freescale.net",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id C9A28DDFEB
	for <linuxppc-dev@ozlabs.org>; Wed, 27 May 2009 04:19:52 +1000 (EST)
Message-ID: <4A1C3230.8030009@freescale.com>
Date: Tue, 26 May 2009 13:17:20 -0500
From: Timur Tabi <timur@freescale.com>
MIME-Version: 1.0
To: Geoff Thorpe <Geoff.Thorpe@freescale.com>
Subject: Re: [PATCH 1/2 v8] powerpc: introduce macro spin_event_timeout()
References: <1242761199-17875-1-git-send-email-timur@freescale.com>	<1242761199-17875-2-git-send-email-timur@freescale.com>	<9e4733910905251046y5f7377f4y49ce72e775faef16@mail.gmail.com>	<ed82fe3e0905252027y198e78ct821753acacb1bdb1@mail.gmail.com>	<4A1C16DF.9090802@freescale.com>
	<4A1C20EA.5080603@freescale.com> <4A1C3059.40303@freescale.com>
In-Reply-To: <4A1C3059.40303@freescale.com>
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

> rc = spin_event_timeout((ret = in_be32(x) & 0x14), ...);

It's an interesting idea, but I have two problems with it:

1) This approach is that it depends on the internals of the macro.  That is, you're sneaking in an assignment in the hopes that the code will behave properly.  You see that the current code evaluates the condition only once, so it works.  The code will look like this:

2) Unlike the wait_event_xxx macros, I believe that the actual evaluated expression is important to the caller.  So 90% of the time, the caller is going to pass in "ret = (condition)", which means it makes more sense to have this as a built-in feature of the macro.

So if you're okay with v9 of the patch, please ACK it.

-- 
Timur Tabi
Linux kernel developer at Freescale
