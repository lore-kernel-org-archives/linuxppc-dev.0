Return-Path: <trini@kernel.crashing.org>
Received: from fed1rmmtao08.cox.net (fed1rmmtao08.cox.net [68.230.241.31])
	by ozlabs.org (Postfix) with ESMTP id 40C812BDA6
	for <linuxppc-dev@ozlabs.org>; Wed, 22 Sep 2004 01:48:48 +1000 (EST)
Date: Tue, 21 Sep 2004 08:48:46 -0700
From: Tom Rini <trini@kernel.crashing.org>
To: Marius Groeger <mgroeger@sysgo.com>
Message-ID: <20040921154846.GQ27914@smtp.west.cox.net>
References: <414916BD.9080607@sonartech.com.au>
	<20040915223624.A25752@home.com>
	<414946A0.1020306@sonartech.com.au>
	<20040920173241.GL27914@smtp.west.cox.net>
	<20040920122312.A8344@home.com>
	<Pine.LNX.4.61.0409211112400.2255@mag.sysgo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <Pine.LNX.4.61.0409211112400.2255@mag.sysgo.com>
Cc: linuxppc-dev@ozlabs.org
Subject: Re: Linux-2.6.9-rc2 kernel build for mvme5100
List-Id: "Linux on PowerPC \(Including Embedded\) Developers Mail List"
	<linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Tue, Sep 21, 2004 at 11:15:20AM +0200, Marius Groeger wrote:
> On Mon, 20 Sep 2004, Matt Porter wrote:
> >>Did you disable CONFIG_VT, if it was enabled?  Otherwise you need to
> >>pass console=ttyS0
> >
> >and on recent kernels, you need console=ttyS0,9600 on boards like
> >this that use 9600 baud. Baud rate used to default to 9600, but
> >no longer.
> 
> So what IS the default then? Until today, I thought you don't necessarily
> need a console= argument at all. See Documentation/serial-console.txt:
> 
>    If no console device is specified, the first device found capable of
>    acting as a system console will be used. At this time, the system first
>    looks for a VGA card and then for a serial port. So if you don't have a
>    VGA card in your system the first serial port will automatically become
>    the console.
> 
> Are you saying that you should always pass console=...?

Double checking my facts here, it's not CONFIG_VT per-se, but
CONFIG_VT_CONSOLE.  The problem is that VT_CONSOLE will register before
anything else, even if no video hardware is found.  Now getting a bit
simplistic, if you don't want VT_CONSOLE, you don't want VT, so...

-- 
Tom Rini
http://gate.crashing.org/~trini/
