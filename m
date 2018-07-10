Return-Path: <mpe@ellerman.id.au>
Received: from ozlabs.org (bilbo.ozlabs.org [203.11.71.1])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 41Q3Vs0tnnzDr8D
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 10 Jul 2018 23:50:29 +1000 (AEST)
From: Michael Ellerman <mpe@ellerman.id.au>
To: Christian Zigotzky <chzigotzky@xenosoft.de>
Cc: Darren Stevens <darren@stevens-zone.net>,
 linuxppc-dev <linuxppc-dev@lists.ozlabs.org>
Subject: Re: [PATCH NEXT 1/4] powerpc/pasemi: Add PCI initialisation for Nemo
 board.
In-Reply-To: <F7494DDC-BDA9-460A-94EB-6FAF58D673FA@xenosoft.de>
References: <4b3d1ee02c7.3de0aa2c@auth.smtp.1and1.co.uk>
 <87k1skanxy.fsf@concordia.ellerman.id.au>
 <F7494DDC-BDA9-460A-94EB-6FAF58D673FA@xenosoft.de>
Date: Tue, 10 Jul 2018 23:50:28 +1000
Message-ID: <871scbb3ob.fsf@concordia.ellerman.id.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Christian Zigotzky <chzigotzky@xenosoft.de> writes:

> Hi Michael,
> Hi All,
>
> kbuild test robot Wed, 03 Jan 2018 04:17:20 -0800 wrote:
>
> Hi Darren,
>
> Thank you for the patch! Perhaps something to improve:
>
> arch/powerpc/platforms/pasemi/pci.c: In function 'sb600_set_flag': >> inc=
lude/linux/kern_levels.h:5:18: warning: format '%lx' expects argument of >>=
 type 'long unsigned int', but argument 2 has type 'resource_size_t {aka lo=
ng >> long unsigned int}' [-Wformat=3D] #define KERN_SOH "\001" /* ASCII St=
art Of Header */
>
> =E2=80=94-
>
> I was able to fix this small format issue. I replaced the format '%08lx' =
with '%08llx'.
>
> + printk(KERN_CRIT "NEMO SB600 IOB base %08llx\n",res.start);
>
> Is this fix OK or is there a better solution?
>
>> On 3. May 2018, at 15:06, Michael Ellerman <mpe@ellerman.id.au> wrote:
>>=20
>>> +
>>> +        printk(KERN_CRIT "NEMO SB600 IOB base %08lx\n",res.start);
>>=20
>> That's INFO or even DEBUG.
>>>=20
>
> Michael,
>
> What do you think about this fix?
>
> + printk(KERN_INFO "NEMO SB600 IOB base %08llx\n",res.start);

pr_info() would be nice.

But I replied with lots of other comments previously.

None of them were super critical, but it would be nice to get them fixed
before merging if possible.

cheers
