Return-Path: <michael@ellerman.id.au>
Received: from ozlabs.org (bilbo.ozlabs.org [203.11.71.1])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 40tkKL5NDczDqGR
 for <linuxppc-dev@lists.ozlabs.org>; Sun, 27 May 2018 12:22:30 +1000 (AEST)
Date: Sun, 27 May 2018 12:22:23 +1000
In-Reply-To: <20180525133308.GA17443@roeck-us.net>
References: <20180525133308.GA17443@roeck-us.net>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Subject: Re: [PATCH] powerpc/64s: Clear PCR on boot
To: Guenter Roeck <linux@roeck-us.net>, Michael Neuling <mikey@neuling.org>,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Paul Mackerras <paulus@samba.org>, Michael Ellerman <mpe@ellerman.id.au>
CC: linuxppc-dev@lists.ozlabs.org,linux-kernel@vger.kernel.org
From: Michael Ellerman <michael@ellerman.id.au>
Message-ID: <31148B04-5AA9-4F4F-BD34-CD9665F7F6D6@ellerman.id.au>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>



On 25 May 2018 11:33:08 pm AEST, Guenter Roeck <linux@roeck-us=2Enet> wrot=
e:
>On Fri, May 18, 2018 at 11:37:42AM +1000, Michael Neuling wrote:
>> Clear the PCR (Processor Compatibility Register) on boot to ensure we
>> are not running in a compatibility mode=2E
>>=20
>> We've seen this cause problems when a crash (and kdump) occurs while
>> running compat mode guests=2E The kdump kernel then runs with the PCR
>> set and causes problems=2E The symptom in the kdump kernel (also seen
>in
>> petitboot after fast-reboot) is early userspace programs taking
>> sigills on newer instructions (seen in libc)=2E
>>=20
>
>Hi folks,
>
>this patch causes qemu to bail out with
>
>Trying to write privileged spr 338 (0x152) at c000000000033454
>
>when running it with "-M powernv -cpu POWER8" and powernv_defconfig=2E
>
>Can you confirm that this is a bug in qemu ?

Hi Guenter,

Thanks for the report=2E As far as I'm concerned this is a qemu bug, that =
register should exist on a bare metal Power8=2E

Will try and get you a qemu patch to fix it=2E

cheers

--=20
Sent from my Android phone with K-9 Mail=2E Please excuse my brevity=2E
