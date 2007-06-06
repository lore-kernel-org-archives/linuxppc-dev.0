Return-Path: <arnd@arndb.de>
Received: from moutng.kundenserver.de (moutng.kundenserver.de
	[212.227.126.188]) by ozlabs.org (Postfix) with ESMTP id D2199DDE04
	for <linuxppc-dev@ozlabs.org>; Wed,  6 Jun 2007 23:01:39 +1000 (EST)
From: Arnd Bergmann <arnd@arndb.de>
To: Segher Boessenkool <segher@kernel.crashing.org>
Subject: Re: [PATCH] of_serial: ignore unknown serial port
Date: Wed, 6 Jun 2007 15:01:15 +0200
References: <20070531.183033.-1300520557.kouish@swc.toshiba.co.jp>
	<18022.19709.50452.30370@cargo.ozlabs.ibm.com>
	<fe647387a21ec103882e7cf577d0d7d5@kernel.crashing.org>
In-Reply-To: <fe647387a21ec103882e7cf577d0d7d5@kernel.crashing.org>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Message-Id: <200706061501.15853.arnd@arndb.de>
Cc: linuxppc-dev@ozlabs.org, Paul Mackerras <paulus@samba.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Wednesday 06 June 2007, Segher Boessenkool wrote:
> >
> > Is this a bugfix that needs to go in 2.6.22?
> 
> This potentially breaks lots of other platforms, so no
> please, put it in early in the next cycle and give those
> others time to recover from this change.

I would expect that the bugfix is relatively harmless, as the
driver is rather new and there can only be a very small set
of users. All the OF based systems should be working fine
either way, because they already have legacy_serial, and
the dtc sources that come with the kernel all list the 
serial ports as compatible to either "ns16550", "cpm_uart",
"marvell,mpsc", or "mpc5200-psc-uart". In the first case
of those four, the change is harmless, for the other three
it is a valid bug fix.

It probably only makes a difference for 52xx in the case that
you have CONFIG_SERIAL_OF_PLATFORM=y and CONFIG_SERIAL_MPC52xx=m.
In that configuration, you get the same bug that Kou Ishizaki
observed on celleb without this fix.

	Arnd <><
