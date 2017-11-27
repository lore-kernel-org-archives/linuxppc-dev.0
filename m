Return-Path: <mpe@ellerman.id.au>
Received: from ozlabs.org (bilbo.ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3ylY7L5jd6zDr8c
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 27 Nov 2017 15:03:26 +1100 (AEDT)
From: Michael Ellerman <mpe@ellerman.id.au>
To: christophe lombard <clombard@linux.vnet.ibm.com>, benh@au1.ibm.com,
 linuxppc-dev@lists.ozlabs.org, fbarrat@linux.vnet.ibm.com,
 vaibhav@linux.vnet.ibm.com, andrew.donnellan@au1.ibm.com
Subject: Re: [PATCH] cxl: Add support for ASB_Notify on POWER9
In-Reply-To: <d18c47e1-d40f-1d6e-e68c-99ae7be01737@linux.vnet.ibm.com>
References: <1511435132-24020-1-git-send-email-clombard@linux.vnet.ibm.com>
 <1511469668.2466.48.camel@au1.ibm.com>
 <49cd46e7-c13e-c82c-404c-2c9e989b9774@linux.vnet.ibm.com>
 <1511528547.2466.52.camel@au1.ibm.com>
 <d18c47e1-d40f-1d6e-e68c-99ae7be01737@linux.vnet.ibm.com>
Date: Mon, 27 Nov 2017 15:03:26 +1100
Message-ID: <87zi782ws1.fsf@concordia.ellerman.id.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

christophe lombard <clombard@linux.vnet.ibm.com> writes:

> Le 24/11/2017 =C3=A0 14:02, Benjamin Herrenschmidt a =C3=A9crit=C2=A0:
>> On Fri, 2017-11-24 at 11:14 +0100, christophe lombard wrote:
>>> To my knowledge, there is no property (or similar), somewhere, that
>>> indicating that the TIDR is supported or not.
>>> For the time being, if I am not wrong, the only check we have, is
>>> this condition in the function set_thread_tidr(struct task_struct *t):
>>>
>>>          if (!cpu_has_feature(CPU_FTR_ARCH_300))
>>>                  return -EINVAL;
>>>
>>>
>>> Christophe
>>=20
>> Then we need to fix that
>>=20
>> Ben.
>>=20
>
> You are right. We will insert a checking in the cxl driver to allow
> updating the TIDR if a P9 is present. This will be in the patch V2.
> Thanks

A cxl_is_power9() check should be fine.

When the check fails you should return an error code that can be
distinguished and interpreted correctly by userspace, ie. not EINVAL.
That implies if the program calls with a different set of arguments the
call might succeed, which is not true.

Either ENODEV or ENXIO would be best I think.

cheers
