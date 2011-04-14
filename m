Return-Path: <emrekara2002@yahoo.co.uk>
Received: from nm12.bullet.mail.ukl.yahoo.com (nm12.bullet.mail.ukl.yahoo.com
	[217.146.183.186]) by ozlabs.org (Postfix) with SMTP id C65FAB6EF1
	for <linuxppc-dev@lists.ozlabs.org>;
	Thu, 14 Apr 2011 17:06:56 +1000 (EST)
Message-ID: <204286.97927.qm@web25602.mail.ukl.yahoo.com>
Date: Thu, 14 Apr 2011 08:06:54 +0100 (BST)
From: emre kara <emrekara2002@yahoo.co.uk>
Subject: fsl elbc driver causes corruption with bus monitor timeouts while
	simultaneously access on Nor / Nand mtd partitions
To: Scott Wood <scottwood@freescale.com>, Roy Zang <tie-fei.zang@freescale.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Wood Scott-B07421 <B07421@freescale.com>, felix@embedded-sol.com,
	David Woodhouse <David.Woodhouse@intel.com>,
	linux-kernel@vger.kernel.org, bayraktarz@yahoo.com,
	Lan Chunhe-B25806 <b25806@freescale.com>, linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Hi Scott, Roy.
Scott's "mtd: eLBC NAND: increase bus timeout to maximum" patch is excluded=
 from kernel with Roy's "P4080/eLBC: Make Freescale elbc interrupt common t=
o elbc devices" patch. I don't know the reason for it but this causes bus m=
onitor timeouts and corrupts nand flash while using mainline kernel. As I k=
now there is an errata related to this topic, I think "increasing bus timeo=
ut to maximum" is a must.
You can easly generate this situation with below commands:

Note: mtd4 is a Nor and mtd9 is a Nand partition.
[root@P2020RDB root]# mount /dev/mtdblock9 /mnt/src/
mount: you must specify the filesystem type
[root@P2020RDB root]# mount /dev/mtdblock9 /mnt/src/ -t jffs2
=EF=BF=BD=EF=BF=BDJFFS2 notice: (1950) jffs2_build_xattr_subsystem: complet=
e building xattr subsystem, 0 of xdatum (0 unchecked, 0 orphan) and 0 of xr=
ef (0 dead, 0 orphan) found.
[root@P2020RDB root]# dd if=3D/dev/mtd4 of=3D/mnt/src/uboot bs=3D1
fsl-lbc ffe05000.localbus: Local bus monitor time-out: LTESR 0x80000000
fsl-lbc ffe05000.localbus: command failed: fir 412e0000 fcr 0 status 800000=
00 mdr c0
Read of newly-erased block at 0x00430000 failed: -74. Putting on bad_list
fsl-lbc ffe05000.localbus: Local bus monitor time-out: LTESR 0x80000000
fsl-lbc ffe05000.localbus: command failed: fir 426db000 fcr 6070d000 status=
 80000000 mdr ff
Erase at 0x0042c000 failed immediately: errno -5
fsl-lbc ffe05000.localbus: Local bus monitor time-out: LTESR 0x80000000
Cfsl-lbc ffe05000.localbus: command failed: fir 412e0000 fcr 0 status 80000=
000 mdr c0
Read of newly-erased block at 0x00433000 failed: -74. Putting on bad_list
JFFS2: marking eraseblock at 00433000

Regards.

Emre
