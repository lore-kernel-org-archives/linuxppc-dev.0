From: Philip.Lougher@Zarlink.Com
Subject: Re: Hung kernel on EP405?
To: Phillip.Treddenick@colorado.edu
Cc: linuxppc-embedded@lists.linuxppc.org,
	owner-linuxppc-embedded@lists.linuxppc.org
Message-ID: <OFD5A6157C.F5EA81EF-ON80256CD0.00482DBE@zarlink.com>
Date: Mon, 17 Feb 2003 13:26:29 +0000
MIME-Version: 1.0
Content-type: text/plain; charset=us-ascii
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Hi,

Philip Treddenick wrote:

>Any help or insight is appreciated.

I'd like to help, but you don't give enough information to do so...

>but when I run the kernel it appears to hang.  I would like
>to know if there is a way to verify what it's doing?  I've tried rlogin
and I've
>tried pinging it, but I don't get any response.  The kernel is setup to
mount a
>NFS, but I don't know how to verify that that is working either.  I tried
>enabling the ethernet port by setting the board control and status
registers.
>That didn't seem to work.

What does 'it appears to hang' mean?  Normally, when the kernel is entered
from the boot loader, and starts to boot-up, you will see a lot of kernel
booting messages on the serial port.  If you don't see these, then the
kernel is not booting.  In this case, there isn't any point in trying to
talk to the board via the ethernet, as it's not running anything.

If you are seeing bootup messages, then what is the output?  Normally, when
the kernel boots up it expects to mount the root  from hard disk or an
initrd, and have the ethernet IP  address setup after mounting the root.
However, if you're mounting the root via NFS (which is what is appears
you're doing), then the IP address has to be set before mounting the root.
To do this, the kernel has a configure option, that makes the kernel
automatically obtain an IP address via DHCP or BOOTP.  Do you have that
option set? (its in submenu Networking options, called IP: kernel level
autoconfiguation).  If you do, then you should check that your DHCP/BOOTP
server is getting a request, and is answering the board.  If you don't, the
kernel is probably giving up trying to mount the root.  In both cases, the
bootup messages will be pretty useful.

Phillip






                      Phillip.Treddenick@colorado.edu
                      Sent by:                               To:       linuxppc-embedded@lists.linuxppc.org
                      owner-linuxppc-embedded@lists.l        cc:
                      inuxppc.org                            Subject:  Hung kernel on EP405?


                      16-Feb-2003 07:37 AM







I am having trouble running Monta Vista Hardhat Linux on an EP405 board
with
Solaris 2.7 as the host.  I'm using the Planetcore bootloader to download
the
kernel to the board, but when I run the kernel it appears to hang.  I would
like
to know if there is a way to verify what it's doing?  I've tried rlogin and
I've
tried pinging it, but I don't get any response.  The kernel is setup to
mount a
NFS, but I don't know how to verify that that is working either.  I tried
enabling the ethernet port by setting the board control and status
registers.
That didn't seem to work.  Do these registers have specific settings
necessary
for running the EP405 board?

Any help or insight is appreciated.
Thanks, Phill Treddenick
        treddeni@colorado.edu


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
