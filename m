Message-Id: <200008162349.BAA31630@denx.local.net>
To: "Prashant Patel" <pmpatel@myIAgent.com>
cc: linuxppc-embedded@lists.linuxppc.org
Subject: Re: Testing the serial port of TQM823L 
From: Wolfgang Denk <wd@denx.de>
Mime-version: 1.0
Content-type: text/plain; charset=ISO-8859-1
In-reply-to: Your message of "Wed, 16 Aug 2000 16:32:41 CDT."
             <008501c007c9$81ecbad0$fd2f7ece@kennedy>
Date: Thu, 17 Aug 2000 01:49:17 +0200
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Hi,

in message <008501c007c9$81ecbad0$fd2f7ece@kennedy> you wrote:
>
>       I am working with TQM823L board. It has two serial ports. I am using

I guess that's my bailiwick, then ;-)

> one serial port RS-232-2 ( and device ttyS0) to run the kernel stored in
> flash. Once the kernel is running, i think i can access another serial port
> RS-232-1 through device ttyS1. I have one program which writes on device

Right. You have configured SMC2 for serial console, and want  to  use
SMC1 as additional serial port.

> ttyS1. When i run that program, it is supposed to turn on the motor attached
> to serial port RS-232-1(i.e device ttyS1).  But it didn't work. When i
> tested my program with other board, it works fine.

Use a simpler setup for testing; attach another termial (any computer
with a free serial port running some terminal emulation)  to  the  TQ
board.

The use "echo some text >/dev/ttyS1" to send some characters  to  the
serial  port;  you  should  see  the  characters  "some  text" on the
connected terminal. The type "cat /dev/ttyS1"  on  the  console,  and
type  "some other text" on the connected terminal. You should see the
characters "some other text" on the console.

If this doesn't work it makes no sense to try any fancy programs  you
might have.

>      When i use "setserial" command, i got  following message.
> >setserial -ga /dev/ttyS0
> >Cannot get serial info. : invalid argument.
> >setserial -ga /dev/ttyS1
> >Cannot get serial info. : invalid argument

"setserial" is not supported (and not necessary) on MPC8xx systems.

>         so i don't know where i am making mistake.  How could i test whether
> serial port RS-232-1 is receiving data, whenever i write to device ttyS1?
> And  How could i test whether serial port RS-232-1 is live or not, after
> running kernel through serial port RS-232-2 (device ttyS0).

There are a few important issues:

* Make sure you are using the latest version of kernel  sources;  for
  the TQM8xxL see either

	ftp://ftp.denx.de/pub/LinuxPPC/usr/src/linux-2.2.13-2000-08-01.tar.bz2
  or
  	ftp://ftp.denx.de/pub/LinuxPPC/usr/src/linux-2.4-2000-08-01.tar.bz2

* Keep in mind that TQ has a very special pin-out  on  the  connector
  for  SMC1,  (mis-)  using  some  modem  handshake signals for other
  purposes. If you don't have  full  control  over  those  lines  you
  better  play  io  safe and use a cable with 3 wires only (GND, RxD,
  TxD).

* Make sure your receiving side does not wait for hardware  handshake
  signals. I'm using a cable like this with my TQ systems (assuming a
  standard 9 pin serial connector):

  3 wires (GND, RxD and TxD)  connect  the  TQ  board  to  the  other
  system, and on the "other system" side there are local connections of
  DTR with DSR and RTS with CTS resp.

  TQ board                  other system
  RxD 2 ------------------------- 3 TxD
  TxD 3 ------------------------- 2 RxD
  GND 5 ------------------------- 5 GND
   CD 1 n.c.                 n.c. 1 CD
  DTR 4 n.c.                   +- 4 DTR
  DSR 6 n.c.                   +- 6 DSR
  RTS 7 n.c.                 +--- 7 RTS
  CTS 8 n.c.                 +--- 8 CTS
   RI 9 n.c.                 n.c. 9 RI

Let me know if you have any other problems.

Wolfgang

--
Software Engineering:  Embedded and Realtime Systems,  Embedded Linux
Phone: (+49)-8142-4596-87  Fax: (+49)-8142-4596-88  Email: wd@denx.de
Another megabytes the dust.

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
