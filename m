Return-Path: <panto@antoniou-consulting.com>
Received: from li42-95.members.linode.com (li42-95.members.linode.com
 [209.123.162.95])
 by lists.ozlabs.org (Postfix) with ESMTP id C946A1A0024
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  5 May 2015 02:50:22 +1000 (AEST)
Subject: Re: [PATCH v4 19/21] drivers/of: Support adding sub-tree
Mime-Version: 1.0 (Mac OS X Mail 8.2 \(2098\))
Content-Type: text/plain; charset=utf-8
From: Pantelis Antoniou <panto@antoniou-consulting.com>
In-Reply-To: <1430521038.7979.70.camel@kernel.crashing.org>
Date: Mon, 4 May 2015 19:41:59 +0300
Message-Id: <A6DF99C6-7059-4670-86D0-6926861F0164@antoniou-consulting.com>
References: <1430460188-31343-1-git-send-email-gwshan@linux.vnet.ibm.com>
 <1430460188-31343-20-git-send-email-gwshan@linux.vnet.ibm.com>
 <CAL_JsqKEUevxSe0Q=pGdsWOiT+TW9iAnCsAWuuqOYj3ZPOG7dg@mail.gmail.com>
 <1430493730.7979.58.camel@kernel.crashing.org>
 <CAL_JsqLrBSB4y_0j+i=kXbDA08HO23JuYjJGHR9nhsPnMC_Zyg@mail.gmail.com>
 <1430521038.7979.70.camel@kernel.crashing.org>
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

> On May 2, 2015, at 01:57 , Benjamin Herrenschmidt =
<benh@kernel.crashing.org> wrote:
>=20
> On Fri, 2015-05-01 at 13:46 -0500, Rob Herring wrote:
>> On Fri, May 1, 2015 at 10:22 AM, Benjamin Herrenschmidt
>> <benh@kernel.crashing.org> wrote:
>>> On Fri, 2015-05-01 at 07:54 -0500, Rob Herring wrote:
>>>=20
>>>> The difference seems to be whether you allocate space or just point =
to
>>>> the FDT for various strings/data. Is that right?
>>>>=20
>>>>>   * of_fdt_add_subtree() is the introduced API to do the work.
>>>>=20
>>>> Have you looked at overlays and if so why do they not work for your =
purposes?
>>>>=20
>>>> Why do you need to do this with the flattened tree?
>>>=20
>>> The basic idea I asked Gavin to implement is that since the FW needs =
to
>>> provide a bunch of DT updates to Linux at runtime in the form of new
>>> nodes below an existing one, rather than doing it via some =
new/custom
>>> format, instead, have it send a bit of FDT blob to expand under an
>>> existing node.
>>=20
>> Overlay =3D an FDT blob to graft into a live running system. Sounds =
like
>> the same thing.
>>=20
>>> As for the details of Gavin implementation, I haven't looked at it =
in
>>> details yet so there might be issues there, however I don't know =
what
>>> you mean by "overlays", any pointer ?
>>=20
>> CONFIG_OF_OVERLAY
>>=20
>> =
http://events.linuxfoundation.org/sites/events/files/slides/dynamic-dt-key=
note-v3.pdf
>=20
> Well, that looks horrendously complicated, poorly documented and =
totally
> unused in-tree outside of the unittest stuff, yay ! It has all sort of
> "features" that I don't really care about.
>=20

If it was easy to get stuff in, it would get more of the real-use =
drivers
in.

> I still don't see what it buys me other than making my FW a lot more
> complex having to generate all that additional fixup etc... crap that =
I
> don't totally get yet.
>=20

You don=E2=80=99t generate any additional fixups. You just compile with =
the option
that generates all the fixups for you.

> What's wrong with just unflattening the nodes in place ? The DT comes
> from the FW in the first place so all the phandles are already good in
> the new added blob. Internally, the FW created new nodes in its =
internal
> representation and flattened the subtree and sends that subtree to
> Linux.
>=20
> I don't plan to play "revert" either, if you unplug, I do need to =
remove
> what's under the slot but that's true of boot time devices, not just
> "new" ones, so the overlay stuff won't do the trick and I certainly
> don't want to keep track=E2=80=A6
>=20

You get all of the corner cases handled for free. Perhaps it works for =
your
case too.

Perhaps you can educate me on what you need supported and we can make =
sure
it=E2=80=99s included.

> Ben.
>=20
>=20

Regards

=E2=80=94 Pantelis
