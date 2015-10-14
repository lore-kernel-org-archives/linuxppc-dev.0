Return-Path: <olof@lixom.net>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 9574E1A066C
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 15 Oct 2015 03:54:58 +1100 (AEDT)
Received: from mail-yk0-f179.google.com (mail-yk0-f179.google.com
 [209.85.160.179])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id EC65C141107
 for <linuxppc-dev@ozlabs.org>; Thu, 15 Oct 2015 03:54:57 +1100 (AEDT)
Received: by ykoo7 with SMTP id o7so53209190yko.0
 for <linuxppc-dev@ozlabs.org>; Wed, 14 Oct 2015 09:54:55 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <1444779780.12197.3.camel@ellerman.id.au>
References: <1442986835-13985-1-git-send-email-mpe@ellerman.id.au>
 <20151002074708.CF4DC14076A@ozlabs.org>
 <CAOesGMjDC99RFEenyUqc2uhpT9EhqhevrqxiO5Gd7AN_GWmrkg@mail.gmail.com>
 <1444779780.12197.3.camel@ellerman.id.au>
Date: Wed, 14 Oct 2015 09:54:55 -0700
Message-ID: <CAOesGMgd2rnAs9hmi1B9PWN2=fr6HUDn+krxdDdGPUKBrZOQGw@mail.gmail.com>
Subject: Re: [RFC, 1/2] scripts/kconfig/Makefile: Allow KBUILD_DEFCONFIG to be
 a target
From: Olof Johansson <olof@lixom.net>
To: Michael Ellerman <mpe@ellerman.id.au>
Cc: linuxppc-dev@ozlabs.org, mmarek@suse.com,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 yann.morin.1998@free.fr,
 "linux-kbuild@vger.kernel.org" <linux-kbuild@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Tue, Oct 13, 2015 at 4:43 PM, Michael Ellerman <mpe@ellerman.id.au> wrote:
> On Tue, 2015-10-13 at 14:02 -0700, Olof Johansson wrote:
>> On Fri, Oct 2, 2015 at 12:47 AM, Michael Ellerman <mpe@ellerman.id.au> wrote:
>> > On Wed, 2015-23-09 at 05:40:34 UTC, Michael Ellerman wrote:
>> >> Arch Makefiles can set KBUILD_DEFCONFIG to tell kbuild the name of the
>> >> defconfig that should be built by default.
>> >>
>> >> However currently there is an assumption that KBUILD_DEFCONFIG points to
>> >> a file at arch/$(SRCARCH)/configs/$(KBUILD_DEFCONFIG).
>> >>
>> >> We would like to use a target, using merge_config, as our defconfig, so
>> >> adapt the logic in scripts/kconfig/Makefile to allow that.
>> >>
>> >> To minimise the chance of breaking anything, we first check if
>> >> KBUILD_DEFCONFIG is a file, and if so we do the old logic. If it's not a
>> >> file, then we call the top-level Makefile with KBUILD_DEFCONFIG as the
>> >> target.
>> >>
>> >> Signed-off-by: Michael Ellerman <mpe@ellerman.id.au>
>> >> Acked-by: Michal Marek <mmarek@suse.com>
>> >
>> > Applied to powerpc next.
>> >
>> > https://git.kernel.org/powerpc/c/d2036f30cfe1daa19e63ce75
>>
>> This breaks arm64 defconfig for me:
>>
>> mkdir obj-tmp
>> make -f Makefile O=obj-tmp ARCH=arm64 defconfig
>> ... watch loop of:
>> *** Default configuration is based on target 'defconfig'
>>   GEN     ./Makefile
>
> Crap, sorry. I knew I shouldn't have touched that code!
>
> Does this fix it for you?

Yes, it does, however:

>
> diff --git a/scripts/kconfig/Makefile b/scripts/kconfig/Makefile
> index b2b9c87..3043d6b 100644
> --- a/scripts/kconfig/Makefile
> +++ b/scripts/kconfig/Makefile
> @@ -96,7 +96,7 @@ savedefconfig: $(obj)/conf
>  defconfig: $(obj)/conf
>  ifeq ($(KBUILD_DEFCONFIG),)
>         $< $(silent) --defconfig $(Kconfig)
> -else ifneq ($(wildcard arch/$(SRCARCH)/configs/$(KBUILD_DEFCONFIG)),)
> +else ifneq ($(wildcard $(srctree)/arch/$(SRCARCH)/configs/$(KBUILD_DEFCONFIG)),)
>         @$(kecho) "*** Default configuration is based on '$(KBUILD_DEFCONFIG)'"
>         $(Q)$< $(silent) --defconfig=arch/$(SRCARCH)/configs/$(KBUILD_DEFCONFIG) $(Kconfig)

Do you need a $(srctree) prefix here too? I'm not entirely sure what I
would do to reproduce a run that goes down this path so I can't
confirm.


-Olof
