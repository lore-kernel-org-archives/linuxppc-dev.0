Return-Path: <mpe@ellerman.id.au>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3xWp3w6jwMzDr9D
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 15 Aug 2017 20:04:28 +1000 (AEST)
From: Michael Ellerman <mpe@ellerman.id.au>
To: "Naveen N. Rao" <naveen.n.rao@linux.vnet.ibm.com>
Cc: Breno Leitao <leitao@debian.org>, linuxppc-dev@lists.ozlabs.org
Subject: Re: [PATCH] powerpc/xmon: Exclude all of xmon/ from ftrace
In-Reply-To: <87wp6emj5w.fsf@concordia.ellerman.id.au>
References: <20170802182538.26526-1-naveen.n.rao@linux.vnet.ibm.com>
 <87wp6emj5w.fsf@concordia.ellerman.id.au>
Date: Tue, 15 Aug 2017 20:04:27 +1000
Message-ID: <87y3qltadw.fsf@concordia.ellerman.id.au>
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

Michael Ellerman <mpe@ellerman.id.au> writes:

> "Naveen N. Rao" <naveen.n.rao@linux.vnet.ibm.com> writes:
>
>> diff --git a/arch/powerpc/xmon/Makefile b/arch/powerpc/xmon/Makefile
>> index 0b2f771593eb..5f95af64cb8f 100644
>> --- a/arch/powerpc/xmon/Makefile
>> +++ b/arch/powerpc/xmon/Makefile
>> @@ -7,6 +7,19 @@ UBSAN_SANITIZE := n
>>  
>>  ccflags-$(CONFIG_PPC64) := $(NO_MINIMAL_TOC)
>>  
>> +ifdef CONFIG_FUNCTION_TRACER
>> +CFLAGS_REMOVE_xmon.o	= -mno-sched-epilog $(CC_FLAGS_FTRACE)
>> +CFLAGS_REMOVE_nonstdio.o = -mno-sched-epilog $(CC_FLAGS_FTRACE)
>> +ifdef CONFIG_XMON_DISASSEMBLY
>> +CFLAGS_REMOVE_ppc-dis.o	= -mno-sched-epilog $(CC_FLAGS_FTRACE)
>> +CFLAGS_REMOVE_ppc-opc.o	= -mno-sched-epilog $(CC_FLAGS_FTRACE)
>> +ifdef CONFIG_SPU_BASE
>> +CFLAGS_REMOVE_spu-dis.o	= -mno-sched-epilog $(CC_FLAGS_FTRACE)
>> +CFLAGS_REMOVE_spu-opc.o	= -mno-sched-epilog $(CC_FLAGS_FTRACE)
>> +endif
>> +endif
>> +endif
>
> Urk.
>
> We want to disable it for everything in the directory, so can you do
> something like:
>
>   ORIG_CFLAGS := $(KBUILD_CFLAGS)
>   KBUILD_CFLAGS = $(subst $(CC_FLAGS_FTRACE),,$(ORIG_CFLAGS))

Yes:

  # Disable ftrace for the entire directory
  ORIG_CFLAGS := $(KBUILD_CFLAGS)
  KBUILD_CFLAGS = $(subst -mno-sched-epilog,,$(subst $(CC_FLAGS_FTRACE),,$(ORIG_CFLAGS)))

Seems to work.

cheers
