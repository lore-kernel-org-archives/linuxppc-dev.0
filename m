Return-Path: <evilninja@gmx.net>
Received: from mail.gmx.net (mail.gmx.net [213.165.64.20])
	by ozlabs.org (Postfix) with SMTP id E5F192BF13
	for <linuxppc-dev@ozlabs.org>; Fri,  7 Jan 2005 03:00:36 +1100 (EST)
Message-ID: <41DD60A3.3020203@gmx.net>
Date: Thu, 06 Jan 2005 17:00:35 +0100
From: Christian <evilninja@gmx.net>
MIME-Version: 1.0
To: linuxppc-dev@ozlabs.org
References: <200412261435.13562.marc.dietrich@ap.physik.uni-giessen.de>
	<200501041504.57588.marvin24@gmx.de>
	<1104850036.6164.25.camel@weizen.left.earth>
	<200501051233.25622.marvin24@gmx.de>
	<20050105154753.GA26760@pegasos> <41DC1F7E.5030003@gmx.net>
	<20050105173908.GC29131@pegasos>
In-Reply-To: <20050105173908.GC29131@pegasos>
Content-Type: text/plain; charset=UTF-8
Subject: Re: [FYI] linux 2.6 still not working with PReP (ppc32)
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

Sven Luther schrieb:
> 
> It is the standard powerpc debian kernel. apt-get install
> kernel-image-2.6.8-powerpc, and you will find the config in
> /boot/config-2.6.8-powerpc. All the rest of the stuff can be found in the
[...]
> 
> Well, i am really interested to know if the above debian kernel boots for you
> or not. And to find the patches that fix it if it doesn't.

ok. but 2.6.8 +2.6.9 won't boot for me, as it does not include the
prep_pci.c fix, which was introduced in 2.6.10-rc3. i assume

http://people.debian.org/~luther/prep/d-i-2005.01.03-prep

is made from a current kernel, thus containing the fix (because it's
booting, upon "configure network" the network actually works too ;))

i've fetched kernel-source-2.6.9 now, applied the prep_pci fix and
compiled the kernel. i *had* to make changes to the debian-config
(config-2.6.9-powerpc) because i am still not able to boot via disk. so i
enabled CONFIG_ROOT_NFS and CONFIG_TULIP, details here:

http://www.nerdbynature.de/bits/hal/daily/boot/config-2.6.9-powerpc
http://www.nerdbynature.de/bits/hal/daily/boot/config-2.6.9-powerpc.my
http://www.nerdbynature.de/bits/hal/2.6.10-rc3/prep_pci_renumbered-2.6.10-rc3.patch

the kernel boots, network is set up, but since everything else is modular,
it cries about several things. i can ping the host and i really think this
all would work, except when i set CONFIG_SCSI_SYM53C8XX_2=y

http://www.nerdbynature.de/bits/hal/daily/boot/config-2.6.9-powerpc.my+scsi

then the ABORT and RESET errors show upon upon initialization of the
scsi-adapter (no disk attached). i don't have a fix for this scsi-issue at
hand. maybe i missed something...

hope this helps anyhow to get PReP ready for debian sometimes...
Christian.
- --
BOFH excuse #148:

Insert coin for new game
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.5 (GNU/Linux)
Comment: Using GnuPG with Thunderbird - http://enigmail.mozdev.org

iD8DBQFB3WCjC/PVm5+NVoYRAqH/AKDP1Dds54VDC7+F/rz/ykBpbsC6yQCg/3oC
ukrDN1HRvS+5kfgYtO2CJ4w=
=/h4o
-----END PGP SIGNATURE-----
