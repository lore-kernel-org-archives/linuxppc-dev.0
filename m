From: Paul Mackerras <paulus@linuxcare.com>
To: linuxppc-dev@lists.linuxppc.org
Subject: Re: IrDA
Date: Tue, 29 Feb 2000 14:47:22 +1100
Content-Type: text/plain
References: <38BAD4DB.CA50A2E1@mondonet.net>
MIME-Version: 1.0
Message-Id: <00022914512901.11287@argo.linuxcare.com.au>
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On Tue, 29 Feb 2000, Mario Scarpa wrote:

> any luck in putting the irda thing into the kernel ?
> Trying with a lombard with no success :(

This is how far I have got with the IR port on the 101 (lombard):

By default the transmitter will output a pulse of light on each change of
level on the transmit data line from the serial port.  To get the effect
of a pulse of light for each zero bit (which is the IrDA encoding for the
slower speeds, up to 115.2kB/s) you have to set the serial port chip
(Z8530) to use NRZI encoding.  This is not too hard for transmission but
for receiving it means that you have to use the digital phase-locked loop
(DPLL) in the 8530 chip.  I tried setting it up to do that but I didn't
have much success, the receiver got mostly garbage when I tried sending
stuff to it.

--
Paul Mackerras, Senior Open Source Researcher, Linuxcare, Inc.
+61 2 6262 8990 tel, +61 2 6262 8991 fax
paulus@linuxcare.com.au, http://www.linuxcare.com.au/
Linuxcare.  Support for the revolution.

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
