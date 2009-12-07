Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 1CE3BB7BBF
	for <linuxppc-dev@lists.ozlabs.org>;
	Mon,  7 Dec 2009 12:12:56 +1100 (EST)
Subject: Re: ZILOG serial port broken in 2.6.32
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Rob Landley <rob@landley.net>
In-Reply-To: <200912060101.22515.rob@landley.net>
References: <200912060101.22515.rob@landley.net>
Content-Type: text/plain; charset="UTF-8"
Date: Mon, 07 Dec 2009 12:10:48 +1100
Message-ID: <1260148248.2076.1348.camel@pasglop>
Mime-Version: 1.0
Cc: paulus@samba.org, linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Sun, 2009-12-06 at 01:01 -0600, Rob Landley wrote:
> Trying again with a few likely-looking cc's from the MAINTAINERS file:
> 
> Summary: 
> 
> The PMACZILOG serial driver last worked in 2.6.28.  It was broken by commit 
> f751928e0ddf54ea4fe5546f35e99efc5b5d9938 by Alan Cox making bits of the tty 
> layer dynamically allocated.  The PMACZILOG driver wasn't properly converted, 
> it works with interrupts disabled (for boot messages), but as soon as 
> interrupts are enabled (PID 1 spawns) the next write to the serial console 
> panics the kernel.

Ah looks like I missed that... I'll dig. Thanks for the report.

Cheers,
Ben.
