Return-Path: <scott.wood@nxp.com>
Received: from emea01-am1-obe.outbound.protection.outlook.com
 (mail-am1on0091.outbound.protection.outlook.com [157.56.112.91])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3r47yP4VgpzDq5s
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 11 May 2016 05:06:20 +1000 (AEST)
From: Scott Wood <scott.wood@nxp.com>
To: Horia Ioan Geanta Neag <horia.geanta@nxp.com>, Herbert Xu
 <herbert@gondor.apana.org.au>, Benjamin Herrenschmidt
 <benh@kernel.crashing.org>, Paul Mackerras <paulus@samba.org>, "Michael
 Ellerman" <mpe@ellerman.id.au>
CC: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "Cristian
 Stoica" <cristian.stoica@nxp.com>, "linux-crypto@vger.kernel.org"
 <linux-crypto@vger.kernel.org>, Tudor-Dan Ambarus
 <tudor-dan.ambarus@nxp.com>, "linuxppc-dev@lists.ozlabs.org"
 <linuxppc-dev@lists.ozlabs.org>, "David S. Miller" <davem@davemloft.net>,
 Alexandru Porosanu <alexandru.porosanu@nxp.com>
Subject: Re: [PATCH v2 4/8] powerpc: add io{read,write}64 accessors
Date: Tue, 10 May 2016 18:50:38 +0000
Message-ID: <DB5PR0401MB1928B01F60FF3137118F237891710@DB5PR0401MB1928.eurprd04.prod.outlook.com>
References: <1462462435-27403-1-git-send-email-horia.geanta@nxp.com>
 <1462462573-27779-1-git-send-email-horia.geanta@nxp.com>
 <AM2PR04MB0673A09EBC13818E0C2D764E98700@AM2PR04MB0673.eurprd04.prod.outlook.com>
Content-Type: text/plain; charset="iso-8859-2"
MIME-Version: 1.0
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 05/09/2016 03:20 AM, Horia Ioan Geanta Neag wrote:=0A=
> On 5/5/2016 6:37 PM, Horia Geant=E3 wrote:=0A=
>> This will allow device drivers to consistently use io{read,write}XX=0A=
>> also for 64-bit accesses.=0A=
>>=0A=
>> Signed-off-by: Horia Geant=E3 <horia.geanta@nxp.com>=0A=
> =0A=
> It would be great if PPC maintainers could Ack this patch.=0A=
> =0A=
> As stated in the cover letter: https://lkml.org/lkml/2016/5/5/340=0A=
> I'd like to go with the whole patch set via cryptodev-2.6 tree.=0A=
=0A=
It looks good to me.  Michael?=0A=
=0A=
-Scott=0A=
=0A=
=0A=
> =0A=
> Thanks,=0A=
> Horia=0A=
> =0A=
>> ---=0A=
>>  arch/powerpc/kernel/iomap.c | 24 ++++++++++++++++++++++++=0A=
>>  1 file changed, 24 insertions(+)=0A=
>>=0A=
>> diff --git a/arch/powerpc/kernel/iomap.c b/arch/powerpc/kernel/iomap.c=
=0A=
>> index 12e48d56f771..3963f0b68d52 100644=0A=
>> --- a/arch/powerpc/kernel/iomap.c=0A=
>> +++ b/arch/powerpc/kernel/iomap.c=0A=
>> @@ -38,6 +38,18 @@ EXPORT_SYMBOL(ioread16);=0A=
>>  EXPORT_SYMBOL(ioread16be);=0A=
>>  EXPORT_SYMBOL(ioread32);=0A=
>>  EXPORT_SYMBOL(ioread32be);=0A=
>> +#ifdef __powerpc64__=0A=
>> +u64 ioread64(void __iomem *addr)=0A=
>> +{=0A=
>> +	return readq(addr);=0A=
>> +}=0A=
>> +u64 ioread64be(void __iomem *addr)=0A=
>> +{=0A=
>> +	return readq_be(addr);=0A=
>> +}=0A=
>> +EXPORT_SYMBOL(ioread64);=0A=
>> +EXPORT_SYMBOL(ioread64be);=0A=
>> +#endif /* __powerpc64__ */=0A=
>>  =0A=
>>  void iowrite8(u8 val, void __iomem *addr)=0A=
>>  {=0A=
>> @@ -64,6 +76,18 @@ EXPORT_SYMBOL(iowrite16);=0A=
>>  EXPORT_SYMBOL(iowrite16be);=0A=
>>  EXPORT_SYMBOL(iowrite32);=0A=
>>  EXPORT_SYMBOL(iowrite32be);=0A=
>> +#ifdef __powerpc64__=0A=
>> +void iowrite64(u64 val, void __iomem *addr)=0A=
>> +{=0A=
>> +	writeq(val, addr);=0A=
>> +}=0A=
>> +void iowrite64be(u64 val, void __iomem *addr)=0A=
>> +{=0A=
>> +	writeq_be(val, addr);=0A=
>> +}=0A=
>> +EXPORT_SYMBOL(iowrite64);=0A=
>> +EXPORT_SYMBOL(iowrite64be);=0A=
>> +#endif /* __powerpc64__ */=0A=
>>  =0A=
>>  /*=0A=
>>   * These are the "repeat read/write" functions. Note the=0A=
>>=0A=
> =0A=
> =0A=
=0A=
