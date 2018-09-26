Return-Path: <christophe.leroy@c-s.fr>
Received: from pegase1.c-s.fr (pegase1.c-s.fr [93.17.236.30])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 42KxDN01l2zF12D
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 26 Sep 2018 21:53:56 +1000 (AEST)
Subject: Re: [PATCH v3 2/2] powerpc/64: add stack protector support
To: Michael Ellerman <mpe@ellerman.id.au>,
 Segher Boessenkool <segher@kernel.crashing.org>
Cc: Russell Currey <ruscur@russell.cc>,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Paul Mackerras <paulus@samba.org>,
 Andrew Donnellan <andrew.donnellan@au1.ibm.com>,
 linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
References: <2b934594d21ade67a4092637cf9e6b7d2d131187.1537801613.git.christophe.leroy@c-s.fr>
 <e84d65fb4744cf8260eb2fc9474765a7f3a60573.1537801613.git.christophe.leroy@c-s.fr>
 <0797fc91-6400-2508-1cc0-4bba78aafbbb@c-s.fr>
 <d203ccfce64c8f9fd403162f2fa3807ade7f1d28.camel@russell.cc>
 <30fb4e6b-0981-c53c-a1db-94138eaad268@c-s.fr>
 <20180926092806.GM23155@gate.crashing.org>
 <284752d1-6c32-bdca-72d3-4d8616b26fbf@c-s.fr>
 <87o9ckfpek.fsf@concordia.ellerman.id.au>
From: Christophe LEROY <christophe.leroy@c-s.fr>
Message-ID: <64ead919-df89-bd08-bdd1-4235aae9d7b2@c-s.fr>
Date: Wed, 26 Sep 2018 13:53:51 +0200
MIME-Version: 1.0
In-Reply-To: <87o9ckfpek.fsf@concordia.ellerman.id.au>
Content-Type: text/plain; charset=utf-8; format=flowed
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>



Le 26/09/2018 à 13:50, Michael Ellerman a écrit :
> Christophe LEROY <christophe.leroy@c-s.fr> writes:
>> Le 26/09/2018 à 11:28, Segher Boessenkool a écrit :
>>> On Wed, Sep 26, 2018 at 09:58:30AM +0200, Christophe LEROY wrote:
>>>> Segher, any idea about this problem ?
>>>
>>>>>> arch/powerpc/platforms/powermac/bootx_init.o: In function `bootx_printf':
>>>>>> /var/lib/jenkins-slave/workspace/snowpatch/snowpatch-linux-
>>>>>> sparse/linux/arch/powerpc/platforms/powermac/bootx_init.c:88:
>>>>>> undefined reference to `__stack_chk_fail_local'
>>>
>>> Are you building as PIC?  Are you linking libssp_nonshared.a?  Why not?
>>
>> Spotted, thanks.
>>
>> arch/powerpc/platforms/powermac/Makefile contains:
>>
>> CFLAGS_bootx_init.o  		+= -fPIC
> ...
>>
>> Or maybe stack protection on bootx_init doesn't make much sense and we
>> could just do the following ?
>>
>> CFLAGS_bootx_init.o  		+= -fPIC $(call cc-option, -fno-stack-protector)
> 
> That would be fine by me.

Yes, that's what I did in v4, sent a few minutes ago. Indeed the same 
was already done for prom_init, which is similar.

Christophe
