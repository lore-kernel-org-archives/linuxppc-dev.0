Return-Path: <glikely@secretlab.ca>
Received: from mail-iw0-f175.google.com (mail-iw0-f175.google.com
	[209.85.223.175]) by ozlabs.org (Postfix) with ESMTP id 85E53B7CEF
	for <linuxppc-dev@ozlabs.org>; Fri, 26 Mar 2010 04:35:47 +1100 (EST)
Received: by iwn5 with SMTP id 5so665621iwn.9
	for <linuxppc-dev@ozlabs.org>; Thu, 25 Mar 2010 10:35:46 -0700 (PDT)
MIME-Version: 1.0
Sender: glikely@secretlab.ca
In-Reply-To: <4BAB9755.2080408@freescale.com>
References: <1269380552-10418-1-git-send-email-timur@freescale.com>
	<fa686aa41003241007mf6052d5s4643795f4a87cdcf@mail.gmail.com>
	<4BAA4C8A.70104@freescale.com>
	<65327.84.105.60.153.1269481760.squirrel@gate.crashing.org>
	<4BAB7E67.6040707@freescale.com> <4BAB816F.5060405@firmworks.com>
	<fa686aa41003250916t3d0839e5m42d7f7f6540e821a@mail.gmail.com>
	<4BAB9120.1060600@freescale.com>
	<fa686aa41003250959v401d14e0g151aa54a57eea39@mail.gmail.com>
	<4BAB9755.2080408@freescale.com>
From: Grant Likely <grant.likely@secretlab.ca>
Date: Thu, 25 Mar 2010 11:35:25 -0600
Message-ID: <fa686aa41003251035h3574a2bahce183ca6056e5f7e@mail.gmail.com>
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

On Thu, Mar 25, 2010 at 11:03 AM, Timur Tabi <timur@freescale.com> wrote:
> Grant Likely wrote:
>> For indirect firmware, create a /chosen/firmware node. =A0Don't add a
>> compatible property,
>
> Oh, I don't like that idea at all. =A0The compatible property is useful f=
or me to know *how* to parse the binary blob.

Compatible is for devices.  This is not a device.  Drivers cannot bind
against it.  Use a different mechanism if you have metadata about the
blob.  If your driver doesn't know how to validate its own firmware
blobs, then you've got bigger problems.

>> compatible is for devices and this node is for
>> blob data.
>
> But the blob has a format. =A0For QE firmware, for example, it's this:
>
> struct qe_firmware {
[...]
> } __attribute__ ((packed));

So?  If your data has a structure that the device tree cares about,
the break it out into the device tree nodes/properties structure.  If
it is a blob, then only the driver cares.  The format of the blob
doesn't have any bearing on how it is encapsulated into the tree.

>> =A0Put each firmware blob into a separate property, and make
>> the names reasonable (ie. mpc<blah>-qe-firmware). =A0Have the QE
>> reference the firmware blob by property name.
>
> I don't like the idea of using the property name as a pseudo-compatible s=
tring.

It's a name, not a pseudo compatible string, and your device node will
explicitly reference it by name.  There is not backwards compatibility
or fuzzy binding issues at play here.  It is a way for your driver
node to state, "I want *that exact* firmware blob".  You could make
the property name "george" and it would still be completely clear (if
a little weird) because all the references are contained within the
tree.

g.

--=20
Grant Likely, B.Sc., P.Eng.
Secret Lab Technologies Ltd.
