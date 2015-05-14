Return-Path: <panto@antoniou-consulting.com>
Received: from li42-95.members.linode.com (li42-95.members.linode.com
 [209.123.162.95])
 by lists.ozlabs.org (Postfix) with ESMTP id BFC501A03A4
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 14 May 2015 17:34:32 +1000 (AEST)
Subject: Re: [PATCH v4 19/21] drivers/of: Support adding sub-tree
Mime-Version: 1.0 (Mac OS X Mail 8.2 \(2098\))
Content-Type: text/plain; charset=utf-8
From: Pantelis Antoniou <panto@antoniou-consulting.com>
In-Reply-To: <1431588358.4160.42.camel@kernel.crashing.org>
Date: Thu, 14 May 2015 10:34:26 +0300
Message-Id: <D7FC0542-DD1A-428F-8E75-81620C6D83DC@antoniou-consulting.com>
References: <1430460188-31343-1-git-send-email-gwshan@linux.vnet.ibm.com>
 <1430460188-31343-20-git-send-email-gwshan@linux.vnet.ibm.com>
 <CAL_JsqKEUevxSe0Q=pGdsWOiT+TW9iAnCsAWuuqOYj3ZPOG7dg@mail.gmail.com>
 <1430493730.7979.58.camel@kernel.crashing.org>
 <CAL_JsqLrBSB4y_0j+i=kXbDA08HO23JuYjJGHR9nhsPnMC_Zyg@mail.gmail.com>
 <1430521038.7979.70.camel@kernel.crashing.org>
 <A6DF99C6-7059-4670-86D0-6926861F0164@antoniou-consulting.com>
 <1430774063.7979.139.camel@kernel.crashing.org>
 <1431560124.20218.91.camel@kernel.crashing.org>
 <CAL_JsqKqTa5eg3eOqx3bkeNdO_920WwDiRbQaxwWLEWpCypFmA@mail.gmail.com>
 <1431564871.4160.8.camel@kernel.crashing.org>
 <53EAE361-0015-4702-97C6-9F67B87963C2@antoniou-consulting.com>
 <1431585994.4160.32.camel@kernel.crashing.org>
 <3988EABE-3DE9-4E1C-9778-22E35138E359@antoniou-consulting.com>
 <1431587657.4160.37.camel@kernel.crashing.org>
 <75F026CA-5AC1-4106-B2F0-AB0D006DEF5A@antoniou-consulting.com>
 <1431588358.4160.42.camel@kernel.crashing.org>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
 "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
 Gavin Shan <gwshan@linux.vnet.ibm.com>, Grant Likely <grant.likely@linaro.org>,
 Rob Herring <robherring2@gmail.com>, Bjorn Helgaas <bhelgaas@google.com>,
 linuxppc-dev <linuxppc-dev@lists.ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Hi Ben,

> On May 14, 2015, at 10:25 , Benjamin Herrenschmidt =
<benh@kernel.crashing.org> wrote:
>=20
> On Thu, 2015-05-14 at 10:19 +0300, Pantelis Antoniou wrote:
>=20
>>=20
>> You don=E2=80=99t want to know how sausages are made, but they are =
delicious :)
>=20
> ... most of the time :)
>=20
>>> But yeah generating the overlay doesn't necessarily scare me, I can
>>> generate a temp tree that is the overlay in which I "copy" the =
subtree
>>> (or in my internal ptr-based representation I could have a concept =
of
>>> alias which I follow while flattening).
>>>=20
>>> That leaves me with these problems:
>>>=20
>>> - No support for removing of nodes, so that needs to be added back =
to
>>> the format and to Linux unless I continue removing by hand in the =
PCI
>>> hotplug code itself
>>>=20
>>=20
>> What kind of nodes/properties you need to remove at _application_ =
time?
>=20
> Well, if we stick to removing by hand in Linux for the unplug case, =
then
> none.
>=20

OK

>> What you describe is inserting a bunch of properties and nodes under
>> a slot=E2=80=99s device node. Reverting the overlay removes them all =
just fine.
>=20
> Except that still doesn't work for boot time :-)
>=20
> So I would have to do a special case on unplug:
>=20
> 	if (slot->dt_is_overlay) /* set to false at boot */
> 		remove_subtree_myself();
> 	else
> 		undo_overlay(slot->overlay);
>=20

OK, in that case you do require removal. But in any case it=E2=80=99s =
the =E2=80=98negative=E2=80=99
of an already applied one, either at boot time or not.

Modifying the overlay code to apply a =E2=80=98negative=E2=80=99 =
property should do the trick.

Is that correct?

>>> - No support for "committing" the overlay which needs to be added as
>>> well.
>>>=20
>>=20
>> That=E2=80=99s the easiest part.
>=20
> Yeah, I will need to get my head around the code a bit more but it
> doesn't seem too scary.
>=20
>> I see. Well, how about this?
>>=20
>> Who said you have to do the whole blob dance in the firmware?
>>=20
>> You can just as easily pass the blob as it is to the linux kernel and
>> the kernel there can convert it to an overlay and apply it.
>=20
> That's not that pretty but we can do that too which solve the problem =
of
> fixing the FW interface.
>=20
> There is however an argument to be made in having the FW be able to
> generate arbitrary overlays. If we ever want to pass more "property"
> updates or node updates to Linux at runtime.
>=20
> A few cases have crept up on the radar, like updating the pstate =
tables
> or VPD informations ...
>=20
> If we go down that path, then I would implement a concept of =
generation
> count in the firmware, so I can generate an overlay that include all =
the
> changes since the last "generation" given to Linux.
>=20

I will probably need that generation count myself for my PCI use case.

> However that requires supporting removal of nodes/properties. So I'm
> tempted to keep that feature on the back burner and go with an ad-hoc
> interface for PCI for now.
>=20

I see. Bonne chance :)

> Ben.
>=20
>=20

Regards

=E2=80=94 Pantelis
