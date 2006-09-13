Return-Path: <arnd.bergmann@de.ibm.com>
From: Arnd Bergmann <arnd.bergmann@de.ibm.com>
To: cbe-oss-dev@ozlabs.org
Subject: Re: [Cbe-oss-dev] automount support
Date: Wed, 13 Sep 2006 19:35:17 +0200
References: <OF55BAD2B1.35B36763-ON852571E8.00524F80-852571E8.005288A4@us.ibm.com>
In-Reply-To: <OF55BAD2B1.35B36763-ON852571E8.00524F80-852571E8.005288A4@us.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-15"
Message-Id: <200609131935.17746.arnd.bergmann@de.ibm.com>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Wednesday 13 September 2006 17:01, William Chung wrote:
> I noticed that the stock cell kernel does not enable the autofs and=20
> autofs4 modules. =A0The stock Fedora Core 5 kernel does have these module=
s=20
> enabled. =A0What is the reason for disabling automount support? =A0Would =
there=20
> be any issues to changing arch/powerpc/configs/cell_defconfig to enable=20
> the autofs and autofs4 modules?

While there are no technical reasons against it, it increases build
time on my development system, and I generally try to avoid
adding modules that are not generally needed.

The other defconfig files are inconsistent in this regard:

arch/powerpc/configs/cell_defconfig:# CONFIG_AUTOFS_FS is not set
arch/powerpc/configs/cell_defconfig:# CONFIG_AUTOFS4_FS is not set
arch/powerpc/configs/chrp32_defconfig:# CONFIG_AUTOFS_FS is not set
arch/powerpc/configs/chrp32_defconfig:# CONFIG_AUTOFS4_FS is not set
arch/powerpc/configs/g5_defconfig:CONFIG_AUTOFS_FS=3Dm
arch/powerpc/configs/g5_defconfig:# CONFIG_AUTOFS4_FS is not set
arch/powerpc/configs/iseries_defconfig:CONFIG_AUTOFS_FS=3Dm
arch/powerpc/configs/iseries_defconfig:# CONFIG_AUTOFS4_FS is not set
arch/powerpc/configs/maple_defconfig:# CONFIG_AUTOFS_FS is not set
arch/powerpc/configs/maple_defconfig:# CONFIG_AUTOFS4_FS is not set
arch/powerpc/configs/pmac32_defconfig:# CONFIG_AUTOFS_FS is not set
arch/powerpc/configs/pmac32_defconfig:CONFIG_AUTOFS4_FS=3Dm
arch/powerpc/configs/ppc64_defconfig:CONFIG_AUTOFS_FS=3Dy
arch/powerpc/configs/ppc64_defconfig:# CONFIG_AUTOFS4_FS is not set
arch/powerpc/configs/pseries_defconfig:# CONFIG_AUTOFS_FS is not set
arch/powerpc/configs/pseries_defconfig:CONFIG_AUTOFS4_FS=3Dm

I guess having one of them is pretty common, but not both.
Which one do you prefer?

	Arnd <><
