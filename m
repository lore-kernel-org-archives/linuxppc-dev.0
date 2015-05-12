Return-Path: <mr.triggtrigg@gmail.com>
Received: from mail-pd0-x229.google.com (mail-pd0-x229.google.com
 [IPv6:2607:f8b0:400e:c02::229])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id EF07D1A0008
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 13 May 2015 03:09:16 +1000 (AEST)
Received: by pdea3 with SMTP id a3so19938263pde.3
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 12 May 2015 10:09:14 -0700 (PDT)
Content-Type: text/plain;
	charset=us-ascii
Mime-Version: 1.0 (1.0)
Subject: Re: [PATCH v2 1/2] powerpc/powernv: Add poweroff (EPOW,
 DPO) events support for PowerNV platform
From: Triggering <mr.triggtrigg@gmail.com>
In-Reply-To: <CAPfuKjKtSHB3Q03vGD9XDnk2yFV31mC8wdJGr3q8XYZfvSx3LA@mail.gmail.com>
Date: Tue, 12 May 2015 22:39:06 +0530
Message-Id: <F9E178BE-B0C1-4CCC-B9BF-F6C4D882EA80@gmail.com>
References: <1430991020-7556-1-git-send-email-vipin@linux.vnet.ibm.com>
 <1430991020-7556-2-git-send-email-vipin@linux.vnet.ibm.com>
 <CAPfuKj+CpLN7QdRJ+VFTz1_p5QL9fkJ+FOa0tKQ2-YEOoXR+4g@mail.gmail.com>
 <m3zj5arbjy.fsf@oc8180480414.ibm.com>
 <CAPfuKjKtSHB3Q03vGD9XDnk2yFV31mC8wdJGr3q8XYZfvSx3LA@mail.gmail.com>
To: Stewart Smith <stewart@linux.vnet.ibm.com>
Cc: Vipin K Parashar <vipin@linux.vnet.ibm.com>, linuxppc-dev@lists.ozlabs.org,
 joel@jms.id.au
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Accidentally hit the reply button instead of reply all. Re sending.

> On 12-May-2015, at 11:55, trigg <mr.triggtrigg@gmail.com> wrote:
>=20
> Hi Stewart,
>=20
> On Tue, May 12, 2015 at 4:01 AM, Stewart Smith
> <stewart@linux.vnet.ibm.com> wrote:
>> trigg <mr.triggtrigg@gmail.com> writes:
>>>> --- a/arch/powerpc/include/asm/opal-api.h
>>>> +++ b/arch/powerpc/include/asm/opal-api.h
>>>> @@ -730,6 +730,36 @@ struct opal_i2c_request {
>>>>        __be64 buffer_ra;               /* Buffer real address */
>>>> };
>>>>=20
>>>> +/*
>>>> + * EPOW status sharing (OPAL and the host)
>>>> + *
>>>> + * The host will pass on OPAL, a buffer of length OPAL_EPOW_MAX_CLASSE=
S
>>>> + * to fetch system wide EPOW status. Each element in the returned buff=
er
>>>> + * will contain bitwise EPOW status for each EPOW sub class.
>>>> + */
>>>> +
>>>> +/* EPOW types */
>>>> +enum OpalEpow {
>>>> +       OPAL_EPOW_POWER         =3D 0,    /* Power EPOW */
>>>> +       OPAL_EPOW_TEMP          =3D 1,    /* Temperature EPOW */
>>>> +       OPAL_EPOW_COOLING       =3D 2,    /* Cooling EPOW */
>>>> +       OPAL_MAX_EPOW_CLASSES   =3D 3,    /* Max EPOW categories */
>>>> +};
>>> Dont explicitly assign sequential numbers in an enum. Its taken care
>>> of by the compiler.
>>=20
>> This header is shared with firmware, and the exact values of each item
>> does matter as it's ABI.
>=20
> This enum has no semantic difference with a series of #defines. So you
> are better
> off using #defines for this. Using enums with explicitly defined
> values beats the whole
> purpose of using them.
>=20
>> The explicit numbers means that people think
>> twice before inserting a new value in the middle and subtley breaking
>> firmware ABI.
>=20
> I disagree. It wont prevent (even worsen) errors like two
> enum-constants being explicitly defined to same values.
> With implicit numbering you can atleast be sure that each
> enum-constant will be unique.
