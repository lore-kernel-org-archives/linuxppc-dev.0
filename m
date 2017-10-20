Return-Path: <pantelis.antoniou@konsulko.com>
Received: from mail-wr0-x241.google.com (mail-wr0-x241.google.com
 [IPv6:2a00:1450:400c:c0c::241])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3yJJKN33p2zDqBc
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 20 Oct 2017 19:06:31 +1100 (AEDT)
Received: by mail-wr0-x241.google.com with SMTP id q42so10600849wrb.7
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 20 Oct 2017 01:06:31 -0700 (PDT)
Content-Type: text/plain; charset=utf-8
Mime-Version: 1.0 (Mac OS X Mail 10.3 \(3273\))
Subject: Re: [PATCH v2 5/5] of/fdt: only store the device node basename in
 full_name
From: Pantelis Antoniou <pantelis.antoniou@konsulko.com>
In-Reply-To: <59E91D4D.8000200@gmail.com>
Date: Fri, 20 Oct 2017 11:06:23 +0300
Cc: Moritz Fischer <mdf@kernel.org>, Rob Herring <robh@kernel.org>,
 Alan Tull <atull@kernel.org>,
 "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
 Michael Ellerman <mpe@ellerman.id.au>,
 linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
 linux-kernel <linux-kernel@vger.kernel.org>,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Paul Mackerras <paulus@samba.org>, David Laight <David.Laight@aculab.com>,
 linux-fpga@vger.kernel.org
Message-Id: <331B5EB4-9C97-4B2C-9B54-BF648F309A50@konsulko.com>
References: <20170821151651.25096-1-robh@kernel.org>
 <20170821151651.25096-6-robh@kernel.org>
 <CANk1AXTLT9gB_f0GZLODpppjkxqDAp1x1RZmQ8O1i+UHckimxw@mail.gmail.com>
 <CABGGisxU2OPZz-rrWYZYgCQ0iGM9w5vL9Ob9BTHALFN8JyxeJQ@mail.gmail.com>
 <59E69786.2030406@gmail.com>
 <CANk1AXStoiNtJfU0iNug1wKASurqH6OrNoaN=UtSh6xxSB088Q@mail.gmail.com>
 <CAL_JsqKR3Jg+tgZr4xGPtcWnZW7ng741YjuyUFaS2SXKXbxGtg@mail.gmail.com>
 <1508341985.25643.12.camel@hp800z>
 <CAL_JsqKJ74y3qHVqbRph5C8=0Ggb+n=JT3TZybu2+mENyZ1VZA@mail.gmail.com>
 <4393AFA4-620F-4C21-995D-A9806DAE1990@konsulko.com>
 <20171019200615.GA10743@tyrael.ni.corp.natinst.com>
 <59E91D4D.8000200@gmail.com>
To: Frank Rowand <frowand.list@gmail.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Hi Frank,

> On Oct 20, 2017, at 00:46 , Frank Rowand <frowand.list@gmail.com> =
wrote:
>=20
> On 10/19/17 13:06, Moritz Fischer wrote:
>=20
> < snip >
>=20
>> We also have plenty of code that is just not aware of overlays, and
>> assumes certain parts of the tree to stay static.
>=20
> I would state that somewhat differently.  :-)  There is very little
> code that is aware of overlays, and most code assumes the device tree
> does not change after early boot.
>=20
> This is one of the areas where the creation of overlays needs to be
> done with care.
>=20

Correct. But this is not breaking the kernel.

In general we have the following case where we load overlays (at least
well formed overlays that are not doing stupid things).

1. Activation of a new device. Usually this works since is something =
that=E2=80=99s
normally done at boot.

2. Deactivation of a device. This might break because the removal paths
of platform device especially are not well tested (or never executed for =
that
matter).

3. Modification of properties in an already activated device. If the =
device driver
has not installed a device tree modification hook (as in almost 99% of =
the devices)
it will do absolutely nothing, since the device tree is parsed only at =
probe time.
I can argue that for these cases we could have a catch-all hook that =
displays a
message that nothing happened.

4. Modification of some part of the tree that=E2=80=99s not part of a =
device driver, perhaps
the aliases or chosen node. This may potentially be harmful or harmless =
depending on
what has been modified. For instance modifying an already existing alias =
might cause
internal inconsistency about device naming, while adding a new aliases =
should be harmless.
This is a matter of policy per board, whether to allow or not.

Are there other cases that are potentially more harmful?

>=20
>> I ran into that issue when I tried to add thermal zones via an =
overlay,
>> I've been investigating how to fix the thermal framework to work with
>> overlays since then and have some partially working code.
>> Currently the thermal framework parses the thermal-zones node at =
boot,
>> and assumes this stays static. This breaks with overlays.
>>=20
>> I agree we eventually need to fix the parts that break when we use
>> overlays.
>=20

Regards

=E2=80=94 Pantelis
