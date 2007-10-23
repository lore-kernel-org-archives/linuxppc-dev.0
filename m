Return-Path: <BillF@optiscan.com>
Received: from mail.optiscan.com (mail.optiscan.com [203.26.112.1])
	by ozlabs.org (Postfix) with ESMTP id 7C917DDED9
	for <linuxppc-embedded@ozlabs.org>;
	Wed, 24 Oct 2007 10:15:27 +1000 (EST)
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Subject: RE: Root file system for powerpc 74xx board
Date: Wed, 24 Oct 2007 09:58:25 +1000
Message-ID: <34E73CC1202BF246B7DE3463BEBC068998F028@postie.optiscan.com>
In-Reply-To: <4ac2955e0710230755m318a9fdeq9b8074a819b8797c@mail.gmail.com>
References: <4ac2955e0710230755m318a9fdeq9b8074a819b8797c@mail.gmail.com>
From: "Bill Farrow" <BillF@optiscan.com>
To: <linuxppc-embedded@ozlabs.org>
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

> I have=A0 Linux running on an intel x86 machine with cross
> development environment. I want to host 74xx file system
> with Xfree86 and library support=A0 on the intel machine.=20
>
> I will boot the file system using NFS to the 74xx system.
>
> How to create/extract the file system with xfree86 support from fedora =
file system=A0 ?

I'm not sure if Fedora Linux has a Live CD that you can download for PPC =
machines.  We used an Ubuntu (Live) CD for our setup.  In our case the =
CD is bootable and contains a file called filesyste.squashfs that is a =
full desktop root filesystem with Xorg, all compiled for PPC.  You wont =
be able to unpack the squashfs file on your x86 Host because of the byte =
ordering, so you need to use your PPC target to do the work.

Mount the CDROM iso image on your x86 Host and then export this via NFS =
to your PPC target
  Host# sudo mount -o loop -t iso9660 ubuntu-6.10-desktop-powerpc.iso =
/mnt/
  Host# sudo mkdir /opt/ubuntu
  Host# sudo vi /etc/exports
    /mnt 192.168.0.0/255.255.255.0(rw,no_root_squash,sync)
    /opt/ubuntu 192.168.0.0/255.255.255.0(rw,no_root_squash,sync)

Use the Target to mount via nfs the Hosts /mnt/ directory that you =
exported, then mount via loopback the filesystem.squashfs and copy the =
contents back to the Host's nfs exported /mnt/ directory.

  Target# mount host_ip_address:/mnt/ /mnt/host
  Target# mount /mnt/host/casper/filesystem.squashfs /mnt/squashfs
  Target# mount host_ip_address:/ubuntu/ /mnt/ubuntu
  Target# cp -a /mnt/squashfs /mnt/ubuntu

I'm writing this from memory, so the above commands may be incorrect but =
the general idea and flow should be OK.

Bill
