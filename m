Return-Path: <shawnxjin@gmail.com>
Received: from mail-yw0-f42.google.com (mail-yw0-f42.google.com
	[209.85.213.42]) by ozlabs.org (Postfix) with ESMTP id 2DA8FB6F0E
	for <linuxppc-dev@ozlabs.org>; Tue, 24 Aug 2010 04:18:46 +1000 (EST)
Received: by ywl5 with SMTP id 5so690075ywl.15
	for <linuxppc-dev@ozlabs.org>; Mon, 23 Aug 2010 11:18:45 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20100821073116.GA1597@opentech.at>
References: <AANLkTinb9yJk10yE2nAT_exNaANHyFbAH59LOM=Jy7Oz@mail.gmail.com>
	<20100821073116.GA1597@opentech.at>
Date: Mon, 23 Aug 2010 11:18:44 -0700
Message-ID: <AANLkTimUj-=a5-5kLhNxwBARK9p3+Yiu5CF_BjbH6KpB@mail.gmail.com>
Subject: Re: How to build the kernel without any optimization?
From: Shawn Jin <shawnxjin@gmail.com>
To: Nicholas Mc Guire <der.herr@hofr.at>
Content-Type: text/plain; charset=ISO-8859-1
Cc: ppcdev <linuxppc-dev@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

>> I already added the following to arch/powerpc/Makefile.
>>
>> # Prevent GDB from jumping around in the code when trying to single step
>> ifeq ($(CONFIG_DEBUG_KERNEL),y)
>> KBUILD_CFLAGS =A0 =A0 =A0 =A0 =A0 +=3D -fno-schedule-insns -fno-schedule=
-insns2
>> endif
>>
>
> much of the kernel can not be build without optimization - what you
> can do though is slectively try to disable optimization for specific
> files by putting
>
> =A0CFLAGS_REMOVE_objfilenam.o =3D -SOME_OPT
>
> in the Makefile. I think that is safer than what you did above as this wo=
uld
> always depend on the order of options that ultimately get passed to gcc.

With this CLAGS_REMOVE, building the objfilenam.o uses only the
-SOME_OPT instead of the default CFLAGS defined? The most I found for
-SOME_OPT is the -pg.

Thanks,
-Shawn.
