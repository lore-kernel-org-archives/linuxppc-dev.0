Message-ID: <38BA9C94.14977454@mpifr-bonn.mpg.de>
Date: Mon, 28 Feb 2000 17:04:36 +0100
From: Albrecht Dreﬂ <ad@mpifr-bonn.mpg.de>
MIME-Version: 1.0
To: LinuxPPC-Dev Liste <linuxppc-dev@lists.linuxppc.org>
Subject: iMac Mouse Three Button Emulation: a solution
Content-Type: multipart/mixed;
 boundary="------------F98EE77686E9EAE288C837CE"
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


This is a multi-part message in MIME format.
--------------F98EE77686E9EAE288C837CE
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit

[I'm afraid the original post was lost?  SORRY if you read this for the third
time now...]

Hi all!

I wrote a patch for linux-pmac-stable, version 2.2.15pre-something which
enables an emulation for the 2nd and 3rd mouse button for the iMac single
button mouse (and possibly other machines with both USB keyboard and mouse).
In principle, it works like the "adb_buttons" stuff, simply catching two kb
events from the keyboard and generating mouse events instead (BTW, the
adb_buttons stuff will NOT work on the iMac, as some people suggested, as it
needs adb keyboard and mouse).

To install the patch, save the stuff below to a file, run "patch -b -p 1 <
file" in the linux source directory, and execute "make menuconfig" or "make
xconfig". If you enable the USB mouse, there is a new check item "Enable
three-button emulation". Check it, save the configuration and build and install
as usual. Add "usb_buttons=x,y" to the kernel parameters (e.g. in BootX), with
x and y set to the keycodes which shall emulate the middle and right button
respectively. The default is "usb_buttons=71,81" for the num lock and = keys
(on an iMac with german keyboard).  Use "showkey -k" to get the keycodes for
your favorite ones.

Please note that you should NOT activate this feature if you have a working
three-button USB mouse, as the code blocks any 2nd and 3rd mouse button events
and passes the emulated ones only. This behaviour is not nice, but I must
admit that I can not imagine a situation where this is really a problem, so I
omitted the code to fix this. An other point: the emulation does of course not
work if you do not have an USB keyboard, e.g. if you connect the iMac Mouse to
a Lombard PowerBook.

I did not test the patch thoroughly yet, but it seems to work fine. I hope that
this is an useful extension, and if there are other people than me who think
so, it might be a good idea to include it in the standard tree (Paul?)?

Yours, Albrecht.

--------------F98EE77686E9EAE288C837CE
Content-Type: application/octet-stream;
 name="USB-Patch-2.2.15.gz"
Content-Disposition: attachment;
 filename="USB-Patch-2.2.15.gz"
Content-Transfer-Encoding: base64

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
wwL8/wH2+tXZrRMAAA==
--------------F98EE77686E9EAE288C837CE--


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
