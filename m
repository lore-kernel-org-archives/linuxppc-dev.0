Subject: Re: File system boot strategy
From: Gary Thomas <gary@mlbassoc.com>
To: =?ISO-8859-1?Q?G=E9rard_Gu=E9vel?= <gguevel@interfaceconcept.com>
Cc: linuxppc embedded <linuxppc-embedded@lists.linuxppc.org>
In-Reply-To: <000101c3aaae$e61e4240$5201a8c0@GEG2400>
References: <000101c3aaae$e61e4240$5201a8c0@GEG2400>
Content-Type: text/plain; charset=ISO-8859-1
Message-Id: <1068817206.29984.5.camel@hermes>
Mime-Version: 1.0
Date: 14 Nov 2003 06:40:06 -0700
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


On Fri, 2003-11-14 at 05:57, Gérard Guével wrote:
> Hi,
>
> I have a custom 8260 board with a 2.4.18 Kernel.
>
> I want to mount multiple file systems from a CFI compliant flash.
> The directories are distributed  like this :
>
> 	/   /bin /home /lib /root /sbin /usr		-> cramfs  to have a protected Linux
> kernel
> 	/etc /tftpboot				-> jffs2      to allow modifying services and files to
> load
> 	/dev /proc /tmp /var			-> ramfs    to store data which can be lost.
>
> I want to boot with the cramfs as root file system but the UNTAR wants all
> the directories /dev /proc /tmp in the cramfs.
>
> Can I use multiple file systems like this ?
> Must I start with a ramfs and then mount cramfs ?
>
> I find many docs to mount each file system individually and to add others
> file systems mounted on /mnt
> but no example to break a standard filesystem into multiple sub file
> systems.

There is nothing special about /mnt - it's just a directory (or set of
directories like /mnt/floppy, /mnt/cdrom, etc). Also, the main names
(like /etc) could be symbolic links.  Here's how I might solve this:

==  cramfs  contents

    /bin
    /home
    /lib
    /root
    /sbin
    /usr
    /JFFS2          (just a mount point)
    /etc => /JFFS2/etc
    /tftpboot => /JFFS2/tmp
    /RAMDISK        (another mount point)
    /tmp => /RAMDISK/tmp
    /var => /RAMDISK/var

/dev and /proc are special.  If you enable "devfs" and "procfs" in the
kernel they get populated automatically, all you need do is mount them.

--
Gary Thomas <gary@mlbassoc.com>
MLB Associates


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
