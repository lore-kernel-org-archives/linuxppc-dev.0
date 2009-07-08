Return-Path: <mzaturenskiy.st@gmail.com>
Received: from mail-qy0-f171.google.com (mail-qy0-f171.google.com
	[209.85.221.171])
	by bilbo.ozlabs.org (Postfix) with ESMTP id 6EAD1B7089
	for <linuxppc-dev@lists.ozlabs.org>;
	Thu,  9 Jul 2009 08:56:23 +1000 (EST)
Received: by qyk1 with SMTP id 1so6272587qyk.26
	for <linuxppc-dev@lists.ozlabs.org>;
	Wed, 08 Jul 2009 15:56:21 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <97dd5fd20907081225g2dc4a8dep74407ece12223162@mail.gmail.com>
References: <97dd5fd20907081225g2dc4a8dep74407ece12223162@mail.gmail.com>
From: Mikhail Zaturenskiy <mzaturenskiy.st@gmail.com>
Date: Wed, 8 Jul 2009 17:56:01 -0500
Message-ID: <97dd5fd20907081556t8626132sf32c8a6c00c4264c@mail.gmail.com>
Subject: Re: switching from initrd to initramfs
To: linuxppc-dev@lists.ozlabs.org
Content-Type: text/plain; charset=ISO-8859-1
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

> I was hoping to convert this working initrd to initramfs before I try
> and create my own initrd, I'm still learning about this process. I got
> this to work yesterday morning, but I'm not sure what changed or what
> I'm doing differently...
> Can somebody help me figure out what's missing?

Never mind, got it! :)  For reference, here is what I did:
First I made a custom init file called "init_mz" with  the following contents:
#!/bin/sh
echo "hello! processing init_mz"

#Create all the symlinks to /bin/busybox
echo "installing busybox links..."
busybox --install -s
echo "done installing busybox links..."

#Mount things needed by this script
echo "mounting proc..."
mount -t proc proc /proc
echo "done mounting proc..."
echo "mounting sysfs..."
mount -t sysfs sysfs /sys
echo "done mounting sysfs..."

#Create device nodes
echo "creating /dev nodes..."
mknod /dev/null c 1 3
mknod /dev/tty c 5 0
mdev -s
echo "done creating /dev nodes..."

echo "exec-ing sh..."
exec /bin/sh

At this point booting with the "rdinit=/init_mz" kernel argument worked.

Then I removed pretty much everything unnecessary from my root tree,
cross-compiled a busybox v1.14.2 with defconfg (except
statically-linked), and created the few necessary links, so my tree
looks like this:

************
|-- bin
|   |-- busybox
|   |-- echo -> busybox
|   |-- mount -> busybox
|   `-- sh -> busybox
|-- dev
|-- init_mz
|-- proc
|-- sbin
|-- sys
`-- usr
    |-- bin
    `-- sbin
**************
I could probably also get rid of /dev /proc /sbin /sys /usr* /bin/echo
and /bin/mount and just create those on the fly in the init_mz file.

I'm building the initramfs ramdisk using:
find | cpio -ovc | gzip -v9 > ../initramfs.cpio.gz
mkimage -T ramdisk -C gzip -n 'Test Ramdisk Image' -d
../initramfs.cpio.gz ../uCpio

For my kernel arguments I'm using "console=ttyCPM0,9600n8
root=/dev/ram rw rdinit=/init_mz" and that is all! I now have a
functional initramfs that's 0.97MB large.

For a while I was confused because "ls" output had file names with
strange symbols such as "1;34mbin0m" for "bin", but I figured out that
it's because supposedly those represent font colors and I'm using
HyperTerminal which doesn't support them.

I hope somebody will find this useful.

Mikhail Zaturenskiy
