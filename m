Message-ID: <1046452964.3e5f9ae4ee444@webmail.colorado.edu>
Date: Fri, 28 Feb 2003 10:22:44 -0700
From: Phill Treddenick <Phillip.Treddenick@colorado.edu>
To: "linuxppc-embedded@lists.linuxppc.org" <linuxppc-embedded@lists.linuxppc.org>
Subject: RE: Re: Hung kernel on EP405?
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Hi,

Here is a detailed account of what's happening.  (Monta Vista Hardhat Linux
2.0 running on an embedded planet EP405 rev 1.2 with Solaris 2.7 as the host)
I build the kernel doing a 'make dep' and then
a 'make zImage'.  Then, I download the kernel(the umcompressed "vmlinux"
kernel, is this the correct one to use?)
via tftp using Planetcore Bootloader version 1.01.  I load it into a reasonable
location in the RAM(I've tried many).  I am then able to dump the contents of
memory using the bootloader and see that the kernel has in fact been loaded into
RAM.  Now, when I make the jump into the code one of two things happens: If I
jump to an address 0x10000 above where I loaded the code (I was told I needed to
do this to get around the elf header) then I get no response in my kermit
terminal, all the LEDs on the board are off and the only way to recover is to
push the reset button on the board.  If I jump to
any other address(I've tried many) the board resets itself immediately and the
bootloader begins running again.  Am I just jumping to the wrong address or do
you think I'm building the kernel improperly or is there something else I'm
missing?

Thanks

Phill Treddenick

Quoting Philip.Lougher@Zarlink.Com:

>
> Hi,
>
> Philip Treddenick wrote:
>
> >Any help or insight is appreciated.
>
> I'd like to help, but you don't give enough information to do so...
>
> >but when I run the kernel it appears to hang.  I would like
> >to know if there is a way to verify what it's doing?  I've tried rlogin
> and I've
> >tried pinging it, but I don't get any response.  The kernel is setup to
> mount a
> >NFS, but I don't know how to verify that that is working either.  I tried
> >enabling the ethernet port by setting the board control and status
> registers.
> >That didn't seem to work.
>
> What does 'it appears to hang' mean?  Normally, when the kernel is entered
> from the boot loader, and starts to boot-up, you will see a lot of kernel
> booting messages on the serial port.  If you don't see these, then the
> kernel is not booting.  In this case, there isn't any point in trying to
> talk to the board via the ethernet, as it's not running anything.
>
> If you are seeing bootup messages, then what is the output?  Normally, when
> the kernel boots up it expects to mount the root  from hard disk or an
> initrd, and have the ethernet IP  address setup after mounting the root.
> However, if you're mounting the root via NFS (which is what is appears
> you're doing), then the IP address has to be set before mounting the root.
> To do this, the kernel has a configure option, that makes the kernel
> automatically obtain an IP address via DHCP or BOOTP.  Do you have that
> option set? (its in submenu Networking options, called IP: kernel level
> autoconfiguation).  If you do, then you should check that your DHCP/BOOTP
> server is getting a request, and is answering the board.  If you don't, the
> kernel is probably giving up trying to mount the root.  In both cases, the
> bootup messages will be pretty useful.
>
> Phillip
>
>
>
>
>
>
>
>                       Phillip.Treddenick@colorado.edu
>
>                       Sent by:                               To:
> linuxppc-embedded@lists.linuxppc.org
>                       owner-linuxppc-embedded@lists.l        cc:
>
>                       inuxppc.org                            Subject:  Hung
> kernel on EP405?
>
>
>
>
>                       16-Feb-2003 07:37 AM
>
>
>
>
>
>
>
>
>
>
> I am having trouble running Monta Vista Hardhat Linux 2.0 on an Embedded
Planet EP405 board rev 1.2
> with
> Solaris 2.7 as the host.  I'm using the Planetcore bootloader to download
> the
> kernel to the board, but when I run the kernel it appears to hang.  I would
> like
> to know if there is a way to verify what it's doing?  I've tried rlogin and
> I've
> tried pinging it, but I don't get any response.  The kernel is setup to
> mount a
> NFS, but I don't know how to verify that that is working either.  I tried
> enabling the ethernet port by setting the board control and status
> registers.
> That didn't seem to work.  Do these registers have specific settings
> necessary
> for running the EP405 board?
>
> Any help or insight is appreciated.
> Thanks, Phill Treddenick
>         treddeni@colorado.edu
>
>
>
>
>
>
>


treddeni@colorado.edu
303 818-7694
----- End forwarded message -----


Phill Treddenick
treddeni@colorado.edu
303 818-7694

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
