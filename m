Return-Path: <glppe-linuxppc-embedded-2@m.gmane.org>
Received: from ciao.gmane.org (main.gmane.org [80.91.229.2])
	by ozlabs.org (Postfix) with ESMTP id CAA9BDE391
	for <linuxppc-embedded@ozlabs.org>;
	Thu,  5 Jun 2008 02:44:03 +1000 (EST)
Received: from list by ciao.gmane.org with local (Exim 4.43)
	id 1K3w5d-0001jp-GK
	for linuxppc-embedded@ozlabs.org; Wed, 04 Jun 2008 16:43:57 +0000
Received: from p5497cf09.dip.t-dialin.net ([84.151.207.9])
	by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
	id 1AlnuQ-0007hv-00
	for <linuxppc-embedded@ozlabs.org>; Wed, 04 Jun 2008 16:43:57 +0000
Received: from dzu by p5497cf09.dip.t-dialin.net with local (Gmexim 0.1
	(Debian)) id 1AlnuQ-0007hv-00
	for <linuxppc-embedded@ozlabs.org>; Wed, 04 Jun 2008 16:43:57 +0000
To: linuxppc-embedded@ozlabs.org
From: Detlev Zundel <dzu@denx.de>
Subject: Re: Is the linux-2.6.25.4 compatible with freescale lite5200b?
Date: Wed, 04 Jun 2008 18:42:45 +0200
Message-ID: <m2d4mx883e.fsf@ohwell.denx.de>
References: <70cc19fe0806031955v4478b886k94150ca9c9295a49@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: news <news@ger.gmane.org>
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

Hi Henry,

> I want to use Linux as the OS of freescale lite5200b develop board. Then I have
> tried two version of kernel, 2.6.25.4 and 2.4.25.
> We succeed in 2.4.25, failed in 2.6.25.4. We use the default config file for
> the board, lite5200_defconfig, which would be found both in /arch/ppc/configs/.

That's the problem.  The 5200 was never completely supported in
ARCH=ppc.  You will need to switch to ARCH=powerpc (including all that
new exciting flat device tree infrastructure) where the board should
work.

In short (using bootwrapper only for demonstration purposes, in the long
run you want to use fdt aware infrastructure):

export ARCH=powerpc
make mpc5200_defconfig
make zImage
ls -l arch/powerpc/boot/cuImage.lite5200b
-rw-rw-r-- 1 dzu dzu 1587892 Jun  4 18:40 arch/powerpc/boot/cuImage.lite5200b

Note that lite5200b does not have its own config any more but uses a
common config + an individual device tree
(arch/powerpc/boot/dts/lite5200b.dts). The zImage target above does all
the magic...

Cheers
  Detlev

--
DENX Software Engineering GmbH,      MD: Wolfgang Denk & Detlev Zundel
HRB 165235 Munich,  Office: Kirchenstr.5, D-82194 Groebenzell, Germany
Phone: (+49)-8142-66989-40 Fax: (+49)-8142-66989-80 Email: dzu@denx.de
