Return-Path: <Lijun.Pan@freescale.com>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id D1EAA1A0571
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 10 Apr 2015 07:52:30 +1000 (AEST)
Received: from na01-bl2-obe.outbound.protection.outlook.com
 (mail-bl2on0138.outbound.protection.outlook.com [65.55.169.138])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id 35D0D14011D
 for <linuxppc-dev@ozlabs.org>; Fri, 10 Apr 2015 07:52:28 +1000 (AEST)
From: Lijun Pan <Lijun.Pan@freescale.com>
To: "linuxppc-dev@ozlabs.org" <linuxppc-dev@ozlabs.org>
Subject: new way of writing defconfigs for freescale's powerpc platforms
Date: Thu, 9 Apr 2015 21:52:23 +0000
Message-ID: <DM2PR03MB3689ECA6BC27B156BD10F76FCFB0@DM2PR03MB368.namprd03.prod.outlook.com>
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Cc: Scott Wood <scottwood@freescale.com>,
 Richard Schmitt <richard.schmitt@freescale.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Hi Maintainers,

We have a proposal for writing the defconfigs for freescale's powperpc plat=
forms in a new way.
Can you take a look and provide some feedback?

You know currently we have mpc85xx_defconfig, corenet32_defconfig, bsc913x_=
defconfig, *fman*_defconfig, etc.
We are going to extract some common parts from the existing defconfigs, and=
 name it, say, fsl_basic_defconfig.
Then, we could create some defconfigs targeting specific features or specif=
ic platforms.
Say, features specific: kvm_defconfig, fman_defconfig, etc.
Platforms specific: p1_defconfig, p2_defcongfig, p4_defconfig, t1_defconfig=
, t2_defconfig, t2_defconfig, b4_defconfig, etc
When we want to make a kernel image for p1 platform,
Using the following steps:

make ./scripts/kconfig/merge_config.sh arch/powerpc/configs/fsl_basic_confi=
g p1_defconfig
make

What do you think of this new approach?
Will you accept this approach?

Here is a brief quote of the reasons why we take this approach.
"we've had complaints in the past that some feature X  is available on one =
platform but not another.=20
Why.  And our answer has been, it's arbitrary.=20
Some platform config files define it, and some platform config files don't.=
 =20
That's because when someone adds a feature, they don't update all relevant =
defconfigs.

Sometimes config files that should be very similar, are in fact very differ=
ent.=20
take for example corenet32_smp_defconfig and corenet64_smp_defconfig. =20
There are differences in mtd settings, and others when the only difference =
should be very close to just PPC64.

So the hope was to create some kind of layered architecture. =20
Have a basic defconfig, then maybe have a fragment for 64 bit,=20
then fragments for particular platform differences, then a fragment for KVM=
,=20
and a fragment for ASF and so on."

Thanks
Lijun
