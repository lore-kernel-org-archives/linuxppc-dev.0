Message-ID: <19990921003754.25514.rocketmail@web125.yahoomail.com>
Date: Mon, 20 Sep 1999 17:37:54 -0700 (PDT)
From: David Hay <hay_dave@yahoo.com>
Reply-To: hay@colorado.edu
Subject: USB driver not detecting mouse? (lots of detail)
To: linuxppc-user@lists.linuxppc.org, linuxppc-dev@lists.linuxppc.org
Cc: iweiny@falcon.csc.calpoly.edu
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


I have a Kensington USB Mouse-In-A-Box Scroll mouse which works fine under
MacOS, so I know there's nothing wrong with the mouse or the Entegra 4-Port
USB card it's connected to.  I have a Power Tower Pro 225 (if that makes a
difference)

Here's what I've done so far:

1. I applied the PCI patches, mentioned previously in the linuxppc-dev list,
to my 2.2.12 kernel and now my USB card is recognized (search for "Various
PCI Patches").  Here's the card entry from /proc/pci:

  Bus  1, device  14, function  0:
    USB Controller: OPTi Unknown device (rev 16).
      Vendor id=1045. Device id=c861.
      Medium devsel.  Fast back-to-back capable.  IRQ 28.  Master Capable. 
Latency=32.
      Non-prefetchable 32 bit memory at 0x90000000 [0x90000000].

2. I followed the instructions for using the 2.3 USB driver with a 2.2 kernel
and was able to compile everything.  Now, when I load the usb-ohci module, I
get the following messages in my log:


Sep 20 18:20:57 dhay kernel: OHCI USB Driver loading 
Sep 20 18:20:57 dhay kernel: usb-ohci: Warning! Gobs of debugging output has
been enabled. 
Sep 20 18:20:57 dhay kernel:           Check your kern.debug logs for the
bulk of it. 
Sep 20 18:20:57 dhay kernel: usb-ohci: 2 root hub ports found 
Sep 20 18:20:57 dhay kernel: usb-ohci: forking ohci-control thread for
0xc1e88880 
Sep 20 18:20:57 dhay kernel: ohci-control thread code for 0xc1e88880 code at
0xc8837acc 
Sep 20 18:20:57 dhay kernel: New USB bus registered 
Sep 20 18:20:57 dhay kernel: usb-ohci: HC c1e88880 reset. 
Sep 20 18:20:57 dhay kernel: usb-ohci: host controller operational 
Sep 20 18:20:57 dhay kernel: entering ohci_check_configuration c1e88880 
Sep 20 18:20:57 dhay kernel: ohci_connect_change on port 0 
Sep 20 18:20:57 dhay kernel: USB new device connect, assigned device number 1

Sep 20 18:20:57 dhay kernel: ctrl msg 80 6 100 0 8 on pipe 80000080 returned:

Sep 20 18:20:57 dhay kernel:  12 1 0 1 9 0 0 8 
Sep 20 18:20:57 dhay kernel: ctrl msg 80 6 100 0 12 on pipe 80000180
returned: 
Sep 20 18:20:57 dhay kernel:  12 1 0 1 9 0 0 8 51 4 46 14 0 1 0 0 
Sep 20 18:20:57 dhay kernel:  0 1 
Sep 20 18:20:57 dhay kernel: ctrl msg 80 6 200 0 8 on pipe 80000180 returned:

Sep 20 18:20:57 dhay kernel:  9 2 19 0 1 1 0 e0 
Sep 20 18:20:57 dhay kernel: ctrl msg 80 6 200 0 19 on pipe 80000180
returned: 
Sep 20 18:20:57 dhay kernel:  9 2 19 0 1 1 0 e0 32 9 4 0 0 1 9 0 
Sep 20 18:20:57 dhay kernel:  0 0 7 5 81 3 1 0 ff 
Sep 20 18:20:57 dhay kernel: Unknown new USB device: 
Sep 20 18:20:57 dhay kernel:   Length              = 18 
Sep 20 18:20:57 dhay kernel:   DescriptorType      = 01 
Sep 20 18:20:57 dhay kernel:   USB version         = 1.00 
Sep 20 18:20:57 dhay kernel:   Vendor:Product      = 0451:1446 
Sep 20 18:20:57 dhay kernel:   MaxPacketSize0      = 8 
Sep 20 18:20:57 dhay kernel:   NumConfigurations   = 1 
Sep 20 18:20:57 dhay kernel:   Device version      = 1.00 
Sep 20 18:20:57 dhay kernel:   Device Class:SubClass:Protocol = 09:00:00 
Sep 20 18:20:57 dhay kernel:     Hub device class 
Sep 20 18:20:57 dhay kernel: Configuration: 
Sep 20 18:20:57 dhay kernel:   bLength             =    9 
Sep 20 18:20:57 dhay kernel:   bDescriptorType     =   02 
Sep 20 18:20:57 dhay kernel:   wTotalLength        = 0019 
Sep 20 18:20:57 dhay kernel:   bNumInterfaces      =   01 
Sep 20 18:20:57 dhay kernel:   bConfigurationValue =   01 
Sep 20 18:20:57 dhay kernel:   iConfiguration      =   00 
Sep 20 18:20:57 dhay kernel:   bmAttributes        =   e0 
Sep 20 18:20:57 dhay kernel:   MaxPower            =  100mA 
Sep 20 18:20:57 dhay kernel:  
Sep 20 18:20:57 dhay kernel:   Interface: 0 
Sep 20 18:20:57 dhay kernel:   Alternate Setting:  0 
Sep 20 18:20:57 dhay kernel:     bLength             =    9 
Sep 20 18:20:57 dhay kernel:     bDescriptorType     =   04 
Sep 20 18:20:57 dhay kernel:     bInterfaceNumber    =   00 
Sep 20 18:20:57 dhay kernel:     bAlternateSetting   =   00 
Sep 20 18:20:57 dhay kernel:     bNumEndpoints       =   01 
Sep 20 18:20:57 dhay kernel:     bInterface Class:SubClass:Protocol =  
09:00:00 
Sep 20 18:20:57 dhay kernel:     iInterface          =   00 
Sep 20 18:20:57 dhay kernel:     Endpoint: 
Sep 20 18:20:57 dhay kernel:       bLength             =    7 
Sep 20 18:20:57 dhay kernel:       bDescriptorType     =   05 
Sep 20 18:20:57 dhay kernel:       bEndpointAddress    =   81 (in) 
Sep 20 18:20:57 dhay kernel:       bmAttributes        =   03 (Interrupt) 
Sep 20 18:20:57 dhay kernel:       wMaxPacketSize      = 0001 
Sep 20 18:20:57 dhay kernel:       bInterval           =   ff 
Sep 20 18:20:57 dhay kernel: ohci-control thread sleeping

This suggests to me a few things:

(1) My 4-port card has two hubs on it (2 ports each)
(2) The driver is not finding the mouse attached to the hub (since the device
info above Indicates it's for a hub.
(3) The second hub is not found either.

So any ideas on what's going on here?  Any reason the initialization code
isn't finding my mouse?  I've tried loading the module with my mouse plugged
into each port, and nothing seems to make a difference.

Thanks!
===
------------------------------------------------------------
 David Hay                                     \|/ ____ \|/
 hay@colorado.edu                              ~@-/ oO \-@~
 http://home.earthlink.net/~dhay/              /_( \__/ )_\
 ~ Live well ~ Laugh often ~ Love much ~          \__U_/

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
