Message-ID: <3DFA3420.10105@mvista.com>
Date: Fri, 13 Dec 2002 11:25:20 -0800
From: Todd Poynor <tpoynor@mvista.com>
MIME-Version: 1.0
To: David Gibson <david@gibson.dropbear.id.au>
Cc: linuxppc-embedded@lists.linuxppc.org
Subject: Re: Support for Arctic platform (405LP based)
References: <20021213043628.GI21319@zax.zax>
In-Reply-To: <20021213043628.GI21319@zax.zax>
Content-Type: text/plain; charset=us-ascii; format=flowed
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


A few comments and questions...

I assume symbol CONFIG_ARCTIC2 is more appropriate than CONFIG_ARCTIC,
with additional symbols possibly to be invented in the future to
distinguish minor changes in board rev 3, 4, ... But mentioning this
just in case it might make future maintenance easier to use a single
symbol for common Arctic family code.

CONFIG_IBM_OPENBIOS is taken out of the CONFIG_SYCAMORE section of
arch/ppc/config.in?

Duplication of the CONFIG_BEECH case in
arch/ppc/boot/simple/embed_config.c: might be trying to enable the SSX
bootloader for Beech, but since CONFIG_IBM_OPENBIOS is on for Beech it
seems we'd have dup definitions?  Would more SSX code would be necessary
anyhow?

CONFIG_PPC_RTC is used to protect RTC code, most of these were
explicitly removed from other platforms some time ago, not sure what the
status of this is since there are a couple platforms that still use it.

I notice the bd_t has no entry for the ethernet MAC address in firmware,
like Beech, but am hoping there's an EEPROM on the device that holds
this info.  On Beech it causes some ugliness because the usual EEPROM is
not provided, so only the bootloader can program the ether dev's MAC.
And consequently the generic ethernet driver is hacked to deal with that.


--
Todd


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
