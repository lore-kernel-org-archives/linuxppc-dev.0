Return-Path: <xenidis@gmail.com>
Received: from mail-ob0-f179.google.com (mail-ob0-f179.google.com
 [209.85.214.179])
 (using TLSv1 with cipher ECDHE-RSA-RC4-SHA (128/128 bits))
 (Client CN "smtp.gmail.com", Issuer "Google Internet Authority" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 805002C0094
 for <linuxppc-dev@lists.ozlabs.org>; Mon,  5 Nov 2012 14:23:34 +1100 (EST)
Received: by mail-ob0-f179.google.com with SMTP id lz20so4843557obb.38
 for <linuxppc-dev@lists.ozlabs.org>; Sun, 04 Nov 2012 19:23:31 -0800 (PST)
Sender: Jimi Xenidis <xenidis@gmail.com>
References: <020B0706-E2BD-4A6C-8644-D235278655ED@pobox.com>
 <1352073062.12271.268.camel@pasglop>
Mime-Version: 1.0 (1.0)
In-Reply-To: <1352073062.12271.268.camel@pasglop>
Content-Type: text/plain;
	charset=us-ascii
Message-Id: <BDD4B115-9D17-4063-A957-65775AEBD0F3@pobox.com>
From: Jimi Xenidis <jimix@pobox.com>
Subject: Re: RFC: book3e: DCR MMIO for IBM Blue Gene/Q
Date: Sun, 4 Nov 2012 21:23:29 -0600
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: linuxppc-dev <linuxppc-dev@lists.ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>



On Nov 4, 2012, at 5:51 PM, Benjamin Herrenschmidt <benh@kernel.crashing.org=
> wrote:

> On Sun, 2012-11-04 at 10:32 -0600, Jimi Xenidis wrote:
>> I want to use the stuff in arch/platform/sysdev/dcr.c and I have a couple=
 of questions:
>> 1) anyone have a good devtree binding for this?
>=20
> Not really, I think the cell stuff was the last we looked at this.
>=20
>> I'm thinking:
>>    bgq {
>>        #address-cells =3D <2>;
>>        #size-cells =3D <2>;
>>        ...
>>=20
>>        dcr {
>>            reg =3D <0x3ff 0xe0000000 0x0 0x08000000>;
>>            compatible =3D "ibm,bgq-dcr";
>>            dcr-controller;
>>            dcr-access-method =3D "mmio";
>>            dcr-mmio-stride =3D <??>;
>>        };
>>    };
>>=20
>> I'm not sure what stride I will use since I have yet to figure out the DC=
R numbering in play at the moment, which will be painful.
>> Also, some clarity to the following would be nice:
>>    /* Stride is not properly defined yet, default to 0x10 for Axon */
>>    p =3D of_get_property(dp, "dcr-mmio-stride", NULL);
>>    stride =3D (p =3D=3D NULL) ? 0x10 : *p;
>>=20
>>    /* XXX FIXME: Which property name is to use of the 2 following ? */
>>    p =3D of_get_property(dp, "dcr-mmio-range", NULL);
>>    if (p =3D=3D NULL)
>>        p =3D of_get_property(dp, "dcr-mmio-space", NULL);
>>    if (p =3D=3D NULL)
>>        goto done;
>=20
> Not sure what SLOF did back then. dcr-mmio-range sounds better to me.
>=20
>> I guess my "reg" property is not useful to the code?
>=20
> Right, unless the DCR "bridge" has some registers of its own. It's also
> handy to have as a "standard" way of representing the memory used by the
> DCR bridge, tho that does mean duplication... but then it allows you to
> have a nice unit address.

umm, was there a conclusion here? :-)
-jx

>=20
>> Is there a preference over dcr-mmio-range/space or in the absence of thes=
e to we should use "reg"?
>>=20
>> 2) I need 64 bit reads and writes
>> My intention is to have dcr_{read,write}_generic_{mmio,native} take an un=
signed long for value all the way down.
>> For the native case, this would make is similar to mtspr and mfspr.
>> For the MMIO case, the selected in/out size would be based on "#ifdef __p=
owerpc64__"
>=20
> As long as it doesn't break Axon...
>=20
> Cheers,
> Ben.
>=20
>> Thoughts?
>>=20
>> -jx
>=20
>=20
