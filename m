Message-ID: <39E7709B.D9A6AAA9@mvista.com>
Date: Fri, 13 Oct 2000 13:29:15 -0700
From: "Mark A. Greer" <mgreer@mvista.com>
Reply-To: mgreer@mvista.com
MIME-Version: 1.0
To: Zhaobin Zhu <zzhu@emc.com>
CC: linuxppc-embedded@lists.linuxppc.org
Subject: Re: <kernel-image-name>
References: <007201c0339d$5b235c60$0a00010a@airvent.it> <39E766CF.74B9C039@emc.com>
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Zhaobin Zhu wrote:

> Hi,
>
> I am setting up host (Redhat 6.2 i386) for sp7400 boot over NFS.
>
> I do this following instructions on manual for Hardhat CDK 1.2
>
> When configuring TFTP, to create a symbolic link to boot file
> in /tftpboot,
>
> ln -s /opt/hardhat/devkit/ppc/82xx/target/boot/<kernel-image-name>
> <kernel-image-name>
>
> What should I give to <kernel-image-name> ?
>
> When I do "make zImage", I got two binaries, vmlinux and zvmlinux. I also
> create a S-record file.
> Which of the 3 files do I use as <kernel-image-name> ?
>
> BTW, what is the role of tftp in kernel boot on NFS ?
> I don't see any tftp message when kernel is booting ?

I may have misunderstood your email but if I did understand the email
correctly, you have some incorrect expectations of "booting over NFS".

You can do a "network boot" and then "NFS mount" the root filesystem but DINK
doesn't support net boot on the sandpoint so you can NOT actually BOOT over
the network.  Just as bad, DINK doesn't support booting from a disk either so
you can't actually boot from an IDE drive (even though an IDE ctlr is embedded
on that board).  You _can_ put a root filesystem on an IDE drive and use that
for your root filesystem but you have the same issue of getting the kernel
into memory in the first place.

 You must get the kernel into memory some other way.  That's were DINK's
download over serial, a JTAG probe, or putting the kernel into flash comes
in.  You don't actually get the kernel itself over NFS (chicken & egg--you
need a kernel to NFS mount so you can't use NFS to get the kernel).

When people (such as myself) say "booting over NFS" we usually mean simply
mounting the root filesystem over NFS.  You need firmware support to get the
kernel from over the network (net boot) which DINK doesn't have.

I recommend building a kernel you're happy with (the one in
arch/ppc/boot/zvmlinux), stripping off the first 64KB, and putting it into
flash (do NOT overwrite DINK).  When you power on the system, let DINK run,
then run the zvmlinux at the address you burned it into flash.  You can have
DINK automatically jump to an address with the "env" cmd, I believe.  Someone
else will have to help you with the DINK cmds to get your kernel into flash.

I think my response to a previous email may have caused this confusion.  If
so, I apologize.  I meant to say, I "NFS mount the root filesystem" all the
time but I download the actual kernel into memory using my JTAG probe.

Mark


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
