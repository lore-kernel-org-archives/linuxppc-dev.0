Return-Path: <glikely@secretlab.ca>
Received: from mail-gx0-f224.google.com (mail-gx0-f224.google.com
	[209.85.217.224]) by ozlabs.org (Postfix) with ESMTP id 80034B7D1D
	for <linuxppc-dev@ozlabs.org>; Thu, 20 May 2010 07:48:06 +1000 (EST)
Received: by gxk24 with SMTP id 24so1358022gxk.3
	for <linuxppc-dev@ozlabs.org>; Wed, 19 May 2010 14:48:05 -0700 (PDT)
MIME-Version: 1.0
Sender: glikely@secretlab.ca
In-Reply-To: <4BF45A1F.70100@freescale.com>
References: <1272659448-23302-1-git-send-email-agust@denx.de>
	<1272659448-23302-2-git-send-email-agust@denx.de>
	<g2tfa686aa41005020754t46934f13hbd5c75a6b7668a54@mail.gmail.com>
	<4BDEFB13.5060407@freescale.com>
	<AANLkTilBveOR1aJTgunOq0aqnsGtf1vWHfn8A6uXyoPU@mail.gmail.com>
	<4BF45A1F.70100@freescale.com>
From: Grant Likely <grant.likely@secretlab.ca>
Date: Wed, 19 May 2010 15:47:45 -0600
Message-ID: <AANLkTinxuFz3SSLZtF3yGYtRN8nsW8_6EDiqzmJilYE9@mail.gmail.com>
Subject: Re: [PATCH 2/2] powerpc/mpc5121: add initial support for PDM360NG
	board
To: Scott Wood <scottwood@freescale.com>
Content-Type: text/plain; charset=ISO-8859-1
Cc: Detlev Zundel <dzu@denx.de>, Markus Fischer <markus.fischer.ec@ifm.com>,
	devicetree-discuss@lists.ozlabs.org,
	Michael Weiss <michael.weiss@ifm.com>, linuxppc-dev@ozlabs.org,
	Anatolij Gustschin <agust@denx.de>, Wolfgang Grandegger <wg@denx.de>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Wed, May 19, 2010 at 3:37 PM, Scott Wood <scottwood@freescale.com> wrote=
:
> On 05/19/2010 04:27 PM, Grant Likely wrote:
>>
>> On Mon, May 3, 2010 at 10:34 AM, Scott Wood<scottwood@freescale.com>
>> =A0wrote:
>>>
>>> Grant Likely wrote:
>>>>>
>>>>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 // IPIC
>>>>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 // interrupts cell =3D<intr #, sense>
>>>>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 // sense values match linux IORESOURCE_=
IRQ_* defines:
>>>>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 // sense =3D=3D 8: Level, low assertion
>>>>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 // sense =3D=3D 2: Edge, high-to-low ch=
ange
>>>>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 //
>>>>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 ipic: interrupt-controller@c00 {
>>>>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 compatible =3D "fsl,mpc=
5121-ipic", "fsl,ipic";
>>>>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 interrupt-controller;
>>>>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 #address-cells =3D<0>;
>>>>
>>>> Don't need #address-cells here
>>>
>>> #address-cells is required by ePAPR for interrupt controllers if an
>>> interrupt-map is used.
>>
>> Why?
>>
>> /me is too lazy to dig out ePAPR and look.
>
> Address cells are part of the interrupt identification. =A0Typically with
> interrupt maps this is only used on the child end (e.g. to select a
> particular PCI slot), but if the parent interrupt controller's address ce=
lls
> are non-zero it will be expected in the parent interrupt specifier as wel=
l.
>
> I believe the only part of this that is new with ePAPR is that it asks th=
at
> the interrupt controller address cells be explicitly specified, as it's a
> bit icky for it to default to 2 in some contexts and 0 in others.

Hmmm.  I've not seen that before.  On the 5200 the value of
#address-cells for interrupt controllers has apparently defaulted to
<0> so I've never encountered or thought about it.  I'm not even sure
what #address-cells !=3D 0 would mean in the context of interrupt
mapping, or where it would be relevant.

g.
