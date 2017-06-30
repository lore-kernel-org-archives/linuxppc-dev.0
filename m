Return-Path: <laurentiu.tudor@nxp.com>
Received: from EUR01-VE1-obe.outbound.protection.outlook.com
 (mail-ve1eur01on0042.outbound.protection.outlook.com [104.47.1.42])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3wzXjm3hzLzDr55
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 30 Jun 2017 20:25:48 +1000 (AEST)
From: Laurentiu Tudor <laurentiu.tudor@nxp.com>
To: Michael Ellerman <mpe@ellerman.id.au>, "oss@buserror.net"
 <oss@buserror.net>, "linuxppc-dev@lists.ozlabs.org"
 <linuxppc-dev@lists.ozlabs.org>
Subject: Re: [PATCH] powerpc: allow compiling with GENERIC_MSI_IRQ
Date: Fri, 30 Jun 2017 10:25:42 +0000
Message-ID: <595626F0.2090700@nxp.com>
References: <20170630095022.17228-1-laurentiu.tudor@nxp.com>
 <8737ahrdn9.fsf@concordia.ellerman.id.au>
In-Reply-To: <8737ahrdn9.fsf@concordia.ellerman.id.au>
Content-Type: text/plain; charset="Windows-1252"
MIME-Version: 1.0
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Hi Michael,

On 06/30/2017 01:08 PM, Michael Ellerman wrote:
> Hi Laurentiu,
>
> laurentiu.tudor@nxp.com writes:
>> From: Laurentiu Tudor <laurentiu.tudor@nxp.com>
>>
>> This allows building powerpc with the GENERIC_MSI_IRQ Kconfig
>> by enabling the asm-generic msi.h in Kbuild. Without this,
>> there's a compilation error [1] because powerpc, as most arches,
>> doesn't provide an asm/msi.h.
>>
>> [1] In file included from ./include/linux/kvm_host.h:20:0,
>>                   from ./arch/powerpc/include/asm/kvm_ppc.h:30,
>>                   from arch/powerpc/kernel/dbell.c:20:
>> ./include/linux/msi.h:195:21: fatal error: asm/msi.h: No such file or di=
rectory
>
> I have >50 configs here with GENERIC_MSI_IRQ=3Dy, so I don't understand
> what's going wrong for you.
>
> Can you tell me more about what you're doing and how it's breaking.
>

Actually i made an error in the commit message, sorry about that. It's=20
GENERIC_MSI_IRQ_DOMAIN that breaks the arch/powerpc build. If this is=20
enabled, the generic header include/linux/msi.h wants an asm/msi.h and=20
we don't have one on powerpc. That's what the patch tries to fix.
Want me to resend with the correct commit message? ... if you're ok with=20
the patch, of course.

---
Thanks & Best Regards, Laurentiu=
