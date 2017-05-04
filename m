Return-Path: <roy.pledge@nxp.com>
Received: from EUR01-HE1-obe.outbound.protection.outlook.com
 (mail-he1eur01on0073.outbound.protection.outlook.com [104.47.0.73])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3wJrqB5c1hzDqBQ
 for <linuxppc-dev@lists.ozlabs.org>; Fri,  5 May 2017 09:30:14 +1000 (AEST)
From: Roy Pledge <roy.pledge@nxp.com>
To: Scott Wood <oss@buserror.net>, Karim Eshapa <karim.eshapa@gmail.com>
CC: Claudiu Manoil <claudiu.manoil@nxp.com>, "colin.king@canonical.com"
 <colin.king@canonical.com>, "linuxppc-dev@lists.ozlabs.org"
 <linuxppc-dev@lists.ozlabs.org>, "linux-arm-kernel@lists.infradead.org"
 <linux-arm-kernel@lists.infradead.org>, "linux-kernel@vger.kernel.org"
 <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2] drivers:soc:fsl:qbman:qman.c: Sleep instead of stuck
 hacking jiffies.
Date: Thu, 4 May 2017 23:30:05 +0000
Message-ID: <VI1PR04MB3216EC873ED7EB10F3D2CF9D86EA0@VI1PR04MB3216.eurprd04.prod.outlook.com>
References: <1493508775.25397.26.camel@buserror.net>
 <1493873917-7484-1-git-send-email-karim.eshapa@gmail.com>
 <1493932034.25397.37.camel@buserror.net>
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

On 5/4/2017 5:07 PM, Scott Wood wrote:=0A=
> On Thu, 2017-05-04 at 06:58 +0200, Karim Eshapa wrote:=0A=
>> +	stop =3D jiffies + 10000;=0A=
>> +	/*=0A=
>> +	 * if MR was full and h/w had other FQRNI entries to produce, we=0A=
>> +	 * need to allow it time to produce those entries once the=0A=
>> +	 * existing entries are consumed. A worst-case situation=0A=
>> +	 * (fully-loaded system) means h/w sequencers may have to do 3-4=0A=
>> +	 * other things before servicing the portal's MR pump, each of=0A=
>> +	 * which (if slow) may take ~50 qman cycles (which is ~200=0A=
>> +	 * processor cycles). So rounding up and then multiplying this=0A=
>> +	 * worst-case estimate by a factor of 10, just to be=0A=
>> +	 * ultra-paranoid, goes as high as 10,000 cycles. NB, we consume=0A=
>> +	 * one entry at a time, so h/w has an opportunity to produce new=0A=
>> +	 * entries well before the ring has been fully consumed, so=0A=
>> +	 * we're being *really* paranoid here.=0A=
>> +	 */=0A=
> OK, upon reading this more closely it seems the intent was to delay for 1=
0,000=0A=
> *processor cycles* and somehow that got turned into 10,000 jiffies (which=
 is=0A=
> 40 seconds at the default Hz!).  We could just replace this whole thing w=
ith=0A=
> msleep(1) and still be far more paranoid than was originally intended.=0A=
>=0A=
> Claudiu and Roy, any comments?=0A=
Yes the timing here is certainly off, the code changed a few times since=0A=
the comment was originally written.=0A=
An msleep(1) seems reasonable here to me.=0A=
=0A=
Roy=0A=
>=0A=
> -Scott=0A=
>=0A=
>=0A=
=0A=
