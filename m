Message-ID: <3B995CA4.4CEC51C5@acm.org>
Date: Fri, 07 Sep 2001 16:47:48 -0700
From: Ira Weiny <iweiny@acm.org>
MIME-Version: 1.0
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>,
	linuxppc-dev <linuxppc-dev@lists.linuxppc.org>
Subject: System map in XMON (was: Cardbus issues on TiBook)
References: <3B98F783.1266EC60@acm.org> <20010907170630.852@smtp.adsl.oleane.com>
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Benjamin Herrenschmidt wrote:
>
> >Also I used this line "sysmap=/boot/System.map-fw" to load the system
> >map but then I realized you said OpenFirmware path.  How do I calculate
> >the openfirmware path to the system map?  And would this be dynamic when
> >I recompile if I just put the file in the filesystem or would I have to
> >reload it with ybin?  Thanks again for all your help.
>
> Put the System.map net to the kernel, and copy/paste the kernel path ;)
>
> Ben/

I hate to be stupid but:

I tried this as well:

sysmap=/boot

My kernel is in /boot and the System.map was a softlink but I have tried
it not being a softlink:

/boot]# ls
System.map                first.b                vmlinux-fw
System.map-2.2.18-4hpmac  kernel.h               vmlinux-fw.2001-07-15
System.map-2.4.4-pre1-2   kernel.h-2.2.18        vmlinux-fw.2001-08-10
System.map-fw.2001-07-15  second.b               vmlinux-fw.2001-08-18
System.map-fw.2001-08-10  vmlinux                vmlinuz-2.2.18-4hpmac
System.map-fw.2001-08-18  vmlinux-2.2.18-4hpmac  yaboot
System.map.new            vmlinux-2.4.4-pre1-2
/boot]#

Are there permissions or something I have to change?  I have also tried
using the sysmap directive with the image= section like this:

image=/boot/vmlinux-fw
	sysmap=/boot
        label=linux-fw
        root=/dev/hda9
        append="video=aty128fb hdc=scsi"
        read-only

But that did not work.  Do I need a particular version of yaboot/ybin?
I have:
/etc]# /usr/local/sbin/ybin -V
ybin 1.0
...

I don't get it, sorry,
Ira Weiny
iweiny@acm.org

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
