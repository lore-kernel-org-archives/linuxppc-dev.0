Return-Path: <galak@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client did not present a certificate)
 by ozlabs.org (Postfix) with ESMTPS id B8001B6F67
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 30 Nov 2011 02:48:39 +1100 (EST)
Subject: Re: [PATCH 2/6] powerpc/85xx: consolidate of_platform_bus_probe calls
Mime-Version: 1.0 (Apple Message framework v1251.1)
Content-Type: text/plain; charset=iso-8859-1
From: Kumar Gala <galak@kernel.crashing.org>
In-Reply-To: <CAOZdJXXZG38v-tgA2Ty7-uxJ3AxoFCmNxMO3dKJnJYQtJFb9DA@mail.gmail.com>
Date: Tue, 29 Nov 2011 09:48:38 -0600
Message-Id: <38BAFE03-DB17-4442-8CC2-E386E46FEB19@kernel.crashing.org>
References: <1321552581-29773-1-git-send-email-dbaryshkov@gmail.com>
 <1321552581-29773-2-git-send-email-dbaryshkov@gmail.com>
 <CAOZdJXXZG38v-tgA2Ty7-uxJ3AxoFCmNxMO3dKJnJYQtJFb9DA@mail.gmail.com>
To: Tabi Timur-B04825 <B04825@freescale.com>
Cc: Dmitry Eremin-Solenikov <dbaryshkov@gmail.com>,
 Gala Kumar-B11780 <B11780@freescale.com>,
 "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


On Nov 28, 2011, at 5:42 PM, Tabi Timur-B04825 wrote:

> On Thu, Nov 17, 2011 at 11:56 AM, Dmitry Eremin-Solenikov
> <dbaryshkov@gmail.com> wrote:
>=20
>> diff --git a/arch/powerpc/platforms/85xx/p1022_ds.c =
b/arch/powerpc/platforms/85xx/p1022_ds.c
>> index 00d93a4..cacb4d4 100644
>> --- a/arch/powerpc/platforms/85xx/p1022_ds.c
>> +++ b/arch/powerpc/platforms/85xx/p1022_ds.c
>> @@ -330,10 +330,6 @@ static void __init p1022_ds_setup_arch(void)
>>  }
>>=20
>>  static struct of_device_id __initdata p1022_ds_ids[] =3D {
>> -       { .type =3D "soc", },
>> -       { .compatible =3D "soc", },
>> -       { .compatible =3D "simple-bus", },
>> -       { .compatible =3D "gianfar", },
>>        /* So that the DMA channel nodes can be probed individually: =
*/
>>        { .compatible =3D "fsl,eloplus-dma", },
>>        {},
>> @@ -343,6 +339,7 @@ static int __init p1022_ds_publish_devices(void)
>>  {
>>        return of_platform_bus_probe(NULL, p1022_ds_ids, NULL);
>>  }
>> +machine_device_initcall(p1022_ds, mpc85xx_common_publish_devices);
>>  machine_device_initcall(p1022_ds, p1022_ds_publish_devices);
>=20
> I don't think this is working.  I need to investigate some more to be
> sure, but it looks like this is not picking up "fsl,eloplus-dma".
> None of the DMA channels are being probed in the audio driver
> (sound/soc/fsl_dma.c).

Hmm, that's odd.  Should see if the issues exists before the change.

- k=
