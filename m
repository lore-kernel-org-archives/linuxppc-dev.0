Return-Path: <barulli@gemrad.com>
Received: from MTA072D.interbusiness.it (MTA072D.interbusiness.it
	[85.37.17.72]) by ozlabs.org (Postfix) with ESMTP id 93C86DE07F
	for <linuxppc-embedded@ozlabs.org>;
	Fri, 26 Jan 2007 20:51:08 +1100 (EST)
Received: from mailserver (localhost [127.0.0.1])
	by mailserver.gemrad.com (Postfix) with SMTP id 8EAAB10A077
	for <linuxppc-embedded@ozlabs.org>;
	Fri, 26 Jan 2007 10:44:02 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])by mailserver.gemrad.com
	(Postfix) with ESMTP id 74F2210A132for
	<linuxppc-embedded@ozlabs.org>; Fri, 26 Jan 2007 10:44:02 +0100 (CET)
Received: from mailserver.gemrad.com ([127.0.0.1])by localhost (mailserver
	[127.0.0.1]) (amavisd-new, port 10024) with ESMTPid 02633-02
	for <linuxppc-embedded@ozlabs.org>;
	Fri, 26 Jan 2007 10:44:02 +0100 (CET)
Received: from mailserver.gemrad.com (localhost [127.0.0.1])by
	mailserver.gemrad.com (Postfix) with ESMTP id E79F510A077for
	<linuxppc-embedded@ozlabs.org>; Fri, 26 Jan 2007 10:44:01 +0100 (CET)
Message-ID: <6386542.1169804641943.SLOX.WebMail.wwwrun@mailserver.gemrad.com>
From: vittorio barulli <barulli@gemrad.com>
To: linuxppc-embedded@ozlabs.org
Subject: MVME3100 and linux-2.6.10
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Fri, 26 Jan 2007 10:44:01 +0100 (CET)
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

I have a PowerPc Motorola, I install on it a kernel image (2.6.10) that
use a ramdisk as root filesystem.
The original version issued with kernel 2.6.10 is working even if I
recompile it.

Now I want to modify the original ramdisk to insert some file that I
need. If I insert in the ramdisk some little file the kernel continue
to start, but if i insert a great file (4 Mb) the kernel don't boot.
the result on video is:

loaded at:     01864400 0253356C
relocated to:  00400000 010CF16C
board data at: 010CD124 010CD16C
relocated to:  00405238 00405280
zimage at:     00405A05 005BA5C2
initrd at:     005BB000 010CC420
avail ram:     010D0000 AACC8A8B

Linux/PPC load: console=ttyS0,9600 root=/dev/ram0 ramdisk_size=64000
ramdisk_blocksize=1024
Uncompressing Linux...done.
Now booting the kernel

At this point the system is stopped.
The next line describe what I do to modify the ramdisk and to compile
the kernel.

Mounting ramdisk:

gunzip /usr/src/linux-2.6.10.rm02/arch/ppc/boot/images/ramdisk.image.gz
losetup /dev/loop0
/usr/src/linux-2.6.10.rm02/arch/ppc/boot/images/ramdisk.image
mount  /dev/loop0 /opt/commcpu/CommEnvironment/ -o loop -t ext2

Unmounting ramdisk:
umount /opt/commcpu/CommEnvironment/
losetup -d /dev/loop0
fsck /usr/src/linux-2.6.10.rm02/arch/ppc/boot/images/ramdisk.image
gzip -9 /usr/src/linux-2.6.10.rm02/arch/ppc/boot/images/ramdisk.image

Compiling kernel:

cd /usr/src/linux-2.6.10.rm02/
export ARCH=ppc
export CROSS_COMPILE=ppc-
make zImage.initrd 




--------------------------------------------------------------------------------
INFORMATIVA SULLA PRIVACY
Le informazioni contenute nella presente comunicazione e i relativi allegati
possono essere riservate e sono, comunque, destinate esclusivamente alle persone
o alla Società sopraindicate.
La diffusione, distribuzione e/o copiatura del documento trasmesso da parte di 
qualsiasi soggetto diverso dal destinatario è proibita, sia ai sensi 
dell.art. 616 c.p. , che ai sensi del D.Lgs. n. 196/2003. 
Se avete ricevuto questo messaggio per errore, vi preghiamo di distruggerlo e di
informarci immediatamente per telefono allo 0735/59051 o inviando un messaggio 
all'indirizzo e-mail privacy@gemrad.com (all' attenzione ing. Giovanni Lazzeri).


The information in this e-mail (which includes any files transmitted with it) 
is confidential and may also be legally privileged. 
It is intended for the addressee only. Access to this e-mail by anyone else is 
unauthorised.It is not to be relied upon by any person other than the addressee, 
except with our prior written approval. If no such approval is given, we will 
not accept any liability (in negligence or otherwise) arising from any third 
party acting, or refraining from acting on such information. 
Unauthorised recipients are required to maintain confidentiality. 
If you have received this e-mail in error please notify us immediately 
(privacy@gemrad.com),destroy any copies and delete it from your computer system. 
Any use, dissemination, forwarding, printing or copying of this e-mail is 
prohibited. 
Copyright in this e-mail and any document created by us will be and remain 
vested in us and will not be transferred to you. 
We assert the right to be identified as the author of and to object to any 
misuses  of the contents of  this e-mail or such documents.
