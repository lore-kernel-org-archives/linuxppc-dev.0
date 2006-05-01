Return-Path: <segher@kernel.crashing.org>
Received: from mail-in-05.arcor-online.net (mail-in-05.arcor-online.net
	[151.189.21.45])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mx.arcor.de",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id E45EB679A6
	for <linuxppc-dev@ozlabs.org>; Tue,  2 May 2006 07:27:10 +1000 (EST)
In-Reply-To: <00CD15B8-F448-4985-8EEC-3BBF61C0110B@kernel.crashing.org>
References: <5CA113BC-1614-4551-87E5-6926E14C2225@kernel.crashing.org>
	<1146512012.24239.28.camel@cashmere.sps.mot.com>
	<695BB790-1E64-4B53-91DD-7DD88305F201@kernel.crashing.org>
	<1146512732.24239.34.camel@cashmere.sps.mot.com>
	<55FD11DB-54AF-4284-9E9A-C313F4232105@kernel.crashing.org>
	<20060501150728.04694488.kim.phillips@freescale.com>
	<00CD15B8-F448-4985-8EEC-3BBF61C0110B@kernel.crashing.org>
Mime-Version: 1.0 (Apple Message framework v749.3)
Content-Type: text/plain; charset=US-ASCII; format=flowed
Message-Id: <0F94524B-C621-4C23-B168-B97C25080B1D@kernel.crashing.org>
From: Segher Boessenkool <segher@kernel.crashing.org>
Subject: Re: DTC/dts modifications
Date: Mon, 1 May 2006 23:26:57 +0200
To: Kumar Gala <galak@kernel.crashing.org>
Cc: linuxppc-dev@ozlabs.org, jdl@jdl.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

> Cool, here's an invocation that seems to work well.  Not sure what
> causes linux = 1 (thus I need the -U linux).  Also address the line
> information that is normally spit out.
>
> cpp -U linux -P -x assembler-with-cpp foo.dts

Try  -undef  instead.  You will *still* have some predefined
symbols, but at least all of those will have plenty of underscores.

It's still a really bad idea to run non-C code through the C
pre-processor; have you considered using m4 or similar instead?


Segher
