Date: Sun, 15 Dec 2002 18:35:49 +1100
From: David Gibson <david@gibson.dropbear.id.au>
To: Todd Poynor <tpoynor@mvista.com>
Cc: linuxppc-embedded@lists.linuxppc.org
Subject: Re: Support for Arctic platform (405LP based)
Message-ID: <20021215073549.GB16755@zax.zax>
References: <20021213043628.GI21319@zax.zax> <3DFA3420.10105@mvista.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <3DFA3420.10105@mvista.com>
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


On Fri, Dec 13, 2002 at 11:25:20AM -0800, Todd Poynor wrote:
> A few comments and questions...
>
> I assume symbol CONFIG_ARCTIC2 is more appropriate than CONFIG_ARCTIC,
> with additional symbols possibly to be invented in the future to
> distinguish minor changes in board rev 3, 4, ... But mentioning this
> just in case it might make future maintenance easier to use a single
> symbol for common Arctic family code.

Well... the difference between Artic-1 and Arctic-2 is not just a
board revision - they are quite different devices, with different
peripherals on board.  So there's not much point sharing a cnofig
option for these two.  On the other hand Arctic-3 (if and when it
exists) is likely to be a relatively small revision of Arctic-2, so
we'll probably want to use the CONFIG_ARCTIC2 symbol for it as well.

> CONFIG_IBM_OPENBIOS is taken out of the CONFIG_SYCAMORE section of
> arch/ppc/config.in?

Err... I have no idea what you're asking.  How did SYCAMORE get into
this?

> Duplication of the CONFIG_BEECH case in
> arch/ppc/boot/simple/embed_config.c: might be trying to enable the SSX
> bootloader for Beech, but since CONFIG_IBM_OPENBIOS is on for Beech it
> seems we'd have dup definitions?  Would more SSX code would be necessary
> anyhow?

Again, I'm afraid I'm having trouble parsing that paragraph - what do
you want to know?

> CONFIG_PPC_RTC is used to protect RTC code, most of these were
> explicitly removed from other platforms some time ago, not sure what the
> status of this is since there are a couple platforms that still use it.
>
> I notice the bd_t has no entry for the ethernet MAC address in firmware,
> like Beech, but am hoping there's an EEPROM on the device that holds
> this info.  On Beech it causes some ugliness because the usual EEPROM is
> not provided, so only the bootloader can program the ether dev's MAC.
> And consequently the generic ethernet driver is hacked to deal with that.

The ethernet on the Artic-2 debug board (RTL8019 based - not the same
as the Beech's ethernet - driver coming soon) does indeed have an
EEPROM.

--
David Gibson			| For every complex problem there is a
david@gibson.dropbear.id.au	| solution which is simple, neat and
				| wrong.
http://www.ozlabs.org/people/dgibson

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
