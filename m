Message-ID: <40B378EE.7050108@xiphos.ca>
Date: Tue, 25 May 2004 12:48:46 -0400
From: Joshua Lamorie <jpl@xiphos.ca>
MIME-Version: 1.0
To: linuxppc-embedded@lists.linuxppc.org
Subject: Re: Serial-to-socket conversion
References: <20040525162646.A291FC109F@atlas.denx.de>
In-Reply-To: <20040525162646.A291FC109F@atlas.denx.de>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Thank you for your suggestions.

Wolfgang Denk wrote:

>We're running a modified version of netkit-rsh which  allows  to  use
>"rlogin <host> -l <portname>" to connect to a remote serial port; for
>example, this config file might be used:
>
>

VanBaren, Gerald (AGRE) wrote:

> At this point you should be able to telnet into your target computer, port 1234 (in the above example),
> from your remote computer:
>  telnet 192.168.1.1 1234
> (filling in the proper IP address and port number).  Anything you type should go out the serial port
> and anything that comes in the serial port should be sent to your telnet session.


However, my problem remains at the local end.  I want to be able to
attach anything that would normally talk to a serial port to this
socket, without using an actual serial port because at the remote end I
have a 'funky serial port'.  It's actually some logic talking SPI in a
way that allows bi-directional emulation of a serial port.

I really want to be able to aim minicom at /dev/ttySFAKESERIALPORT which
is really a bi-directional pipe to some socket program (possibly nc) and
then I'll take care of the rest.  I want to do some file transfers
through this 'funky serial port', with error checking and I really don't
want to have to write my own.

Thanks again for your suggestions, and if I didn't have to make this
happen today, I'd probably try to write something lower level.  My
current solution is to have two serial ports on the local computer.
Minicom talks out ttyUSB0 through a null modem to ttyUSB1.
serial_client.c listens on ttyUSB1 and has a socket open to the remote
computer.  The remote computer does some funky shimmy sham and passes
every octet on to the embedded system.  Ugly, but I think it will work
(at low speeds with no hardware flow control).

Joshua

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
