Message-ID: <20040624115640.49843.qmail@web13606.mail.yahoo.com>
Date: Thu, 24 Jun 2004 04:56:40 -0700 (PDT)
From: m madhuker <mythri_madhuker@yahoo.com>
Subject: problem with usb webcam in MPC8245
To: linuxppc-embedded@lists.linuxppc.org
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


hello all,

             Iam working with MPC8245 board.and iam
using timesys GPL-linux(kernel ver: 2.4.7).

        We have logitec quickcam 3000 pro webcam.
which supports philips driver. in x86 linux system its
working well.(since driver was already installed).

        But in this board kernel has pwc-8.0 version,
which not support our webcam. so we downloaded philips
8.8 version. which supports quickam 3000 pro webcam.
and as per installation notes we followed...
      but when we compile kernel(make zImage.initrd.)
        it got error as follows:
        ----------------
      pwc-if.c:2023: parse error before string
constant
        cc1: warnings being treated as errors
    pwc-if.c:2023: warning: type defaults to `int' in
declaration of `MODULE_LICENSE'
        pwc-if.c:2023: warning: function declaration
isn't a prototype
        pwc-if.c:2023: warning: data definition has no
type or storage class
        make[3]: *** [pwc-if.o] Error 1
        make[3]: Leaving directory
`/usr/src/timesys/ampenpp1/2.4.7-timesys-3.1.554/kernel/drivers/usb'
        make[2]: *** [first_rule] Error 2
        make[2]: Leaving directory
`/usr/src/timesys/ampenpp1/2.4.7-timesys-3.1.554/kernel/drivers/usb'
        make[1]: *** [_subdir_usb] Error 2
        make[1]: Leaving directory
`/usr/src/timesys/ampenpp1/2.4.7-timesys-3.1.554/kernel/drivers'
        make: *** [_dir_drivers] Error 2
        [root@mail kernel]#
        -------------------------

        so we masked the line no: 2023 as follows:
        MODULE_LICENCE("GPL");
        then after it was complied sucessesfully...and

        while booting kernel in board its dispalyed as
follows:
        -------------
        usb.c: registered new driver usbdevfs
        usb.c: registered new driver hub
        pwc Philips PCA645/646 + PCVC675/680/690 +
PCVC730/740/750 webcam module versio.pwc Also supports
the Askey VC010, Logitech Quickcam 3000 Pro, Samsung
MPC-C10 ,pwc the Creative WebCam 5, SOTEC Afina Eye
and Visionite VCS-UC300 and VCS-UM10.usb.c: registered
new driver Philips webcam
        ----------------
        we thought board was detected.
        but, when we run application it is saying:
        /dev/video0: No such device.

        we created the node also as 'mknod /dev/video0
c 81 0'
        please give suggestion.
                            Thanking you.
                                       Regards
                                       Madhukar


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
