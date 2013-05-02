Return-Path: <B07421@freescale.com>
Received: from tx2outboundpool.messaging.microsoft.com
 (tx2ehsobe004.messaging.microsoft.com [65.55.88.14])
 (using TLSv1 with cipher AES128-SHA (128/128 bits))
 (Client CN "mail.global.frontbridge.com",
 Issuer "MSIT Machine Auth CA 2" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id DC0192C00C8
 for <linuxppc-dev@lists.ozlabs.org>; Thu,  2 May 2013 10:13:28 +1000 (EST)
Date: Wed, 1 May 2013 19:13:12 -0500
From: Scott Wood <scottwood@freescale.com>
Subject: Re: ppc/sata-fsl: orphan config value: CONFIG_MPC8315_DS
To: Anthony Foiani <tkil@scrye.com>
In-Reply-To: <5181A6CA.9090903@scrye.com> (from tkil@scrye.com on Wed May  1
 18:35:38 2013)
Message-ID: <1367453592.29231.18@snotra>
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

On 05/01/2013 06:35:38 PM, Anthony Foiani wrote:
> Scott --
>=20
> Thanks again for the quick reply.
>=20
> On 05/01/2013 12:05 PM, Scott Wood wrote:
>> On 04/30/2013 09:06:56 PM, Anthony Foiani wrote:
>>> Instead of a new property name, I would instead check for my =20
>>> specific board type (let's call it a foo-8315) in the top-level =20
>>> compatible list?  So I'd change my devtree to have this top-level =20
>>> compatible:
>>>=20
>>> / {
>>>     compatible =3D "example,foo-8315", "fsl,mpc8315erdb";
>>=20
>> It should really only have compatible =3D "example,foo-8315", since =20
>> it's not 100% compatible with fsl,mpc8315erdb (at least due to this =20
>> bug, but probably there are other differences as well).
>=20
> Then I guess I don't understand the proper use of "compatible" (or is =20
> the root node special?)

It's only special in that 100% compatibility is much less likely to be =20
true of an entire system than of a particular component.

> E.g., the DTS for the "parent" board (MPC8315ERDB) has multiple =20
> entries for the crypto "compatible" value:
>=20
> https://git.kernel.org/cgit/linux/kernel/git/torvalds/linux.git/tree/arch=
/powerpc/boot/dts/mpc8315erdb.dts?id=3Drefs/tags/v3.9#n286
> (or: *http://preview.tinyurl.com/btlqxgo* )
>=20
> |		crypto@30000 {
> 			compatible =3D "fsl,sec3.3", "fsl,sec3.1", =20
> "fsl,sec3.0",
> 				     "fsl,sec2.4", "fsl,sec2.2", =20
> "fsl,sec2.1",
> 				     "fsl,sec2.0";
> 			reg =3D <0x30000 0x10000>;|
>=20
> I read this as meaning: "if you have to ask if a certain feature is =20
> compatible with some 'foo', then this board provides that =20
> compatibility".  Not as "if a value is in the compatibility flag, =20
> then it is 100% compatible with that value".  (Although maybe that's =20
> true in the case of the SEC, so perhaps that a bad example.)

AFAIK there is backwards compatibility with these SEC versions.  If =20
not, they shouldn't be listed.

> For what it's worth, the upstream vendor did have a separate =20
> root-node "compatible" value -- which called a board-specific =20
> function in a board-specific C file, both of which were direct cut & =20
> paste copies from the MPC8315ERDB function / file.  My gut instinct =20
> is that this degree of duplication is unhealthy and incorrect, but if =20
> my solution is considered abuse of the device tree, then I can try to =20
> do it a different way next time.

It's quite possible to use the same C file for multiple similar boards =20
with different compatibles.  This is done often, including =20
mpc831x_erdb.c.

> Given those diffs, it didn't seem much of a stretch to use compatible =20
> =3D "fsl,mpc8315erdb"

The criteria for claiming compatibility should be based in the hardware =20
itself, not whether a particular file in Linux needs any changes.

>>>> Or do you mean that you would not set this on any board's device =20
>>>> tree by default, and instead have users set it if they encounter =20
>>>> problems?
>>>=20
>>> No, I would expect to set it on all the boards, so using the =20
>>> compatibility hack above would work.
>>=20
>> You mean all the boards that have the bug, which doesn't include any =20
>> upstream device tree, right?
> As mentioned above, my primary concern is the use of these cards in =20
> the project/product I'm working on.  My answer has been to apply this =20
> fix (and the matching change to the device tree I supply as a part of =20
> the boot image).  I feel that I'm trying to do the right thing by =20
> getting some of these changes publicly visible, but I fear that I'll =20
> also have to go down the route of "not enough time or money to =20
> properly upstream it".
>=20
> "doesn't include upstream device tree" ... no, the device tree was =20
> supplied with the original set of patches from the vendor.

I'm not saying that the device tree not being upstream is a problem -- =20
actually the opposite, that it means we don't have compatibility to =20
maintain with an already-accepted device tree.

-Scott=
