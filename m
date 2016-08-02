Return-Path: <scott.wood@nxp.com>
Received: from EUR01-DB5-obe.outbound.protection.outlook.com
 (mail-db5eur01on0053.outbound.protection.outlook.com [104.47.2.53])
 (using TLSv1 with cipher ECDHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3s3nrW4WG9zDqQn
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  3 Aug 2016 06:30:18 +1000 (AEST)
From: Scott Wood <scott.wood@nxp.com>
To: arvind Yadav <arvind.yadav.cs@gmail.com>, Arnd Bergmann <arnd@arndb.de>,
 "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>
CC: "qiang.zhao@freescale.com" <qiang.zhao@freescale.com>,
 "viresh.kumar@linaro.org" <viresh.kumar@linaro.org>, "zajec5@gmail.com"
 <zajec5@gmail.com>, "linux-wireless@vger.kernel.org"
 <linux-wireless@vger.kernel.org>, "David.Laight@aculab.com"
 <David.Laight@aculab.com>, "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
 "scottwood@freescale.com" <scottwood@freescale.com>,
 "akpm@linux-foundation.org" <akpm@linux-foundation.org>,
 "davem@davemloft.net" <davem@davemloft.net>, "linux@roeck-us.net"
 <linux@roeck-us.net>, Li Yang <leoli@freescale.com>
Subject: Re: [v4] Fix to avoid IS_ERR_VALUE and IS_ERR abuses on 64bit systems.
Date: Tue, 2 Aug 2016 19:57:48 +0000
Message-ID: <DB5PR0401MB1928DE1F195A57160DED735D91050@DB5PR0401MB1928.eurprd04.prod.outlook.com>
References: <1469963924-8800-1-git-send-email-arvind.yadav.cs@gmail.com>
 <1956647.cOmaJREgOE@wuerfel>
 <DB5PR0401MB19280ACA87C7F5EE2822D5FB91040@DB5PR0401MB1928.eurprd04.prod.outlook.com>
 <2484583.95xFmO7xir@wuerfel> <57A0BD8E.9050305@gmail.com>
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 08/02/2016 10:34 AM, arvind Yadav wrote:=0A=
> =0A=
> =0A=
> On Tuesday 02 August 2016 01:15 PM, Arnd Bergmann wrote:=0A=
>> On Monday, August 1, 2016 4:55:43 PM CEST Scott Wood wrote:=0A=
>>> On 08/01/2016 02:02 AM, Arnd Bergmann wrote:=0A=
>>>>> diff --git a/include/linux/err.h b/include/linux/err.h=0A=
>>>>> index 1e35588..c2a2789 100644=0A=
>>>>> --- a/include/linux/err.h=0A=
>>>>> +++ b/include/linux/err.h=0A=
>>>>> @@ -18,7 +18,17 @@=0A=
>>>>>  =0A=
>>>>>  #ifndef __ASSEMBLY__=0A=
>>>>>  =0A=
>>>>> -#define IS_ERR_VALUE(x) unlikely((unsigned long)(void *)(x) >=3D (un=
signed long)-MAX_ERRNO)=0A=
>>>>> +#define IS_ERR_VALUE(x) unlikely(is_error_check(x))=0A=
>>>>> +=0A=
>>>>> +static inline int is_error_check(unsigned long error)=0A=
>>>> Please leave the existing macro alone. I think you were looking for=0A=
>>>> something specific to the return code of qe_muram_alloc() function,=0A=
>>>> so please add a helper in that subsystem if you need it, not in=0A=
>>>> the generic header files.=0A=
>>> qe_muram_alloc (a.k.a. cpm_muram_alloc) returns unsigned long.  The=0A=
>>> problem is certain callers that store the return value in a u32.  Why=
=0A=
>>> not just fix those callers to store it in unsigned long (at least until=
=0A=
>>> error checking is done)?=0A=
>>>=0A=
>> Yes, that would also address another problem with code like=0A=
>>=0A=
>>          kfree((void *)ugeth->tx_bd_ring_offset[i]);=0A=
>>=0A=
>> which is not 64-bit safe when tx_bd_ring_offset is a 32-bit value=0A=
>> that also holds the return value of qe_muram_alloc.=0A=
=0A=
Well, hopefully it doesn't hold a return of qe_muram_alloc() when it's=0A=
being passed to kfree()...=0A=
=0A=
There's also the code that casts kmalloc()'s return to u32, etc.=0A=
ucc_geth is not 64-bit clean in general.=0A=
=0A=
>>=0A=
>> 	Arnd=0A=
> Yes, we will fix caller. Caller api is not safe on 64bit.=0A=
=0A=
The API is fine (or at least, I haven't seen a valid issue pointed out=0A=
yet).  The problem is the ucc_geth driver.=0A=
=0A=
> Even qe_muram_addr(a.k.a. cpm_muram_addr )passing value unsigned int,=0A=
> but it should be unsigned long.=0A=
=0A=
cpm_muram_addr takes unsigned long as a parameter, not that it matters=0A=
since you can't pass errors into it and a muram offset should never=0A=
exceed 32 bits.=0A=
=0A=
-Scott=0A=
=0A=
