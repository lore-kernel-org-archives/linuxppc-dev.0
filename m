Message-ID: <3F7B38AE.4020406@embeddededge.com>
Date: Wed, 01 Oct 2003 16:27:26 -0400
From: Dan Malek <dan@embeddededge.com>
MIME-Version: 1.0
To: Kent Borg <kentborg@borg.org>
Cc: linuxppc-embedded@lists.linuxppc.org
Subject: Re: Where to Put Ethernet MAC Addresses?
References: <20031001153209.D688@borg.org>
Content-Type: text/plain; charset=us-ascii; format=flowed
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Kent Borg wrote:

> What are the various right ways to do this?

As Gary mentioned, most are handled in some way by the boot rom.
Many people put them in the boot rom flash (or rom if anyone uses
that anymore), and on PowerPC we use the first level linux bootloader
to recover this information and create some form of data record
that is passed to the kernel driver for further initialization
if necessary.

User 'init' scripts are usually too late, especially if you want
to use tftp in the rom for debug, or dhcp discovery.

There isn't any standard way, sometimes in flash, sometimes in
serial EEPROM along with other data.  Sometimes the mac address
is derived from the serial number.  It all depends upon what you
have available and how you may want to upgrade programmable devices
with new software in the field (you normally don't want to be erasing
mac addresses or serial numbers or such information as part of
programming new boot rom code).


	-- Dan


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
