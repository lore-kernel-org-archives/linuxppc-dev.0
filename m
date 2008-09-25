Return-Path: <mustafa.cayir@bte.mam.gov.tr>
Received: from itri.bte.mam.gov.tr (bte.mam.gov.tr [193.140.75.15])
	by ozlabs.org (Postfix) with SMTP id 99D4DDDEE4
	for <linuxppc-embedded@ozlabs.org>;
	Thu, 25 Sep 2008 23:41:01 +1000 (EST)
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-9"
Subject: =?iso-8859-9?Q?Linux_In=FDt_Hangs?=
Date: Thu, 25 Sep 2008 16:40:56 +0300
Message-ID: <7B9A8FF57DBB524190E98CABF6E56F07DD411D@itri.bte.mam.gov.tr>
From: =?iso-8859-9?Q?Mustafa_Cay=FDr?= <mustafa.cayir@bte.mam.gov.tr>
To: <linuxppc-embedded@ozlabs.org>
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

Hi,

my kernel hangs by initializing the system. My target is mpc7457-based. =
I use ELDK 3.1.1 and mount my root-fs over nfs.

Following is screen-shot:=09
....
NET: Registered protocol family 1
NET: Registered protocol family 17
egiga0: link down
IP-Config: Complete:
      device=3Degiga0, addr=3D10.18.6.129, mask=3D255.255.0.0, =
gw=3D255.255.255.255,
     host=3Dgomsis, domain=3D, nis-domain=3D(none),
     bootserver=3D10.18.6.232, rootserver=3D10.18.6.232, rootpath=3D
Looking up port of RPC 100003/2 on 10.18.6.232
egiga0: link up<5>, full duplex<5>, speed 100 Mbps<5>
Looking up port of RPC 100005/1 on 10.18.6.232
VFS: Mounted root (nfs filesystem).
Mounted devfs on /dev
Freeing unused kernel memory: 112k init

Hangs here !


I use ethereal to look at  the  network  traffic. Find out what the
last succesful lookup calls:=20

Network File System, LOOKUP Call DH:0x500ec3bb/ld-2.3.1.so
Network File System, LOOKUP Call DH:0x500ec3bb/ld.so.1
Network File System, LOOKUP Call DH:0x2c97820b/lib
Network File System, LOOKUP Call DH:0x500ec3bb/init
Network File System, LOOKUP Call DH:0x2c97820b/sbin
Network File System, LOOKUP Call DH:0x2c97820b/dev
5853	14.129760	10.18.6.135	10.18.6.232	MOUNT	V1 MNT Call =
/opt/eldk_7457/ppc_74xx

After printing the message "Freeing unused kernel memory: 112k init", it =
hangs Any ideas?

Thanks in advance

Mustafa
