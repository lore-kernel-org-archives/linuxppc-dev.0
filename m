Return-Path: <mpe@ellerman.id.au>
Received: from ozlabs.org (bilbo.ozlabs.org [203.11.71.1])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 42Kx920cTvzF3KM
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 26 Sep 2018 21:51:02 +1000 (AEST)
From: Michael Ellerman <mpe@ellerman.id.au>
To: Christophe LEROY <christophe.leroy@c-s.fr>,
 Segher Boessenkool <segher@kernel.crashing.org>
Cc: Russell Currey <ruscur@russell.cc>,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Paul Mackerras <paulus@samba.org>,
 Andrew Donnellan <andrew.donnellan@au1.ibm.com>, linuxppc-dev@lists.ozlabs.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 2/2] powerpc/64: add stack protector support
In-Reply-To: <284752d1-6c32-bdca-72d3-4d8616b26fbf@c-s.fr>
References: <2b934594d21ade67a4092637cf9e6b7d2d131187.1537801613.git.christophe.leroy@c-s.fr>
 <e84d65fb4744cf8260eb2fc9474765a7f3a60573.1537801613.git.christophe.leroy@c-s.fr>
 <0797fc91-6400-2508-1cc0-4bba78aafbbb@c-s.fr>
 <d203ccfce64c8f9fd403162f2fa3807ade7f1d28.camel@russell.cc>
 <30fb4e6b-0981-c53c-a1db-94138eaad268@c-s.fr>
 <20180926092806.GM23155@gate.crashing.org>
 <284752d1-6c32-bdca-72d3-4d8616b26fbf@c-s.fr>
Date: Wed, 26 Sep 2018 21:50:59 +1000
Message-ID: <87o9ckfpek.fsf@concordia.ellerman.id.au>
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

Christophe LEROY <christophe.leroy@c-s.fr> writes:
> Le 26/09/2018 =C3=A0 11:28, Segher Boessenkool a =C3=A9crit=C2=A0:
>> On Wed, Sep 26, 2018 at 09:58:30AM +0200, Christophe LEROY wrote:
>>> Segher, any idea about this problem ?
>>=20
>>>>> arch/powerpc/platforms/powermac/bootx_init.o: In function `bootx_prin=
tf':
>>>>> /var/lib/jenkins-slave/workspace/snowpatch/snowpatch-linux-
>>>>> sparse/linux/arch/powerpc/platforms/powermac/bootx_init.c:88:
>>>>> undefined reference to `__stack_chk_fail_local'
>>=20
>> Are you building as PIC?  Are you linking libssp_nonshared.a?  Why not?
>
> Spotted, thanks.
>
> arch/powerpc/platforms/powermac/Makefile contains:
>
> CFLAGS_bootx_init.o  		+=3D -fPIC
...
>
> Or maybe stack protection on bootx_init doesn't make much sense and we=20
> could just do the following ?
>
> CFLAGS_bootx_init.o  		+=3D -fPIC $(call cc-option, -fno-stack-protector)

That would be fine by me.

cheers
