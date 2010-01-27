Return-Path: <glikely@secretlab.ca>
Received: from mail-yx0-f185.google.com (mail-yx0-f185.google.com
	[209.85.210.185]) by ozlabs.org (Postfix) with ESMTP id C9054B8214
	for <linuxppc-dev@ozlabs.org>; Thu, 28 Jan 2010 03:52:48 +1100 (EST)
Received: by yxe15 with SMTP id 15so3059743yxe.9
	for <linuxppc-dev@ozlabs.org>; Wed, 27 Jan 2010 08:52:47 -0800 (PST)
MIME-Version: 1.0
Sender: glikely@secretlab.ca
In-Reply-To: <20100125180024.1a850578@wker>
References: <1263932653-3634-1-git-send-email-agust@denx.de>
	<1263932653-3634-9-git-send-email-agust@denx.de>
	<fa686aa41001210943i3739f693uecf0c05ef0a81c1@mail.gmail.com>
	<20100125180024.1a850578@wker>
From: Grant Likely <grant.likely@secretlab.ca>
Date: Wed, 27 Jan 2010 09:52:27 -0700
Message-ID: <fa686aa41001270852s57e0fa64l3c7067cf211a1d1f@mail.gmail.com>
Subject: Re: [PATCH 08/11] powerpc/mpc5121: add USB host support
To: Anatolij Gustschin <agust@denx.de>
Content-Type: text/plain; charset=ISO-8859-1
Cc: linuxppc-dev@ozlabs.org,
	devicetree-discuss <devicetree-discuss@lists.ozlabs.org>,
	linux-usb@vger.kernel.org, wd@denx.de, dzu@denx.de
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Mon, Jan 25, 2010 at 10:00 AM, Anatolij Gustschin <agust@denx.de> wrote:
> On Thu, 21 Jan 2010 10:43:34 -0700
> Grant Likely <grant.likely@secretlab.ca> wrote:
>
>> > diff --git a/Documentation/powerpc/dts-bindings/fsl/usb.txt b/Document=
ation/powerpc/dts-bindings/fsl/usb.txt
>> > index b001524..9050154 100644
>> > --- a/Documentation/powerpc/dts-bindings/fsl/usb.txt
>> > +++ b/Documentation/powerpc/dts-bindings/fsl/usb.txt
>> > @@ -33,6 +33,14 @@ Recommended properties :
>> > =A0- interrupt-parent : the phandle for the interrupt controller that
>> > =A0 =A0services interrupts for this device.
>> >
>> > +Optional properties :
>>
>> > + - big-endian-regs : boolean; if defined, indicates the USB host
>> > + =A0 controller registers format is big endian.
>>
>> Rather than testing for this explicitly, add fsl,mpc5121-usb2-dr to
>> the match table and use the .data pointer for setting device specific
>> quirks.

Still, don't use a new property to describe this.  The regs being
big-endian is all wrapped up in the definition of what
fsl,mpc5121-usb2-dr means.  You should also drop fsl-usb2-dr from the
compatible list in the .dts file since this device is *not* compatible
with it due to the endian difference.  Test for fsl,mpc5121-usb2-dr
explicitly, and adapt the driver behaviour accordingly.

g.

--=20
Grant Likely, B.Sc., P.Eng.
Secret Lab Technologies Ltd.
