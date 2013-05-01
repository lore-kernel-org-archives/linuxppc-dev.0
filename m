Return-Path: <B07421@freescale.com>
Received: from va3outboundpool.messaging.microsoft.com
 (va3ehsobe002.messaging.microsoft.com [216.32.180.12])
 (using TLSv1 with cipher AES128-SHA (128/128 bits))
 (Client CN "mail.global.frontbridge.com",
 Issuer "Microsoft Secure Server Authority" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id A95312C00CC
 for <linuxppc-dev@lists.ozlabs.org>; Thu,  2 May 2013 04:05:35 +1000 (EST)
Date: Wed, 1 May 2013 13:05:25 -0500
From: Scott Wood <scottwood@freescale.com>
Subject: Re: ppc/sata-fsl: orphan config value: CONFIG_MPC8315_DS
To: Anthony Foiani <tkil@scrye.com>
In-Reply-To: <518078C0.7070805@scrye.com> (from tkil@scrye.com on Tue Apr 30
 21:06:56 2013)
Message-ID: <1367431525.29231.6@snotra>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; delsp=Yes; format=Flowed
Cc: "Robert P.J.Day" <rpjday@crashcourse.ca>,
 "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>,
 Li Yang-R58472 <r58472@freescale.com>, Jeff Garzik <jeff@garzik.org>,
 Adrian Bunk <bunk@stusta.de>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 04/30/2013 09:06:56 PM, Anthony Foiani wrote:
> Scott --
>=20
> On 04/30/2013 06:42 PM, Scott Wood wrote:
>> I just meant that, for whatever boards you would have put this in =20
>> the device tree, put it in platform code instead (if the platform =20
>> file supports more than one board type, then check the compatible at =20
>> the top of the device tree).
>=20
> I think I understand what you're suggesting.
>=20
> Instead of a new property name, I would instead check for my specific =20
> board type (let's call it a foo-8315) in the top-level compatible =20
> list?  So I'd change my devtree to have this top-level compatible:
>=20
> / {
>     compatible =3D "example,foo-8315", "fsl,mpc8315erdb";

It should really only have compatible =3D "example,foo-8315", since it's =20
not 100% compatible with fsl,mpc8315erdb (at least due to this bug, but =20
probably there are other differences as well).

> If I saw that, I would then twiddle the bits as needed?

Yes.

> MIght work, although having it in the sata block of the device tree =20
> has the advantage of providing me exactly the OF node that I need (in =20
> ofdev->dev.of_node).  I'd have to figure out how to traverse to the =20
> dev tree root and then back down one to the root compat entry.  =20
> Probably not impossible, but I was aiming for a fairly minimal patch.

Well, if this is only seen on your board so far (or rather, your =20
vendor's board which isn't upstream), and you're OK with updating the =20
device tree, then I have no objection.

> It would also be nice if we could unravel exactly why that =20
> CONFIG_8315_DS ever showed up in the first place.

It would be nice, but I doubt that particular information is ever going =20
to surface...  IIRC I asked internally back when this first came up, =20
and didn't get an answer.

>> Or do you mean that you would not set this on any board's device =20
>> tree by default, and instead have users set it if they encounter =20
>> problems?
>=20
> No, I would expect to set it on all the boards, so using the =20
> compatibility hack above would work.

You mean all the boards that have the bug, which doesn't include any =20
upstream device tree, right?

-Scott=
