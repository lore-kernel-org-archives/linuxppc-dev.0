Return-Path: <glppe-linuxppc-embedded-2@m.gmane.org>
Received: from ciao.gmane.org (main.gmane.org [80.91.229.2])
	by ozlabs.org (Postfix) with ESMTP id 28273DE606
	for <linuxppc-embedded@ozlabs.org>;
	Fri,  6 Jun 2008 00:23:23 +1000 (EST)
Received: from list by ciao.gmane.org with local (Exim 4.43)
	id 1K4GN5-0004vb-Hz
	for linuxppc-embedded@ozlabs.org; Thu, 05 Jun 2008 14:23:19 +0000
Received: from p5497cc9a.dip.t-dialin.net ([84.151.204.154])
	by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
	id 1AlnuQ-0007hv-00
	for <linuxppc-embedded@ozlabs.org>; Thu, 05 Jun 2008 14:23:19 +0000
Received: from dzu by p5497cc9a.dip.t-dialin.net with local (Gmexim 0.1
	(Debian)) id 1AlnuQ-0007hv-00
	for <linuxppc-embedded@ozlabs.org>; Thu, 05 Jun 2008 14:23:19 +0000
To: linuxppc-embedded@ozlabs.org
From: Detlev Zundel <dzu@denx.de>
Subject: Re: No console output when booting linux from uboot
Date: Thu, 05 Jun 2008 16:22:04 +0200
Message-ID: <m2od6g6jxv.fsf@ohwell.denx.de>
References: <A9D89E0D76AFF24B9441851F2AC72D7203B7D468@BANMLVEM05.e2k.ad.ge.com>
	<m2hcc988n9.fsf@ohwell.denx.de>
	<A9D89E0D76AFF24B9441851F2AC72D7203BCB942@BANMLVEM05.e2k.ad.ge.com>
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

Hi Mike,

> Thanks. Now I am confusing with the way uboot passing parameters to
> linux kernel:
>
> in Uboot 1.2.0: Kernel is entered through the following calling
>         theKernel (linux_argc, linux_argv, linux_env, 0);
> while in Uboot 1.3.0:
>         (*kernel) (kbd, initrd_start, initrd_end, cmd_start, cmd_end);
>
> The linux kernel I used is designed with Uboot 1.2.0, while I used
> 1.3.2. Will this be a problem for passing the parameters?

Hm, now you got me confused.  I cannot see the first version anywhere in
u-boot or its history.  Even in 1.2.0 its either

(*kernel) (kbd, initrd_start, initrd_end, cmd_start, cmd_end);

or

(*kernel) ((bd_t *)of_flat_tree, (ulong)kernel, 0, 0, 0);

The first path is chosen when using the traditional 2 argument bootm
command, the logic being that this is a non-fdt aware kernel.  The
second path is chosen when using the newer three-argument version of
bootm with the third argument being the flat device tree (needs
CONFIG_OF_FLAT_TREE in U-Boot 1.2.0).

So if you have anything differing from this, you have to conclude for
yourself what the situation is.  When you have mainline U-Boot and Linux,
i.e. comparable what I describe, we especially took care that we are
backwards compatible.  So by using the two- or three parameter version,
we effectively select between two kernel call conventions.  The
situation stays the same in newer U-Boot versions.

Cheers
  Detlev 

--
DENX Software Engineering GmbH,      MD: Wolfgang Denk & Detlev Zundel
HRB 165235 Munich,  Office: Kirchenstr.5, D-82194 Groebenzell, Germany
Phone: (+49)-8142-66989-40 Fax: (+49)-8142-66989-80 Email: dzu@denx.de
