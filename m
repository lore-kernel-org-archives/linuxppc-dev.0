Date: Tue, 30 May 2000 12:30:42 -0400 (EDT)
From: "Mark S. Mathews" <mark@absoval.com>
To: Matthew Locke <mlocke@jps.net>
cc: linuxppc-embedded@lists.linuxppc.org
Subject: RE: rpx_cfg() copy to NVRAM?
In-Reply-To: <NDBBJCEBJMJJJBIMCFBEOEDJCDAA.mlocke@jps.net>
Message-ID: <Pine.LNX.3.96.1000530120941.8139A-100000@tristar.cc.absoval.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


On Tue, 30 May 2000, Matthew Locke wrote:

> > I'm in the process of changing head.S and embed_config.c to work with the
> > new EP bootloader.
>
> Why?  You don't need to change anything.  There are two configuration
> variables in the eeprom that need to be set.

Why? the HZ key is no longer present and the value of the SB key is now
baud instead of baud/100.

Additionally, based on my read of the bootldr docs, EP (you? ;-) is trying
to set things up so that (in the future) they can change the contents or
format of the eeprom without warning.  Therefore, the bootldr does a
'conversion' of the eeprom data to the RPXU key=value similar format and
writes it to dpram.

I get the sense that the keys and value formats won't change whereas the
contents of eeprom might be changed in the future.

> SYPCR needs to be set to turn the watchdog off. Can't remember the value
> and I don't have the docs in front of me.

I'm using 0xffffff89

> NVRAM needs to be set to
> non-zero, even if the board doesn't have any nvram.

I'm using a 'no-nvram' rpxlite and I have NVRam set to zero.  Works just
fine.  Is this an issue with the bootldr or with what Linux wants from
eeprom?

-Mark

Mark S. Mathews

AbsoluteValue Systems      Web:    http://www.absoval.com
P.O. Box 941149            e-mail: mark@absoval.com
Maitland, FL 32794-1149    Phone:  407.644.8582
USA                        Fax:    407.539.1294


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
