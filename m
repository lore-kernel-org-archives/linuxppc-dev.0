Date: Wed, 26 Apr 2000 16:54:44 +0300 (EEST)
From: Kostas Gewrgiou <gewrgiou@imbc.gr>
To: daenzerm@student.ethz.ch
cc: "W. Taylor Holliday" <wtholliday@ucdavis.edu>,
        linuxppc-dev@lists.linuxppc.org
Subject: Re: XFree 4.0 dual monitor on AGP G4
In-Reply-To: <3906E062.EB20B459@relog.ch>
Message-ID: <Pine.LNX.4.21.0004261635150.27506-100000@idd-01.imbc.gr>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=ISO-8859-7
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On Wed, 26 Apr 2000, Michel Dänzer wrote:

>
> "W. Taylor Holliday" wrote:
>
> > I modified the config file you sent me to use the secondary monitor only
> > (since XFree wouldn't parse the dual monitor layout section),
>
> Dang, gotta look at the syntax for the Layout Section again :)
>

Thats what i use:

Section "ServerLayout"
        Identifier "Main Layout"
        Screen "Screen 1"
        Screen "Screen 2" LeftOf "Screen 1"
EndSection

 Unfortunately i don't think that it will work in this case,
the second r128 will never be able to pick the right device
(/dev/fb1 here) the BusID line is more or less ignored in the fbdev
case so the second driver will open /dev/fb0 which will result
in a kernel crash.

Here is the related code from the xfree source, note the FIXME
line there.....

The only solutions for now (beyond fixing the code) is to use
the unaccelerated fbdev driver for /dev/fb1, not using fbdev
in the r128 driver will also work but this will require a couple
of changes in the r128 driver (info about what changes are needed
were posted in this list a few months back)



/* try to find the framebuffer device for a given PCI device */
static int
fbdev_open_pci(pciVideoPtr pPci)
{
        struct  fb_fix_screeninfo fix;
        char    filename[16];
        int     fd,i,j;

        for (i = 0; i < 4; i++) {
                sprintf(filename,"/dev/fb%d",i);
                if (-1 == (fd = open(filename,O_RDWR,0))) {
                        continue;
                }
                if (-1 == ioctl(fd,FBIOGET_FSCREENINFO,(void*)&fix)) {
                        close(fd);
                        continue;
                }
                /* FIXME: better ask the fbdev driver for bus/device/func,
                          but there is no way to to this yet. */
                for (j = 0; j < FB2PCICOUNT; j++) {
                        if (pPci->vendor   == fb2pci_map[j].vendor &&
                            pPci->chipType == fb2pci_map[j].chip   &&
                            fix.accel      == fb2pci_map[j].id)
                                break;
                }
                if (j == FB2PCICOUNT) {
                        close(fd);
                        continue;
                }
                return fd;
        }
        return -1;
}


   Kostas Gewrgiou


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
