Return-Path: <r58472@freescale.com>
Received: from ch1outboundpool.messaging.microsoft.com
 (ch1ehsobe001.messaging.microsoft.com [216.32.181.181])
 (using TLSv1 with cipher AES128-SHA (128/128 bits))
 (Client CN "mail.global.frontbridge.com",
 Issuer "Microsoft Secure Server Authority" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 5CC88B6FCB
 for <linuxppc-dev@ozlabs.org>; Fri, 17 Feb 2012 15:33:01 +1100 (EST)
From: Li Yang-R58472 <r58472@freescale.com>
To: Kumar Gala <galak@kernel.crashing.org>
Subject: RE: [PATCH 1/2] powerpc/85xx: fix problem that prevents PHYS_64BIT
 from configurable
Date: Fri, 17 Feb 2012 04:32:53 +0000
Message-ID: <94F013E7935FF44C83EBE7784D62AD3F057427B6@039-SN2MPN1-023.039d.mgd.msft.net>
References: <1329394210-1014-1-git-send-email-leoli@freescale.com>
 <EDB74FED-002D-4F94-B134-995BFB4C0A6B@kernel.crashing.org>
In-Reply-To: <EDB74FED-002D-4F94-B134-995BFB4C0A6B@kernel.crashing.org>
Content-Type: text/plain; charset="Windows-1252"
MIME-Version: 1.0
Cc: "linuxppc-dev@ozlabs.org" <linuxppc-dev@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

>Subject: Re: [PATCH 1/2] powerpc/85xx: fix problem that prevents
>PHYS_64BIT from configurable
>
>
>On Feb 16, 2012, at 6:10 AM, Li Yang wrote:
>
>> Fix the problem that large physical address support cannot be disabled
>> when some platforms which only provides 36-bit support are selected.
>> According to the philosophy of kernel config enabling a platform
>> support doesn't mean the kernel is only running on that platform.
>> Remove the auto selection of PHYS_64BIT option for these platforms.
>> They will need to use a 36bit default config that selects PHYS_64BIT
>> explicitly.
>>
>> The reason why we need to keep PHYS_64BIT option configurable is that
>> enabling it cause negative performance impact on various aspects like
>> TLB miss and physical address manipulating.  We should not enable it
>> unless really needed, e.g. use large memory of 4GB or bigger.
>>
>> Signed-off-by: Li Yang <leoli@freescale.com>
>> ---
>> arch/powerpc/platforms/85xx/Kconfig |    6 ------
>> 1 files changed, 0 insertions(+), 6 deletions(-)
>
>Nak, this isn't correct.
>
>For some of these platforms like P2041RDB, P3041DS, P3060QDS, P4080DS, &
>P5020DS only a 36-bit physical address map is supported by u-boot and the
>device tree.  This was a decision that was made to NOT support 32-bit
>address map for these boards and accept the performance implication of it
>to reduce the # of builds, etc.

Ok.  Although personally I don't think # of builds matters that much.

>
>Additionally, outside of maybe P2041RDB I believe the majority of these
>boards ship with 4G of DDR (but that off the top of my head) and thus
>require the 36-bit / PHYS_64BIT support to be enabled.

I know that current support of DPAA boards requires 36-bit.  But I don't th=
ink they need to select the PHYS_64BIT option directly and make it not conf=
igurable.  It's conflicting with the logic that enabling a platform support=
 doesn't mean the kernel is only running on that platform.  Btw: what's you=
r recommendations on solving this?

- Leo
