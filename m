Message-Id: <199912010334.TAA08396@scaup.prod.itd.earthlink.net>
Date: Wed, 01 Dec 1999 03:34:48 GMT
From: jingai <jingai@earthlink.net>
To: linuxppc-dev@lists.linuxppc.org
CC: linuxppc-users@lists.linuxppc.org
Subject: USB mouse not working w/ kernel 2.3.29
Reply-To: jingai@earthlink.net
MIME-Version: 1.0
Content-Type: text/plain; charset="iso8859-1"
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>



I finally got Paul's unstable (2.3.29) kernel to build, and all is fine, except
that my Contour Designs UniMouse isn't working now.  Looking thru dmesg it
appears to be detected and registered, but it doesn't respond.  Upon checking
procinfo, the counter doesn't seem to be going up for mouse clicks/movements, although
the keyboard (a MacAlly USB keyboard) is working fine.  Did the major and/or
minor number change for the mouse lately??  Currently, /dev/mouse links to
/dev/usbmouse, which links to /dev/hidbp-mse-0, which has a major number of 10 and a
minor of 32.  This worked fine with my 2.2.12 and some 2.3.x back-port of the USB
stuff (sorry, I don't remember which 2.3 version I ripped the code from).

Here is the output during bootup:

---

OHCI USB Driver loading
usb-ohci: 2 root hub ports found
usbcore: Registered new driver mouse
USB HID boot protocol mouse driver registered.
usbcore: Registered new driver keyboard
usbcore: Registered new driver hub
ohci-control thread code for 0xc5fe0220 code at 0xc0135e00
New USB bus registered, assigned bus number 1
usb-ohci: HC c5fe0220 reset.
usb-ohci: host controller operational
USB new device connect, assigned device number 1
USB hub found
hub: 4 ports detected
hub: ganged power switching
hub: standalone hub
hub: global over-current protection
hub: power on to power good time: 100ms
hub: hub controller current requirement: 100mA
hub:  port 1 is removable
hub:  port 2 is removable
hub:  port 3 is removable
hub:  port 4 is removable
hub: local power source is good
hub: no over-current condition exists
hub: enabling power on all ports
usb: usb-bandwidth-alloc: was: 0, new: 11, bustime = 11 us, Pipe allowed: yes
usb: bw_alloc bumped to 11 for 1 requesters
usbcore: hub driver claimed interface c5fe09e0
ohci-control thread sleeping
hub: port 1 connection change
USB new device connect, assigned device number 2
usb: skipped 1 class/vendor specific interface descriptors
Manufacturer: 
Product: 
USB mouse found
usbcore: mouse driver claimed interface c5fe0ae0
hub: port 2 connection change
USB new device connect, assigned device number 3
Manufacturer: 
Product: 
SerialNumber: 
USB hub found
hub: 3 ports detected
hub: ganged power switching
hub: standalone hub
hub: global over-current protection
hub: power on to power good time: 44ms
hub: hub controller current requirement: 100mA
hub:  port 1 is not removable
hub:  port 2 is removable
hub:  port 3 is removable
hub: local power source is good
hub: no over-current condition exists
hub: enabling power on all ports
usb: usb-bandwidth-alloc: was: 11, new: 22, bustime = 11 us, Pipe allowed: yes
usb: bw_alloc bumped to 22 for 2 requesters
usbcore: hub driver claimed interface c5fe0ca0
hub: port 1 reset change
hub: port 2 reset change
hub: port 1 connection change
USB new device connect, assigned device number 4
usb: skipped 1 class/vendor specific interface descriptors
Manufacturer: 
Product: 
SerialNumber: 
USB HID boot protocol keyboard detected.
usb: usb-bandwidth-alloc: was: 22, new: 39, bustime = 17 us, Pipe allowed: yes
usb: bw_alloc bumped to 39 for 3 requesters
usbcore: keyboard driver claimed interface c5fe0de0
hub: port 1 reset change

---

Also, I'm a little concerned about the following, though I don't know what it
means:

PCI: Probing PCI hardware
PCI: Address space collision on region 2 of device ATI Technologies Inc 3D Rage
LT Pro
PCI: Address space collision on region 0 of device Initio Corporation 360P
PCI: Address space collision on region 1 of device Initio Corporation 360P
PCI: Address space collision on region 6 of device Initio Corporation 360P


Thanks in advance for any help,
Jonathan

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
