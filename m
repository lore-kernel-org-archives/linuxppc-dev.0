Message-ID: <819E3E914E0AD11194DE00805F0D100B0138B840@fbi.infocom.dk>
From: Kim Jørgensen <KIJ@infocom.dk>
To: "'linuxppc-embedded@lists.linuxppc.org'"
	 <linuxppc-embedded@lists.linuxppc.org>
Subject: RE: Problems with serial ports
Date: Fri, 28 Apr 2000 12:36:03 +0200
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


>> Linux runs fine on the board using smc1 as console, but I can't receive
or
>> transmit anything on smc2 and scc2.
>
>The SCC2 is used for Ethernet, and SMC2 is probably reserved for the
>Embedded Planet TDM audio codec.  If you don't use Ethernet, you can
>enable SCC2 for serial use.  You have to manually edit the
>arch/ppc/8xx_io/uart.c port table.

I did that, I added scc2 to rs_table in uart.c and the kernel seams to find
all the
serial ports:

CPM UART driver version 0.03
ttyS00 at 0x0280 is a SMC
ttyS01 at 0x0380 is a SMC
ttyS02 at 0x0100 is a SCC

>  I am working on a configurable
>version, just haven't found anything terribly fool-proof yet.  I also
>have a very different new driver I am testing for the uart.

Is the new driver available?


I tried to use scc2 as console under startup and smc1 as console by the
kernel. (I just changed serial_init to serial_scc_init in head.S)
This works ok, I get the startup messages on scc2 and the kernel messages
and bash prompt on smc1.
Now I can transmit and receive data on scc2 (ttyS2), but still not on smc2.
It seams like scc2 and smc1 is not initialised properly by uart.c.
Can anyone tell me what is wrong?

Kim Jorgensen


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
