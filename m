Message-Id: <4.3.2.20010906081809.00c566c0@falcon.si.com>
Date: Thu, 06 Sep 2001 08:31:08 -0400
To: linuxppc-embedded@lists.linuxppc.org
From: Jerry Van Baren <vanbaren_gerald@si.com>
Subject: Re: FLASH RamDisk and kernel init options for disk
In-Reply-To: <200109060842.BAA12475@krakatoa.gigabitnetworks.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"; format=flowed
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


At 01:42 AM 9/6/01 -0700, James F Dougherty wrote:

>Hi,

[snip]

>Also, is there some way to pass a kernel argument which
>does an fsck on a disk before it mounts it every time?
>I'm pretty sure this doesn't exist ..

That is already part of /etc/fstab.  Set fs_passno to a non-zero value.

(copied from man fstab)
        The  sixth field, (fs_passno), is used by the fsck(8) pro­
        gram to determine the order in which filesystem checks are
        done at reboot time.  The root filesystem should be speci­
        fied with a fs_passno of 1, and other  filesystems  should
        have a fs_passno of 2.  Filesystems within a drive will be
        checked sequentially, but filesystems on different  drives
        will  be  checked  at the same time to utilize parallelism
        available in the hardware.  If the sixth field is not pre­
        sent  or  zero,  a value of zero is returned and fsck will
        assume that the filesystem does not need to be checked.

I assume that is not what you wanted.  You want to force fsck to check
file systems that were properly unmounted on shutdown.

(copied from man shutdown)
        The -F flag means `force  fsck'.   This  only  creates  an
        advisory file /forcefsck which can be tested by the system
        when it comes up again.  The boot rc file can test if this
        file  is present, and decide to run fsck(1) with a special
        `force' flag so that even properly  unmounted  filesystems
        get  checked.   After that, the boot process should remove
        /forcefsck.

This would imply that if you do "touch /forcefsck" on shutdown, your
system would do what you want.

(copied from man fsck)
        fsck-options
               Any options which are not understood  by  fsck,  or
               which follow the -- option are treated as file sys­
               tem-specific options to be passed to the file  sys­
               tem-specific checker.

(copied from man e2fsck)
        -f     Force checking even if the file system seems clean.

(copied from /etc/rc.sysinit in a RedHat system, YMMV)

if [ -f /fsckoptions ]; then
         fsckoptions=`cat /fsckoptions`
     else
         fsckoptions=
fi

if [ -f /forcefsck ]; then
         fsckoptions="-f $fsckoptions"
fi

if [ "$BOOTUP" != "serial" ]; then
         fsckoptions="-C $fsckoptions"
else
         fsckoptions="-V $fsckoptions"
fi

OK, we're on a roll now.  You can create /fsckoptions to specify "-f"
(and possibly other parameters) to do what you want.  Otherwise create
/forcefsck (this should work on most if not all distributions) to force
the fsck.

gvb

******************** Lawyer gibberish: ********************
This e-mail and any files transmitted with it are confidential is the
property of Smiths Aerospace. This footnote also confirms that this
e-mail message has been scanned for the presence of known computer viruses.


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
