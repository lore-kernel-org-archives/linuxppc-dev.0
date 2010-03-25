Return-Path: <glikely@secretlab.ca>
Received: from mail-px0-f171.google.com (mail-px0-f171.google.com
	[209.85.216.171]) by ozlabs.org (Postfix) with ESMTP id 3EA04B7CF0
	for <linuxppc-dev@ozlabs.org>; Fri, 26 Mar 2010 03:59:22 +1100 (EST)
Received: by pxi1 with SMTP id 1so3353099pxi.10
	for <linuxppc-dev@ozlabs.org>; Thu, 25 Mar 2010 09:59:21 -0700 (PDT)
MIME-Version: 1.0
Sender: glikely@secretlab.ca
In-Reply-To: <4BAB9120.1060600@freescale.com>
References: <1269380552-10418-1-git-send-email-timur@freescale.com>
	<ed82fe3e1003240505h59d29c83x6948f8b3b70c4570@mail.gmail.com>
	<90D93687-940F-47FB-8CEA-F3C065EA611D@kernel.crashing.org>
	<fa686aa41003241007mf6052d5s4643795f4a87cdcf@mail.gmail.com>
	<4BAA4C8A.70104@freescale.com>
	<65327.84.105.60.153.1269481760.squirrel@gate.crashing.org>
	<4BAB7E67.6040707@freescale.com> <4BAB816F.5060405@firmworks.com>
	<fa686aa41003250916t3d0839e5m42d7f7f6540e821a@mail.gmail.com>
	<4BAB9120.1060600@freescale.com>
From: Grant Likely <grant.likely@secretlab.ca>
Date: Thu, 25 Mar 2010 10:59:01 -0600
Message-ID: <fa686aa41003250959v401d14e0g151aa54a57eea39@mail.gmail.com>
Subject: Re: [PATCH] powerpc/fsl: add device tree binding for QE firmware
To: Timur Tabi <timur@freescale.com>
Content-Type: text/plain; charset=ISO-8859-1
Cc: Mitch Bradley <wmb@firmworks.com>, Scott Wood <scottwood@freescale.com>,
	devicetree-discuss@lists.ozlabs.org, linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Thu, Mar 25, 2010 at 10:36 AM, Timur Tabi <timur@freescale.com> wrote:
> Grant Likely wrote:
>> On Thu, Mar 25, 2010 at 9:29 AM, Mitch Bradley <wmb@firmworks.com> wrote=
:
>>> It seems to me that there are plausible use cases for both direct-inclu=
sion
>>> and indirection. =A0I don't see any real problems with either, so I wou=
ld vote
>>> for specifying both alternatives.
>>
>> Ugh. =A0Then this one driver would need to implement both binding for
>> little, if any, actual benefit.
>
> Although I agree that I don't like supporting both bindings, we could enc=
apsulate the locating of the firmware node in a function. =A0The function w=
ill first look for a child firmware node, and if it doesn't find it, look f=
or a fsl,firmware property. =A0It will return a pointer to the firmware nod=
e regardless.
>
>> I'm sure we can come to an agreement
>> on one method if the firmware absolutely has to be in the tree.
>
> If we have to pick one, then I think the only viable choice is have a sep=
arate firmware node and a phandle pointer to it. =A0Otherwise, I just don't=
 see how we can handle multiple devices needing the same firmware.

Wait for David to weigh in on this one before making a decision.  He
knows the dtb format best.

>> Personally, my vote lies with direct-inclusion. =A0However, if
>> indirection is used, then I think it would be wise to define where
>> data-only nodes like this should live. =A0Under /chosen perhaps?
>
> I personally don't care that much; /chosen is okay with me, but ....
>
>> It
>> wouldn't be good to place it somewhere where it will be confused for
>> an actual device node.
>
> ... what's wrong with the root node?

Take things to a logical extreme and see what it looks like.  Instead
of one QE blob, assume that you need to provide 100 firmware blobs for
various devices (yes, that number is ridiculous, but that's kind of
the point).  Essentially what I mean is make the assumption that the
problem you have is not unique, that other drivers also need firmware.
 Should it be organized?  Does it make sense to have one node in the
root for each firmware blob?  Does it make sense for each of those
nodes to have a 'compatible' property which makes it look like a
physical device?

Here's a counter proposal off the top of my head:

For indirect firmware, create a /chosen/firmware node.  Don't add a
compatible property, compatible is for devices and this node is for
blob data.  Put each firmware blob into a separate property, and make
the names reasonable (ie. mpc<blah>-qe-firmware).  Have the QE
reference the firmware blob by property name.

g.

--=20
Grant Likely, B.Sc., P.Eng.
Secret Lab Technologies Ltd.
