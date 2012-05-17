Return-Path: <B04825@freescale.com>
Received: from db3outboundpool.messaging.microsoft.com
 (db3ehsobe006.messaging.microsoft.com [213.199.154.144])
 (using TLSv1 with cipher AES128-SHA (128/128 bits))
 (Client CN "mail.global.frontbridge.com",
 Issuer "Microsoft Secure Server Authority" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id D9A12B6FDE
 for <linuxppc-dev@ozlabs.org>; Fri, 18 May 2012 04:42:56 +1000 (EST)
Message-ID: <4FB546A4.7090502@freescale.com>
Date: Thu, 17 May 2012 13:42:44 -0500
From: Timur Tabi <timur@freescale.com>
MIME-Version: 1.0
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: Re: Re: Build regressions/improvements in v3.4-rc7
References: <1337157034-22773-1-git-send-email-geert@linux-m68k.org>
 <CAMuHMdUtL4_mv-e-EQAZmNcb9dAT=PXB59i7Vuj2vf8NnaBFzQ@mail.gmail.com>
 <1337212281.30558.17.camel@pasglop>
In-Reply-To: <1337212281.30558.17.camel@pasglop>
Content-Type: text/plain; charset="ISO-8859-1"
Cc: Parisc List <linux-parisc@vger.kernel.org>,
 the arch/x86 maintainers <x86@kernel.org>, linux-kernel@vger.kernel.org,
 Linuxppc-dev <linuxppc-dev@ozlabs.org>,
 Geert Uytterhoeven <geert@linux-m68k.org>,
 Scott Wood <scottwood@freescale.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Benjamin Herrenschmidt wrote:
>   + arch/powerpc/platforms/512x/mpc512x_shared.c: error: 'enum
>> fsl_diu_monitor_port' declared inside parameter list [-Werror]:  =>
>> 70:9, 84:9, 88:36
>>   + arch/powerpc/platforms/512x/mpc512x_shared.c: error: 'return' with
>> a value, in function returning void [-Werror]:  => 189:2
>>   + arch/powerpc/platforms/512x/mpc512x_shared.c: error: function
>> declaration isn't a prototype [-Werror=strict-prototypes]:  => 69:5,
>> 88:6, 83:6, 187:1
>>   + arch/powerpc/platforms/512x/mpc512x_shared.c: error: its scope is
>> only this definition or declaration, which is probably not what you
>> want [-Werror]:  => 70:9

So I think I have a fix for these, but I still would like the actual
.config so that I can be sure.

>>   + drivers/virt/fsl_hypervisor.c: error: 'MSR_GS' undeclared (first
>> use in this function):  => 799:80

I can't reproduce this one.  MSR_GS is defined in reg_booke.h.
fsl_hypervisor.c should not be compiled on a non-booke platform.  I don't
know if the fix is to add this to fsl_hypervisor.c:

	#include <asm/reg_booke.h>

or if I should update the Kconfig:

config FSL_HV_MANAGER
	tristate "Freescale hypervisor management driver"
	depends on FSL_SOC

to

	depends on FSL_BOOKE

or maybe

	depends on FSL_BOOKE && FSL_SOC

-- 
Timur Tabi
Linux kernel developer at Freescale
