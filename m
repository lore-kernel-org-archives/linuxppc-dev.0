Return-Path: <glikely@secretlab.ca>
Received: from yx-out-2324.google.com (yx-out-2324.google.com [74.125.44.28])
	by ozlabs.org (Postfix) with ESMTP id 86FCFDDE11
	for <linuxppc-dev@ozlabs.org>; Mon,  2 Mar 2009 09:47:07 +1100 (EST)
Received: by yx-out-2324.google.com with SMTP id 8so1161003yxb.39
	for <linuxppc-dev@ozlabs.org>; Sun, 01 Mar 2009 14:47:05 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <9e4733910903010754q1b4d9fafy87668049653d5e21@mail.gmail.com>
References: <1235575933-29691-1-git-send-email-w.sang@pengutronix.de>
	<fa686aa40902262131i6c75687foaf42daeb4fc7a3b7@mail.gmail.com>
	<20090301101815.GC23093@pengutronix.de>
	<fa686aa40903010648q238380acy34b58e04226d8014@mail.gmail.com>
	<9e4733910903010754q1b4d9fafy87668049653d5e21@mail.gmail.com>
Date: Sun, 1 Mar 2009 15:47:05 -0700
Message-ID: <fa686aa40903011447x1810f252m367d6c05cc567133@mail.gmail.com>
Subject: Re: [PATCH] powerpc/mpc52xx: add Phytec phyCORE-MPC5200B-IO board
	(pcm032)
From: Grant Likely <grant.likely@secretlab.ca>
To: Jon Smirl <jonsmirl@gmail.com>
Content-Type: text/plain; charset=ISO-8859-1
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Sun, Mar 1, 2009 at 8:54 AM, Jon Smirl <jonsmirl@gmail.com> wrote:
> On Sun, Mar 1, 2009 at 9:48 AM, Grant Likely <grant.likely@secretlab.ca> =
wrote:
>> On Sun, Mar 1, 2009 at 3:18 AM, Wolfram Sang <w.sang@pengutronix.de> wro=
te:
>>> Hi Grant,
>>>
>>> thanks for the review!
>>>
>>> On Thu, Feb 26, 2009 at 10:31:24PM -0700, Grant Likely wrote:
>>>> Thanks for the patch Wolfram. =A0Comments below.
>>>>
>>>> On Wed, Feb 25, 2009 at 8:32 AM, Wolfram Sang <w.sang@pengutronix.de> =
wrote:
>>>> > Signed-off-by: Wolfram Sang <w.sang@pengutronix.de>
>>>> > ---
>>>> > =A0arch/powerpc/boot/dts/pcm032.dts =A0 =A0 =A0 =A0 =A0 =A0 | =A0391=
 +++++++
>>>> > =A0arch/powerpc/configs/52xx/pcm032_defconfig =A0 | 1394 +++++++++++=
+++++++++++++++
>>>>
>>>> Do you really need a separate defconfig for this board? =A0Can it be
>>>> merged with an existing defconfig?
>>>
>>> Will have a look if I can make a pcm03x_defconfig out of pcm030_defconf=
ig.
>>
>> Cool, thanks.
>>
>>>> motionpro.dts is a good example of what it should look like.
>>>
>>> Ah, thanks for the pointer. Will have a look there. Guess I'll need to =
update
>>> pcm030.dts later, too (from which I copied this one). Will rewrite the
>>> localbus-node addressing the comments you gave.
>>
>> pcm030.dts in mainline doesn't have a localbus node.
>
> I've been using this on my pcm030 locally.

Hey Jon, a few comments below for the record.  :-)

> pcm030 doesn't have a PCI socket but it can be added via the expansion bu=
s.
> With just the basic pcm030 hardware, if I uncomment the pci node I
> sometimes hang on boot.

Hmmm.  Weird.  Have you been able to identify what code it hangs in?

>
> =A0 =A0 =A0 =A0lpb@ff000000 {

This node doesn't really have an address since it is simply a bus (the
control registers are elsewhere).  Should make this simply: locabus {

> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0compatible =3D "fsl,lpb", "simple-bus";

Ideally this should be: compatible =3D
"fsl,mpc5200b-lpb",fsl,mpc5200-lpb","simple-bus".  However, I forgot
to add "simple-bus" to arch/powerpc/platforms/52xx/mpc52xx-common.c
for the bus probing code and so this won't work in current mainline.
The fix is queued up in -next, and I'm going to try and get it into
.29

Cheers,
g.

--=20
Grant Likely, B.Sc., P.Eng.
Secret Lab Technologies Ltd.
