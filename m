Return-Path: <moritz.fischer@ettus.com>
Received: from mail-pf0-f195.google.com (mail-pf0-f195.google.com
 [209.85.192.195])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3yJ0N04QQSzDqF4
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 20 Oct 2017 07:07:44 +1100 (AEDT)
Received: by mail-pf0-f195.google.com with SMTP id a8so7559318pfc.0
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 19 Oct 2017 13:07:44 -0700 (PDT)
Date: Thu, 19 Oct 2017 13:06:15 -0700
From: Moritz Fischer <mdf@kernel.org>
To: Pantelis Antoniou <pantelis.antoniou@konsulko.com>
Cc: Rob Herring <robh@kernel.org>, Alan Tull <atull@kernel.org>,
 Frank Rowand <frowand.list@gmail.com>,
 "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
 Michael Ellerman <mpe@ellerman.id.au>,
 linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
 linux-kernel <linux-kernel@vger.kernel.org>,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Paul Mackerras <paulus@samba.org>,
 David Laight <David.Laight@aculab.com>, linux-fpga@vger.kernel.org
Subject: Re: [PATCH v2 5/5] of/fdt: only store the device node basename in
 full_name
Message-ID: <20171019200615.GA10743@tyrael.ni.corp.natinst.com>
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
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="uAKRQypu60I7Lcqm"
In-Reply-To: <4393AFA4-620F-4C21-995D-A9806DAE1990@konsulko.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


--uAKRQypu60I7Lcqm
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Oct 19, 2017 at 11:51:40AM +0300, Pantelis Antoniou wrote:
> Hi Rob,
>=20
> > On Oct 18, 2017, at 21:30 , Rob Herring <robh@kernel.org> wrote:
> >=20
> > On Wed, Oct 18, 2017 at 10:53 AM, Pantelis Antoniou
> > <pantelis.antoniou@konsulko.com> wrote:
> >> On Wed, 2017-10-18 at 10:44 -0500, Rob Herring wrote:
> >>> On Wed, Oct 18, 2017 at 10:12 AM, Alan Tull <atull@kernel.org> wrote:
> >>>> On Tue, Oct 17, 2017 at 6:51 PM, Frank Rowand <frowand.list@gmail.co=
m> wrote:
> >>>>> On 10/17/17 14:46, Rob Herring wrote:
> >>>>>> On Tue, Oct 17, 2017 at 4:32 PM, Alan Tull <atull@kernel.org> wrot=
e:
> >>>>>>> On Mon, Aug 21, 2017 at 10:16 AM, Rob Herring <robh@kernel.org> w=
rote:
> >>>>>>>=20
> >>>>>>> Hi Rob,
> >>>>>>>=20
> >>>>>>>> With dependencies on a statically allocated full path name conve=
rted to
> >>>>>>>> use %pOF format specifier, we can store just the basename of nod=
e, and
> >>>>>>>> the unflattening of the FDT can be simplified.
> >>>>>>>>=20
> >>>>>>>> This commit will affect the remaining users of full_name. After
> >>>>>>>> analyzing these users, the remaining cases should only change so=
me print
> >>>>>>>> messages. The main users of full_name are providing a name for s=
truct
> >>>>>>>> resource. The resource names shouldn't be important other than p=
roviding
> >>>>>>>> /proc/iomem names.
> >>>>>>>>=20
> >>>>>>>> We no longer distinguish between pre and post 0x10 dtb formats a=
s either
> >>>>>>>> a full path or basename will work. However, less than 0x10 forma=
ts have
> >>>>>>>> been broken since the conversion to use libfdt (and no one has c=
ared).
> >>>>>>>> The conversion of the unflattening code to be non-recursive also=
 broke
> >>>>>>>> pre 0x10 formats as the populate_node function would return 0 in=
 that
> >>>>>>>> case.
> >>>>>>>>=20
> >>>>>>>> Signed-off-by: Rob Herring <robh@kernel.org>
> >>>>>>>> ---
> >>>>>>>> v2:
> >>>>>>>> - rebase to linux-next
> >>>>>>>>=20
> >>>>>>>> drivers/of/fdt.c | 69 +++++++++---------------------------------=
--------------
> >>>>>>>> 1 file changed, 11 insertions(+), 58 deletions(-)
> >>>>>>>=20
> >>>>>>> I've just updated to the latest next branch and am finding proble=
ms
> >>>>>>> applying overlays.   Reverting this commit alleviates things.  The
> >>>>>>> errors I get are:
> >>>>>>>=20
> >>>>>>> [   88.498704] OF: overlay: Failed to apply prop @/__symbols__/cl=
k_0
> >>>>>>> [   88.513447] OF: overlay: apply failed '/__symbols__'
> >>>>>>> [   88.518423] create_overlay: Failed to create overlay (err=3D-1=
2)
> >>>>>>=20
> >>>>>> Frank's series with overlay updates should fix this.
> >>>>>=20
> >>>>> Yes, it does:
> >>>>>=20
> >>>>>  [PATCH v3 11/12] of: overlay: remove a dependency on device node f=
ull_name
> >>>>=20
> >>>> Thanks for the fast response.  I fetched the dt/next branch to test
> >>>> this but there are sufficient changes that Pantelis' "OF: DT-Overlay
> >>>> configfs interface (v7)" is broken now.  I've been adding that
> >>>> downstream since 4.4.  We're using it as an interface for applying
> >>>> overlays to program FPGAs.  If we fix it again, is there any chance
> >>>> that can go upstream now?
> >>>=20
> >>> With a drive-by posting once every few years, no.
> >>>=20
> >>=20
> >> I take offense to that. There's nothing changed in the patch for years.
> >> Reposting the same patch without changes would achieve nothing.
> >=20
> > Are you still expecting review comments on it or something?
> > Furthermore, If something is posted infrequently, then I'm not
> > inclined to comment or care if the next posting is going to be after I
> > forget what I previously said (which is not very long).
> >=20
> > I'm just saying, don't expect to forward port, post and it will be
> > accepted. Below is minimally one of the issues that needs to be
> > addressed.
> >=20
> >>> The issue remains that the kernel is not really setup to deal with any
> >>> random property or node to be changed at any point in run-time. I
> >>> think there needs to be some restrictions around what the overlays can
> >>> touch. We can't have it be wide open and then lock things down later
> >>> and break users. One example of what you could do is you can only add
> >>> sub-trees to whitelisted nodes. That's probably acceptable for your
> >>> usecase.
> >>>=20
> >>=20
> >> Defining what can and what cannot be changed is not as trivial as a
> >> list of white-listed nodes.
> >=20
> > No, but we have to start somewhere and we are not starting with any
> > change allowed anywhere at anytime. If that is what people want, then
> > they are going to get to maintain that out of tree.
> >=20
>=20
> I am still not sold on this =E2=80=98dangerous=E2=80=99 idea. No-one is c=
razy enough to
> suggest overlays to be loadable by an unprivileged user. It=E2=80=99s exa=
ctly the
> same =E2=80=98danger=E2=80=99 as loading a kernel module, while is sure c=
apable of much
> greater mischief.

Agreed.
>=20
> >> In some cases there is a whole node hierarchy being inserted (like in
> >> a FPGA).
> >=20
> > Yes, so you'd have a target fpga region. That sounds fine to me. Maybe
> > its not a static whitelist, but drivers have to register target
> > nodes/paths.
> >=20
> >> In others, it's merely changing a status property to "okay" and
> >> a few device parameters.
> >=20
> > That seems fine too. Disabled nodes could be allowed. But what if you
> > add/change properties on a node that is not disabled? Once a node is
> > enabled, who is responsible for registering the device?
> >=20
> > What about changing a node from enabled to disabled? The kernel would
> > need to handle that or not allow it.
> >=20
>=20
> So it seems a simple whitelist won=E2=80=99t cut it. We=E2=80=99re alread=
y talking about
> special casing for this or that property.
>=20
> My argument is that this kind of validation is not part of the core-devic=
e tree,
> but instead is a policy decision different for each board.
> =20
> >> The real issue is that the kernel has no way to verify that a given
> >> device tree, either at boot time or at overlay application time, is
> >> correct.
> >>=20
> >> When the tree is wrong at boot-time you'll hang (if you're lucky).
> >> If the tree is wrong at run-time you'll get some into some unidentified
> >> funky state.
> >=20
> > Or have some security hole or a mechanism for userspace to crash the sy=
stem.
> >=20
>=20
> User-space as in regular users should never have enough privileges to app=
ly an
> overlay, same as in loading a kernel module.
>=20
> >> Finally what is, and what is not 'correct' is not for the kernel to
> >> decide arbitrarily, it's a matter of policy, different for each
> >> use-case.
> >=20
> > It is if the kernel will break doing so.
> >=20
>=20
> I still haven=E2=80=99t seen a real example of the kernel breaking.
>=20
> I have seen a lot of cases where the kernel is crashing due to the device
> removal path being broken, but those are kernel bugs to fix, not something
> to use to hold back functionality that people want to use.

We also have plenty of code that is just not aware of overlays, and
assumes certain parts of the tree to stay static.

I ran into that issue when I tried to add thermal zones via an overlay,
I've been investigating how to fix the thermal framework to work with
overlays since then and have some partially working code.
Currently the thermal framework parses the thermal-zones node at boot,
and assumes this stays static. This breaks with overlays.

I agree we eventually need to fix the parts that break when we use
overlays.

>=20
> > Rob
>=20
> Regards
>=20
> =E2=80=94 Pantelis
>=20
> --
> To unsubscribe from this list: send the line "unsubscribe linux-fpga" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html

Cheers,

Moritz

--uAKRQypu60I7Lcqm
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEowQ4eJSlIZpNWnl2UVwKRFcJcNgFAlnpBbMACgkQUVwKRFcJ
cNgqPAf+LcnQKAR+wfdFByQ/Ngd7Xldy1sSFL9m5jgq3wqtK0cXXYXa7fm37Png9
W/bhUg+5ySiU2jdT6m7RviGyDzXA4e4kxGTfkGFrpCOYm3UuwkN2jL5AT6AasaSh
USnG/vu2ZsulZ7QJTpHvwyCDaGe4yXaqZfvmyo55/3WjMFe6UBUXhWNdGpAgs4uu
LeWnQDrwm8dkGNEhfUXX2u4rNudfgOPHDVaRcqqxb6vW5YFjQNZT17QiijxGZm1W
eCRFL8ypuGptZjTJyAgxVtF81ijASU6GOGW0nfCDswhnZQ/KdLaBO5THUVKgXoiv
SJl15SO8ZsfvaJvlHkA8BzA/raLr+w==
=uxFu
-----END PGP SIGNATURE-----

--uAKRQypu60I7Lcqm--
