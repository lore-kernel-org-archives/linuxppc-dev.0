To: linuxppc-embedded@lists.linuxppc.org
Subject: MPC8xx USB host mode
Message-ID: <1022759888.3cf613d09d1f7@imp.imms.de>
Date: Thu, 30 May 2002 13:58:08 +0200 (MEST)
From: Christian Schroeder <christian.schroeder@imms.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Hi all,

I try to enable the USB host controller on a mpc823 (TQM832L-Board).
The CPU is a mpc823e (PPC823EZTnnB2)

1. I collected and read all information from the web and this mailing
   list.
2. I got Brad Parkers's m8xxhci driver rev. 2 from heeltoe.com
3. I did some modifications in the driver source.
   - USE_TIMER1_FOR_SOF
   - USE_PA4_CLK4
4. I disabled the POLL_FOR_HUB code

If I boot the target, all seems ok.


If I connect a usb keyboard to the target, I get theese messages
(the keyboard contains a usb 5 port hub):

hub.c: USB new device connect on bus1/1, assigned device number 7
hub.c: USB hub found
hub.c: 5 ports detected
hub.c: USB new device connect on bus1/1/4, assigned device number 8
usb.c: USB device driver not accepting new addres=8 (error=-110)
usb.c: USB new device connect on bus 1/1/4 assigned device number 9
input0: USB HIDBP Keyboard 046a:0001 on on usb1:9.0

If I press the keyboard - nothing occurs ...
I dont't know, why the driver needs two tries to recognize the keyboard.
The TQM823L-Board uses a Philips USB Transceiver and I did not insert
the delay gates between the mpc and the transceiver. If I remove the
keyboard, the following messages occur:

usb.c: USB disconnect on device 7
usb.c: USB disconnect on device 9
rh_port_enable(0)

If I connect a Thunderbird 4-Port USB HUB, the following messages occur:

rh_port_reset(1)
hub.c: USB new device connect on bus1/1, assigned device number 10
usb.c: USB device not responding, giving up (error=-110)

or

rh_port_reset(1)
hub.c: USB new device connect on bus1/1, assigned device number 2
hub.c: USB hub found
hub.c: 4 ports detected
hub.c: Unable to get hub status (err=-110)
hub.c: hub configuration failed for device #2
usb.c: USB device 2 (vend/prod 0x3eb/0x3301) is not claimed by any active driver

Now - does the driver work or not or partially and do I need to insert
the delay gates between mpc an usb transceiver ?

Thanks for any answers.
Christian Schroeder

Dr.-Ing. Christian Schroeder
Institut fuer Mikroelektronik- und Mechatronik-Systeme
Langewiesener Strasse 22
98693 Ilmenau
Telefon: +49 3677 678315
Telefax: +49 3677 678337
Mobil:   +49 173 5789172
e-mail:  christian.schroeder@imms.de
www:     http://www.imms.de/~christi/cs.html
pgp:     finger christi@finger.imms.de


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
