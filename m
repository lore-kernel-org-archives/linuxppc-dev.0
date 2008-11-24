Return-Path: <tpiepho@freescale.com>
Received: from az33egw02.freescale.net (az33egw02.freescale.net
	[192.88.158.103])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "az33egw02.freescale.net",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id 7C58BDDDFB
	for <linuxppc-dev@ozlabs.org>; Tue, 25 Nov 2008 10:58:47 +1100 (EST)
Date: Mon, 24 Nov 2008 15:51:00 -0800 (PST)
From: Trent Piepho <tpiepho@freescale.com>
To: "Morrison, Tom" <tmorrison@empirix.com>
Subject: Re: 8572E - machine check pin (MCP0)
In-Reply-To: <BD261180E6D35F4D9D32F3E44FD3D9010F1B21F8@EMPBEDEX.empirix.com>
Message-ID: <Pine.LNX.4.64.0811241545040.21311@t2.domain.actdsltmp>
References: <mailman.176.1227568041.29923.linuxppc-dev@ozlabs.org>
	<BD261180E6D35F4D9D32F3E44FD3D9010F1B21F8@EMPBEDEX.empirix.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Mon, 24 Nov 2008, Morrison, Tom wrote:
> Running 2.6.23.25 kernel...
>
> I have an external watchdog timer that is going off - and pulsing into
> the MCP0 of the 8572E. I get the printk indicating that the MCP0 went
> off - the problem is - how do I clear the condition that caused this
> because my hardware engineer swears that the pulse is ONLY 250ms - and
> after resetting several status registers (mcpsumr & rst
> (because my hardware engineer swears that the pulse is ONLY 250ms long
> (and I have a delay after my printk of 250ms)) - so I am pretty sure
>
> I am resetting the conditions mcpsumr (also, extra: the rstsr),
> but after writing mcpsumr - and reading back - it still has
> the mcp0 bit set?
>
> Where else do I need to reset the status - I think I am doing it
> right...
> but it isn't clearing the exception - and it 'dies' the next time
> through
> this (why is another problem - but first, I'd like to know why the
> condition
> is NOT being cleared...at all)...

SRESET# also sets MCP0 and MCP1, maybe that is on?

I'd also check the EMCP bit in SPRN_HID0 (on core 0 for MCP0).
