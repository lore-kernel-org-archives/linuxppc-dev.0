Return-Path: <Fabien.Clement@thomson.net>
Received: from dmzraw5.extranet.tce.com (dmzraw5.extranet.tce.com
	[157.254.234.142]) by ozlabs.org (Postfix) with ESMTP id 0A066685ED
	for <linuxppc-embedded@ozlabs.org>;
	Wed, 19 Oct 2005 21:40:42 +1000 (EST)
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Date: Wed, 19 Oct 2005 13:17:54 +0200
Message-ID: <9C1918067C3BC14C9C351C206D8A843701F54A94@rennsmail03.eu.thmulti.com>
From: "Clement Fabien" <Fabien.Clement@thomson.net>
To: "somshekar chandrashekar kadam" <som_kadam1@rediffmail.com>,
	<linuxppc-embedded@ozlabs.org>
Subject: RE: ELDK 3.1.1 ramdisk
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

Make sure ROOT_DEV is initialized to the correct device, for instance :

In Sandpoint.c (arch\ppc\platforms):	=09

#ifdef	CONFIG_ROOT_NFS
	ROOT_DEV =3D to_kdev_t(0x00FF);	/* /dev/nfs pseudo device */
#endif

There is no default value for it, except if you pass it on command line

Fabien

________________________________________
From: linuxppc-embedded-bounces@ozlabs.org =
[mailto:linuxppc-embedded-bounces@ozlabs.org] On Behalf Of somshekar =
chandrashekar kadam
Sent: lundi 17 octobre 2005 09:52
To: linuxppc-embedded@ozlabs.org
Subject: ELDK 3.1.1 ramdisk

=A0=20
HI ,=20

=A0 I am using MPC862 with 64mb ram , with Denx 3.1.1 eldk=20
with linux-2.4.25 on my custom board.=20
on Uboot i use SMC2 as my serial console , when i load linux i use SCC4 =
as my serisl console , this is becuase i dont have any idea why my SMC2 =
is not working , it works fine on my linux-2.4.18 kernel ,=20
anyways thats not the problem ,

i am using ramdisk_image.gz provided by eldk , and i have configured =
kernel wit intial ramdisk support , i have attachec the config file =
below , and also the booting messages in another file . as i chnages the =
console from smc2 to scc4 from uboot to linux may be intial message is =
not clear ,=20
i always get kernel panic VFS unable to mount root fs , is there =
something else i need to do or i am missing very important configuartion =
, please throw some light=20

thanks in advance=20
Neelu=20
