Return-Path: <laigui.qin@ge.com>
Received: from ext-cn0ut-8.online-age.net (Ext-cn0ut-8.online-age.net
	[63.210.253.238])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "ext-cn0ut.online-age.net",
	Issuer "Savvis Communications Root CA" (not verified))
	by ozlabs.org (Postfix) with ESMTPS id 2DA4FDE2CA
	for <linuxppc-embedded@ozlabs.org>;
	Fri,  6 Jun 2008 22:24:35 +1000 (EST)
Received: from int-cn0ut-2.online-age.net (int-cn0ut-2.online-age.net
	[3.159.252.71])
	by ext-cn0ut-8.online-age.net (8.13.6/8.13.6/20051114-SVVS-TLS-DNSBL)
	with ESMTP id m56BuPit016409
	for <linuxppc-embedded@ozlabs.org>; Fri, 6 Jun 2008 07:56:25 -0400
Received: from cinmlef06.e2k.ad.ge.com (int-cn0ut-2.online-age.net
	[3.159.252.71])
	by int-cn0ut-2.online-age.net (8.13.6/8.13.6/20050510-SVVS) with ESMTP
	id m56BuPWI027563
	for <linuxppc-embedded@ozlabs.org>; Fri, 6 Jun 2008 07:56:25 -0400
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Subject: RE: No console output when booting linux from uboot
Date: Fri, 6 Jun 2008 17:24:05 +0530
Message-ID: <A9D89E0D76AFF24B9441851F2AC72D7203C0DAAA@BANMLVEM05.e2k.ad.ge.com>
In-Reply-To: <m2od6g6jxv.fsf@ohwell.denx.de>
References: <A9D89E0D76AFF24B9441851F2AC72D7203B7D468@BANMLVEM05.e2k.ad.ge.com><m2hcc988n9.fsf@ohwell.denx.de><A9D89E0D76AFF24B9441851F2AC72D7203BCB942@BANMLVEM05.e2k.ad.ge.com>
	<m2od6g6jxv.fsf@ohwell.denx.de>
From: "Qin, Laigui (GE EntSol, Security)" <laigui.qin@ge.com>
To: "Detlev Zundel" <dzu@denx.de>
Cc: linuxppc-embedded@ozlabs.org
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

Sorry for the confusing. I just figured out my problem is not for the
Uboot version...

As you suggested, I debuged the hw action related to serial driver
today. I add the "console=3DttyS2" in my uboot bootargs and corrected =
some
part, but still no output yet. Is there other factors will affect the
console output, except the serial driver?

BestRegards,
Mike Qin

-----Original Message-----
From: linuxppc-embedded-bounces+laigui.qin=3Dge.com@ozlabs.org
[mailto:linuxppc-embedded-bounces+laigui.qin=3Dge.com@ozlabs.org] On
Behalf Of Detlev Zundel
Sent: Thursday, June 05, 2008 10:22 PM
To: linuxppc-embedded@ozlabs.org
Subject: Re: No console output when booting linux from uboot

Hi Mike,

> Thanks. Now I am confusing with the way uboot passing parameters to=20
> linux kernel:
>
> in Uboot 1.2.0: Kernel is entered through the following calling
>         theKernel (linux_argc, linux_argv, linux_env, 0); while in=20
> Uboot 1.3.0:
>         (*kernel) (kbd, initrd_start, initrd_end, cmd_start, cmd_end);
>
> The linux kernel I used is designed with Uboot 1.2.0, while I used=20
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
yourself what the situation is.  When you have mainline U-Boot and
Linux, i.e. comparable what I describe, we especially took care that we
are backwards compatible.  So by using the two- or three parameter
version, we effectively select between two kernel call conventions.  The
situation stays the same in newer U-Boot versions.

Cheers
  Detlev=20

--
DENX Software Engineering GmbH,      MD: Wolfgang Denk & Detlev Zundel
HRB 165235 Munich,  Office: Kirchenstr.5, D-82194 Groebenzell, Germany
Phone: (+49)-8142-66989-40 Fax: (+49)-8142-66989-80 Email: dzu@denx.de

_______________________________________________
Linuxppc-embedded mailing list
Linuxppc-embedded@ozlabs.org
https://ozlabs.org/mailman/listinfo/linuxppc-embedded
