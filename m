From: iweiny@pacbell.net
Date: Mon, 06 Dec 1999 14:23:12 -0800 (PST)
Subject: OHCI fix for Belkin BusPort card on PowerMac
To: linuxppc-dev@lists.linuxppc.org (linuxdev), linux-usb@suse.com (usb)
Message-id: <199912062223.OAA05538@batcave2.localdomain>
MIME-version: 1.0
Content-type: text/plain; charset=us-ascii
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Hello and thanks to all who have responded to my pleas for help.

I thought I would thank you and at the same time bring up an interesting
behavior I found to get my USB-DC265 Kodak camera to work.

I am running:
PowerMac 8500 (604 processor)
USB BusPort from Belkin (Model: F5U005-MAC) PCI USB card
LinuxPPC dist
2.2.12 kernel (self compiled)
2.3.29 USB stack from Paul Mackerras's rsync tree
opendis-0.0.3-pre4 from http://digitalux.netpedia.net

After many long nights of reading print statements in kernel logs.  I found
that the OHCI driver was IN FACT TALKING to the camera!

However, when requesting more data then the camera had to give the returned
status was "9" and not "0".  The OHCI driver interpreted this as an error and
subsequently the user level program would think no data had been returned.

After verifing the data to be correct I applied a very simple correction of:

/* Thinking this is what my controler returns when it is done? */
#define USB_ST_EOF           9

and used that to signal the ohci.c and dc2xx.c drivers that the "End of File"
had been reached.

My final question is:  Could this status be the same status as

#define USB_ST_DATAUNDERRUN   -9

or What does "data under run" mean?

It is obvious to me that my card has some unique status codes and I may run
into this in the future.  It is for this reason I will not include patches for
any of this unless others are like me with this type of card; trying to get 
bulk messages to work.

Once again Thank you all
Ira Weiny


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
