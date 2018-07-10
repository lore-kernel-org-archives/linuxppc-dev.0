Return-Path: <chzigotzky@xenosoft.de>
Received: from mo6-p00-ob.smtp.rzone.de (mo6-p00-ob.smtp.rzone.de
 [IPv6:2a01:238:20a:202:5300::11])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 41Prr15Hj9zDrTg
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 10 Jul 2018 15:49:37 +1000 (AEST)
Content-Type: text/plain;
	charset=utf-8
Mime-Version: 1.0 (1.0)
Subject: [PATCH NEXT 1/4] powerpc/pasemi: Add PCI initialisation for Nemo
 board.
From: Christian Zigotzky <chzigotzky@xenosoft.de>
In-Reply-To: <87k1skanxy.fsf@concordia.ellerman.id.au>
Date: Tue, 10 Jul 2018 07:43:23 +0200
Cc: Darren Stevens <darren@stevens-zone.net>,
 linuxppc-dev <linuxppc-dev@lists.ozlabs.org>
Message-Id: <F7494DDC-BDA9-460A-94EB-6FAF58D673FA@xenosoft.de>
References: <4b3d1ee02c7.3de0aa2c@auth.smtp.1and1.co.uk>
 <87k1skanxy.fsf@concordia.ellerman.id.au>
To: Michael Ellerman <mpe@ellerman.id.au>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Hi Michael,
Hi All,

kbuild test robot Wed, 03 Jan 2018 04:17:20 -0800 wrote:

Hi Darren,

Thank you for the patch! Perhaps something to improve:

arch/powerpc/platforms/pasemi/pci.c: In function 'sb600_set_flag': >> includ=
e/linux/kern_levels.h:5:18: warning: format '%lx' expects argument of >> typ=
e 'long unsigned int', but argument 2 has type 'resource_size_t {aka long >>=
 long unsigned int}' [-Wformat=3D] #define KERN_SOH "\001" /* ASCII Start Of=
 Header */

=E2=80=94-

I was able to fix this small format issue. I replaced the format '%08lx' wit=
h '%08llx'.

+ printk(KERN_CRIT "NEMO SB600 IOB base %08llx\n",res.start);

Is this fix OK or is there a better solution?

> On 3. May 2018, at 15:06, Michael Ellerman <mpe@ellerman.id.au> wrote:
>=20
>> +
>> +        printk(KERN_CRIT "NEMO SB600 IOB base %08lx\n",res.start);
>=20
> That's INFO or even DEBUG.
>>=20

Michael,

What do you think about this fix?

+ printk(KERN_INFO "NEMO SB600 IOB base %08llx\n",res.start);

Thanks,
Christian=
