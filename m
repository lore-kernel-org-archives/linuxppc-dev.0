Return-Path: <laurentiu.tudor@nxp.com>
Received: from EUR03-VE1-obe.outbound.protection.outlook.com
 (mail-eopbgr50053.outbound.protection.outlook.com [40.107.5.53])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3xBcn04Jt8zDrF8
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 18 Jul 2017 21:07:00 +1000 (AEST)
From: Laurentiu Tudor <laurentiu.tudor@nxp.com>
To: Michael Ellerman <mpe@ellerman.id.au>, "oss@buserror.net"
 <oss@buserror.net>, "linuxppc-dev@lists.ozlabs.org"
 <linuxppc-dev@lists.ozlabs.org>
Subject: Re: [PATCH v2] powerpc: allow compiling with GENERIC_MSI_IRQ_DOMAIN
Date: Tue, 18 Jul 2017 11:06:54 +0000
Message-ID: <596DEB80.6020305@nxp.com>
References: <20170717131243.2157-1-laurentiu.tudor@nxp.com>
 <87pocyhv4n.fsf@concordia.ellerman.id.au>
In-Reply-To: <87pocyhv4n.fsf@concordia.ellerman.id.au>
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

On 07/18/2017 01:55 PM, Michael Ellerman wrote:
> laurentiu.tudor@nxp.com writes:
>
>> From: Laurentiu Tudor <laurentiu.tudor@nxp.com>
>>
>> This allows building powerpc with the GENERIC_MSI_IRQ_DOMAIN
>> Kconfig by enabling the asm-generic msi.h in Kbuild. Without
>> this, there's a compilation error [1] because powerpc, as most
>> arches, doesn't provide an asm/msi.h.
>>
>> [1] In file included from ./include/linux/kvm_host.h:20:0,
>>                   from ./arch/powerpc/include/asm/kvm_ppc.h:30,
>>                   from arch/powerpc/kernel/dbell.c:20:
>> ./include/linux/msi.h:195:21: fatal error: asm/msi.h: No such file or di=
rectory
>>
>> Signed-off-by: Laurentiu Tudor <laurentiu.tudor@nxp.com>
>> ---
>> v2:
>>   - compilation error happens when GENERIC_MSI_IRQ_DOMAIN is enabled and=
 not
>>     GENERIC_MSI_IRQ, so fix commit msg and title
>
> It looks like the only way powerpc can enable GENERIC_MSI_IRQ_DOMAIN is
> by enabling FSL_MC_BUS ?
>

Yes, i think so. I'm currently working on making FSL_MC_BUS compile=20
multi-arch [1] and that's how i hit this compilation error on ppc.

[1] https://lkml.org/lkml/2017/7/17/415

---
Best Regards, Laurentiu=
