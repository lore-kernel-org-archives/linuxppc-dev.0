Return-Path: <B07421@freescale.com>
Received: from DB3EHSOBE003.bigfish.com (db3ehsobe003.messaging.microsoft.com
	[213.199.154.141])
	(using TLSv1 with cipher AES128-SHA (128/128 bits))
	(Client CN "mail.global.frontbridge.com",
	Issuer "Microsoft Secure Server Authority" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id D5493B700E
	for <linuxppc-dev@lists.ozlabs.org>;
	Tue,  2 Aug 2011 02:12:36 +1000 (EST)
Date: Mon, 1 Aug 2011 11:12:06 -0500
From: Scott Wood <scottwood@freescale.com>
To: <naresh.kamboju@wipro.com>
Subject: Re: HELP:PowerPc-Linux kernel
Message-ID: <20110801111206.75e577ab@schlenkerla.am.freescale.net>
In-Reply-To: <35CC4C9595855B43903A67B297EFA8E3C54771@HYD-MKD-MBX01.wipro.com>
References: <35CC4C9595855B43903A67B297EFA8E3C544FD@HYD-MKD-MBX01.wipro.com>
	<CAGn8Sby3Swk8zXxDXnXDBM+bDn=RV2cmvqvwXZM+05P=Z1FMAg@mail.gmail.com>
	<35CC4C9595855B43903A67B297EFA8E3C546BC@HYD-MKD-MBX01.wipro.com>
	<4E33F8F3.80002@mlbassoc.com>
	<35CC4C9595855B43903A67B297EFA8E3C54771@HYD-MKD-MBX01.wipro.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Cc: vijay.t.nikam@gmail.com, gary@mlbassoc.com, paulus@samba.org,
	cort@fsmlabs.com, linuxppc-dev@lists.ozlabs.org,
	david@gibson.dropbear.id.au
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Mon, 1 Aug 2011 17:01:27 +0530
<naresh.kamboju@wipro.com> wrote:

> >Did you try passing 'console=ttyCPM0' to the bootargs?
> >I have tried ttyCPM0 no use.

Have you tried specifying the baud rate?

> Do I need to modify something on boot loader or is there any boot loader
> can support CPM ?
> 
> Scott,
> Is cpm_console_init() must be initialized to fix this issue?

Please start with the latest kernel.  Upgrade U-Boot as well if you have a
way to recover if the new image doesn't work (e.g. a BDI).

You don't need the bootwrapper for the main serial driver to work.  You may
need some board-specific pin/port init, though at least the serial port
that U-Boot uses should already be set up, assuming it worked in U-Boot
of course. :-)

If it still doesn't work after switching to a current kernel, try dumping
CPM registers, instrumenting the driver, etc. to see what's going on.

-Scott
