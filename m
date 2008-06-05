Return-Path: <laigui.qin@ge.com>
Received: from ext-nj2ut-2.online-age.net (ext-nj2ut-2.online-age.net
	[64.14.54.231])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "ext-nj2ut.online-age.net",
	Issuer "Savvis Communications Root CA" (not verified))
	by ozlabs.org (Postfix) with ESMTPS id 80746DDE21
	for <linuxppc-embedded@ozlabs.org>;
	Thu,  5 Jun 2008 11:57:42 +1000 (EST)
Received: from int-nj2ut-6.online-age.net (int-nj2ut-6.online-age.net
	[3.159.237.75])
	by ext-nj2ut-2.online-age.net (8.13.6/8.13.6/20051114-SVVS-TLS-DNSBL)
	with ESMTP id m551vaHv026026
	for <linuxppc-embedded@ozlabs.org>; Wed, 4 Jun 2008 21:57:36 -0400
Received: from cinmlef11.e2k.ad.ge.com (int-nj2ut-6.online-age.net
	[3.159.237.75])
	by int-nj2ut-6.online-age.net (8.13.6/8.13.6/20050510-SVVS) with ESMTP
	id m551vZBo003715
	for <linuxppc-embedded@ozlabs.org>; Wed, 4 Jun 2008 21:57:36 -0400
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Subject: RE: No console output when booting linux from uboot
Date: Thu, 5 Jun 2008 07:25:20 +0530
Message-ID: <A9D89E0D76AFF24B9441851F2AC72D7203BCB942@BANMLVEM05.e2k.ad.ge.com>
In-Reply-To: <m2hcc988n9.fsf@ohwell.denx.de>
References: <A9D89E0D76AFF24B9441851F2AC72D7203B7D468@BANMLVEM05.e2k.ad.ge.com>
	<m2hcc988n9.fsf@ohwell.denx.de>
From: "Qin, Laigui (GE EntSol, Security)" <laigui.qin@ge.com>
To: "Detlev Zundel" <dzu@denx.de>, <linuxppc-embedded@ozlabs.org>
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

Thanks. Now I am confusing with the way uboot passing parameters to
linux kernel:

in Uboot 1.2.0: Kernel is entered through the following calling
        theKernel (linux_argc, linux_argv, linux_env, 0);
while in Uboot 1.3.0:
        (*kernel) (kbd, initrd_start, initrd_end, cmd_start, cmd_end);

The linux kernel I used is designed with Uboot 1.2.0, while I used
1.3.2. Will this be a problem for passing the parameters?


Mike Qin


-----Original Message-----
From: linuxppc-embedded-bounces+laigui.qin=3Dge.com@ozlabs.org
[mailto:linuxppc-embedded-bounces+laigui.qin=3Dge.com@ozlabs.org] On
Behalf Of Detlev Zundel
Sent: Thursday, June 05, 2008 12:31 AM
To: linuxppc-embedded@ozlabs.org
Subject: Re: No console output when booting linux from uboot

Hi Mike,

> I am trying to boot linux kernel (2.6.23) from uboot (1.3.2) for my=20
> custom board. The uboot works well, the kernel booting hit the=20
> start_kernel(). But there is nothing output from console.

Do you provide a correct "console=3D..." parameter?

> With debugger, I saw that the printk() functions were called many=20
> times without any console output. Tracing into the source code, I=20
> found that the printk() called "con->write" operation...
>
> Can anyone guide me to solve this?

I have a hint concerning an incorrect conjecture from your side.
Usually when start_kernel starts, the kernel knows nothing about
consoles to output printk messages to, so in the early phases the
printk's (like printk(KERN_NOTICE)) only end up in the internal ring
buffer.  Its only later when the console is associated with a real
device that everything gets sent there.

So you shouldn't really wonder why early printk's do not output
anything, this is a red herring.  Debug the code responsible for the hw
acting as your console according to the kernel command line.

Cheers
  Detlev

--=20
DENX Software Engineering GmbH,      MD: Wolfgang Denk & Detlev Zundel
HRB 165235 Munich,  Office: Kirchenstr.5, D-82194 Groebenzell, Germany
Phone: (+49)-8142-66989-40 Fax: (+49)-8142-66989-80 Email: dzu@denx.de

_______________________________________________
Linuxppc-embedded mailing list
Linuxppc-embedded@ozlabs.org
https://ozlabs.org/mailman/listinfo/linuxppc-embedded
