Message-ID: <3C0E5AC7.4090203@embeddededge.com>
Date: Wed, 05 Dec 2001 12:35:03 -0500
From: Dan Malek <dan@embeddededge.com>
MIME-Version: 1.0
To: Rudolf Ladyzhenskii <rudolf.ladyzhenskii@act-aus.net>
Cc: "Linuxppc-Embedded (E-mail)" <linuxppc-embedded@lists.linuxppc.org>
Subject: Re: ATM switching in MPC8260
References: <B164B53F5BD6D511888D009027732E1A0249AA@ntserver.act.domain>
Content-Type: text/plain; charset=us-ascii; format=flowed
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Rudolf Ladyzhenskii wrote:

> Hi, all
>
> I have to do some ATM traffic switching

I'm not sure what you mean by "traffic switching."  The 603 core
needs to be involved for some management of the connections.  I've
done custom Ethernet bridging applications over ATM using the AAL5
and it has worked well.

> MPC8260 manual says that it is possible to do it on AAL0

The AAL0 is just a "raw" ATM cell connection.  Anything over this interface
requires 603 core interaction.  It's purpose is to provide a conduit for
ATM cells that aren't configured for processing by CPM.  Any VCI/VPI the
CPM receives that it doesn't understand is routed here.

> Does anyone know if this is possible for AAL5?

With AAL5 you just hand the CPM a PDU for transmit, and the receiver
returns the PDU in the receive buffer.  The CPM does all of the cell
fragmentation, CRC and length checks, and header processing.

There are many nice features of this ATM controller, including things
like bit rate and cell scheduling.  I suspect the whole of the Linux ATM
software can be done by the CPM (and then some), all we need is a data
path and control interface.

Have fun!


	-- Dan


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
