Message-Id: <199910080148.SAA15697@snipe.prod.itd.earthlink.net>
Subject: Continuing USB Problems
Date: Thu, 7 Oct 99 21:49:10 -0400
From: jingai <jingai@earthlink.net>
To: "linuxppc-dev" <linuxppc-dev@lists.linuxppc.org>,
        "linuxppc-user" <linuxppc-user@lists.linuxppc.org>,
        "linux-usb" <linux-usb@suse.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Okay, I've finally gotten around to digging thru the 2.3.19 USB code to 
try to pinpoint my problem.  First of all, this is my setup:

UMAX S900 (PowerMac clone), Entrega 4-port USB card (two root hubs, I 
believe), Contour Designs Unimouse, and a MacAlly iKey keyboard.

The OHCI USB driver fails when trying to get a descriptor from the device 
(my mouse).  It seems to recognize the card just fine, though.  I turned 
on debug messages and also added some of my own (to print the result from 
the call to the function that grabs the descriptor), which I have 
attached to this email below.

Also, just FYI, I have installed the PCI Patches mentioned on the 
linuxppc-dev list, and also modified the USB code as described in the USB 
HOWTO on http://www.dynamine.net/linux-usb/HOWTO/

Anyway, if anyone can help, I would *really* appreciate it.  I have been 
hacking at this for three weeks to no avail :(  Oh, and I have tried 
plugging the mouse into all four of the ports, but nothing changed.

Here is the output from the driver (note: my debug messages are precluded 
by JSLUSB):

OHCI USB Driver loading
usb-ohci: Warning! Gobs of debugging output has been enabled.
          Check your kern.debug logs for the bulk of it.
usb-ohci: 2 root hub ports found
usb-ohci: forking ohci-control thread for 0xc028e220
ohci-control thread code for 0xc028e220 code at 0xc0114b20
New USB bus registered
usb-ohci: HC c028e220 reset.
usb-ohci: host controller operational
entering ohci_check_configuration c028e220
ohci_connect_change on port 0
USB new device connect, assigned device number 1
ohci_control_msg: timed out on pipe 80000080 cmd 80 6 100 0 8
JSLUSB: result of call to dev->bus->op->control_msg() == 272.
ohci_control_msg: timed out on pipe 80000080 cmd 80 6 100 0 8
JSLUSB: result of call to dev->bus->op->control_msg() == 272.
ohci_control_msg: timed out on pipe 80000080 cmd 80 6 100 0 8
JSLUSB: result of call to dev->bus->op->control_msg() == 272.
ohci_control_msg: timed out on pipe 80000080 cmd 80 6 100 0 8
JSLUSB: result of call to dev->bus->op->control_msg() == 272.
ohci_control_msg: timed out on pipe 80000080 cmd 80 6 100 0 8
JSLUSB: result of call to dev->bus->op->control_msg() == 272.
ohci_control_msg: timed out on pipe 80000080 cmd 80 6 100 0 8
JSLUSB: result of call to dev->bus->op->control_msg() == 272.
ohci_control_msg: timed out on pipe 80000080 cmd 80 6 100 0 8
JSLUSB: result of call to dev->bus->op->control_msg() == 272.
ohci_control_msg: timed out on pipe 80000080 cmd 80 6 100 0 8
JSLUSB: result of call to dev->bus->op->control_msg() == 272.
ohci_control_msg: timed out on pipe 80000080 cmd 80 6 100 0 8
JSLUSB: result of call to dev->bus->op->control_msg() == 272.
ohci_control_msg: timed out on pipe 80000080 cmd 80 6 100 0 8
JSLUSB: result of call to dev->bus->op->control_msg() == 272.
usb-ohci: unable to allocate a TD
usb-ohci: out of TDs
usb-ohci: build_td_chain failed for dev c03b6000, pipe 0x80000080
usbcore: USB device not responding, giving up
ohci-control thread sleeping

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
