Date: Sun, 22 Oct 2000 23:47:13 +0300 (EET DST)
From: Topi Kanerva <tkanerva@ees2.oulu.fi>
To: Claus Enneper <cl.en@gmx.net>
cc: linuxppc-dev@lists.linuxppc.org
Subject: Re: IrDA on PowerBooks
In-Reply-To: <20001017164617.B369@olis.north.de>
Message-ID: <Pine.GSO.4.21.0010222332230.4065-100000@stekt6>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On Tue, 17 Oct 2000, Claus Enneper wrote:

>don't know anything about the ericson, but as long as you followed
>the IRDA-HOWTO, it should work right out of the box.
>get the irda-utils src, or use debian's package.
>and there is a gsmlib-rpm at linuxppc, which manage your sms (no GUI).
>	I did't try that one, 'cause I use irda only for the palm.

now I know why it didn't work out of the box for me...
this is what I get in the dmesg log:

IrDA (tm) Protocols for Linux-2.2 (Dag Brattli)
irda_setup timed out on 1st byte
irda_setup timed out on 1st byte
IrDA: Registered device irda0
irtty_net_open()
irlap_change_speed(), setting speed to 9600

I looked at macserial.c, the "irda_setup timed out on 1st byte" is printed
if the chip doesn't give a proper response until the timeout finishes.
i tried increasing the timeout from 10ms to 20ms, but it didn't help.

so, the irda setup supposedly fails. (it branches to a label called "out",
but I didn't look the code much further...) so, this is on a Pismo
PowerBook, with kernel 2.2.17pre20-ben3, macserial.c compiled in the
kernel, other things are modules (like irda.o, ircomm.o, ircomm-tty.o,
irtty.o) however, I don't know what is the main difference between ircomm
and irtty, I couldn't find an explanation good enough anywhere, anyway
which one of these is supposed to work on PowerBooks?



-topi


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
