Message-ID: <3A1F0C14.C238B12@vienna.at>
Date: Sat, 25 Nov 2000 01:47:16 +0100
From: Roman Weissgaerber <weissg@vienna.at>
Reply-To: weissg@vienna.at
MIME-Version: 1.0
To: dan@mvista.com, Brad Parker <brad@parker.boston.ma.us>,
        linuxppc-embedded@lists.linuxppc.org,
        "linux-usb-devel@lists.sourceforge.net"
 <linux-usb-devel@lists.sourceforge.net>
Subject: MPC850 USB Host >was Re: USB Host mode on RPX Lite DW?
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Hi Brad, Hi Dan,

I have done some testing of the USB host driver for MPC850
on a TQ components STK 8xxL Starter Kit with a TQM850L board.

Configuration changes for STK 8xxL/50MHz:
- used an external 48 MHz clock connected to clock 4 for USB clock
- used Timer 1 for SOF generation/microcode patch
- removed the dip-switches stuff
- the driver qualified the MPC850 as bad device revision x21 x01
  I have removed that check


There was a basic functionality after some changes (see below)
of the MPC850 Host driver with the following devices:

- HUB: connects and switches on the ports,
  but connecting a device to the HUB fails;
  also, about every 10th int transfer gets a timeout (no ACK)

- Printer: Bulk out seems to work, prints

- plusb (host-to-host): ping can be detected on the other
  host (tcpdump) but does not come back to the MPC850
  -> bulk in seems to fail

- serial /USC1000 : can send chars (bulk out),
  receiving chars fails (bulk in)


Problems of the MPC850 Host driver that needs a fix/workaround:

- the retry value on errors should be reseted to 0 on every successful
  transfer (also a NAKed transfer is a successful transfer)
  otherwise the HCI stops INT transfers after the third error in a long
  period of time
 (eg. a HUB replies with NAKs as long as there is no connection-change
  and after the third error it fails)

- the driver internally rejects URBs with buffers larger than n Packets
  where n is limited by the available BDs
  (eg. 40 BDs , 64 Bytes packets = 2560 Bytes max buffer size)
  most devices use larger URBs

- the Data toggle switching of BULK transfers (DATA0/DATA1)
  must be continuous over the whole lifetime of an endpoint.
  But, the driver starts with a DATA0 at every new URB.
  (The support for the data-toggle in usb.c should be used)
  (Also there is no check of the data toggle of incomming transfers)

Other changes I have done so far:

- I replaced the MPC850-driver-process by a simple virtual root hub,
  (like OHCI and UHCI)
- A new device should be detected by the 'physical layer'
  and not by polling with a get descriptor bus transfer;
  this should be replaced
  with a read of the state of the BUS-wires


As I have stripped the driver a little bit and have cutted
it into 5 pieces it is not easy to make a patch immediately.
(it is hard for me to understand 5000 lines of code in one file)

Now, what is the best way to send patches, modifications or experimental
code
for the mpc850 host driver, and what list should we use for discussion.

- Roman

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
