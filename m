From: iweiny@pacbell.net
Date: Mon, 29 Nov 1999 17:20:47 -0800 (PST)
Subject: USB Bulk transfers
To: linuxppc-dev@lists.linuxppc.org (linuxdev)
Message-id: <199911300120.RAA01443@batcave2.localdomain>
MIME-version: 1.0
Content-type: text/plain; charset=us-ascii
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Has anyone done anything with the USB bulk transfers?

DETAILS:
PowerMac 8500
USB card and Mouse WORK!
kernel 2.2.12 self compiled
USB 2.3.29 code from Pauls rsync tree (modified for 2.2 kernel)

I have a Kodak Digital camera (DC-265) and I would like to get the USB working
for it.  I have been in contact with many from Intel linux side who have gotten
it to work with the recent dc2xx.c driver in the 2.3.xx USB stack.

My problem spcifically is this.  The control messages seem to be fine and
recognize the camera, set up the Endpoints and pipes and report the dc2xx
driver to have claimed the interface.  However, when user land accesses the
device the following message appears.

kernel: ohci_bulk_msg_completed 0, c1eae000, 68, c2235dd0
kernel: ohci_bulk_msg_completed 9, c1eae000, 0, c2235df0
kernel: ohci_bulk_msg done, status 9 (bytes_transferred = 0).

The second msg is the read request and the status 9 is...  What?  I thought it
was data underflow but that error number is -9 not 9?

I am not sure what is happening but I am thinking the camera is not getting the
68 bytes as the write msg claims.  Or quite possibly I have an endianess issue
and when the camera gets the data it does not understand?  I know the PCI is LE
and therefore USB is as well.  But is the data passed as LE or BE or whatever
the processor sends?

Thanks in advance
Ira Weiny
iweiny@acm.org


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
