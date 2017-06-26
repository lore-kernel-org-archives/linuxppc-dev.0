Return-Path: <schindele@nentec.de>
Received: from dmz-mail.nentec.de (gate.nentec.de [213.218.23.37])
 by lists.ozlabs.org (Postfix) with SMTP id 3wx8Tq66qXzDr1k
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 26 Jun 2017 23:07:11 +1000 (AEST)
Subject: Re: [PATCH] powerpc/ipic: Support edge on IRQ0
To: Michael Ellerman <mpe@ellerman.id.au>, Scott Wood <oss@buserror.net>,
 linuxppc-dev@lists.ozlabs.org
References: <20170625023905.24649-1-oss@buserror.net>
 <878tkeex1f.fsf@concordia.ellerman.id.au>
From: =?UTF-8?Q?J=c3=bcrgen_Schindele?= <schindele@nentec.de>
Message-ID: <e1f22604-17fe-0a13-994c-14b497a049fb@nentec.de>
Date: Mon, 26 Jun 2017 14:55:45 +0200
MIME-Version: 1.0
In-Reply-To: <878tkeex1f.fsf@concordia.ellerman.id.au>
Content-Type: text/plain; charset=utf-8; format=flowed
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Index 48 equals IRQ0 in developpers manual


Am 26.06.2017 um 14:46 schrieb Michael Ellerman:
> Scott Wood <oss@buserror.net> writes:
>
>> External IRQ0 has the same capabilities as the other IRQ1-7 and is
>> handled by the same register IPIC_SEPNR.  When this register is not
>> specified for "ack" in "ipic_info", you cannot configure this IRQ as
>> IRQ_TYPE_EDGE_FALLING.  This oversight was probably due to the
>> non-contiguous hwirq numbering of IRQ0 in the IPIC.
> I don't know this code at all, but nothing in the diff says "IRQ0" to
> me?
>
> cheers
>
>> diff --git a/arch/powerpc/sysdev/ipic.c b/arch/powerpc/sysdev/ipic.c
>> index f267ee0afc08..16f1edd78c40 100644
>> --- a/arch/powerpc/sysdev/ipic.c
>> +++ b/arch/powerpc/sysdev/ipic.c
>> @@ -315,6 +315,7 @@ static struct ipic_info ipic_info[] =3D {
>>   		.prio_mask =3D 7,
>>   	},
>>   	[48] =3D {
>> +		.ack	=3D IPIC_SEPNR,
>>   		.mask	=3D IPIC_SEMSR,
>>   		.prio	=3D IPIC_SMPRR_A,
>>   		.force	=3D IPIC_SEFCR,
>> --=20
>> 2.11.0

--=20
  i. A.
J=C3=BCrgen Schindele
Softwareentwicklung

PSI Nentec GmbH
Greschbachstra=C3=9Fe 12
76229 Karlsruhe
Deutschland
Telefon: +49 721 94249-51
Telefax: +49 721 94249-10
schindele@nentec.de
www.nentec.de

Gesch=C3=A4ftsf=C3=BChrung: Klaus Becker, Roland Knapp
Sitz der Gesellschaft: Karlsruhe
Handelsregister: Amtsgericht Mannheim HRB 107658

Diese E-Mail enth=C3=A4lt vertrauliche oder rechtlich gesch=C3=BCtzte Inf=
ormationen. Wenn Sie nicht der vorgesehene Empf=C3=A4nger sind, informier=
en Sie bitte sofort den Absender und l=C3=B6schen Sie diese E-Mail. Das u=
nbefugte Kopieren dieser E-Mail oder die unbefugte Weitergabe der enthalt=
enen Informationen ist nicht gestattet.

The information contained in this message is confidential or protected by=
 law. If you are not the intended recipient, please contact the sender an=
d delete this message. Any unauthorised copying of this message or unauth=
orised distribution of the information contained herein is prohibited.
