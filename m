Return-Path: <srinivas.surabhi@wipro.com>
Received: from wip-ectls-mx3.wipro.com (wip-ectls-mx3.wipro.com
	[203.101.113.41])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "wip-ectls-mx3.wipro.com",
	Issuer "certserv.wipro.com" (not verified))
	by ozlabs.org (Postfix) with ESMTP id 8FDB767A67
	for <linuxppc-embedded@ozlabs.org>;
	Fri, 18 Mar 2005 23:53:49 +1100 (EST)
Received: from wip-ectls-mx3.wipro.com (localhost.localdomain [127.0.0.1])
	by localhost (Postfix) with ESMTP id AD0982241A1
	for <linuxppc-embedded@ozlabs.org>;
	Fri, 18 Mar 2005 18:23:45 +0530 (IST)
Received: from blr-ec-bh2.wipro.com (blr-ec-bh2.wipro.com [10.200.50.92])
	by wip-ectls-mx3.wipro.com (Postfix) with ESMTP id A13BC224106
	for <linuxppc-embedded@ozlabs.org>;
	Fri, 18 Mar 2005 18:23:45 +0530 (IST)
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Date: Fri, 18 Mar 2005 18:28:21 +0530
Message-ID: <EF9B29C78F41FA488927FCBC7750AF0E011DA9A5@hyd-mdp-msg.wipro.com>
From: <srinivas.surabhi@wipro.com>
To: <linuxppc-embedded@ozlabs.org>
Subject: PCI problem
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>



Hi,

We are facing the problem with MVlinux3.1 having kernel 2.4.20 booting
once the PCI is enabled in config kernel.

First Question is it any where required in linux kernel sources to make
the PCI configuration changes...IF so please let me know in which file
??

Even the message "linux kernel banner " which is at the beginning of the
start_kernel function is not seen. Once the multi image( kernel + ram
disk File system) is extracted into RAM. After that it hangs


bootm 0xfef80000 ## Booting image at fef80000 ...
   Image Name:   MultiImage
   Image Type:   PowerPC Linux Multi-File Image (gzip compressed)
   Data Size:    4647626 Bytes =3D  4.4 MB
   Load Address: 00000000
   Entry Point:  00000000
   Contents:
   Image 0:   551181 Bytes =3D 538.3 kB
   Image 1:  4096430 Bytes =3D  3.9 MB
   Verifying Checksum ... OK
   Uncompressing Multi-File Image ... =3D0=3D
OK
Booting Linux
   Loading Ramdisk to 07417000, end 077ff1ae ... OK

...Then hangs ....

SO please help me out in finding out the relation of PCI and the
start_kernel. As per my knowledge once the kernel_init is entered then
the pci_init is invoked. But strangely I am seeing with pci enabled,
hang at the very beginning..

Thanks & Rgds
SS

-----Original Message-----
From: wd@denx.de [mailto:wd@denx.de]

Sent: Thursday, February 17, 2005 5:13 PM
To: Srinivas Surabhi (WT01 - EMBEDDED & PRODUCT ENGINEERING SOLUTIONS)
Cc: linuxppc-embedded@ozlabs.org
Subject: Re: Mounta Vista Linux prompt on serial console


In message
<EF9B29C78F41FA488927FCBC7750AF0E08DA14@hyd-mdp-msg.wipro.com> you
wrote:
>

> But the problem is that it was stopping at
>

> "No init found.  Try passing init=3D option to kernel". Before that
there
>  were no errors. Everthing looks fine Mounted VFS root file system was
also

Fine. So you can mount the root filesystem, but it obviously does not
contain all the required files.

>  seen. From the net I understood is that the fstab file was the cause.
So
>  edited the filesytem parameter for / as /dev/ram earlier it used to
be
>  /dev/root.

No. /etc/fstab has absolutley nothing to do with  your  problem.  The
kernel  cannot  start  the  init  porocess - make sure init is in the
filesystem, plus all required libraries.

> So please tell me whether the given fstab file will suffice? The
filesystem

This is completley unrelated.

> 2. I have one more doubt /sbin/init utility comes with what package?
>  Because in /sbin directory although the init binary is present, not
shown
>  in the file system heirarchy view. For eg. if I select DHCPD package
then
>  able to see dhcpd related binary in the /sbin similarly my question
was
>  which package has to be selected to have init included.

Please contact MV support. I have no  idea  how  they  package  their
distribution,  or  how  their  config  tools might work. You paid for
their stuff, so ask _them_.

Best regards,

Wolfgang Denk

--

See us @ Embedded World, Nuremberg, Feb 22 - 24,  Hall 10.0 Booth 310
Phone: (+49)-8142-66989-10 Fax: (+49)-8142-66989-80 Email: wd@denx.de
The most exciting phrase to hear in science, the one that heralds new
discoveries, is not "Eureka!" (I found it!) but "That's funny ..."
                                                      -- Isaac Asimov



Confidentiality Notice


The information contained in this electronic message and any attachments
to this message are intended
for the exclusive use of the addressee(s) and may contain confidential
or privileged information. If
you are not the intended recipient, please notify the sender at Wipro or
Mailadmin@wipro.com immediately
and destroy all copies of this message and any attachments.
_______________________________________________
Linuxppc-embedded mailing list
Linuxppc-embedded@ozlabs.org
https://ozlabs.org/mailman/listinfo/linuxppc-embedded



Confidentiality Notice=0D

The information contained in this electronic message and any attachments to=
 this message are intended
for the exclusive use of the addressee(s) and may contain confidential or=
 privileged information. If
you are not the intended recipient, please notify the sender at Wipro or=
 Mailadmin@wipro.com immediately
and destroy all copies of this message and any attachments.
