Return-Path: <scott.wood@nxp.com>
Received: from EUR01-DB5-obe.outbound.protection.outlook.com
 (mail-db5eur01on0071.outbound.protection.outlook.com [104.47.2.71])
 (using TLSv1 with cipher ECDHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3s3Prg5bFmzDrFJ
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  2 Aug 2016 15:29:07 +1000 (AEST)
From: Scott Wood <scott.wood@nxp.com>
To: Arnd Bergmann <arnd@arndb.de>, "linuxppc-dev@lists.ozlabs.org"
 <linuxppc-dev@lists.ozlabs.org>
CC: Arvind Yadav <arvind.yadav.cs@gmail.com>, "zajec5@gmail.com"
 <zajec5@gmail.com>, "leoli@freescale.com" <leoli@freescale.com>,
 "qiang.zhao@freescale.com" <qiang.zhao@freescale.com>,
 "viresh.kumar@linaro.org" <viresh.kumar@linaro.org>,
 "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>,
 "David.Laight@aculab.com" <David.Laight@aculab.com>, "netdev@vger.kernel.org"
 <netdev@vger.kernel.org>, "scottwood@freescale.com"
 <scottwood@freescale.com>, "akpm@linux-foundation.org"
 <akpm@linux-foundation.org>, "davem@davemloft.net" <davem@davemloft.net>,
 "linux@roeck-us.net" <linux@roeck-us.net>
Subject: Re: [v4] Fix to avoid IS_ERR_VALUE and IS_ERR abuses on 64bit systems.
Date: Mon, 1 Aug 2016 16:55:43 +0000
Message-ID: <DB5PR0401MB19280ACA87C7F5EE2822D5FB91040@DB5PR0401MB1928.eurprd04.prod.outlook.com>
References: <1469963924-8800-1-git-send-email-arvind.yadav.cs@gmail.com>
 <1956647.cOmaJREgOE@wuerfel>
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

On 08/01/2016 02:02 AM, Arnd Bergmann wrote:=0A=
> On Sunday, July 31, 2016 4:48:44 PM CEST Arvind Yadav wrote:=0A=
>> IS_ERR_VALUE() assumes that parameter is an unsigned long.=0A=
>> It can not be used to check if 'unsigned int' is passed insted.=0A=
>> Which tends to reflect an error.=0A=
>>=0A=
>> In 64bit architectures sizeof (int) =3D=3D 4 && sizeof (long) =3D=3D 8.=
=0A=
>> IS_ERR_VALUE(x) is ((x) >=3D (unsigned long)-4095).=0A=
>>=0A=
>> IS_ERR_VALUE() of 'unsigned int' is always false because the 32bit=0A=
>> value is zero extended to 64 bits.=0A=
>>=0A=
>> Value of (unsigned int)-4095 is always less than value of=0A=
>> (unsigned long)-4095.=0A=
>>=0A=
>> Now We are taking only first 32 bit for error checking rest of the 32 bi=
t=0A=
>> we ignore such that we get appropriate comparison on 64bit system as wel=
l.=0A=
> =0A=
> This is completely wrong: if you have a valid 64-bit pointer like=0A=
> 0x00001234ffffff00, this will be interpreted as an error now.=0A=
> =0A=
>> First 32bit of Value of (unsigned int)-4095 and (unsigned long)-4095 wil=
l=0A=
>> be equal.=0A=
>>=0A=
>> Signed-off-by: Arvind Yadav <arvind.yadav.cs@gmail.com>=0A=
>> ---=0A=
>>  include/linux/err.h | 12 +++++++++++-=0A=
>>  1 file changed, 11 insertions(+), 1 deletion(-)=0A=
>>=0A=
>> diff --git a/include/linux/err.h b/include/linux/err.h=0A=
>> index 1e35588..c2a2789 100644=0A=
>> --- a/include/linux/err.h=0A=
>> +++ b/include/linux/err.h=0A=
>> @@ -18,7 +18,17 @@=0A=
>>  =0A=
>>  #ifndef __ASSEMBLY__=0A=
>>  =0A=
>> -#define IS_ERR_VALUE(x) unlikely((unsigned long)(void *)(x) >=3D (unsig=
ned long)-MAX_ERRNO)=0A=
>> +#define IS_ERR_VALUE(x) unlikely(is_error_check(x))=0A=
>> +=0A=
>> +static inline int is_error_check(unsigned long error)=0A=
> =0A=
> Please leave the existing macro alone. I think you were looking for=0A=
> something specific to the return code of qe_muram_alloc() function,=0A=
> so please add a helper in that subsystem if you need it, not in=0A=
> the generic header files.=0A=
=0A=
qe_muram_alloc (a.k.a. cpm_muram_alloc) returns unsigned long.  The=0A=
problem is certain callers that store the return value in a u32.  Why=0A=
not just fix those callers to store it in unsigned long (at least until=0A=
error checking is done)?=0A=
=0A=
-Scott=0A=
=0A=
