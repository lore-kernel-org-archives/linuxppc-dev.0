Message-ID: <38397383.8F8677A1@jlc.net>
Date: Mon, 22 Nov 1999 11:46:59 -0500
From: Dan Malek <dmalek@jlc.net>
MIME-Version: 1.0
To: sorin@nitechinc.com
CC: linuxppc-embedded@lists.linuxppc.org
Subject: Re: IDE on MBX board
References: <99111909331400.01435@splash.nitechinc.com>
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Sorin Balea wrote:
> 
> Hello all
> 
> I've noticed that the MBX board has an IDE port. Has anyone been able to
> use it, let's say with a hard disk? Any tips regarding this problem?


Well......Cort had it working once, I tend to break and fix it at
various times.  I think right now it is broken......

The IDE has assumed knowledge of PC-style addresses and behavior.  To
use things like ATA Flash cards in the PCMCIA of the 8xx, I break the
generic IDE interface.  On the 8xx, it is also sensitive to the interrupt
controller.  Cort and I are always going back and forth about how to
use the internal interrupt controller in combination with the external
8259.  I want things that are more generic to other 8xx boards, and to
get IDE to work you have to make assumptions unique to the MBX.

I understand it would be nice to have the IDE working on the MBX, but
all of the products I have worked with use ATA flash....nothing has
ever used an IDE drive through a PCI/AT bus adapter.  This is why code
I tend to check in will allow PCMCIA ATA Flash and not the more complex
external IDE.....it represents products in the field.



	-- Dan

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
