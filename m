Return-Path: <mpe@ellerman.id.au>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3s8KGc6V8dzDqRR
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 10 Aug 2016 15:20:08 +1000 (AEST)
From: Michael Ellerman <mpe@ellerman.id.au>
To: Nicholas Piggin <npiggin@gmail.com>
Cc: linuxppc-dev@ozlabs.org, Anton Blanchard <anton@samba.org>,
 imunsie@au.ibm.com
Subject: Re: [PATCH] powerpc/Makefile: Use cflags-y/aflags-y for setting
 endian options
In-Reply-To: <20160810003658.527c34e0@roar.ozlabs.ibm.com>
References: <1470746626-1989-1-git-send-email-mpe@ellerman.id.au>
 <20160810003658.527c34e0@roar.ozlabs.ibm.com>
Date: Wed, 10 Aug 2016 15:20:08 +1000
Message-ID: <87fuqdtd2v.fsf@concordia.ellerman.id.au>
MIME-Version: 1.0
Content-Type: text/plain
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Nicholas Piggin <npiggin@gmail.com> writes:

> On Tue,  9 Aug 2016 22:43:46 +1000
> Michael Ellerman <mpe@ellerman.id.au> wrote:
>> diff --git a/arch/powerpc/Makefile b/arch/powerpc/Makefile
>> index ca254546cd05..1934707bf321 100644
>> --- a/arch/powerpc/Makefile
>> +++ b/arch/powerpc/Makefile
>> @@ -66,29 +66,28 @@ endif
>>  UTS_MACHINE := $(OLDARCH)
>>  
>>  ifeq ($(CONFIG_CPU_LITTLE_ENDIAN),y)
>> -override CC	+= -mlittle-endian
>> -ifneq ($(cc-name),clang)
>> -override CC	+= -mno-strict-align
>> -endif
>> -override AS	+= -mlittle-endian
>>  override LD	+= -EL
>> -override CROSS32CC += -mlittle-endian
>>  override CROSS32AS += -mlittle-endian
>
> Can't we get rid of CROSS32AS? If not, then should it get the
> -mbig-endian override?

It's unused. I have a patch to remove it lying around, let me dig up
that series.

cheers
