Date: Tue, 23 Feb 1999 13:39:58 -0700 (MST)
From: Matt Porter <mmporter@home.com>
To: VALETTE Eric <valette@crf.canon.fr>
cc: cort@persephone.cs.nmt.edu, jpeters@phx.mcd.mot.com, paubert@iram.es,
        jeremy@goop.org, linuxppc-dev@lists.linuxppc.org
Subject: Re: Interrupt routing in prep_pci.c
In-Reply-To: <m10EzkG-0000WXC@tri-yann.crf.canon.fr>
Message-ID: <Pine.LNX.3.96.990223132534.4503A-100000@liberty.chnd1.az.home.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On Mon, 22 Feb 1999, VALETTE Eric wrote:

> eric>	1) we should know wether the board firmware correctly
> eric>	set up the PCI devices. If this is the case, the old
> eric>	interrupt scheme must be removed. Note that this
> eric>	implies to have a better scheme for identifying board than the
> eric>	inb (0x800) currently used.
> 
> Cort> That's right, we should keep the setup if it's correct.  Find me a better
> Cort> scheme for identifying the board, then.
> 
> For motorola, use the sytem configuration register at physaddr 0xfef80400 for
> example. I do not know all the boards but probably someone at motorola could 
> make suggestions as I bet PPCBUG has code to make it :)
> 
> I think  correct board dentification is a key point for code
> portability/autoconfiguration. Not working on this item will
> prevent any good restructuration as adding code for one board will
> break another...

Ok, maybe this will help stop the endless whining.

First determine Raven or Hawk existence, if it is Raven the following
works:

The key is to use the base module status register (BMSR) at I/O 0x802

0xe0  MCP750
0xe1  MCPN750
0xf7  MTX no parport
0xf8  MTX w/ parport
0xf9  MVME2300
0xfa  MVME2300SC or MVME2600 w/100BaseT (use SYSCR 0xfef80400 to determine
      which: bits 31-24 of SYSCR are 0xfd for 2300's or 0xfe for others)
0xfb  MVME2600/2700 w/712 I/O
0xfc  MVME2600/2700 w/761 I/O
0xfd  MVME3600 w/712 I/O
0xfe  MVME3600 w/761 I/O
0xff  MVME1600

Now, if it is a Hawk, you have a new architecture which has no board
registers.  VPD is stored in EEPROM across the Hawk I2C bus.  Write the
I2C lib for Hawk and parse the data.  It is _much_ more detailed than what
is available from the old register sets.  The first board with this scheme
is the MVME2400.

--
Matt Porter
mmporter@home.com
This is Linux Country. On a quiet night, you can hear Windows reboot.


[[ This message was sent via the linuxppc-dev mailing list. Replies are ]]
[[ not forced back to the list, so be sure to  Cc linuxppc-dev  if your ]]
[[ reply is of general interest. To unsubscribe from linuxppc-dev, send ]]
[[ the message 'unsubscribe' to linuxppc-dev-request@lists.linuxppc.org ]]
