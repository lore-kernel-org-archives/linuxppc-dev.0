Message-ID: <33030.192.168.1.2.1005954563.squirrel@fridge.solinno.co.uk>
Date: Fri, 16 Nov 2001 23:49:23 -0000 (GMT)
Subject: yaboot on 43p140 (7043-140) - so close yet so far
From: "Leigh Brown" <leigh@solinno.co.uk>
To: linuxppc-dev@lists.linuxppc.org
Reply-To: leigh@solinno.co.uk
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Hi All,

I've been trying to get yaboot going on my 43p140 and I'm having limited
success.  I could not get yaboot to boot on the 140 as an ELF image, so
I hacked it to put a PReP header on the front using mkprep from the
kernel (.../arch/ppc/boot/util/mkprep.c).  I also amended crt0.S to
relocate the image as .../arch/ppc/boot/prep/head.S does.  The patch for
the changes I made is at http://www.solinno.co.uk/leigh/yaboot.140.diff.

This prep version of yaboot now boots correctly and many aspects of it
work, so the OF calls are being executed successfully.  However, the
major problem is that none of the methods to access the block devices are
working (read/seek/block-size).  Without these I don't see how yaboot
can access the devices to load the kernel images.  BTW the output from
yaboot booting on the 140 is at http://www.solinno.co.uk/leigh/minicom.cap.

The strange thing is, it looks like those methods _are_ present for the
devices, for example:

0 > dev /pci@80000000/scsi@10/sd@4,0  ok
    0 > .properties
        name                    sd
device_type             block
ibm,fw-device-code      21f00000
ibm,loc-code            04-D0-3,0
ok
   0 > words
       selftest        #blocks         size            offset-high
offset-low
write           read            seek            close           open
read-blocks     max-transfer    block-size      dev-selftest    dma-free

ok

I can even use see to look at the fcode although it doesn't mean anything
much to me.

Soooo, any open firmware experts got any ideas?  I'd really appreciate
any pointers anyone may have.

Cheers,

Leigh.

PS This using yaboot-1.3.5, although I get similar results with 1.2.5.


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
