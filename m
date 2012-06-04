Return-Path: <galak@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client did not present a certificate)
 by ozlabs.org (Postfix) with ESMTPS id 89FC6B6EE7
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  5 Jun 2012 00:44:29 +1000 (EST)
Subject: Re: [PATCH] powerpc: Optimise the 64bit optimised __clear_user
Mime-Version: 1.0 (Apple Message framework v1278)
Content-Type: text/plain; charset=iso-8859-1
From: Kumar Gala <galak@kernel.crashing.org>
In-Reply-To: <CAOesGMjm9fZs26pjGOvaUks+=_2N=v_CBeY89iVpXZcKkccMdg@mail.gmail.com>
Date: Mon, 4 Jun 2012 09:44:23 -0500
Message-Id: <ACFF4669-F957-4704-BA15-5EAB417B8360@kernel.crashing.org>
References: <20120604175858.38dac554@kryten>
 <CAOesGMjm9fZs26pjGOvaUks+=_2N=v_CBeY89iVpXZcKkccMdg@mail.gmail.com>
To: Olof Johansson <olof@lixom.net>
Cc: michael@ellerman.id.au, linuxppc-dev@lists.ozlabs.org, mikey@neuling.org,
 paulus@samba.org, Anton Blanchard <anton@samba.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


On Jun 4, 2012, at 8:12 AM, Olof Johansson wrote:

> Hi,
>=20
> On Mon, Jun 4, 2012 at 12:58 AM, Anton Blanchard <anton@samba.org> =
wrote:
>>=20
>> I blame Mikey for this. He elevated my slightly dubious testcase:
>>=20
>> # dd if=3D/dev/zero of=3D/dev/null bs=3D1M count=3D10000
>>=20
>> to benchmark status. And naturally we need to be number 1 at creating
>> zeros. So lets improve __clear_user some more.
>>=20
>> As Paul suggests we can use dcbz for large lengths. This patch gets
>> the destination 128 byte aligned then uses dcbz on whole cachelines.
>>=20
>> Before:
>> 10485760000 bytes (10 GB) copied, 0.414744 s, 25.3 GB/s
>>=20
>> After:
>> 10485760000 bytes (10 GB) copied, 0.268597 s, 39.0 GB/s
>>=20
>> 39 GB/s, a new record.
>>=20
>> Signed-off-by: Anton Blanchard <anton@samba.org>
>> ---
>>=20
>> Index: linux-build/arch/powerpc/lib/string_64.S
>> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
>> --- linux-build.orig/arch/powerpc/lib/string_64.S       2012-06-04 =
16:18:56.351604302 +1000
>> +++ linux-build/arch/powerpc/lib/string_64.S    2012-06-04 =
16:47:10.538500871 +1000
>> @@ -78,7 +78,7 @@ _GLOBAL(__clear_user)
> [..]
>=20
>> +15:
>> +err2;  dcbz    r0,r3
>> +       addi    r3,r3,128
>> +       addi    r4,r4,-128
>> +       bdnz    15b
>=20
> This breaks architecture spec (and at least one implementation); cache
> lines are not guaranteed to be 128 bytes.

I'm guessing it breaks more than one (FSL 64-bit is 64byte cache lines).

- k=
