Return-Path: <greg@kroah.com>
Received: from perch.kroah.org (mail.kroah.org [69.55.234.183])
	by ozlabs.org (Postfix) with ESMTP id D158067A65
	for <linuxppc-dev@ozlabs.org>; Sun,  2 Jul 2006 14:57:24 +1000 (EST)
Date: Sat, 1 Jul 2006 21:05:01 -0700
From: Greg KH <gregkh@suse.de>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: Re: [PATCH] powermac: Fix some 64b resource damage
Message-ID: <20060702040501.GA10452@suse.de>
References: <1151805303.19419.15.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1151805303.19419.15.camel@localhost.localdomain>
Cc: Andrew Morton <akpm@osdl.org>, linuxppc-dev list <linuxppc-dev@ozlabs.org>,
	Linus Torvalds <torvalds@osdl.org>, Paul Mackerras <paulus@samba.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Sun, Jul 02, 2006 at 11:55:03AM +1000, Benjamin Herrenschmidt wrote:
> The 64 bits resource patches did a bit of damage on PowerMac causing a
> buffer overflow in macio_asic and a warning in a sound driver. The
> former is fixed by reverting the sprintf of the bus_id to %08x as it was
> before. The bus_id used for macio devices is always a 32 bits value
> (macio always sits in 32 bits space) and since it's exposed to userland,
> the format of the string shouldn't be changed like that anyway. The
> second by using the proper type for printk.
> 
> Signed-off-by: Benjamin Herrenschmidt <benh@kernel.crashing.org>
> ---
> Linus, please apply asap since right now, PowerMac overflows kobject
> buffers on boot, pretty bad.

Acked by me, sorry about this.

greg k-h
