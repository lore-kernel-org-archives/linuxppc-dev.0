Return-Path: <xenidis@gmail.com>
Received: from mail-oa0-f51.google.com (mail-oa0-f51.google.com
 [209.85.219.51])
 (using TLSv1 with cipher ECDHE-RSA-RC4-SHA (128/128 bits))
 (Client CN "smtp.gmail.com", Issuer "Google Internet Authority" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 34B232C009A
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  6 Nov 2012 02:25:40 +1100 (EST)
Received: by mail-oa0-f51.google.com with SMTP id n12so5348309oag.38
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 05 Nov 2012 07:25:38 -0800 (PST)
Sender: Jimi Xenidis <xenidis@gmail.com>
Subject: Re: RFC: book3e: DCR MMIO for IBM Blue Gene/Q
Mime-Version: 1.0 (Apple Message framework v1283)
Content-Type: text/plain; charset=us-ascii
From: Jimi Xenidis <jimix@pobox.com>
In-Reply-To: <BDD4B115-9D17-4063-A957-65775AEBD0F3@pobox.com>
Date: Mon, 5 Nov 2012 09:25:34 -0600
Message-Id: <749146C7-B9A8-4001-9580-3B87A041A580@pobox.com>
References: <020B0706-E2BD-4A6C-8644-D235278655ED@pobox.com>
 <1352073062.12271.268.camel@pasglop>
 <BDD4B115-9D17-4063-A957-65775AEBD0F3@pobox.com>
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


On Nov 4, 2012, at 9:23 PM, Jimi Xenidis wrote:

>=20
>=20
> On Nov 4, 2012, at 5:51 PM, Benjamin Herrenschmidt =
<benh@kernel.crashing.org> wrote:
>=20
>> On Sun, 2012-11-04 at 10:32 -0600, Jimi Xenidis wrote:
>>> I want to use the stuff in arch/platform/sysdev/dcr.c and I have a =
couple of questions:
>>> 1) anyone have a good devtree binding for this?
>>=20
>> Not really, I think the cell stuff was the last we looked at this.
>>=20
>>> I'm thinking:
>>>   bgq {
>>>       #address-cells =3D <2>;
>>>       #size-cells =3D <2>;
>>>       ...
>>>=20
>>>       dcr {
>>>           reg =3D <0x3ff 0xe0000000 0x0 0x08000000>;
>>>           compatible =3D "ibm,bgq-dcr";
>>>           dcr-controller;
>>>           dcr-access-method =3D "mmio";
>>>           dcr-mmio-stride =3D <??>;
>>>       };
>>>   };
>>>=20
>>> I'm not sure what stride I will use since I have yet to figure out =
the DCR numbering in play at the moment, which will be painful.
>>> Also, some clarity to the following would be nice:
>>>   /* Stride is not properly defined yet, default to 0x10 for Axon */
>>>   p =3D of_get_property(dp, "dcr-mmio-stride", NULL);
>>>   stride =3D (p =3D=3D NULL) ? 0x10 : *p;
>>>=20
>>>   /* XXX FIXME: Which property name is to use of the 2 following ? =
*/
>>>   p =3D of_get_property(dp, "dcr-mmio-range", NULL);
>>>   if (p =3D=3D NULL)
>>>       p =3D of_get_property(dp, "dcr-mmio-space", NULL);
>>>   if (p =3D=3D NULL)
>>>       goto done;
>>=20
>> Not sure what SLOF did back then. dcr-mmio-range sounds better to me.
>>=20
>>> I guess my "reg" property is not useful to the code?
>>=20
>> Right, unless the DCR "bridge" has some registers of its own. It's =
also
>> handy to have as a "standard" way of representing the memory used by =
the
>> DCR bridge, tho that does mean duplication... but then it allows you =
to
>> have a nice unit address.
>=20
> umm, was there a conclusion here? :-)
> -jx
>=20
>>=20
>>> Is there a preference over dcr-mmio-range/space or in the absence of =
these to we should use "reg"?
>>>=20
>>> 2) I need 64 bit reads and writes
>>> My intention is to have dcr_{read,write}_generic_{mmio,native} take =
an unsigned long for value all the way down.
>>> For the native case, this would make is similar to mtspr and mfspr.
>>> For the MMIO case, the selected in/out size would be based on =
"#ifdef __powerpc64__"
>>=20
>> As long as it doesn't break Axon...

So Axon, being 64-bit, would break with the changes proposed, since it =
is 64-bit bit and assumes 32bit accessors.
I'll simply add 64bit accessors for now.

-jx


>>=20
>> Cheers,
>> Ben.
>>=20
>>> Thoughts?
>>>=20
>>> -jx
>>=20
>>=20
