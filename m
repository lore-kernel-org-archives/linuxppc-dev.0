From: bob@kunk.jriver.com
Message-ID: <19991008052744.14168.qmail@kunk.jriver.com>
Subject: USB printers
To: linuxppc-dev@lists.linuxppc.org
Date: Fri, 8 Oct 1999 00:27:44 -0500 (CDT)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


I have the rev 2.2.12 CVS kernel, an iMac and a Lexmark optra E310 USB laser
printer. I been trying different kernels to see if any will work with this
printer without success. I eventually did get it working with a hack.

First, the prehack dmesg USB output...

usb-ohci: HC c0271220 reset.
scsi : 1 host.
usb-ohci: host controller operational
USB new device connect, assigned device number 1
Found 02:09
Found 04:09
Found 05:07
parsed = 25 len = 0
USB hub found
hub: 4-ports detected
hub: individual port power switching
hub: standalone hub
hub: individual port over current protection
hub: power on to power good time: 100ms
hub: hub controller current requirement: 80mA
hub:  port 1 is removable
hub:  port 2 is removable
hub:  port 3 is removable
hub:  port 4 is removable
hub: local power source is good
hub: no over current condition exists
USB hub 1: enabling power on all ports
hub: port 1 connection change
USB new device connect, assigned device number 2
Found 02:09
Found 04:09
Expected descriptor 05/07, got 21/09 - skipping
 09 21 00 01 00 01 22 40 00
Found 05:07
parsed = 34 len = 0
Manufacturer: Alps Electric
Product: M2452
USB HID boot protocol keyboard detected.
hub: port 2 connection change
USB new device connect, assigned device number 3
Found 02:09
Found 04:09
Expected descriptor 05/07, got 21/09 - skipping
 09 21 00 01 00 01 22 32 00
Found 05:07
parsed = 34 len = 0
Manufacturer: Logitech
Product: M4848
USB mouse found
hub: port 3 connection change
USB new device connect, assigned device number 4
Found 02:09
Found 04:09
Found 05:07
Found 05:07
parsed = 32 len = 0
Manufacturer: Lexmark International, Inc.
Product: Lexmark Optra E310
SerialNumber: R0UCM000
Unknown new USB device:
  Length              = 18
  DescriptorType      = 01
  USB version         = 1.00
  Vendor:Product      = 043d:000c
  MaxPacketSize0      = 8
  NumConfigurations   = 1
  Device version      = 1.00
  Device Class:SubClass:Protocol = 00:00:00
    Per-interface classes
Configuration:
  bLength             =    9
  bDescriptorType     =   02
  wTotalLength        = 0020
  bNumInterfaces      =   01
  bConfigurationValue =   01
  iConfiguration      =   00
  bmAttributes        =   40
  MaxPower            =    0mA

  Alternate Setting: 0
  Interface:
    bLength             =    9
    bDescriptorType     =   04
    bInterfaceNumber    =   00
    bAlternateSetting   =   00
    bNumEndpoints       =   02
    bInterface Class:SubClass:Protocol =   07:01:02
    iInterface          =   00
    Endpoint:
      bLength             =    7
      bDescriptorType     =   05
      bEndpointAddress    =   01 (out)
      bmAttributes        =   02 (Bulk)
      wMaxPacketSize      = 0040
      bInterval           =   00
    Endpoint:
      bLength             =    7
      bDescriptorType     =   05
      bEndpointAddress    =   81 (in)
      bmAttributes        =   02 (Bulk)
      wMaxPacketSize      = 0020
      bInterval           =   00
hub: port 1 reset change
hub: port 2 reset change
hub: port 3 reset change
---------------------------------------------------

I noticed above that:

 bEndpointAddress    =   81 (in)

and that /usr/src/linux/drivers/usb/printer.c was looking for 82 so I made
the following change...

282c282
<                   interface->endpoint[1].bEndpointAddress != 0x81 ||
---
>                   interface->endpoint[1].bEndpointAddress != 0x82 ||

and got the following USB dmesg from the new kernel...
---------------------------------------------------
usb-ohci: HC c0271220 reset.
scsi : 1 host.
usb-ohci: host controller operational
USB new device connect, assigned device number 1
Found 02:09
Found 04:09
Found 05:07
parsed = 25 len = 0
USB hub found
hub: 4-ports detected
hub: individual port power switching
hub: standalone hub
hub: individual port over current protection
hub: power on to power good time: 100ms
hub: hub controller current requirement: 80mA
hub:  port 1 is removable
hub:  port 2 is removable
hub:  port 3 is removable
hub:  port 4 is removable
hub: local power source is good
hub: no over current condition exists
USB hub 1: enabling power on all ports
hub: port 1 connection change
USB new device connect, assigned device number 2
Found 02:09
Found 04:09
Expected descriptor 05/07, got 21/09 - skipping
 09 21 00 01 00 01 22 40 00
Found 05:07
parsed = 34 len = 0
Manufacturer: Alps Electric
Product: M2452
USB HID boot protocol keyboard detected.
hub: port 2 connection change
USB new device connect, assigned device number 3
Found 02:09
Found 04:09
Expected descriptor 05/07, got 21/09 - skipping
 09 21 00 01 00 01 22 32 00
Found 05:07
parsed = 34 len = 0
Manufacturer: Logitech
Product: M4848
USB mouse found
hub: port 3 connection change
USB new device connect, assigned device number 4
Found 02:09
Found 04:09
Found 05:07
Found 05:07
parsed = 32 len = 0
Manufacturer: Lexmark International, Inc.
Product: Lexmark Optra E310
SerialNumber: R0UCM000
USB Printer found at address 4
hub: port 1 reset change
hub: port 2 reset change
hub: port 3 reset change

------------------------------------

Created the device node and boom, it works. I don't know what side effects 
this will have, if any, but it makes the E310 work.
One other small concern, if I start with the printer off then turn it on
after the boot, I get..

hub: port 3 connection change
USB new device connect, assigned device number 4
get_descriptor failed, waiting
get_descriptor failed, waiting
get_descriptor failed, waiting
get_descriptor failed, waiting
get_descriptor failed, waiting
giving up
hub: port 3 reset change

------------------------------------
Looks like the driver times out too quick. The printer takes 30 seconds or
more to come up but the above messages take less than 10 seconds to complete.
With the printer on before boot however it works great.

Bob
-- 
Robert E. Brose II    N0QBJ
http://www.jriver.com/~bob/
bob@jriver.com

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
